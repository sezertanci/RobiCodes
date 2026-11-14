import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_scope.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/content_catalog.dart';
import 'package:robi_codes/features/settings/settings_dialog.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';
import 'package:robi_codes/features/store/store_screen.dart';
import 'package:robi_codes/features/store/store_texts.dart';
import 'package:robi_codes/games/game_registry.dart';

import '../support/fakes.dart';
import '../support/ui_test_helpers.dart';

const _priceA = '₺20,00';
const _priceB = '₺30,00';
const _priceBundle = '₺40,00';

void main() {
  late FakePurchaseGateway gateway;

  setUp(() {
    gateway = FakePurchaseGateway()
      ..prices = {TestCatalog.productA: _priceA, TestCatalog.productB: _priceB, TestCatalog.bundle: _priceBundle};
  });

  AppServices createServices({bool approves = true, ContentCatalog? catalog}) => AppServices(
    catalog: catalog ?? TestCatalog.build(),
    games: GameRegistry([const FakeGameModule(TestCatalog.gameId)]),
    store: InMemoryKeyValueStore(),
    purchaseGateway: gateway,
    parentalGate: FakeParentalGate(approves: approves),
  );

  Future<AppServices> openStore(WidgetTester tester, {bool approves = true, ContentCatalog? catalog}) async {
    useScreen(tester, TestScreens.tablet);
    final services = createServices(approves: approves, catalog: catalog);
    await services.entitlements.refresh();
    await tester.pumpWidget(
      AppScope(
        services: services,
        child: const MaterialApp(home: StoreScreen()),
      ),
    );
    await settle(tester);
    return services;
  }

  Future<void> tapBuy(WidgetTester tester, String price) => tapVisible(tester, find.text(StoreTexts.buy(price)));

  testWidgets('StoreScreen_NoProductsInCatalog_ShowsEmptyMessageAndFreePacks', (tester) async {
    // Arrange
    final full = TestCatalog.build();
    final catalog = ContentCatalog(games: full.games, packs: full.packs, products: []);

    // Act
    await openStore(tester, catalog: catalog);

    // Assert
    expect(find.text(StoreTexts.noProducts), findsOneWidget);
    expect(find.textContaining(TestCatalog.freePack), findsOneWidget);
    expect(gateway.listingRequests, isEmpty);
  });

  testWidgets('StoreScreen_PricesLoaded_ShowsPlayPricesAndBundleLabel', (tester) async {
    // Act
    await openStore(tester);

    // Assert
    expect(find.text(StoreTexts.buy(_priceA)), findsOneWidget);
    expect(find.text(StoreTexts.buy(_priceB)), findsOneWidget);
    expect(find.text(StoreTexts.buy(_priceBundle)), findsOneWidget);
    expect(find.text(StoreTexts.bundleLabel), findsOneWidget);
  });

  testWidgets('StoreScreen_ParentRejects_ShowsMessageAndStoreNotReached', (tester) async {
    // Arrange
    await openStore(tester, approves: false);

    // Act
    await tapBuy(tester, _priceA);
    await settle(tester);

    // Assert
    expect(find.text(StoreTexts.outcome(PurchaseOutcome.notApproved)), findsOneWidget);
    expect(gateway.purchaseRequests, isEmpty);
  });

  testWidgets('StoreScreen_ParentApprovesPurchase_ShowsOwned', (tester) async {
    // Arrange
    await openStore(tester);

    // Act
    await tapBuy(tester, _priceB);
    await settle(tester);

    // Assert
    expect(gateway.purchaseRequests, [TestCatalog.productB]);
    expect(find.text(StoreTexts.outcome(PurchaseOutcome.purchased)), findsOneWidget);
    expect(find.text(StoreTexts.ownedLabel), findsOneWidget);
    expect(find.text(StoreTexts.buy(_priceB)), findsNothing);
  });

  testWidgets('StoreScreen_PendingPayment_ShowsPendingAndKeepsBuyButton', (tester) async {
    // Arrange
    gateway.nextOutcome = PurchaseOutcome.pending;
    await openStore(tester);

    // Act
    await tapBuy(tester, _priceA);
    await settle(tester);

    // Assert
    expect(find.text(StoreTexts.outcome(PurchaseOutcome.pending)), findsOneWidget);
    expect(find.text(StoreTexts.ownedLabel), findsNothing);
  });

  testWidgets('StoreScreen_OnePackOwned_BundleNotSoldAndMissingPackShown', (tester) async {
    // Arrange
    gateway.owned = {TestCatalog.productA};

    // Act
    await openStore(tester);

    // Assert
    expect(find.text(StoreTexts.buy(_priceBundle)), findsNothing);
    expect(find.text('${StoreTexts.partiallyOwned} Paket B'), findsOneWidget);
    expect(find.text(StoreTexts.buy(_priceB)), findsOneWidget);
  });

  testWidgets('StoreScreen_ProductMissingInPlay_ShowsNotInStore', (tester) async {
    // Arrange
    gateway.prices = {TestCatalog.productA: _priceA, TestCatalog.productB: _priceB};

    // Act
    await openStore(tester);

    // Assert
    expect(find.text(StoreTexts.notInStore), findsOneWidget);
  });

  testWidgets('StoreScreen_PricesUnavailable_ShowsRetryWithoutBuyButtons', (tester) async {
    // Arrange
    gateway.listingsError = StoreError.offline;

    // Act
    await openStore(tester);

    // Assert
    expect(find.text(StoreTexts.priceUnavailable), findsNWidgets(TestCatalog.build().products.length));
    expect(find.text(StoreTexts.buy(_priceA)), findsNothing);
  });

  testWidgets('StoreScreen_RestoreOffline_ShowsCacheKeptMessage', (tester) async {
    // Arrange
    await openStore(tester);
    gateway
      ..owned = null
      ..unreachable = StoreError.offline;

    // Act: liste yalnızca görünen öğeleri kurduğu için düğmeye önce kaydırılır.
    await tester.scrollUntilVisible(find.text(StoreTexts.restore), 300, scrollable: find.byType(Scrollable).last);
    await tapVisible(tester, find.text(StoreTexts.restore));
    await settle(tester);

    // Assert
    expect(find.text(StoreTexts.restoreOffline), findsOneWidget);
  });

  testWidgets('SettingsDialog_StoreEntry_OpensStoreScreen', (tester) async {
    // Arrange
    useScreen(tester, TestScreens.tablet);
    await tester.pumpWidget(RobiCodesApp(services: createServices()));
    await tester.tap(find.byTooltip(SettingsDialog.title));
    await settle(tester);

    // Act
    await tapVisible(tester, find.text(StoreTexts.title));
    await settle(tester);

    // Assert
    expect(find.byType(StoreScreen), findsOneWidget);
  });
}
