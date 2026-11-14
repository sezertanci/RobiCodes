import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_assets.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/app_theme.dart';
import 'package:robi_codes/content/content_catalog.dart';
import 'package:robi_codes/content/models/game_definition.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/achievements/achievement.dart';
import 'package:robi_codes/features/achievements/achievement_catalog.dart';
import 'package:robi_codes/features/achievements/achievement_service.dart';
import 'package:robi_codes/features/progress/progress_repository.dart';
import 'package:robi_codes/games/game_module.dart';
import 'package:robi_codes/games/game_registry.dart';

import '../support/fakes.dart';

/// Örnek katalogdaki oyunu oynanabilir yapan boş modül.
final class _FakeModule implements GameModule {
  const _FakeModule(this.gameId);

  @override
  final String gameId;

  @override
  Widget buildLevel(LevelSession session) => const SizedBox();
}

/// Örnek kataloğa modülü olmayan ("Yakında" görünen) bir oyun eklenir.
const _soonGameId = 'soon';

ContentCatalog _catalogWithComingSoonGame() {
  final catalog = TestCatalog.build();
  return ContentCatalog(
    games: [
      ...catalog.games,
      const GameDefinition(
        id: _soonGameId,
        title: 'Yakında',
        description: 'Açıklama',
        tone: AppTones.pink,
        icon: AppAssets.gameIf,
        trophy: GameTrophy(title: 'Yakında Kupası', description: 'Açıklama'),
      ),
    ],
    packs: catalog.packs,
    products: catalog.products,
  );
}

void main() {
  late InMemoryKeyValueStore store;
  late ProgressRepository progress;

  AchievementService createService() => AchievementService(
    store: store,
    catalog: _catalogWithComingSoonGame(),
    games: GameRegistry([const _FakeModule(TestCatalog.gameId)]),
    progress: progress,
  );

  AchievementStatus statusOf(AchievementService service, String id) =>
      service.statuses().firstWhere((status) => status.achievement.id == id);

  setUp(() {
    store = InMemoryKeyValueStore();
    progress = ProgressRepository(store);
  });

  group('AchievementService', () {
    test('sync_FirstLevelCompleted_ReturnsNewRewardsBadgesFirst', () async {
      // Arrange
      final service = createService();
      await progress.completeLevel(TestCatalog.freePack, 1, 2);

      // Act
      final fresh = await service.sync();

      // Assert
      final ids = [for (final status in fresh) status.achievement.id];
      expect(ids, ['first-game', 'all-games', 'first-adventure']);
      expect(fresh.every((status) => status.isEarned), isTrue);
      expect(service.isEarned('first-game'), isTrue);
      expect(jsonDecode(store.values[StorageKeys.achievements]!), {'earned': ids});
    });

    test('sync_CalledAgain_DoesNotReturnEarnedRewards', () async {
      // Arrange
      final service = createService();
      await progress.completeLevel(TestCatalog.freePack, 1, 2);
      await service.sync();

      // Act
      final second = await service.sync();

      // Assert
      expect(second, isEmpty);
    });

    test('sync_AfterRestart_KeepsEarnedRewardsWithoutCelebrating', () async {
      // Arrange
      await progress.completeLevel(TestCatalog.freePack, 1, 2);
      await createService().sync();

      // Act
      final restarted = createService();
      final fresh = await restarted.sync();

      // Assert
      expect(fresh, isEmpty);
      expect(restarted.earnedCount, 3);
    });

    test('sync_NothingNew_DoesNotNotifyOrWrite', () async {
      // Arrange
      final service = createService();
      var notified = 0;
      service.addListener(() => notified++);

      // Act
      await service.sync();

      // Assert
      expect(notified, 0);
      expect(store.values.containsKey(StorageKeys.achievements), isFalse);
    });

    for (final raw in ['bozuk', '{"earned":"first-game"}', '{"earned":[1,"unknown","first-game"]}']) {
      test('constructor_CorruptOrUnknownRecord_KeepsOnlyKnownIds ($raw)', () {
        // Arrange
        store.values[StorageKeys.achievements] = raw;

        // Act
        final service = createService();

        // Assert
        expect(service.earnedCount, raw.contains('[') ? 1 : 0);
      });
    }

    test('all_ComingSoonGame_IsLeftOutOfEveryGoal', () {
      // Act
      final service = createService();

      // Assert
      final ids = [for (final achievement in service.all) achievement.id];
      expect(ids, contains(AchievementCatalog.gameTrophyId(TestCatalog.gameId)));
      expect(ids, isNot(contains(AchievementCatalog.gameTrophyId(_soonGameId))));
      expect(statusOf(service, 'all-games').progress.goal, 1);
    });

    test('statuses_PaidPackStars_CountOnlyForStarBadges', () async {
      // Arrange
      final service = createService();
      await progress.completeLevel(TestCatalog.packA, 1, 3);

      // Act & Assert
      expect(statusOf(service, 'star-hunter').progress.current, 3);
      expect(statusOf(service, 'first-game').progress.current, 0);
      expect(statusOf(service, 'perfect').progress.current, 0);
    });

    test('statuses_HintUsedLevel_IsNotCountedAsNoHint', () async {
      // Arrange
      final service = createService();
      await progress.completeLevel(TestCatalog.freePack, 1, 1);
      await progress.completeLevel(TestCatalog.freePack, 2, 2);

      // Act & Assert
      expect(statusOf(service, 'no-hint').progress.current, 1);
    });

    test('statuses_AllFreeLevelsDone_EarnsGameTrophyAndChampion', () async {
      // Arrange
      final service = createService();
      final pack = TestCatalog.build().findPack(TestCatalog.freePack)!;
      for (var level = 1; level <= pack.levelCount; level++) {
        await progress.completeLevel(pack.id, level, 3);
      }

      // Act
      final fresh = await service.sync();

      // Assert
      final ids = {for (final status in fresh) status.achievement.id};
      expect(ids, containsAll([AchievementCatalog.gameTrophyId(TestCatalog.gameId), 'champion', 'master-coder']));
    });
  });

  group('AchievementCatalog', () {
    test('build_ProductionCatalog_HasUniqueIdsAndOneTrophyPerGame', () {
      // Arrange
      final services = AppServices.production(InMemoryKeyValueStore());

      // Act
      final all = services.achievements.all;

      // Assert
      final ids = [for (final achievement in all) achievement.id];
      expect(ids.toSet(), hasLength(ids.length));
      for (final game in services.catalog.games.where((game) => services.games.isPlayable(game.id))) {
        expect(ids, contains(AchievementCatalog.gameTrophyId(game.id)));
      }
    });

    test('build_ProductionCatalog_ListsBadgesBeforeTrophies', () {
      // Act
      final kinds = [
        for (final achievement in AppServices.production(InMemoryKeyValueStore()).achievements.all) achievement.kind,
      ];

      // Assert
      final firstTrophy = kinds.indexOf(AchievementKind.trophy);
      expect(kinds.skip(firstTrophy).every((kind) => kind == AchievementKind.trophy), isTrue);
    });
  });
}
