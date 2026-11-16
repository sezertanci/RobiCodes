# İlerleme

## Durum (14.11.2026)

**1. aşama tamamlandı:** Temel mimari, içerik kataloğu, ilerleme, mağaza, bulut kaydı ve ebeveyn
kapısı iskeletleri hazır. `flutter analyze` temiz, 43 testin hepsi geçiyor, debug APK derleniyor.

- Proje klasörü `MiniCodingWorldApp` iken `RobiCodes` olarak yeniden adlandırıldı.
- Uygulama adı "Robi Kodluyor", paket adı `com.sezertanci.robicodes`, Dart paketi `robi_codes`.
- Referans web sürümü: `..\MiniCodingWorld` (dokunulmaz).
- Git deposu: `git@github.com:sezertanci/RobiCodes.git` (`main` dalı).

**2. aşama tamamlandı:** "Robotun Yolunu Bul" Flutter'a aktarıldı.

- 20 seviye, haritalar, çözümler, açılış mesajları ve komut sınırları web sürümüyle aynı
  (`lib/games/path_finder/engine/path_finder_levels.dart`).
- Motor (`path_finder_engine.dart`) web sürümündeki `engine.js` ile aynı mantıkta: çarpma, altın
  toplama, en kısa yol (BFS) ve ipucu.
- Ortak seviye ekranları `lib/features/play/` altında; diğer oyunlar da bunları kullanacak.
- `flutter_svg` eklendi; 16 görsel `MiniCodingWorld` projesinden kopyalandı.
- `flutter analyze` temiz, 109 test geçiyor, debug APK derleniyor.
- Web sürümünden farklar: ses ve konfeti yok; sürükleme uzun basmayla başlıyor; düzenleme düğmeleri
  komutun altında değil şeridin altında; karakter seçimi yok.
- Ekran boyutuna göre uyarlama: tablette düğmeler, harita ve seviye kutuları kısa kenara göre büyür
  (`ScreenScale`); yatayda harita ile kontroller ortalanır, seviye grupları iki sütunda durur.
  Tablette iki yönde denendi.
- Seviye seçimi web sürümündeki renkli grup panellerine çevrildi (`features/play/widgets/`
  altında `LevelGroupPanel`, `LevelButton`, `GroupTone`); paneller 1, 2 veya 4 sütun olur.
  Web sürümündeki nabız animasyonu ve giriş animasyonu alınmadı; sıradaki seviye sabit sarı halkayla
  gösteriliyor. `flutter analyze` temiz, 122 test geçiyor.
- Uygulama ikonu Flutter'ın varsayılan ikonundan lacivert zeminde Robi'ye çevrildi; solunda ışıklı
  yukarı ok, sarı ampul ve ışıklı sağa ok var (uyarlanabilir ikon ve eski sürümler için PNG). Üretim
  betiği `tool/make_launcher_icon.py`. Tablette denendi; MIUI başlatıcısı ikonu önbellekte tuttuğu
  için yeni ikon, başlatıcı yeniden başlatılınca (`adb shell am force-stop com.miui.home`) göründü.

**3. aşama tamamlandı:** "Komutları Sırala" Flutter'a aktarıldı.

- 20 seviye, adımlar, aşamalı (başlıklı kutu grupları) seviyeler, fazla kartlar ve ipuçları web
  sürümüyle aynı (`lib/games/command_order/engine/command_order_levels.dart`).
- Motor (`command_order_engine.dart`): kartları oluşturma, tohumla karıştırma (sıralı veya bir önceki
  sırayla aynı sonuç vermez), ilk yanlış kutuyu bulma (erken / fazla kart) ve sıradaki ipucu.
- Yıldızlar ortak kuralla: ipucu 1, yanlış kontrolden sonra 2, ilk denemede doğru 3. İlerleme
  `command-order` paketinde ayrı tutulur.
- Ortak düğme ve kesik çerçeve `lib/features/play/widgets/` altına taşındı (`ImageButton`,
  `DashedFrame`). Görseller `assets/command-order/` altına kopyalandı.
- `flutter analyze` temiz, 168 test geçiyor, debug APK derleniyor. Tablette denendi: dokunarak ve uzun
  basıp sürükleyerek yerleştirme, yanlış kontrol uyarısı, doğru sıra ve sonuç paneli çalışıyor.
- Web sürümünden farklar: ses, konfeti ve çözülünce kartların zıplama animasyonu yok; sürükleme uzun
  basmayla başlıyor; karıştırma tam sayı aritmetiğiyle yapıldığı için aynı tohum web sürümüyle aynı
  sırayı vermeyebilir (tohum zaten her açılışta rastgele).

**4. aşama tamamlandı:** "Eğer Böyleyse" Flutter'a aktarıldı.

- 20 seviye, yollar, hazır gelen ve açık kutular, fazla bloklar ve açılış mesajları web sürümüyle aynı
  (`lib/games/if_then/engine/if_then_levels.dart`). Her seviyenin palet bloklarıyla çözülebildiği
  testle doğrulanıyor.
- Motor (`if_then_engine.dart`): yolu ayrıştırma, ilk uyan kuralı seçme ("Değilse" son çare),
  çalıştırıp ilk yanlış kareyi bulma ve ipucu (yanlış kare, kural ve gereken hareket).
- Bloklar dokunarak (ilk boş uygun kutuya veya seçilen kutuya) ya da uzun basıp sürükleyerek
  yerleştirilir; dolu kutuya dokunmak onu boşaltır, hazır kutular kilitlidir.
- Yıldızlar ortak kuralla verilir; ilerleme `if-then` paketinde ayrı tutulur.
- Ortak parçalar: path_finder'daki nabız gibi atan ipucu çerçevesi `PulsingHintFrame` olarak
  `features/play/widgets/` altına taşındı; robot görüntüsü, işaret efektleri ve adım süreleri de ortak.
- Dar ekranda yol kareleri küçülür, sığmazsa yatay kayar ve robot görünür tutulur; hareket azaltma
  açıkken animasyonlar kapanır.
- Geniş ekranda (tablet) kurallar solda, bloklar ve düğmeler sağdadır; düğmeler alt satırda değil
  blokların altında, onlarla aynı hizada sola yaslı durduğu için kurallar ekranın alt kenarına kadar uzanır.
- Zıplamada robot taşın üstüne inmez: taşın önünde bekler, sonraki hareketle taşın üstünden atlayıp
  taştan sonraki kareye (ya da bayrağa) iner (web sürümündeki gibi).
- `flutter analyze` temiz, 210 test geçiyor, debug APK derleniyor. Tablette iki yönde denendi: dokunarak
  ve uzun basıp sürükleyerek blok yerleştirme (koşul ve hareket), yanlış kare ve kural işareti, ipucu,
  köprü kurma, kapı açma, yıldız toplama, yıldız kaydı ve sonuç paneli çalışıyor.
- Web sürümünden farklar: ses ve konfeti yok; sürükleme uzun basmayla başlıyor.

**5. aşama tamamlandı:** "Tekrar Et" Flutter'a aktarıldı.

- 20 seviye, haritalar, çözümler, blok sınırları, ipuçları ve açılış mesajları web sürümüyle aynı
  (`lib/games/repeat/engine/repeat_levels.dart`). Her seviyenin çözümünün sınır içinde kaldığı ve en
  kısa yolu verdiği testle doğrulanıyor.
- Motor (`repeat_engine.dart`): çözüm metnini ayrıştırma (`3(RD) U`), blok sayma, programı turlara
  açma, çalıştırma (çarpma, altın, bayrak) ve ipucu (boş blok, yanlış yer, sıradaki ok, çözüldü).
  Çalıştırma "Robotun Yolunu Bul" motorunu kullanır.
- Ortak parçalar: path_finder'daki harita sahnesi arayüzü (`BoardScene`), yön tuşları (`DirectionPad`)
  ve komut kutusu (`CommandChip`) ayrı dosyalara alındı; path_finder'da yalnızca import ve çağrılar değişti.
- Yıldızlar ortak kuralla verilir; ilerleme `repeat` paketinde ayrı tutulur.
- `flutter analyze` temiz, 292 test geçiyor, debug APK derleniyor. Tablette iki yönde denendi: Tekrarla
  bloğu, içine ok ekleme, Bloktan çık, tekrar sayısını değiştirme, seçim ve düzenleme düğmeleri, eksik
  turda "bayrağa ulaşamadı" uyarısı, başarı, yıldız kaydı ve sonuç paneli çalışıyor.
- Web sürümünden farklar: ses ve konfeti yok; sil ve dışarı çıkar düğmeleri açılır bir balonda yazılı
  düğme olarak değil, şeridin sağında sayacın altında simgeli düğme olarak duruyor (dar telefonda balon
  haritayı ve kontrolleri aşağı itip taşmaya yol açıyordu). Web sürümünde de bloklar sürüklenmiyor.

**5. aşama sonrası düzeltmeler:**

- Telefon dikeye sabitlendi (yatayda oyunlar sıkışıyordu); kısa kenarı 600 dp'nin altındaki cihazlar telefon
  sayılır, tablette iki yön serbest. Kısıt ilk önce Dart'ta konmuştu; telefon yatay tutulurken açılınca
  ekran önce yatay görünüp sonra dönüyordu. Bu yüzden pencere çizilmeden uygulansın diye `MainActivity.kt`
  içine taşındı. Emülatörde denendi: yatay tutulurken açılınca doğrudan dikey açılıyor, açıkken döndürülse de
  dikey kalıyor. Testlerden yatay telefon boyutu çıkarıldı.
- Testlerdeki Türkçe ekran anahtarları (`telefon`, `dikeyTablet` …) ve bir test grubu adı İngilizceye çevrildi.
- "Eğer Böyleyse"de zıplayan robotun üstten kırpılması giderildi; metinlerdeki « » işaretleri düz tırnak oldu.
- `flutter analyze` temiz, 283 test geçiyor, debug APK derleniyor.

**6. aşama — 1. alt adım (ses) tamamlandı, kullanıcı onayladı:**

- Kullanıcının 6. aşama kararları ve sırası: 1) ses, 2) kutlama ve konfeti (özel çizim; hareket azaltma açıksa
  gösterilmez), 3) karakter seçimi (6 görünüm ve seçim penceresi doğrudan aktarılır), 4) rozet ve kupalar.
  Her alt adım sonunda telefonda ve tablette denenir, rapor verilip onay beklenir.
- Web'deki 6 ses (`js/core/sound.js`) aynı notalarla `tool/make_sounds.py` ile WAV'a çevrildi
  (`assets/sounds/`, yıldız sesi 3 tonda: `star-0..2`). `audioplayers` eklendi.
- `SoundService` sesi çalar ve açık/kapalı ayarını `sound.v1` anahtarında saklar. Oyunlar sesi
  `GameFeedback` üzerinden bildirir (robot sevinince doğru, üzülünce yanlış sesi); sonuç paneli seviye sonu
  ve yalnızca kazanılan yıldızlar için yıldız sesi çalar. Ana ekrana ayarlar düğmesi ve penceresi eklendi.
- `flutter analyze` temiz, 293 test geçiyor, debug APK derleniyor. Emülatörde denendi: yanlış, doğru, seviye
  sonu ve 3 yıldız sesi web'deki sırayla ve aralıklarla çaldı; ses kapatılınca hiç ses çalmadı; ayar yeniden
  başlatmada korundu. Tablet bağlı olmadığı için tablette henüz denenmedi.
- Sayfa geçişlerindeki "tık" sesi Android'in dokunma sesidir (sistem ayarı); kullanıcı olduğu gibi kalmasını istedi.

**6. aşama — 2. alt adım (kutlama ve konfeti) tamamlandı:**

- Web'deki konfeti (`components.js` `confetti()`, `animations.css`) `CustomPainter` ile aynı formülle çizildi:
  28 parça, 3,2 saniyelik düşüş, sırayla gecikme, renk ve dönüş. Sonuç panelinin üstüne bir kez yağar.
- "Hareketi azalt" açıksa konfeti gösterilmez ve sonuç paneli büyüme animasyonu olmadan açılır (web'de de böyle).
- Rozet bildirimi ve kupa penceresi (`celebration.js`) ödüllere bağlı olduğu için 4. alt adımda yapılacak;
  kupa penceresindeki sürekli yağan konfeti de o zaman eklenecek.
- `flutter analyze` temiz, 299 test geçiyor, debug APK derleniyor. Emülatörde denendi: konfeti panelin
  üstünden ekranın altına yağıp bitiyor; animasyonlar kapatılınca hiç görünmüyor. Tablette henüz denenmedi.
- Kullanıcı onaylayıp commit istedi (`8e92541`).

**6. aşama — 3. alt adım (karakter seçimi) tamamlandı, commit edildi (`1cf0d2e`):**

- Web'de seçilebilen karakter 5 tanedir (`js/core/characters.js`: Robi, Fiyo, Işıl, Pembe, Pırıl); dördünün
  görseli `assets/characters/` altına değiştirilmeden kopyalandı. Web klasöründeki diğer robot görselleri
  (`robot-head`, `robot-small`, `robot-wave`, `robot.svg`) seçim listesinde yoktur ve aktarılmadı.
- `CharacterService` seçimi `character.v1` anahtarında saklar; kayıt yoksa, bozuksa veya artık olmayan bir
  karakteri gösteriyorsa Robi ile başlanır. `CharacterScope` seçili karakteri ağaca verir; konuşma balonu ve
  robot görüntüsü (harita ve yol) buradan okur, oyun ekranlarına parametre eklenmedi.
- Ana ekranın üstüne karakter ve "Değiştir" düğmesi eklendi; pencere web'deki gibi telefonda iki, tablette üç
  sütun, seçili karakter sarı çerçeveli. Web'deki ana ekran robotunun sürekli el sallama animasyonu eklenmedi
  (Ertelenen işler → Animasyonlar).
- Ana ekranda kartlar karakter yüzünden aşağı kaydığı için test yardımcısı `openLevelSelect` kartı tamamen
  görünür yapıp dokunacak şekilde düzeltildi.
- `flutter analyze` temiz, 311 test geçiyor, debug APK derleniyor. Telefonda (emülatör) ve tablette denendi:
  pencere iki/üç sütun açıldı, seçilen karakter ana ekranda, konuşma balonunda, haritada ve yolda göründü,
  uygulama yeniden başlatılınca seçim korundu.
**6. aşama — 4. alt adım (rozet ve kupalar) tamamlandı, onay bekliyor:**

- 10 rozet ve 2 genel kupa ile her oynanabilir oyun için bir kupa (şu an 16 ödül) `features/achievements/`
  altında; liste ve kurallar README'de. Web'deki "Dört Dörtlük" rozetinin adı "Oyun Kaşifi" oldu.
- Hedeflerde yalnızca oynanabilir oyunların ücretsiz paketleri sayılır; satın alınan paketlerin yıldızları
  yalnızca yıldız rozetlerine eklenir; "Yakında" oyunlar hiçbir hedefe girmez.
- Kayıt `achievements.v1` (`{"earned":[...]}`); açılışta önceki ilerlemeden kazanılanlar sessizce eşitlenir.
- Rozet bildirimi, kupa penceresi (sürekli yağan konfeti, dönen ışıklar, "Harika!", kupa sesi), Başarılarım
  ekranı ve ana ekrandaki sayaçlı düğme eklendi. `Confetti` bir `loops` seçeneği aldı.
- Küçük (60 px) bildirim rozetinde "Mükemmel Oyuncu"nun üç yıldızı taşıyordu; yıldız satırı sığmazsa
  orantılı küçülüyor.
- `flutter analyze` temiz, 338 test geçiyor, debug APK derleniyor. Telefonda ve tablette denendi: eski
  ilerleme açılışta 8/16 olarak eşitlendi, Başarılarım ekranı düzgün. Emülatörde sıfırdan oynanınca
  "İlk Oyunum" ve "Mükemmel Oyuncu" bildirimleri sırayla, sonra "Oyun Kaşifi" bildirimi ve "İlk Macera
  Kupası" penceresi göründü; "Harika!" pencereyi kapattı; yeni ödül olmayan seviyelerde bildirim çıkmadı.
  Dikey tablette (711 dp) kupalar tek sütun dizilir.

**7. aşama tamamlandı, commit edildi (`ebadf2b`):** Google Play Billing ile satın alma altyapısı.

**8. aşama — bulut kaydı yapılmayacak (14.11.2026):** Araştırmada, yalnızca çocuklara yönelik
uygulamaların Google Play Games Services kullanamayacağı görüldü. Kullanıcı kararıyla Play Games
Services ve bulut kaydı eklenmedi; taslak `cloud_save` kodu, testleri, `cloud-sync.v1` anahtarı ve
hesap/bulut ebeveyn onayı eylemleri kaldırıldı. Ayrıntı: [docs/decisions.md](docs/decisions.md).
Commit edildi (`f2c91f5`, eksik testler `e06870c`).

**Matematik sorulu ebeveyn doğrulaması eklendi, commit edildi (`d2d79f1`).** Ayrıntı README'de.

**Release imzalama tamamlandı, commit edildi (`61e968f`, 14.11.2026):**

- Play App Signing kullanılacak; AAB repo dışındaki yükleme anahtarıyla (PKCS12, alias `upload`,
  `CN=Sezer Tanci, C=TR`) imzalanıyor.
- Keystore yolu ve alias git dışı `android/key.properties` dosyasında, parola
  `ROBICODES_KEYSTORE_PASSWORD` kullanıcı ortam değişkeninde. `.gitignore` keystore ve `key.properties`
  dosyalarını dışarıda tutuyor. Bilgi eksikse release debug anahtarına düşüp uyarı yazıyor; debug
  imzalama değiştirilmedi.
- Release derlemesi için Android SDK Command-line Tools ve NDK `28.2.13676358` kuruldu (hata ayıklama
  sembollerini ayırmak için gerekli).
- İmzalı AAB (~49 MB) üretildi; `keytool -printcert` ile yükleme anahtarının imzası doğrulandı.
  `flutter analyze` temiz, 449 test geçiyor.
- Kurulum ve derleme adımları README'deki "Release derlemesi ve imzalama" bölümünde.

## Ertelenen işler (unutulmayacak)

2.–5. aşamalarda web sürümünden alınmayan özellikler. Bunlardan vazgeçilmedi; ilgili aşamada ele alınacak.

| Özellik | Durum | Karar |
|---|---|---|
| Ses efektleri | Eklendi (6. aşama) | Rozet ve kupa sesleri de bağlandı. |
| Rozet ve kupalar | Eklendi (6. aşama) | Yalnızca cihazda tutuluyor; bulut kaydı yapılmayacak (8. aşama kararı). |
| Konfeti | Eklendi (6. aşama) | Sonuç panelinde bir kez, kupa penceresinde sürekli yağar. |
| Karakter seçimi | Eklendi (6. aşama) | Web'deki 5 karakter ve seçim penceresi aktarıldı. |
| Animasyonlar | Bazıları yok | Seviye seçimindeki nabız ve giriş animasyonları, ana ekran robotunun el sallaması gibi eksikler sonradan değerlendirilecek. Sürekli tekrarlanan animasyon eklenirse testlerdeki `pumpAndSettle` çağrıları buna göre düzenlenmeli. |

## Dil desteği (15.11.2026)

- Uygulama Türkçe ve İngilizce oynanır; ayrıntılar README'deki "Dil desteği" bölümünde ve
  [docs/decisions.md](docs/decisions.md) içinde. İlk dil sürümü `1.1.0+2`; 6 yeni dille `1.2.0+3`.
- Mağaza metinleri `store/robi-codes/listing/` altında (tr-TR, en-US); öne çıkan görsel her dil için ayrı.
- Ekran görüntüleri dile göre ayrıldı: `store/robi-codes/screenshots/<tr-TR|en-US>/<phone|tablet-7|tablet-10>`.
  İngilizce görüntüler emülatörde çekildi (telefon 1080x1920/420, 7 inç 1200x1920/320, 10 inç 1600x2560/360).
  Sahneler Türkçe görüntülerle aynı oyunlardan seçildi; 10 inç İngilizce görüntülerde ilerleme gerçek
  tabletteki Türkçe görüntülerden azdır (seviye ve yıldız sayıları farklı).
- Almanca, İspanyolca ve Fransızca eklendi (yalnızca uygulama içi; mağaza tarafı yok). Uygulama adları ve
  karakter adı çevirileri [docs/decisions.md](docs/decisions.md) içinde. Bu dillerde uzun metinlerin dar
  ekranlarda sığıp sığmadığı henüz emülatörde denetlenmedi.
- Portekizce (Brezilya), İtalyanca ve Endonezce eklendi (yalnızca uygulama içi). Adlar ve karakter adları
  [docs/decisions.md](docs/decisions.md) içinde; bu diller de emülatörde görsel olarak denetlenmedi.

## Ücretli oyunlar (15.11.2026)

- **Hata Avcısı** kodlandı (`lib/games/bug_hunter/`): 20 seviye, deneme altyapısı, kilitli kart, satın alma
  akışı. "Tekrar Et" denetleyicisine isteğe bağlı `StartingProgram` eklendi; verilmezse Tekrar Et aynen çalışır.
  Kararlar [docs/decisions.md](docs/decisions.md) içinde. Commit `2548424`.
- Play Console (15.11.2026): ödeme profili, TL banka hesabı (doğrulama bekliyor), hesap grubu ve %15 hizmet
  ücreti kaydı tamam. Ürün `pack.bug_hunter.base` etkin; satın alma seçeneği `buy` ("Eski sürümlerle uyumlu"),
  174 ülke. Fiyat: Türkiye 29,99 TL, diğer ülkeler 1,99 USD tabanlı. **Play Console'a girilen fiyat vergisiz
  sayılır, KDV üstüne eklenir** (Türkiye'ye 24,99 girilince 29,99 görünür). Ürün simgesi
  `store/robi-codes/products/bug-hunter-512.png`. Sürüm `1.3.0+4` kapalı teste (Alpha) yüklendi, yayında ve
  cihazlarda satın alma çalışıyor.
- Yeni ücretli paket/bundle için adım adım yol: [docs/paid-pack-release.md](docs/paid-pack-release.md).
- Paketler ekranı genel temaya uyarlandı: ücretli ürün oyun renginde kart (`ProductCard`), ücretsiz paketler
  simgeli küçük kartlar (`FreePackCard`), bilgi ve geri yükleme beyaz panellerde. Ortak `ToneCard` ve
  `GameIconBadge` ana ekrandaki oyun kartıyla paylaşılıyor. Tablete bir sonraki Play sürümüyle gelecek.
- Mağaza metinlerinde "Türkçe ve İngilizce oynanabilir" ifadesi eskidi (8 dil var); güncellenmedi.
- Üretime başvuru için kapalı testte 12 test kullanıcısı ve 14 gün gerekiyor (şu an 11 kullanıcı).
- **Kendi Komutunu Oluştur kodlandı, commit edilmedi (15.11.2026).** `lib/games/my_command/`, ortak program
  düzeni `lib/games/repeat/` altında (`ProgramGameLayout`, `CallChip`, `program_models`, `program_editor`).
  20 seviye, ürün `pack.my_command.base`, turkuaz tema, ikon `assets/icons/game-command.svg`, 8 dilde metinler.
  `flutter analyze` temiz, 636 test geçiyor; emülatörde 1. seviye 3 yıldızla bitirildi. Kalanlar: pubspec
  sürüm yükseltme, ürün simgesi `store/robi-codes/products/my-command-512.png`, Play Console'da ürün ve sürüm.
- **Başlangıç Seti (`bundle.starter`) kodlandı (15.11.2026):** iki ücretli oyunu birlikte açar; sürüm `1.4.1+6` (1.4.0+5 kapalı teste yüklendi),
  release AAB hazır. Play Console'da ürünlerin açılması ve kapalı test sürümü kullanıcıda. Sonraki oyunlar: Değişken Kutusu →
  Desen Bulmacası → Devre → Akış Şeması.
- **Değişken Kutusu kodlandı ve commit edildi (16.11.2026).** `lib/games/variable_box/`; kutu blokları
  (`SetBoxBlock`, `AddBoxBlock`, `BoxRules`) ortak program motorunda, kutu çipleri `inner_block_chip.dart`.
  20 seviye, ürün `pack.variable_box.base`, karton kahvesi teması (`AppTones.brown`), ikon
  `assets/icons/game-box.svg`, kutu düğmeleri koyu altın (`AppTones.amber`), 8 dilde metinler. Tablette denendi.
  Debug'da ayarlarda "Tüm kilitleri aç" anahtarı var (yalnızca bellekte). `flutter analyze` temiz, 774 test geçiyor.
  Kalanlar: pubspec sürüm yükseltme, ürün simgesi `store/robi-codes/products/variable-box-512.png` (kahverengi
  oyun simgesinden), Play Console'da ürün ve sürüm.

## Kararlar

Açık sorulara verilen cevaplar [docs/decisions.md](docs/decisions.md) içinde.

## Sıradaki adım

Kod tarafı yayına hazır. Google Play Console işlemleri kullanıcının onayıyla başlayacak: uygulamayı
oluşturma, Play App Signing'e yükleme anahtarıyla katılma, AAB'yi dahili test kanalına yükleme, uygulama içi
ürünleri katalogdaki kimliklerle tanımlama, Aileler politikası / hedef yaş grubu / veri güvenliği formları,
gizlilik politikası, mağaza metinleri ve ekran görüntüleri. Her aşamada yalnızca o aşamanın işleri yapılır
ve sonunda rapor verilip onay beklenir.
