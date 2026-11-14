# Ürün kararları

1. aşamanın sonunda açık kalan sorulara verilen cevaplar (13.11.2026). Teknik mimari kararları
[README](../README.md) içindedir; bu belge ürün ve kapsam kararlarını tutar.

## Yayın ve paket adı

- Eski WebView uygulaması dahil hiçbir sürüm Play'de yayınlanmadı. Bu yüzden eski bir paket adını
  sürdürme zorunluluğu yoktur.
- Uygulama adı **Robi Kodluyor**, paket adı `com.sezertanci.robicodes` olarak kalır.

## Ücretli paketlere erişim

- Ücretli bir paketi açmak için ücretsiz paketlerin tamamlanması **gerekmez**.
- Her paket bağımsız olarak satın alınabilir.
- Bir bundle, yalnızca kendi içerdiği paketlerin erişimini açar.
- Paketin içindeki grup ve seviye kilitleri, ücretsiz paketlerdeki kuralla aynı şekilde işler.

## Ses efektleri

- Web sürümünde sesler kodla üretilir. Flutter sürümünde bu sesler **dosya olarak** hazırlanır ve
  uygulama varlıklarından (assets) çalınır.
- Sesleri çalmak için uygun ve hafif tek bir ses paketi kullanılır.
- Ses çalma ayrı bir modüldür; oyun mekanikleri ses paketine veya dosyalara doğrudan bağlı olmaz.

## Rozet ve kupalar

- Koşullarda sabit oyun veya seviye sayısı kullanılmaz ("4 oyun", "80 seviye" gibi).
- Sistem veri odaklıdır: koşullar katalogdaki oyunlar ve seviyeler üzerinden hesaplanır. Yeni oyun ve
  seviyeler eklendiğinde rozet ve kupalar kendiliğinden uyum sağlar.

## Bulut kaydı ve hesap bağlama (14.11.2026)

- **Bulut kaydı ve Google hesabı bağlama yapılmaz.** İlerleme yalnızca cihazda tutulur.
- Gerekçe: Google'ın [API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy)
  belgesine göre yalnızca çocuklara yönelik bir uygulama Google Sign-In'i ve Google hesabı verisine
  erişen Google API'lerini kullanmamalıdır; bu yasak Google Play Games Services'i de kapsar. Karma
  kitleli uygulamalarda yalnızca isteğe bağlı olarak sunulabilir. Uygulamanın hedef kitlesi çocuklar
  olduğu için Play Games Services (Saved Games dahil) eklenmez.
- Ek bulgu: Play Games Services v2'de uygulama içinden çıkış (sign-out) API'si yoktur; hesap cihaz
  ayarlarından yönetilir.
- Daha önce eklenen ve hiçbir ekrana bağlı olmayan taslak bulut kodu (`cloud_save`) ile hesap ve
  bulut işlemlerine ait ebeveyn onayı eylemleri kaldırıldı.
