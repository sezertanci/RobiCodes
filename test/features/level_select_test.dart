import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
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
}
