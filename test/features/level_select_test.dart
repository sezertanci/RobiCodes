import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/games/game_registry.dart';

import '../support/fakes.dart';
import '../support/test_l10n.dart';
import '../support/ui_test_helpers.dart';

void main() {
  testWidgets('LevelSelectScreen_PackOwnedWhileOpen_ShowsNewPack', (tester) async {
    // Arrange: mağaza ekran açıldıktan sonra cevap verir (uygulama açılışındaki gecikme gibi).
    final gateway = FakePurchaseGateway();
    final catalog = TestCatalog.build();
    final services = AppServices(
      catalog: catalog,
      games: GameRegistry([const FakeGameModule(TestCatalog.gameId)]),
      store: InMemoryKeyValueStore(),
      purchaseGateway: gateway,
    );
    final paidPackTitle = catalog.findPack(TestCatalog.packA)!.title(texts);
    await tester.pumpWidget(RobiCodesApp(services: services));
    await openLevelSelect(tester, catalog.games.single.title(texts));
    expect(find.text(paidPackTitle), findsNothing);

    // Act
    gateway.owned = {TestCatalog.productA};
    await services.entitlements.refresh();
    await settle(tester);

    // Assert
    await tester.scrollUntilVisible(find.text(paidPackTitle), 300, scrollable: find.byType(Scrollable).last);
    expect(find.text(paidPackTitle), findsOneWidget);
  });

  group('Paid game preview', () {
    const price = '₺49,99';

    Future<AppServices> openPaidGame(WidgetTester tester, {required FakeParentalGate gate}) async {
      final catalog = TestCatalog.withPaidGame();
      final gateway = FakePurchaseGateway()..prices = {TestCatalog.paidProduct: price};
      final services = AppServices(
        catalog: catalog,
        games: GameRegistry([const FakeGameModule(TestCatalog.gameId), const FakeGameModule(TestCatalog.paidGameId)]),
        store: InMemoryKeyValueStore(),
        purchaseGateway: gateway,
        parentalGate: gate,
      );
      await services.listings.load();
      await tester.pumpWidget(RobiCodesApp(services: services));
      await openLevelSelect(tester, catalog.findGame(TestCatalog.paidGameId)!.title(texts));
      return services;
    }

    testWidgets('LevelSelectScreen_PaidGameNotOwned_ShowsPreviewNoteAndPrice', (tester) async {
      // Arrange & Act
      final services = await openPaidGame(tester, gate: FakeParentalGate(approves: false));
      final pack = services.catalog.findPack(TestCatalog.paidPack)!;

      // Assert
      expect(find.text(texts.playPreviewNote), findsOneWidget);
      expect(find.text(texts.storeBuy(price)), findsOneWidget);
      expect(services.unlockPolicy.isLevelUnlocked(pack, 1), isTrue);
      expect(services.unlockPolicy.isLevelUnlocked(pack, 2), isFalse);
    });

    testWidgets('LevelSelectScreen_LockedPaidLevelTapped_AsksParentalApproval', (tester) async {
      // Arrange
      final gate = FakeParentalGate(approves: false);
      await openPaidGame(tester, gate: gate);

      // Act
      await tester.tap(find.bySemanticsLabel(texts.playLevelLocked(2)));
      await settle(tester);

      // Assert
      expect(gate.requests, [ParentalAction.purchase]);
      expect(find.text(texts.storeNotApproved), findsOneWidget);
    });
  });
}
