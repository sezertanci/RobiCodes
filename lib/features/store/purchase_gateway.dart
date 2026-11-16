/// Satın alma denemesinin sonucu.
enum PurchaseOutcome {
  /// Ödeme tamamlandı; ürün sahipliğe eklendi.
  purchased,

  /// Ödeme beklemede (ör. nakit ödeme). Erişim verilmez; ödeme tamamlanınca sahiplik sorgusunda
  /// görünür ve o zaman açılır.
  pending,

  /// Kullanıcı vazgeçti.
  cancelled,

  /// Ürün zaten kullanıcıya ait; yeniden ücretlendirilmez.
  alreadyOwned,

  /// Avantajlı paketteki içeriklerin bir kısmı zaten kullanıcıya ait; çifte ücretlendirmemek için
  /// mağazaya gidilmedi.
  partiallyOwned,

  /// Ürün Google Play'de bulunamadı (Play Console'da tanımlı veya etkin değil).
  productNotFound,

  /// İnternet bağlantısı yok veya Google Play'e ağ üzerinden ulaşılamadı.
  offline,

  /// Google Play hizmetine bağlanılamadı (Play Store yok, güncel değil veya entegrasyon yok).
  unavailable,

  /// Satın alma başka bir nedenle başarısız oldu.
  failed,

  /// Geçerli bir ebeveyn onayı yoktu; mağazaya hiç gidilmedi.
  notApproved,
}

/// Mağaza sorgusunun neden yapılamadığı.
enum StoreError {
  /// İnternet bağlantısı yok.
  offline,

  /// Google Play hizmetine bağlanılamadı.
  unavailable,
}

/// Mağaza sorgusunun sonucu: değer veya hata.
sealed class StoreQuery<T> {
  const StoreQuery();
}

final class StoreSuccess<T> extends StoreQuery<T> {
  const StoreSuccess(this.value);

  final T value;
}

final class StoreFailure<T> extends StoreQuery<T> {
  const StoreFailure(this.error);

  final StoreError error;
}

/// Google Play'den okunan, kullanıcının ülkesine ve para birimine göre biçimlenmiş fiyat bilgisi.
final class StoreListing {
  const StoreListing({required this.productId, required this.price});

  final String productId;

  /// Play'in biçimlediği fiyat metni (ör. "₺49,99"). Uygulama fiyat hesaplamaz.
  final String price;
}

/// Ödemesi tamamlanmış (PURCHASED) bir satın alma. Bekleyen ödemeler bu türe hiç dönüştürülmez.
final class OwnedPurchase {
  const OwnedPurchase({required this.productId, required this.token, required this.isAcknowledged});

  final String productId;

  /// Satın almanın Google Play'deki benzersiz anahtarı. Aynı satın almanın tekrar işlenmesini
  /// önlemek ve onaylamak (acknowledge) için kullanılır.
  final String token;

  /// Satın alma Google Play'e onaylandı mı. Onaylanmayan satın alma 3 gün sonra iade edilir.
  final bool isAcknowledged;
}

/// Satın alma denemesinin sonucu ve tamamlandıysa satın alma kaydı.
final class PurchaseResult {
  const PurchaseResult(this.outcome, {this.purchase});

  final PurchaseOutcome outcome;

  /// Yalnızca [PurchaseOutcome.purchased] sonucunda dolu olabilir.
  final OwnedPurchase? purchase;
}

/// Mağazayla konuşan katman. Uygulamanın geri kalanı Google Play Billing'i doğrudan tanımaz.
///
/// - Promosyon koduyla alınan ürünler de normal satın alma gibi sahiplik sorgusunda görünür.
///   Kod Play Store'da, uygulama dışında kullanılabileceği için sahiplik, uygulama açılışında
///   ve ön plana her gelişinde yeniden sorgulanır.
/// - Tamamlanan her satın alma 3 gün içinde onaylanmalıdır (acknowledge); aksi halde Google Play
///   ödemeyi iade eder ve erişimi geri alır.
/// - Ürünler tüketilmez (consume edilmez); böylece sahiplik kalıcıdır ve yeniden satın alınamaz.
abstract interface class PurchaseGateway {
  /// Ürünlerin güncel fiyatları. Play'de bulunamayan ürünler sonuç haritasında yer almaz.
  Future<StoreQuery<Map<String, StoreListing>>> queryListings(Set<String> productIds);

  /// Ödemesi tamamlanmış satın almalar (satın alma ve promosyon kodu). Bekleyenler dahil edilmez.
  Future<StoreQuery<List<OwnedPurchase>>> queryOwnedPurchases();

  /// Google Play satın alma penceresini açar ve sonucu bekler.
  Future<PurchaseResult> purchase(String productId);

  /// Satın almayı Google Play'e onaylar. Başarılıysa veya zaten onaylıysa `true` döner.
  Future<bool> acknowledge(OwnedPurchase purchase);

  /// Satın almalar uygulama dışından veya gecikmeli olarak değiştiğinde (ör. bekleyen ödeme
  /// tamamlandığında) bildirim verir. Sahiplik bu bildirimle yeniden sorgulanır.
  Stream<void> get purchasesChanged;
}

/// Google Play'in olmadığı ortamlarda (testler, Android dışı) kullanılan mağaza: hiçbir işlem yapmaz.
final class UnavailablePurchaseGateway implements PurchaseGateway {
  const UnavailablePurchaseGateway();

  @override
  Future<StoreQuery<Map<String, StoreListing>>> queryListings(Set<String> productIds) async =>
      const StoreFailure(StoreError.unavailable);

  @override
  Future<StoreQuery<List<OwnedPurchase>>> queryOwnedPurchases() async => const StoreFailure(StoreError.unavailable);

  @override
  Future<PurchaseResult> purchase(String productId) async => const PurchaseResult(PurchaseOutcome.unavailable);

  @override
  Future<bool> acknowledge(OwnedPurchase purchase) async => false;

  @override
  Stream<void> get purchasesChanged => const Stream.empty();
}
