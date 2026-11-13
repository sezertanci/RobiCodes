import '../../content/content_catalog.dart';
import '../../content/models/store_product.dart';
import 'entitlement_service.dart';

/// Bir ürünün kullanıcıya satılıp satılamayacağı.
enum OfferStatus {
  /// Ürünün açtığı paketlerin hiçbiri kullanıcıda yok; satılabilir.
  available,

  /// Ürünün açtığı bütün paketlere zaten erişim var; satılmaz.
  alreadyOwned,

  /// Avantajlı paketteki paketlerin bir kısmına zaten erişim var. Google Play fiyatı sahipliğe göre
  /// düşürmediği için bu durumda avantajlı paket satılmaz; eksik paketler tek tek önerilir.
  partiallyOwned,
}

/// Çifte ücretlendirmeyi önleyen satış kuralı. Mağaza ekranı yalnızca `available` ürünleri gösterir.
final class OfferPolicy {
  const OfferPolicy(this._catalog, this._entitlements);

  final ContentCatalog _catalog;
  final EntitlementService _entitlements;

  OfferStatus statusOf(StoreProduct product) {
    final ownedCount = product.packIds.where(_entitlements.canPlayPack).length;
    if (ownedCount == 0) {
      return OfferStatus.available;
    }
    return ownedCount == product.packIds.length ? OfferStatus.alreadyOwned : OfferStatus.partiallyOwned;
  }

  /// Avantajlı paketin, kullanıcıda olmayan paketlerini tek başına satan ürünler.
  List<StoreProduct> missingPartsOf(StoreProduct bundle) => [
    for (final packId in bundle.packIds)
      if (!_entitlements.canPlayPack(packId))
        ..._catalog
            .productsGranting(packId)
            .where((product) => !product.isBundle && statusOf(product) == OfferStatus.available),
  ];
}
