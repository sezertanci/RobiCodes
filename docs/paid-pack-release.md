# Ücretli paket oluşturma ve yayınlama

Hata Avcısı (`pack.bug_hunter.base`, 15.11.2026) ile denenmiş adımlar. Yeni bir ücretli oyun veya bundle
eklenirken bu sıra izlenir. Play Console'daki işleri kullanıcı yapar; banka, ödeme ve sözleşme adımları
yalnızca kullanıcıya aittir.

## Bir kez yapılanlar (tamam)

- Ödeme profili bağlandı (bireysel profil).
- Herkese açık satıcı profili dolduruldu; ürün türü "Bilgisayar Yazılımı".
- TL banka hesabı eklendi (deneme tutarıyla doğrulanacak).
- Hesap grubu oluşturuldu, ilişkili hesap yok; %15 hizmet ücreti programına kaydolundu.
- Lisans testi: "Test Kullanıcıları" listesi seçili, yanıt `RESPOND_NORMALLY`. Bu listedeki hesaplardan
  para çekilmez.
- Uygulamada `com.android.vending.BILLING` izni ve `in_app_purchase` var.

## 1. Kod tarafı

1. Ürün kimliği `ProductIds` içine eklenir (`lib/content/catalog_data.dart`), biçim `pack.<oyun>.<paket>`.
2. Oyun, deneme seviyeleri, kilitli kart ve 8 dildeki metinler eklenir; testler geçer.
3. `pubspec.yaml` sürümü yükseltilir (ad ve derleme numarası birlikte, ör. `1.3.0+4`).
4. Mağaza sürüm notları `store/robi-codes/listing/tr-TR.md` ve `en-US.md` içine yazılır.
5. Ürün simgesi hazırlanır: `store/robi-codes/products/<oyun>-512.png`.
   - 512×512, 32 bit PNG, şeffaf arka plan, üzerinde yazı yok.
   - Simge karenin yaklaşık %70'i kadar ortalanır; tam doldurursa Play'in altıgen önizlemesinde kenarlar
     kırpılır.
   - Oyunun SVG simgesinden üretim: SVG'yi `width/height="358"` ile 512×512 ortalı bir HTML'e koy, sonra
     `chrome --headless --default-background-color=00000000 --window-size=512,512 --screenshot=<çıktı>`.
6. Release AAB derlenir (imza parolası kullanıcı ortam değişkeninden okunur):
   `flutter build appbundle --release` → `build/app/outputs/bundle/release/app-release.aab`.
   AAB yaklaşık 55 MB olur ama kullanıcıya inen boyut yaklaşık 10 MB'tır (semboller ve diğer mimariler
   inmez); küçültmek gerekmez.

## 2. Play Console: ürün

Yol: **Google Play ile para kazanın → Ürünler → Tek seferlik ürünler → Tek seferlik ürün oluştur**.

**Adım 1 – Ürün bilgileri**

| Alan | Değer |
|---|---|
| Ürün Kimliği | Koddaki kimlik. Sonradan değiştirilemez, tekrar kullanılamaz. |
| Etiketler | Boş |
| Ad / Açıklama | Türkçe (varsayılan). Açıklama en az 50 karakter. |
| Çevirileri yönet | En az en-US eklenir. |
| Simge | `store/robi-codes/products/<oyun>-512.png` |
| Ürün vergisi kategorisi | Dijital uygulama satışları (dokunulmaz) |
| Yaş derecelendirmesi | Tüm yaşlar |
| Ödeme konumu kısıtlaması | Kısıtlama yok |

**Adım 2 – Kullanılabilirlik ve fiyatlandırma**

| Alan | Değer |
|---|---|
| Satın alma seçeneği kimliği | `buy` |
| Satın alma türü | Satın al |
| Gelişmiş: birden fazla satın alma | Kapalı |
| Gelişmiş: sınıf | Dijital içerik |

Fiyat (**Set prices**):

- **Girilen fiyat vergisiz sayılır; KDV'li ülkelerde vergi üstüne eklenir.** Türkiye'ye 29,99 girilirse
  müşteri 35,99 TL görür. Müşterinin 29,99 TL görmesi için 24,99 girilir.
- Türkiye fiyatı kurla çevrilince yurt dışı çok ucuz kalır (29,99 TL ≈ 0,59 USD). Bu yüzden iki ayrı fiyat
  girilir:
  1. Tüm ülkeler seçilir, Türkiye'nin işareti kaldırılır → USD ile taban fiyat (Hata Avcısı: 1,99 USD).
  2. Yalnızca Türkiye seçilir → TRY ile vergisiz fiyat (Hata Avcısı: 24,99 → müşteri 29,99 TL görür).
- Sonuçta Türkiye satırının müşterinin göreceği fiyatı gösterdiği kontrol edilir.
- Kesinti: %15 hizmet ücreti. 29,99 TL'lik satışta yaklaşık 21,24 TL, 1,99 USD'lik KDV'siz satışta
  yaklaşık 1,69 USD kalır.

Kaydedince ürün sayfasında kontrol edilir: durum **Etkin**, `buy` seçeneğinde **"Eski sürümlerle uyumlu"**
etiketi var. Bu etiket olmadan `in_app_purchase` ürünü bulamaz.

## 3. Play Console: sürüm

1. **Test et ve yayınla → Test → Kapalı test (Alpha) → Yeni sürüm oluştur**.
2. AAB yüklenir; sürüm adı `<derleme> (<sürüm>)` görünür.
3. Sürüm notları dil etiketleriyle girilir (`<tr-TR>…</tr-TR>`, `<en-US>…</en-US>`); metin listing
   dosyalarındaki "Sürüm notu" bölümünden alınır.
4. **Yayınlama özeti → İncelemeye gönder** (gönderme kararı kullanıcınındır). İnceleme birkaç saat ile
   1–2 gün sürer.
5. Onaydan sonra tablette Play Store'dan güncellenir ve lisans testi hesabıyla satın alma denenir.

## Bundle için notlar

- İlk bundle: **Başlangıç Seti** (`bundle.starter`, 15.11.2026), Hata Avcısı ve Kendi Komutunu Oluştur'u açar.
  Play'de sıradan bir tek seferlik üründür; hangi paketleri açtığı katalogdaki `StoreProduct.packIds` ile bilinir.
- Fiyat: tek tek alınınca 59,98 TL olan iki oyun 49,99 TL. Türkiye'ye vergisiz 41,66 TRY, diğer ülkelere
  aynı oranla 3,29 USD girilir. Simge `store/robi-codes/products/starter-bundle-512.png`.
- İkinci ve üçüncü bundle (16.11.2026):
  - **İleri Seviye Seti** (`bundle.advanced`): Değişken Kutusu ve Desen Bulmacası. 49,99 TL (vergisiz 41,66 TRY),
    yurt dışı 3,29 USD. Simge `store/robi-codes/products/advanced-bundle-512.png`.
  - **Dörtlü Set** (`bundle.four_games`): dört ücretli oyunun hepsi. Tek tek 119,96 TL olan dört oyun 99,99 TL
    (vergisiz 83,33 TRY), yurt dışı 6,59 USD. Simge `store/robi-codes/products/four-game-bundle-512.png`.
  - Bundle simgesi oyun simgelerinden üretilir: SVG'ler 512×512 bir HTML'de yan yana (dört oyunda 2×2) konur,
    Chrome headless ile çizilir, sonra şeffaf kenarlar kırpılıp ortalanır; içerik yaklaşık 358 piksel genişliktedir.
- Oyunlardan birine sahip olan kullanıcıya bundle satılmaz; eksik oyun tek başına önerilir (`OfferPolicy`).
- Fiyat kuralı (vergisiz giriş, Türkiye ve yurt dışı için ayrı fiyat) bundle için de geçerlidir.
