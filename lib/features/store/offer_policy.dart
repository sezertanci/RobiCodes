import '../../content/content_catalog.dart';
import '../../content/models/store_product.dart';
import 'entitlement_service.dart';

export 'entitlement_service.dart' show OfferStatus;

/// Mağaza ekranının satış kuralı. Ürünün durumu [EntitlementService.offerStatusOf]'tan gelir; satın alma
/// da aynı kuralla engellendiği için çifte ücretlendirme ekrana bağlı kalmaz. Ekran yalnızca `available`
/// ürünlere satın alma düğmesi gösterir.
final class OfferPolicy {
  const OfferPolicy(this._catalog, this._entitlements);

  final ContentCatalog _catalog;
  final EntitlementService _entitlements;

  OfferStatus statusOf(StoreProduct product) => _entitlements.offerStatusOf(product);

  /// Avantajlı paketin, kullanıcıda olmayan paketlerini tek başına satan ürünler.
  List<StoreProduct> missingPartsOf(StoreProduct bundle) => [
    for (final packId in bundle.packIds)
      if (!_entitlements.canPlayPack(packId))
        ..._catalog
            .productsGranting(packId)
            .where((product) => !product.isBundle && statusOf(product) == OfferStatus.available),
  ];
}
