import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/content/content_catalog.dart';
import 'package:robi_codes/features/store/listing_service.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';

import '../support/fakes.dart';

void main() {
  late FakePurchaseGateway gateway;

  setUp(() => gateway = FakePurchaseGateway());

  test('load_NoProductsInCatalog_DoesNotQueryStore', () async {
    // Arrange
    final service = ListingService(
      catalog: ContentCatalog(games: [], packs: [], products: []),
      gateway: gateway,
    );

    // Act
    await service.load();

    // Assert
    expect(gateway.listingRequests, isEmpty);
  });

  test('load_PricesFromStore_ExposesListingsAndMissingProducts', () async {
    // Arrange
    gateway.prices = {TestCatalog.productA: '₺20,00'};
    final service = ListingService(catalog: TestCatalog.build(), gateway: gateway);

    // Act
    await service.load();

    // Assert
    expect(service.listingOf(TestCatalog.productA)!.price, '₺20,00');
    expect(service.listingOf(TestCatalog.productB), isNull);
    expect(service.error, isNull);
    expect(service.isLoading, isFalse);
  });

  test('load_StoreUnreachable_ExposesError', () async {
    // Arrange
    gateway.listingsError = StoreError.offline;
    final service = ListingService(catalog: TestCatalog.build(), gateway: gateway);

    // Act
    await service.load();

    // Assert
    expect(service.error, StoreError.offline);
    expect(service.listingOf(TestCatalog.productA), isNull);
  });
}
