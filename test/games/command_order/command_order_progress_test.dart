import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/games/command_order/command_order_module.dart';

import '../../support/fakes.dart';

void main() {
  final packId = basePackId(GameIds.commandOrder);

  test('production_CommandOrder_IsRegisteredAndPlayable', () {
    final services = AppServices.production(InMemoryKeyValueStore());
    final pack = services.catalog.packsOf(GameIds.commandOrder).single;

    expect(services.games.isPlayable(GameIds.commandOrder), isTrue);
    expect(services.games.moduleFor(GameIds.commandOrder), isA<CommandOrderModule>());
    expect(services.entitlements.canPlayPack(pack.id), isTrue);
    expect(pack.id, packId);
    expect(pack.levelCount, 20);
  });

  test('levelOf_EveryLevel_ReturnsDataAndRejectsUnknown', () {
    final module = CommandOrderModule();

    for (var level = 1; level <= 20; level++) {
      expect(module.levelOf(packId, level).steps, isNotEmpty);
    }
    expect(() => module.levelOf(packId, 21), throwsArgumentError);
    expect(() => module.levelOf('bilinmeyen', 1), throwsArgumentError);
  });

  test('shuffledCards_SameSeedTwice_AvoidsPreviousOrder', () {
    final module = CommandOrderModule(seedSource: () => 7);

    final first = [for (final card in module.shuffledCards(packId, 6)) card.id];
    final second = [for (final card in module.shuffledCards(packId, 6)) card.id];

    expect(second, isNot(first));
  });

  test('completeLevel_CommandOrderLevel_DoesNotTouchPathFinderProgress', () async {
    final services = AppServices.production(InMemoryKeyValueStore());

    await services.progress.completeLevel(packId, 1, 3);

    expect(services.progress.starsOf(packId, 1), 3);
    expect(services.progress.starsOf(basePackId(GameIds.pathFinder), 1), 0);
  });
}
