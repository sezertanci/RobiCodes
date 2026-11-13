/// Bulut kaydıyla konuşan katman. Gerçek entegrasyon ileride Google Play Games Services v2
/// Saved Games ile bu arayüzü uygulayan bir sınıfla eklenir.
///
/// Gerçek uygulamada dikkat edilecekler:
/// - Saved Games, Play Console'da etkinleştirilmeden çalışmaz.
/// - Kayıt dosyası en fazla 3 MB, kapak görseli en fazla 800 KB olabilir.
/// - Çakışma çözümü hazır gelmez; uygulama `ProgressMerger` ile iki kaydı birleştirir.
/// - Buraya yalnızca ilerleme yazılır. Satın almalar her zaman Google Play'den okunur.
abstract interface class CloudSaveGateway {
  /// Oyuncu bir bulut hesabına bağlı mı.
  Future<bool> isSignedIn();

  /// Buluttaki kaydı okur. Kayıt yoksa boş metin, buluta ulaşılamazsa `null` döner.
  Future<String?> load();

  /// Kaydı buluta yazar. Başarılıysa `true` döner.
  Future<bool> save(String data);
}

/// Bulut entegrasyonu yapılana kadar kullanılan katman: hiçbir hesaba bağlanmaz.
final class NoCloudSaveGateway implements CloudSaveGateway {
  const NoCloudSaveGateway();

  @override
  Future<bool> isSignedIn() async => false;

  @override
  Future<String?> load() async => null;

  @override
  Future<bool> save(String data) async => false;
}
