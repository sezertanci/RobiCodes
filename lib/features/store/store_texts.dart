import 'purchase_gateway.dart';

/// Mağaza ekranındaki metinler. Ton sakin ve bilgilendiricidir; satın almaya yönlendiren,
/// aciliyet veya indirim vurgusu yapan ifadeler kullanılmaz.
abstract final class StoreTexts {
  static const title = 'Paketler';
  static const intro =
      'Satın almalar Google Play üzerinden yapılır ve her satın almadan önce ebeveyn onayı istenir. '
      'Google Play promosyon kodunu ödeme ekranındaki "Kodu kullan" bağlantısından veya Play Store '
      'uygulamasından kullanabilirsiniz; kodla alınan paket de burada sahip olunan olarak görünür.';
  static const paidSection = 'Satın alınabilir paketler';
  static const freeSection = 'Ücretsiz paketler';
  static const noProducts = 'Şu an satın alınabilir paket yok.';
  static const bundleLabel = 'Avantajlı paket';
  static const ownedLabel = 'Sahipsiniz';
  static const unlocksLabel = 'Satın alındığında açılanlar:';
  static const priceLoading = 'Fiyat Google Play\'den alınıyor…';
  static const priceUnavailable = 'Fiyat Google Play\'den alınamadı.';
  static const notInStore = 'Bu paket şu an Google Play\'de bulunmuyor.';
  static const retry = 'Tekrar dene';
  static const partiallyOwned =
      'Bu paketteki içeriklerin bir kısmına zaten sahipsiniz. Google Play fiyatı sahip olduklarınıza göre '
      'düşürmediği için aynı içerik için iki kez ödeme yapmamanız adına bu paket satılmıyor. '
      'Eksik paketler:';
  static const restore = 'Satın alımları geri yükle';
  static const restoreHint = 'Google Play hesabınızdaki satın alımları yeniden okur; oyun ilerlemesi silinmez.';
  static const restored = 'Satın alımlar Google Play\'den yeniden okundu.';
  static const restoreOffline = 'İnternet bağlantısı yok; cihazdaki satın alma kayıtları geçerli kalır.';
  static const restoreUnavailable = 'Google Play\'e bağlanılamadı; cihazdaki satın alma kayıtları geçerli kalır.';

  static String buy(String price) => 'Satın al – $price';

  static String levels(int count) => '$count seviye';

  static String restoredOwned(int count) => '$restored Sahip olunan ürün: $count.';

  static String restoreResult(StoreError? error, int ownedCount) => switch (error) {
    null => restoredOwned(ownedCount),
    StoreError.offline => restoreOffline,
    StoreError.unavailable => restoreUnavailable,
  };

  static String outcome(PurchaseOutcome outcome) => switch (outcome) {
    PurchaseOutcome.purchased => 'Satın alma tamamlandı; paket açıldı.',
    PurchaseOutcome.pending => 'Ödeme beklemede. Ödeme tamamlanınca paket kendiliğinden açılır.',
    PurchaseOutcome.cancelled => 'Satın alma iptal edildi.',
    PurchaseOutcome.alreadyOwned => 'Bu pakete zaten sahipsiniz; yeniden satın alınmadı.',
    PurchaseOutcome.productNotFound => notInStore,
    PurchaseOutcome.offline => 'İnternet bağlantısı yok. Bağlantıyı kontrol edip tekrar deneyin.',
    PurchaseOutcome.unavailable => 'Google Play\'e bağlanılamadı. Daha sonra tekrar deneyin.',
    PurchaseOutcome.failed => 'Satın alma tamamlanamadı.',
    PurchaseOutcome.notApproved => 'Ebeveyn onayı verilmedi; satın alma başlatılmadı.',
  };
}
