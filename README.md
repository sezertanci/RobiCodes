# Robi Kodluyor / Robi Codes (Android)

Çocuklara temel kodlama düşüncesini (sıralama, koşul, döngü, yön bulma) oyunlarla öğreten uygulamanın
yalnızca Android için, tamamen Flutter/Dart ile yazılan yeni sürümü. WebView, HTML, CSS veya JavaScript
kullanılmaz. Önceki web sürümü (Mini Kodlama Dünyası, `MiniCodingWorld` klasörü) referans olarak korunur ve bu projeden bağımsızdır.

> **Durum — yayına hazırlık:** Temel mimari hazır. "Robotun Yolunu Bul", "Komutları Sırala", "Eğer Böyleyse" ve
> "Tekrar Et" oyunları 20'şer seviyeyle oynanabilir; diğer oyunlar ana ekranda "Yakında" olarak görünür.
> Ses efektleri, ses ayarı, sonuç panelindeki konfeti ve karakter seçimi, rozetler ve kupalar eklendi.
> Google Play Billing ile paket satın alma ve matematik sorulu ebeveyn doğrulaması eklendi. Uygulama
> Türkçe ve İngilizce oynanır (bkz. "Dil desteği"). Google hesabı
> ve bulut kaydı yoktur; ilerleme yalnızca cihazda tutulur (bkz. "İlerleme kaydı"). Release derlemesi Google
> Play'e yüklenecek yükleme anahtarıyla imzalanır (bkz. "Release derlemesi ve imzalama").
>
> Ürün ve kapsam kararları: [docs/decisions.md](docs/decisions.md). Aşama durumu: [PROGRESS.md](PROGRESS.md).

## Gereksinimler

- Flutter (stable kanal, Dart 3.13 veya üstü)
- Android SDK ve bir Android cihaz veya emülatör
- Android Studio'nun JDK'si (Gradle derlemesi için)
- Release derlemesi için ayrıca Android SDK Command-line Tools ve Flutter'ın istediği NDK sürümü
  (`flutter build appbundle` hata ayıklama sembollerini bunlarla ayırır; eksikse "failed to strip debug
  symbols" hatası verir)

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
    command_order/ Komutları Sırala
      engine/     Seviye verisi (20 seviye), karıştırma, sıra kontrolü ve ipucu; Flutter'dan bağımsız
      ui/         Görev kartı, numaralı kutular, kart havuzu, sürüklenebilir kartlar ve oyun ekranı
    if_then/      Eğer Böyleyse
      engine/     Seviye verisi (20 seviye), yol ayrıştırma, kural seçimi, çalıştırma ve ipucu; Flutter'dan bağımsız
      ui/         Robotun yolu, kural tahtası, blok paleti, sürüklenebilir bloklar ve oyun ekranı
    repeat/       Tekrar Et
      engine/     Blok programı, seviye verisi (20 seviye), açma, çalıştırma ve ipucu; Flutter'dan bağımsız
      ui/         Blok şeridi, turuncu tekrar blokları, Tekrarla düğmesi ve oyun ekranı (harita ortak)
  features/
    play/         Bütün oyunların ortak seviye seçim, seviye ve sonuç ekranları
      widgets/    Ortak parçalar: konuşma balonu, görselli düğme, kesik çerçeve, seviye grup paneli,
                  robot görüntüsü, ipucu ve yanlış işaretleri, nabız gibi atan ipucu çerçevesi, konfeti
    progress/     Yıldız kuralı, ilerleme kaydı, grup ve seviye kilitleri
    achievements/ Rozet ve kupa kataloğu, kazanma koşulları, kayıt servisi, Başarılarım ekranı,
                  rozet bildirimi ve kupa penceresi
    character/    Seçilebilen karakterler, seçimi saklayan servis ve karakter seçme penceresi
    sound/        Ses efektleri, ses servisi (açık/kapalı ayarı) ve ses çalıcı
    language/     Dil seçimi: cihaz dilini çözen ve kullanıcının seçimini saklayan servis
    settings/     Ayarlar penceresi ve dil seçici
    store/        Mağaza katmanı, erişim hakları, çifte ücretlendirmeyi önleyen satış kuralı
    parental_gate/ Ebeveyn doğrulaması, korumalı işlem çalıştırıcı ve sayıları dile göre yazıyla yazan sınıflar
    home/         Ana ekran, karakter ve Başarılarım düğmeleri
  l10n/           Dil dosyaları (app_tr.arb, app_en.arb), LocalizedText ve flutter gen-l10n'un ürettiği kod
assets/           Web sürümünden değiştirilmeden kopyalanan görseller (robot, harita, düğme, ikon) ve
                  sounds/ altında ses efektleri
store/robi-codes/ Google Play için yayın sayfaları: gizlilik politikası (privacy.html). Değişiklik burada
                  yapılır ve sezertanci.github.io reposundaki robi-codes/ klasörüne kopyalanır. Ayrıca
                  her dilin mağaza metinleri (listing/tr-TR.md, listing/en-US.md), simge, dile göre öne
                  çıkan görseller ve ekran görüntüleri (screenshots/<dil>/phone, tablet-7, tablet-10;
                  dil klasörleri tr-TR ve en-US)
tool/             Geliştirme betikleri (uygulama ikonunu üreten make_launcher_icon.py, sesleri üreten
                  make_sounds.py, mağaza simgesi ve öne çıkan görselleri üreten make_store_graphics.py)
```

- **İçerik ile mekanik ayrıdır.** Oyunlar, paketler ve ürünler `content/catalog_data.dart` içindeki
  katalogdan gelir. Kodun hiçbir yeri sabit oyun veya seviye sayısı varsaymaz. Yeni oyun, `GameModule`
  arayüzünü uygulayan bir sınıfla eklenir ve `AppServices.production` içinde kaydedilir.
- **Paket:** Bir oyunun birlikte sunulan seviyeleri. Bir oyunun birden çok paketi olabilir. İlerleme
  paket kimliğiyle tutulur; bu kimlikler yayından sonra değiştirilmez.
- **Ücretsiz / ücretli:** Bir paketi açan mağaza ürünü yoksa paket ücretsizdir. Bu bilgi ayrıca yazılmaz.
- **Bağımlılıklar** arayüzler üzerinden alınır ve `AppServices` içinde elle kurulur. Durum yönetimi için
  ek paket kullanılmaz; servisler `ChangeNotifier`'dır.
- **Dış bağımlılıklar:** `shared_preferences` (cihazda kayıt), `flutter_svg` (web sürümünün SVG
  görsellerini göstermek için; Flutter SVG'yi kendisi çizemez) ve `audioplayers` (ses efektleri).
- **Ses:** Web sürümü sesleri tarayıcıda notalardan anlık üretiyordu. Aynı notalar, süreler ve ses zarfı
  `tool/make_sounds.py` ile WAV dosyalarına çevrildi (`assets/sounds/`). Doğru ve yanlış sesi robot
  sevinince veya üzülünce, seviye sonu sesi sonuç paneli açılınca, yıldız sesi ise her kazanılan yıldız
  belirdiğinde (tonu her yıldızda yükselerek) çalar. Rozet sesi rozet bildirimiyle, kupa sesi kupa
  penceresiyle çalar. Sesler diğer uygulamaların sesini kesmez. Ana ekrandaki ayarlar düğmesinden ses açılıp
  kapatılır; ayar cihazda saklanır ve ilk açılışta ses açıktır. Notalar değişirse dosyalar yeniden üretilir
  (yalnızca Python standart kütüphanesi gerekir): `python tool/make_sounds.py assets/sounds`
- **Oyun ekranı:** Genişliği 760 ve yüksekliği 520 pikselden büyük ekranlarda (tablet) harita solda,
  kontroller sağdadır; ikisi ekranda ortalanmış bir grup oluşturur. Telefonda kontroller altta sabit
  durur ve harita aradaki alana sığdırılır; ekran çok kısaysa (yatay telefon) bütün içerik kaydırılır.
  Tablette düğmeler, harita kareleri ve seviye kutuları ekranın kısa kenarına göre büyür
  (`app/screen_scale.dart`); telefondaki boyutlar değişmez. "Hareketi azalt" ayarı açıksa robot hızlı
  yürür, tepki animasyonları oynatılmaz, konfeti gösterilmez ve sonuç paneli büyüyerek değil doğrudan açılır.
- **Karakter seçimi:** Web sürümündeki 5 karakter (Robi, Fiyo, Işıl, Pembe, Pırıl) aynı görsellerle
  aktarıldı (`features/character/`). Ana ekranın üstündeki karaktere dokununca seçim penceresi açılır
  (telefonda iki, tablette üç sütun); seçilen karakter `character.v1` anahtarında saklanır ve konuşma
  balonunda, haritada ve yolda hemen görünür. Robot çizen widget'lar karakteri `CharacterScope`'tan okur;
  ağaçta yoksa (tek ekranı deneyen testler) varsayılan karakter Robi kullanılır.
- **Rozet ve kupalar:** `features/achievements/` altında genel bir yapıdır; oyun sayısı ve seviye sayısı
  sabit yazılmaz. Her oyunun kupası oyun tanımındaki (`GameDefinition.trophy`) ad ve açıklamadan üretilir,
  yeni oyun eklenince kupası ve "bütün oyunlar" hedefleri kendiliğinden genişler. Hedeflerde yalnızca
  oynanabilir oyunların ücretsiz paketleri sayılır; satın alınan paketlerdeki yıldızlar yalnızca yıldız
  rozetlerine eklenir. "Yakında" görünen oyunlar hiçbir hedefe girmez.
  - Rozetler: İlk Oyunum (1 seviye), Hızlı Başlangıç (bir oyunda 5 seviye), Azimli Oyuncu (bir oyunda
    10 seviye), Usta Kodlayıcı (bir oyunun bütün seviyeleri), Oyun Kaşifi (bütün oyunlarda en az bir
    seviye; web'deki "Dört Dörtlük" rozeti oyun sayısı sabit olmasın diye yeniden adlandırıldı), Yıldız
    Avcısı (20 yıldız), Yıldız Ustası (50 yıldız), Mükemmel Oyuncu (3 yıldızlı seviye), İpucusuz Kahraman
    (ipucusuz 5 seviye), Büyük Başarı (bütün oyunların bütün seviyeleri).
  - Kupalar: İlk Macera Kupası (her oyunda ilk seviye), her oyun için bir usta kupası (Robot, Algoritma,
    Karar, Döngü Ustası) ve Kodlama Şampiyonu (bütün seviyeler).
  - Kazanılanlar `achievements.v1` anahtarında `{"earned":[...]}` olarak saklanır; bozuk kayıt veya bilinmeyen
    kimlikler yok sayılır. Açılışta koşulu önceden sağlanmış ödüller kutlama gösterilmeden eşitlenir;
    kazanılmış ödül bir daha kutlanmaz.
  - Seviye bitince yeni ödüller sırayla gösterilir: önce rozetler üstten kayan bildirimle (kendiliğinden
    veya dokununca kapanır), sonra kupalar durmadan yağan konfetili, dönen ışıklı tam ekran pencerede
    ("Harika!" ile kapanır). Ana ekrandaki kupa düğmesi kazanılan/toplam sayısını gösterir ve Başarılarım
    ekranını açar; kilitli ödüllerde ilerleme çubuğu görünür. Ayarlarda sıfırlama yoktur.
- **Konfeti:** Seviye bitince sonuç panelinin üstüne bir kez yağar (`features/play/widgets/confetti.dart`).
  Web sürümündeki gibi 28 parça; konumları, gecikmeleri, renkleri ve dönüşleri aynı formülle sıradan
  hesaplanır ve 3,2 saniyede ekranın altına iner. Paket kullanılmaz, parçalar `CustomPainter` ile çizilir;
  dokunmaları engellemez.
- **Ekran yönü:** Kısa kenarı 600 dp'nin altındaki cihazlar (telefon) açılışta dikeye sabitlenir;
  tablette iki yön de serbesttir. Kısıt pencere çizilmeden konsun diye Android tarafında
  (`MainActivity.kt`) uygulanır; telefon yatay tutulurken açılsa bile önce yatay görünmez.
- **Komutları Sırala ekranı:** Görev kartı geniş ekranda solda dikey, dar ekranda üstte şerit olarak
  durur. Kartlar havuzdan numaralı kutulara dokunarak (önce kutu seçilebilir) veya uzun basıp
  sürükleyerek yerleştirilir; kutular arasında sürükleme kartların yerini değiştirir. Kontrol et, İpucu
  ve Temizle düğmeleri altta sabittir.
- **Tekrar Et ekranı:** Düzen "Robotun Yolunu Bul" ile aynıdır; harita, yön tuşları ve komut kutuları
  onunla ortaktır. Tekrarla düğmesi turuncu bir blok açar; blok açıkken eklenen oklar onun içine girer ve
  düğme lacivert "Bloktan çık" olur. Tekrar sayısı bloğun üstündeki − ve + ile 2–6 arasında değişir. Bir
  bloğa dokunmak onu seçer; sil ve (bloğun içindeki ok için) dışarı çıkar düğmeleri şeridin sağında,
  sayacın altında çıkar, böylece seçim yapınca ekranın düzeni değişmez. Çalışırken bloğun tur rozeti
  hangi turda olunduğunu gösterir.
- **Seviye seçimi:** Web sürümündeki gibi her zorluk grubu kendi renginde bir paneldir (Kolay yeşil, Orta
  mavi, Zor mor, Uzman kırmızı). Panelde başlık şeridi, tamamlanan seviye rozeti, kilitliyse uyarı ve hap
  biçimli seviye satırları bulunur; kilitli grup soluk görünür. Paneller ekran genişliğine göre bir
  (telefon), iki (560 dp ve üstü) veya dört (960 dp ve üstü) sütuna dizilir.

- **Uygulama ikonu:** Lacivert zeminde Robi (`assets/characters/robot.webp` görselinin üst kısmı); solunda
  yukarıdan aşağıya ışıklı yukarı ok, sarı ampul ve ışıklı sağa ok. Oklar ve ampul Robi'nin renkleriyle
  çizilir. Android 8 ve sonrası için uyarlanabilir ikon (zemin ve ön plan katmanı), eski sürümler için hazır
  PNG'ler `android/app/src/main/res` altında. Görsel değişirse ikonlar Pillow ile yeniden üretilir:
  `python tool/make_launcher_icon.py assets/characters/robot.webp android/app/src/main/res onizleme.png`

### Kurallar (web sürümünden aynen alındı)

- Yıldız: ipucu kullanılırsa 1, ipucusuz bitirilirse 2, ipucusuz ve hedefe uygun bitirilirse 3.
- Bir grup, önceki grubun bütün seviyeleri bitince açılır. Bir seviye, önceki seviye bitince açılır.
- Bir seviyenin kaydı her zaman en iyi sonucu korur.

## Dil desteği

Uygulama Türkçe ve İngilizce oynanır. Mekanizma ortaktır; yeni bir dil kod değiştirmeden eklenir.

- **Dil seçimi:** Varsayılan olarak cihazın dili kullanılır; cihaz dili desteklenmiyorsa uygulama
  İngilizce açılır. Dil Ayarlar'dan değiştirilebilir, seçim cihazda saklanır (`LanguageService`). Dil
  değiştirmek için ebeveyn sorusu sorulmaz.
- **Metinler** `lib/l10n/app_<dil>.arb` dosyalarındadır. Şablon `app_tr.arb`'dir; açıklamalar ve
  parametreler (`@anahtar`) yalnızca orada tutulur. Kod `flutter gen-l10n` ile `lib/l10n/generated`
  altına üretilir (`flutter pub get` ve `flutter run` bunu kendisi de yapar). Ekranlar metinleri
  `context.l10n` ile okur.
- **Veri içindeki metinler** (oyun, seviye, rozet, karakter adları) sabit metin değil `LocalizedText`
  tutar: o anki dilin çevirilerinden metni seçen bir fonksiyon. Robotun konuşma balonu da bu türdedir;
  böylece dil oyunun ortasında değişse bile balon yeni dilde görünür.
- **Ebeveyn sorusundaki sayılar** dile göre yazıyla yazılır (`NumberSpeller`: "yirmi yedi",
  "twenty-seven"). Yazımı tanımlı olmayan dilde İngilizce yazım kullanılır.
- **Uygulama adı** başlatıcıda da dile göre değişir: `android/app/src/main/res/values/strings.xml`
  (İngilizce, "Robi Codes") ve `values-tr/strings.xml` (Türkçe, "Robi Kodluyor").

**Yeni dil eklemek:**

1. `lib/l10n/app_tr.arb` dosyasını `app_<dil>.arb` adıyla kopyala, `@@locale` değerini değiştir, `@`
   ile başlayan açıklama satırlarını sil ve metinleri çevir. `languageName` dilin kendi dilindeki adıdır
   (ör. "Deutsch"); Ayarlar'daki listede bu ad görünür.
2. `lib/features/parental_gate/number_speller.dart` içinde dilin sayı yazımını tanımla ve
   `NumberSpellers.byLanguage` içine kaydet.
3. `android/app/src/main/res/values-<dil>/strings.xml` ile başlatıcıdaki adı ekle.
4. `flutter gen-l10n` ve `flutter test` çalıştır. Testler her ARB dosyasının şablonla aynı anahtarlara
   ve parametrelere sahip olduğunu, her dilin sayı yazımının kayıtlı olduğunu denetler.
5. Mağaza metnini `store/robi-codes/listing/` altına ekle; öne çıkan görsel için
   `tool/make_store_graphics.py` içindeki `TEXTS` sözlüğüne dili ekleyip betiği çalıştır.

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
- Satın alma hakları her zaman Google Play'den okunur.

## İlerleme kaydı

- İlerleme, rozetler, kupalar ve ayarlar yalnızca cihazda tutulur. Google hesabı bağlama ve bulut
  kaydı yoktur.
- Google Play Games Services kullanılmaz: Google'ın API Services User Data Policy belgesine göre
  yalnızca çocuklara yönelik uygulamalar Google Sign-In'i ve Play Games Services'i kullanamaz.
  Ayrıntı: [docs/decisions.md](docs/decisions.md).

## Ebeveyn doğrulaması

- Satın alma yalnızca `ProtectedActionRunner` üzerinden çalışır. Korunan servis metotları, runner'ın verdiği işleme özel ve tek kullanımlık `ParentalApproval` olmadan
  çalışmaz.
- Doğrulama penceresi (`DialogParentalGate`) yazıyla bir çarpma sorusu sorar (ör. "on dört çarpı yedi kaç
  eder?"); cevap rakam tuş takımıyla girilir. Sorular `Random.secure()` ile üretilir; PIN veya sabit cevap
  saklanmaz.
- Yanlış cevapta pencere kısa süre kilitlenir, sonra yeni soru gelir.
- Ayarlar penceresinde yalnızca debug derlemesinde görünen bir deneme girişi vardır.

## Release derlemesi ve imzalama

Google Play App Signing kullanılır: uygulama Google'ın tuttuğu uygulama imzalama anahtarıyla dağıtılır,
geliştirici AAB'yi kendi **yükleme anahtarıyla** (upload key) imzalar. Keystore, parola ve imza bilgileri
repoya girmez; `.gitignore` `*.jks`, `*.keystore` ve `key.properties` dosyalarını dışarıda tutar.

- **Keystore:** Repo dışında, kullanıcı klasöründe (`.android-keys/robicodes-upload.jks`), PKCS12 biçiminde,
  alias `upload`. Keystore ve parolası güvenli bir yere yedeklenmelidir; kaybolursa yükleme anahtarı Play
  Console'dan sıfırlatılmak zorunda kalınır.
- **`android/key.properties`** (git dışı) yalnızca keystore yolunu ve alias'ı tutar, parola tutmaz:

  ```properties
  storeFile=<keystore dosyasının tam yolu, / ayırıcıyla>
  keyAlias=upload
  ```

- **Parola** `ROBICODES_KEYSTORE_PASSWORD` ortam değişkeninden okunur (PKCS12'de mağaza ve anahtar
  parolası aynıdır). Kalıcı kullanıcı değişkeni olarak tanımlandıktan sonra açılan terminaller onu görür;
  önceden açık terminal ve uygulamaların yeniden başlatılması gerekir.
- `android/app/build.gradle.kts` bu üç bilgi varsa release derlemesini yükleme anahtarıyla imzalar. Biri
  eksikse uyarı yazar ve debug anahtarına düşer; bu, yerel `flutter run --release` için yeterlidir ama
  böyle bir AAB'yi Google Play kabul etmez. Debug imzalama ayarı değiştirilmedi.

AAB üretme ve imzayı kontrol etme:

```bash
flutter build appbundle --release
```

```bash
keytool -printcert -jarfile build/app/outputs/bundle/release/app-release.aab
```

Çıktıdaki sahip `CN=Sezer Tanci, C=TR` olmalıdır; `CN=Android Debug` görünüyorsa parola değişkeni
derlemeyi başlatan terminale ulaşmamıştır. `keytool`, Android Studio'nun JDK'sindeki `jbr/bin` klasöründedir.
