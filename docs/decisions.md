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

## Bulut kaydı ve hesap bağlama

- Google Play Games Services v2'nin güncel gereksinimleri ve Families politikasının çocuk
  uygulamalarında oturum açmaya ilişkin koşulları, bulut kaydı aşamasında **yeniden araştırılır ve
  doğrulanır**.
- Politikalara uygunluk doğrulanmadan entegrasyona başlanmaz.
- Ebeveyn doğrulaması olmadan hesap bağlantısı yapılmaz.
