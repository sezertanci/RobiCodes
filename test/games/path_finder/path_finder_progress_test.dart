import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/games/path_finder/path_finder_module.dart';

import '../../support/fakes.dart';

void main() {
  late InMemoryKeyValueStore store;
  late AppServices services;
  late LevelPack pack;

  setUp(() {
    store = InMemoryKeyValueStore();
    services = AppServices.production(store);
    pack = services.catalog.packsOf(GameIds.pathFinder).single;
  });

  test('production_PathFinder_IsRegisteredAndPlayable', () {
    expect(services.games.isPlayable(GameIds.pathFinder), isTrue);
    expect(services.games.moduleFor(GameIds.pathFinder), isA<PathFinderModule>());
    expect(services.entitlements.canPlayPack(pack.id), isTrue);
  });

  test('levelOf_EveryLevel_ReturnsData', () {
    final module = PathFinderModule();

    for (var level = 1; level <= pack.levelCount; level++) {
      expect(module.levelOf(pack.id, level).board, isNotNull);
    }
    expect(() => module.levelOf(pack.id, pack.levelCount + 1), throwsArgumentError);
  });

  test('isLevelUnlocked_FreshStart_OnlyFirstLevelOpen', () {
    expect(services.unlockPolicy.isLevelUnlocked(pack, 1), isTrue);
    expect(services.unlockPolicy.isLevelUnlocked(pack, 2), isFalse);
    expect(services.unlockPolicy.nextLevel(pack), 1);
  });

  test('isLevelUnlocked_EasyGroupFinished_OpensMediumGroup', () async {
    for (var level = 1; level <= 4; level++) {
      await services.progress.completeLevel(pack.id, level, 1);
    }
    expect(services.unlockPolicy.isLevelUnlocked(pack, 6), isFalse);

    await services.progress.completeLevel(pack.id, 5, 1);

    expect(services.unlockPolicy.isLevelUnlocked(pack, 6), isTrue);
    expect(services.unlockPolicy.isLevelUnlocked(pack, 7), isFalse);
  });

  test('completeLevel_WorseReplay_KeepsBestStars', () async {
    await services.progress.completeLevel(pack.id, 1, 3);

    await services.progress.completeLevel(pack.id, 1, 1);

    expect(services.progress.starsOf(pack.id, 1), 3);
  });

  test('production_RestartWithSameStore_RestoresProgressAndLocks', () async {
    await services.progress.completeLevel(pack.id, 1, 3);
    await services.progress.completeLevel(pack.id, 2, 2);

    final restarted = AppServices.production(store);

    expect(restarted.progress.starsOf(pack.id, 1), 3);
    expect(restarted.progress.starsOf(pack.id, 2), 2);
    expect(restarted.progress.totalStars(pack.id), 5);
    expect(restarted.unlockPolicy.nextLevel(pack), 3);
  });
}
