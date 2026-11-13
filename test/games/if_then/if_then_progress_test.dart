import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/games/if_then/if_then_module.dart';

import '../../support/fakes.dart';

void main() {
  final packId = basePackId(GameIds.ifThen);

  test('production_IfThen_IsRegisteredAndPlayable', () {
    final services = AppServices.production(InMemoryKeyValueStore());
    final pack = services.catalog.packsOf(GameIds.ifThen).single;

    expect(services.games.isPlayable(GameIds.ifThen), isTrue);
    expect(services.games.moduleFor(GameIds.ifThen), isA<IfThenModule>());
    expect(services.entitlements.canPlayPack(pack.id), isTrue);
    expect(pack.id, packId);
    expect(pack.levelCount, 20);
  });

  test('levelOf_EveryLevel_ReturnsDataAndRejectsUnknown', () {
    final module = IfThenModule();

    for (var level = 1; level <= 20; level++) {
      expect(module.levelOf(packId, level).lane, isNotEmpty);
    }
    expect(() => module.levelOf(packId, 0), throwsArgumentError);
    expect(() => module.levelOf(packId, 21), throwsArgumentError);
    expect(() => module.levelOf('bilinmeyen', 1), throwsArgumentError);
  });

  test('completeLevel_IfThenLevel_DoesNotTouchOtherGamesProgress', () async {
    final services = AppServices.production(InMemoryKeyValueStore());

    await services.progress.completeLevel(packId, 1, 3);

    expect(services.progress.starsOf(packId, 1), 3);
    expect(services.progress.starsOf(basePackId(GameIds.pathFinder), 1), 0);
    expect(services.progress.starsOf(basePackId(GameIds.commandOrder), 1), 0);
  });
}
