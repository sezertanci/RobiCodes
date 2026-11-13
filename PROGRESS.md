# İlerleme

## Durum (13.11.2026)

**1. aşama tamamlandı:** Temel mimari, içerik kataloğu, ilerleme, mağaza, bulut kaydı ve ebeveyn
kapısı iskeletleri hazır. `flutter analyze` temiz, 43 testin hepsi geçiyor, debug APK derleniyor.

- Proje klasörü `MiniCodingWorldApp` iken `RobiCodes` olarak yeniden adlandırıldı.
- Uygulama adı "Robi Kodluyor", paket adı `com.sezertanci.robicodes`, Dart paketi `robi_codes`.
- Referans web sürümü: `..\MiniCodingWorld` (dokunulmaz).
- Git deposu henüz açılmadı.

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

## Kararlar

Açık sorulara verilen cevaplar [docs/decisions.md](docs/decisions.md) içinde.

## Sıradaki adım

3. aşamanın kapsamı henüz belirlenmedi; kullanıcı onayı bekleniyor. Her aşamada yalnızca o aşamanın
işleri yapılır ve sonunda rapor verilip onay beklenir.
