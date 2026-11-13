# İlerleme

## Durum (13.11.2026)

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

## Ertelenen işler (unutulmayacak)

2., 3. ve 4. aşamada web sürümünden alınmayan özellikler. Bunlardan vazgeçilmedi; ilgili aşamada ele alınacak.

| Özellik | Durum | Karar |
|---|---|---|
| Ses efektleri | Yok | Ortak ses aşamasında eklenecek. |
| Konfeti | Yok | Ortak görsel efekt aşamasında eklenecek. |
| Karakter seçimi | Yok | Web sürümünde var (`js/core/characters.js`, `js/screens/character-dialog.js`, `assets/characters/` altında robotun farklı görünümleri). Vazgeçilmeyecek; eski sürümle karşılaştırılıp geri eklenmesi değerlendirilecek. |
| Animasyonlar | Bazıları yok | Seviye seçimindeki nabız ve giriş animasyonları gibi eksikler sonradan değerlendirilecek. Sürekli tekrarlanan animasyon eklenirse testlerdeki `pumpAndSettle` çağrıları buna göre düzenlenmeli. |

## Kararlar

Açık sorulara verilen cevaplar [docs/decisions.md](docs/decisions.md) içinde.

## Sıradaki adım

4. aşama raporu verildi; sıradaki oyun ve 5. aşamanın kapsamı için kullanıcı onayı bekleniyor. Her aşamada yalnızca o aşamanın
işleri yapılır ve sonunda rapor verilip onay beklenir.
