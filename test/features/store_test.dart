import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/store/entitlement_service.dart';
import 'package:robi_codes/features/store/offer_policy.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';

import '../support/fakes.dart';
import '../support/parental_approvals.dart';

void main() {
  final catalog = TestCatalog.build();
  late FakePurchaseGateway gateway;
  late InMemoryKeyValueStore store;

  EntitlementService createService() => EntitlementService(catalog: catalog, gateway: gateway, store: store);

  setUp(() {
    gateway = FakePurchaseGateway();
    store = InMemoryKeyValueStore();
  });

  group('EntitlementService', () {
    test('canPlayPack_NothingOwned_OnlyFreePackOpen', () {
      final service = createService();

      expect(service.canPlayPack(TestCatalog.freePack), isTrue);
      expect(service.canPlayPack(TestCatalog.packA), isFalse);
    });

    test('refresh_BundleOwned_OpensEveryPackInBundle', () async {
      // Arrange
      gateway.owned = {TestCatalog.bundle};
      final service = createService();

      // Act
      final refreshed = await service.refresh();

      // Assert
      expect(refreshed, isNull);
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
      expect(service.canPlayPack(TestCatalog.packB), isTrue);
    });

    test('refresh_StoreUnavailable_KeepsCachedEntitlements', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      await createService().refresh();
      gateway.owned = null;
      final service = createService();

      // Act
      final refreshed = await service.refresh();

      // Assert
      expect(refreshed, StoreError.unavailable);
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
    });

    test('refresh_PurchaseRefunded_RemovesEntitlement', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      final service = createService();
      await service.refresh();
      gateway.owned = {};

      // Act
      await service.refresh();

      // Assert
      expect(service.canPlayPack(TestCatalog.packA), isFalse);
    });

    test('purchase_Completed_OpensPackAndPersists', () async {
      // Arrange
      final service = createService();

      // Act
      final outcome = await service.purchase(
        TestCatalog.productB,
        approval: await grantApproval(ParentalAction.purchase),
      );

      // Assert
      expect(outcome, PurchaseOutcome.purchased);
      expect(service.canPlayPack(TestCatalog.packB), isTrue);
      expect(store.values[StorageKeys.ownedProducts], '["${TestCatalog.productB}"]');
    });

    test('purchase_Cancelled_DoesNotOpenPack', () async {
      // Arrange
      gateway.nextOutcome = PurchaseOutcome.cancelled;
      final service = createService();

      // Act
      await service.purchase(TestCatalog.productB, approval: await grantApproval(ParentalAction.purchase));

      // Assert
      expect(service.canPlayPack(TestCatalog.packB), isFalse);
    });

    test('purchase_Completed_AcknowledgesOnce', () async {
      // Arrange
      final service = createService();

      // Act
      await service.purchase(TestCatalog.productB, approval: await grantApproval(ParentalAction.purchase));
      await service.refresh();

      // Assert
      expect(gateway.acknowledgeRequests, [FakePurchaseGateway.tokenOf(TestCatalog.productB)]);
    });

    for (final outcome in [
      PurchaseOutcome.pending,
      PurchaseOutcome.failed,
      PurchaseOutcome.offline,
      PurchaseOutcome.unavailable,
      PurchaseOutcome.productNotFound,
      PurchaseOutcome.cancelled,
    ]) {
      test('purchase_${outcome.name}_DoesNotOpenPackOrAcknowledge', () async {
        // Arrange
        gateway.nextOutcome = outcome;
        final service = createService();

        // Act
        final result = await service.purchase(
          TestCatalog.productB,
          approval: await grantApproval(ParentalAction.purchase),
        );

        // Assert
        expect(result, outcome);
        expect(service.canPlayPack(TestCatalog.packB), isFalse);
        expect(gateway.acknowledgeRequests, isEmpty);
        expect(store.values.containsKey(StorageKeys.ownedProducts), isFalse);
      });
    }

    test('purchase_PendingPaymentCompletesLater_OpensPackAndAcknowledges', () async {
      // Arrange: ödeme beklemede kalır, sonra Play tamamlandığını bildirir.
      gateway.nextOutcome = PurchaseOutcome.pending;
      final service = createService();
      await service.purchase(TestCatalog.productB, approval: await grantApproval(ParentalAction.purchase));
      gateway.owned = {TestCatalog.productB};
      gateway.unacknowledged = {TestCatalog.productB};

      // Act
      gateway.changes.add(null);
      await pumpEventQueue();

      // Assert
      expect(service.canPlayPack(TestCatalog.packB), isTrue);
      expect(gateway.acknowledgeRequests, [FakePurchaseGateway.tokenOf(TestCatalog.productB)]);
    });

    test('purchase_PacksAlreadyOpen_DoesNotReachStore', () async {
      // Arrange
      gateway.owned = {TestCatalog.bundle};
      final service = createService();
      await service.refresh();

      // Act
      final outcome = await service.purchase(
        TestCatalog.productA,
        approval: await grantApproval(ParentalAction.purchase),
      );

      // Assert
      expect(outcome, PurchaseOutcome.alreadyOwned);
      expect(gateway.purchaseRequests, isEmpty);
    });

    test('purchase_BundlePartiallyOwned_DoesNotReachStore', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      final service = createService();
      await service.refresh();

      // Act
      final outcome = await service.purchase(
        TestCatalog.bundle,
        approval: await grantApproval(ParentalAction.purchase),
      );

      // Assert
      expect(outcome, PurchaseOutcome.partiallyOwned);
      expect(gateway.purchaseRequests, isEmpty);
    });

    test('purchase_StoreReportsAlreadyOwned_RefreshesOwnership', () async {
      // Arrange: cihazdaki önbellek eski; ürün Play'de zaten kullanıcıya ait.
      gateway.nextOutcome = PurchaseOutcome.alreadyOwned;
      gateway.owned = {TestCatalog.productB};
      final service = createService();

      // Act
      final outcome = await service.purchase(
        TestCatalog.productB,
        approval: await grantApproval(ParentalAction.purchase),
      );

      // Assert
      expect(outcome, PurchaseOutcome.alreadyOwned);
      expect(service.canPlayPack(TestCatalog.packB), isTrue);
    });

    test('purchase_UnknownProduct_ReturnsProductNotFound', () async {
      // Act
      final outcome = await createService().purchase('unknown', approval: await grantApproval(ParentalAction.purchase));

      // Assert
      expect(outcome, PurchaseOutcome.productNotFound);
      expect(gateway.purchaseRequests, isEmpty);
    });

    test('refresh_UnacknowledgedPurchase_AcknowledgesIt', () async {
      // Arrange: uygulama satın alma sırasında kapanmış, onaylama yapılamamış.
      gateway.owned = {TestCatalog.productA};
      gateway.unacknowledged = {TestCatalog.productA};
      final service = createService();

      // Act
      await service.refresh();

      // Assert
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
      expect(gateway.unacknowledged, isEmpty);
    });

    test('refresh_CalledConcurrently_AcknowledgesOnce', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      gateway.unacknowledged = {TestCatalog.productA};
      final service = createService();

      // Act
      await Future.wait([service.refresh(), service.refresh()]);

      // Assert
      expect(gateway.acknowledgeRequests, hasLength(1));
    });

    test('refresh_AcknowledgeFailed_RetriesOnNextRefresh', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      gateway.unacknowledged = {TestCatalog.productA};
      gateway.acknowledgeSucceeds = false;
      final service = createService();
      await service.refresh();
      gateway.acknowledgeSucceeds = true;

      // Act
      await service.refresh();

      // Assert
      expect(gateway.acknowledgeRequests, hasLength(2));
      expect(gateway.unacknowledged, isEmpty);
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
    });

    test('refresh_Offline_ReturnsOfflineAndKeepsCache', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      await createService().refresh();
      gateway
        ..owned = null
        ..unreachable = StoreError.offline;
      final service = createService();

      // Act
      final error = await service.refresh();

      // Assert
      expect(error, StoreError.offline);
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
    });

    test('refresh_SamePurchaseSeenTwice_KeepsSingleEntitlement', () async {
      // Arrange
      gateway.owned = {TestCatalog.productA};
      final service = createService();
      await service.refresh();

      // Act
      await service.refresh();

      // Assert
      expect(service.ownedProductIds, {TestCatalog.productA});
      expect(store.values[StorageKeys.ownedProducts], '["${TestCatalog.productA}"]');
    });

    test('purchasesChanged_PromoCodeRedeemedOutsideApp_OpensPack', () async {
      // Arrange: kod Play Store'da kullanıldı; uygulama ön plana dönünce sahiplik yeniden okunur.
      final service = createService();
      gateway.owned = {TestCatalog.bundle};

      // Act
      gateway.changes.add(null);
      await pumpEventQueue();

      // Assert
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
      expect(service.canPlayPack(TestCatalog.packB), isTrue);
    });

    test('refresh_CorruptCache_RebuildsFromStore', () async {
      // Arrange
      store.values[StorageKeys.ownedProducts] = 'bozuk';
      gateway.owned = {TestCatalog.productB};
      final service = createService();

      // Act
      await service.refresh();

      // Assert
      expect(store.values[StorageKeys.ownedProducts], '["${TestCatalog.productB}"]');
    });

    test('refresh_Restore_DoesNotTouchProgress', () async {
      // Arrange
      const progress = '{"saved":true}';
      store.values[StorageKeys.progress] = progress;
      gateway.owned = {TestCatalog.productA};

      // Act
      await createService().refresh();

      // Assert
      expect(store.values[StorageKeys.progress], progress);
    });

    test('playablePacksOf_OnePackOwned_ReturnsFreeAndOwnedPacksInOrder', () async {
      // Arrange
      gateway.owned = {TestCatalog.productB};
      final service = createService();
      await service.refresh();

      // Act
      final ids = service.playablePacksOf(TestCatalog.gameId).map((pack) => pack.id);

      // Assert
      expect(ids, [TestCatalog.freePack, TestCatalog.packB]);
    });

    test('visiblePacksOf_PaidGameNotOwned_ShowsPreviewPack', () {
      // Arrange
      final service = EntitlementService(catalog: TestCatalog.withPaidGame(), gateway: gateway, store: store);
      final pack = TestCatalog.withPaidGame().findPack(TestCatalog.paidPack)!;

      // Act
      final ids = service.visiblePacksOf(TestCatalog.paidGameId).map((pack) => pack.id);

      // Assert
      expect(ids, [TestCatalog.paidPack]);
      expect(service.playablePacksOf(TestCatalog.paidGameId), isEmpty);
      expect(service.isPreviewOnly(pack), isTrue);
    });

    test('isPreviewOnly_PaidPackOwned_ReturnsFalse', () async {
      // Arrange
      final catalog = TestCatalog.withPaidGame();
      gateway.owned = {TestCatalog.paidProduct};
      final service = EntitlementService(catalog: catalog, gateway: gateway, store: store);
      await service.refresh();

      // Act & Assert
      expect(service.isPreviewOnly(catalog.findPack(TestCatalog.paidPack)!), isFalse);
    });

    test('visiblePacksOf_PackWithoutPreviewNotOwned_HidesIt', () {
      final ids = createService().visiblePacksOf(TestCatalog.gameId).map((pack) => pack.id);

      expect(ids, [TestCatalog.freePack]);
    });

    test('constructor_CachedProducts_ReadsOnlyProductIds', () {
      store.values[StorageKeys.ownedProducts] = '["${TestCatalog.productA}", 1]';

      expect(createService().ownedProductIds, {TestCatalog.productA});
    });

    test('constructor_CorruptCache_StartsEmpty', () {
      store.values[StorageKeys.ownedProducts] = 'bozuk';

      expect(createService().ownedProductIds, isEmpty);
    });
  });

  group('OfferPolicy', () {
    // Örnek fiyatlar (yalnızca senaryoyu anlatmak için): A = 20 TL, B = 50 TL, A+B paketi = 60 TL.
    // A'ya sahip kullanıcı 60 TL'lik paketi alırsa A için ikinci kez ödemiş olur;
    // bu yüzden paket ona gösterilmez, yalnızca B (50 TL) önerilir.
    Future<OfferPolicy> createPolicy(Set<String> owned) async {
      gateway.owned = owned;
      final service = createService();
      await service.refresh();
      return OfferPolicy(catalog, service);
    }

    test('statusOf_NothingOwned_BundleAvailable', () async {
      final policy = await createPolicy({});

      expect(policy.statusOf(catalog.findProduct(TestCatalog.bundle)!), OfferStatus.available);
    });

    test('statusOf_OnePackOwned_BundlePartiallyOwned', () async {
      final policy = await createPolicy({TestCatalog.productA});

      expect(policy.statusOf(catalog.findProduct(TestCatalog.bundle)!), OfferStatus.partiallyOwned);
      expect(policy.statusOf(catalog.findProduct(TestCatalog.productA)!), OfferStatus.alreadyOwned);
    });

    test('statusOf_BundleOwned_SinglePacksAlreadyOwned', () async {
      final policy = await createPolicy({TestCatalog.bundle});

      expect(policy.statusOf(catalog.findProduct(TestCatalog.productB)!), OfferStatus.alreadyOwned);
    });

    test('missingPartsOf_OnePackOwned_OffersOnlyMissingPack', () async {
      // Arrange
      final policy = await createPolicy({TestCatalog.productA});

      // Act
      final missing = policy.missingPartsOf(catalog.findProduct(TestCatalog.bundle)!);

      // Assert
      expect(missing.map((product) => product.id), [TestCatalog.productB]);
    });
  });
}
