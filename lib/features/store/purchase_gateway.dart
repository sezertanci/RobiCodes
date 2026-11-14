/// Satın alma denemesinin sonucu.
enum PurchaseOutcome {
  /// Ödeme tamamlandı; ürün sahipliğe eklendi.
  purchased,

  /// Ödeme beklemede (ör. nakit ödeme). Tamamlanınca sahiplik sorgusunda görünür.
  pending,

  /// Kullanıcı vazgeçti.
  cancelled,

  /// Ürün zaten kullanıcıya ait; yeniden ücretlendirilmez.
  alreadyOwned,

  /// Mağazaya ulaşılamadı (internet yok, Play Store yok veya entegrasyon henüz yapılmadı).
  unavailable,

  /// Geçerli bir ebeveyn onayı yoktu; mağazaya hiç gidilmedi.
  notApproved,
}

/// Mağazayla konuşan katman. Uygulamanın geri kalanı Google Play Billing'i doğrudan tanımaz;
/// gerçek entegrasyon ileride bu arayüzü uygulayan bir sınıfla eklenir.
///
/// Gerçek uygulamada dikkat edilecekler:
/// - Promosyon koduyla alınan ürünler de normal satın alma gibi sahiplik sorgusunda görünür.
///   Kod Play Store'da, uygulama dışında kullanılabileceği için sahiplik, uygulama açılışında
///   ve ön plana her gelişinde yeniden sorgulanır.
/// - Tamamlanan her satın alma 3 gün içinde onaylanmalıdır (acknowledge); aksi halde Google Play
///   ödemeyi iade eder ve erişimi geri alır.
/// - Ürünler tüketilmez (consume edilmez); böylece sahiplik kalıcıdır ve yeniden satın alınamaz.
abstract interface class PurchaseGateway {
  /// Kullanıcının sahip olduğu ürün kimlikleri. Mağazaya ulaşılamazsa `null` döner;
  /// bu durumda cihazdaki önbellek korunur.
  Future<Set<String>?> queryOwnedProductIds();

  Future<PurchaseOutcome> purchase(String productId);
}

/// Satın alma entegrasyonu yapılana kadar kullanılan mağaza: hiçbir işlem yapmaz.
final class UnavailablePurchaseGateway implements PurchaseGateway {
  const UnavailablePurchaseGateway();

  @override
  Future<Set<String>?> queryOwnedProductIds() async => null;

  @override
  Future<PurchaseOutcome> purchase(String productId) async => PurchaseOutcome.unavailable;
}
