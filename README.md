# Robi Kodluyor (Android)

Çocuklara temel kodlama düşüncesini (sıralama, koşul, döngü, yön bulma) oyunlarla öğreten uygulamanın
yalnızca Android için, tamamen Flutter/Dart ile yazılan yeni sürümü. WebView, HTML, CSS veya JavaScript
kullanılmaz. Önceki web sürümü (Mini Kodlama Dünyası, `MiniCodingWorld` klasörü) referans olarak korunur ve bu projeden bağımsızdır.

> **Durum — 2. aşama:** Temel mimari hazır. "Robotun Yolunu Bul" oyunu 20 seviyesiyle oynanabilir;
> diğer oyunlar ana ekranda "Yakında" olarak görünür. Ses henüz yok. Google Play Billing, promosyon kodu, Google hesabı, bulut kaydı ve nihai
> ebeveyn doğrulaması henüz entegre edilmedi; yerlerinde çalışmayan taslak sınıflar vardır.
>
> Ürün ve kapsam kararları: [docs/decisions.md](docs/decisions.md). Aşama durumu: [PROGRESS.md](PROGRESS.md).

## Gereksinimler

- Flutter (stable kanal, Dart 3.13 veya üstü)
- Android SDK ve bir Android cihaz veya emülatör
- Android Studio'nun JDK'si (Gradle derlemesi için)

## Çalıştırma

```bash
flutter pub get
```

```bash
flutter run
```

Denetimler:

```bash
flutter analyze
```

```bash
flutter test
```

```bash
flutter build apk --debug
```

## Mimari

```
lib/
  app/            Bileşim kökü (AppServices), AppScope, tema, uygulama widget'ı
  core/           Ortak altyapı: anahtar-değer deposu, kayıt anahtarları, JSON yardımcıları
  content/        İçerik kataloğu: oyunlar, seviye paketleri, mağaza ürünleri
  games/          Oyun modülü sözleşmesi (GameModule) ve kayıt defteri (GameRegistry)
    path_finder/  Robotun Yolunu Bul
      engine/     Harita, seviye verisi (20 seviye) ve oyun kuralları; Flutter'dan bağımsız
      ui/         Harita, komut şeridi, yön tuşları ve duyarlı oyun ekranı
  features/
    play/         Bütün oyunların ortak seviye seçim, seviye ve sonuç ekranları
    progress/     Yıldız kuralı, ilerleme kaydı, grup ve seviye kilitleri
    store/        Mağaza katmanı, erişim hakları, çifte ücretlendirmeyi önleyen satış kuralı
    cloud_save/   İsteğe bağlı bulut kaydı, kayıt birleştirme
    parental_gate/ Ebeveyn doğrulaması ve korumalı işlem çalıştırıcı
    home/         Ana ekran
assets/           Web sürümünden değiştirilmeden kopyalanan görseller (robot, harita, düğme, ikon)
```

- **İçerik ile mekanik ayrıdır.** Oyunlar, paketler ve ürünler `content/catalog_data.dart` içindeki
  katalogdan gelir. Kodun hiçbir yeri sabit oyun veya seviye sayısı varsaymaz. Yeni oyun, `GameModule`
  arayüzünü uygulayan bir sınıfla eklenir ve `AppServices.production` içinde kaydedilir.
- **Paket:** Bir oyunun birlikte sunulan seviyeleri. Bir oyunun birden çok paketi olabilir. İlerleme
  paket kimliğiyle tutulur; bu kimlikler yayından sonra değiştirilmez.
- **Ücretsiz / ücretli:** Bir paketi açan mağaza ürünü yoksa paket ücretsizdir. Bu bilgi ayrıca yazılmaz.
- **Bağımlılıklar** arayüzler üzerinden alınır ve `AppServices` içinde elle kurulur. Durum yönetimi için
  ek paket kullanılmaz; servisler `ChangeNotifier`'dır.
- **Dış bağımlılıklar:** `shared_preferences` (cihazda kayıt) ve `flutter_svg` (web sürümünün SVG
  görsellerini göstermek için; Flutter SVG'yi kendisi çizemez).
- **Oyun ekranı:** Genişliği 760 ve yüksekliği 520 pikselden büyük ekranlarda (tablet) harita solda,
  kontroller sağdadır; ikisi ekranda ortalanmış bir grup oluşturur. Telefonda kontroller altta sabit
  durur ve harita aradaki alana sığdırılır; ekran çok kısaysa (yatay telefon) bütün içerik kaydırılır.
  Tablette düğmeler, harita kareleri ve seviye kutuları ekranın kısa kenarına göre büyür
  (`app/screen_scale.dart`); telefondaki boyutlar değişmez. "Hareketi azalt" ayarı açıksa robot hızlı
  yürür ve tepki animasyonları oynatılmaz.
- **Seviye seçimi:** Web sürümündeki gibi her zorluk grubu kendi renginde bir paneldir (Kolay yeşil, Orta
  mavi, Zor mor, Uzman kırmızı). Panelde başlık şeridi, tamamlanan seviye rozeti, kilitliyse uyarı ve hap
  biçimli seviye satırları bulunur; kilitli grup soluk görünür. Paneller ekran genişliğine göre bir
  (telefon), iki (560 dp ve üstü) veya dört (960 dp ve üstü) sütuna dizilir.

### Kurallar (web sürümünden aynen alındı)

- Yıldız: ipucu kullanılırsa 1, ipucusuz bitirilirse 2, ipucusuz ve hedefe uygun bitirilirse 3.
- Bir grup, önceki grubun bütün seviyeleri bitince açılır. Bir seviye, önceki seviye bitince açılır.
- Bir seviyenin kaydı her zaman en iyi sonucu korur.

## Satın alma kararları

- Bütün ürünler **tek seferlik ve tüketilmeyen** ürünlerdir; satın alınan içerik kalıcıdır ve
  "Satın alımları geri yükle" ile başka cihazda da açılır.
- Google Play'de ayrı bir "bundle" ürün türü yoktur. Bu yüzden **avantajlı paket ayrı bir üründür**;
  hangi paketleri açtığını uygulama katalogdaki eşlemeden bilir.
- **Çifte ücretlendirme önlenir:** Kullanıcı avantajlı paketteki paketlerden birine zaten sahipse
  avantajlı paket ona gösterilmez; yalnızca eksik paketler tek tek önerilir (`OfferPolicy`).
- **Promosyon kodları** yalnızca Google Play'in resmi kodlarıdır. Kodla alınan ürün, normal satın alma
  gibi sahiplik sorgusunda görünür; ayrı bir kod yolu yoktur. Kod uygulama dışında da kullanılabildiği
  için sahiplik uygulama açılışında (ileride ön plana dönüşte de) yeniden sorgulanır.
- Sahip olunan ürünler cihazda önbelleğe alınır. Mağazaya ulaşılamazsa önbellek korunur; uygulama
  internetsiz çalışır.
- Satın almalar bulut kaydına yazılmaz; her zaman Google Play'den okunur.

## Bulut kaydı kararları

- Bulut kaydı isteğe bağlıdır ve varsayılan olarak kapalıdır. Kayıt önce cihaza yapılır.
- İleride Google Play Games Services v2 Saved Games ile bağlanacak (`CloudSaveGateway`).
- İki kayıt birleştirilirken her seviyenin en yüksek yıldızı alınır; hiçbir ilerleme kaybolmaz.

## Ebeveyn doğrulaması

Satın alma, hesap bağlama, bulut eşitlemesini açma, çıkış ve hesap değiştirme `ProtectedActionRunner` üzerinden çalışır. Nihai doğrulama yöntemi seçilene kadar
`LockedParentalGate` bu işlemlerin hepsini engeller.
