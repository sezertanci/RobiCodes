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
      expect(refreshed, isTrue);
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
      expect(refreshed, isFalse);
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
