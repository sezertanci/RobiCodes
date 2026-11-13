import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/games/repeat/repeat_module.dart';

import '../../support/fakes.dart';

void main() {
  late InMemoryKeyValueStore store;
  late AppServices services;
  late LevelPack pack;

  setUp(() {
    store = InMemoryKeyValueStore();
    services = AppServices.production(store);
    pack = services.catalog.packsOf(GameIds.repeat).single;
  });

  test('production_Repeat_IsRegisteredAndPlayable', () {
    expect(services.games.isPlayable(GameIds.repeat), isTrue);
    expect(services.games.moduleFor(GameIds.repeat), isA<RepeatModule>());
    expect(services.entitlements.canPlayPack(pack.id), isTrue);
    expect(pack.id, basePackId(GameIds.repeat));
    expect(pack.levelCount, 20);
  });

  test('levelOf_EveryLevel_ReturnsDataAndRejectsUnknown', () {
    final module = RepeatModule();

    for (var level = 1; level <= pack.levelCount; level++) {
      expect(module.levelOf(pack.id, level).map, isNotEmpty);
    }
    expect(() => module.levelOf(pack.id, 0), throwsArgumentError);
    expect(() => module.levelOf(pack.id, pack.levelCount + 1), throwsArgumentError);
    expect(() => module.levelOf('bilinmeyen', 1), throwsArgumentError);
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

  test('production_RestartWithSameStore_RestoresProgress', () async {
    await services.progress.completeLevel(pack.id, 1, 3);
    await services.progress.completeLevel(pack.id, 2, 2);

    final restarted = AppServices.production(store);

    expect(restarted.progress.totalStars(pack.id), 5);
    expect(restarted.unlockPolicy.nextLevel(pack), 3);
  });

  test('completeLevel_RepeatLevel_DoesNotTouchOtherGamesProgress', () async {
    await services.progress.completeLevel(pack.id, 1, 3);

    expect(services.progress.starsOf(basePackId(GameIds.pathFinder), 1), 0);
    expect(services.progress.starsOf(basePackId(GameIds.commandOrder), 1), 0);
    expect(services.progress.starsOf(basePackId(GameIds.ifThen), 1), 0);
  });
}
