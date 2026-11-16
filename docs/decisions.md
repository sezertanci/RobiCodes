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

## Ücretli içerik ve ürün kimlikleri (15.11.2026)

- Şu an oynanabilen 4 oyun ve 20'şer seviyelik temel paketleri **ücretsiz** kalır. Ücretli olanlar bundan
  sonra yapılacak içeriktir: hem yeni oyunlar hem de mevcut oyunlara eklenecek yeni seviye paketleri.
- Bu yüzden ilk sürüm ürünsüz çıkar; Play Console'da ürün ve ödeme profili ilk ücretli paketle açılır.
- Avantajlı paket (bundle) olacak. Bir bundle yalnızca **açıldığı gün var olan** paketleri açar ve adı buna
  göre konur (ör. "Başlangıç Seti"); sonradan eklenen paketler için yeni bundle'lar açılır.
- Ürün kimliği biçimi: tek paket `pack.<oyun>.<paket>`, bundle `bundle.<ad>`. Google Play kimlikte `-`
  kabul etmediği için oyun kimliğindeki `-` yerine `_` yazılır (ör. `pack.path_finder.advanced`).
  Kimlikler yayından sonra değiştirilmez ve silinse bile yeniden kullanılamaz.
- Fiyatlar ilk ücretli paket hazır olduğunda belirlenecek.

### İlk ücretli oyun: Hata Avcısı (15.11.2026)

- Ücretli oyunlar sırayla yapılır ve her biri kendi fiyatıyla kapalı teste çıkar: önce **Hata Avcısı**, sonra
  **Kendi Komutunu Oluştur**, ardından ikisini kapsayan bir bundle. Sonraki oyunlar: Değişken Kutusu → Desen
  Bulmacası → Devre → Akış Şeması.
- Hata Avcısı, "Tekrar Et" haritaları ve bloklarıyla oynanır (yön okları + Tekrarla). Seviye bozuk bir kodla
  açılır; çocuk kodu çalıştırıp hatayı bulur ve düzeltir. Ürün kimliği `pack.bug_hunter.base`.
- Deneme: her zorluk grubunun ilk seviyesi ücretsizdir (toplam 4 seviye) ve sırayla açılır; satın alınca kalan
  16 seviye açılır. Ana ekranda kart kilitli görünür ve fiyatı (yoksa "Kilitli") yazar.
- Görünüm: kırmızı renk, ikonda büyüteç altında uğur böceği. Kupa 20 seviye bitince verilir.
- Düzenleme: bir oka dokunup yön tuşuna basınca o ok değişir; seçiliyken "Sil" ve "Önüne ekle" düğmeleri
  görünür. "Temizle" yerine "Baştan al" düğmesi bozuk koda geri döner. Tekrarla düğmesi yalnızca tekrarlı
  seviyelerde (11–20) görünür.

### İkinci ücretli oyun: Kendi Komutunu Oluştur (15.11.2026)

- "Tekrar Et" haritalarıyla oynanır. Ekranda iki alan vardır: üstte oklar dizilerek tek bir komut tanımlanır,
  altta ana program yazılır. Ana programın blok sınırı dar tutulur; çocuk tekrar eden hareketi komuta taşımak
  zorunda kalır.
- Komut, ana programda adı yazmayan turkuaz bir yapboz bloğu olarak görünür.
- Tekrarla bloğu yalnızca 11–20. seviyelerde açılır; 1–10 yalnızca oklar ve komutla oynanır.
- 20 seviye, 4 zorluk grubu. Deneme Hata Avcısı ile aynıdır: her grubun ilk seviyesi ücretsiz (toplam 4).
- Görünüm: turkuaz renk, ikonda içinde oklar olan yapboz parçası.
- Adlar: Kendi Komutunu Oluştur (tr), Make Your Own Command (en), Eigener Befehl (de), Crea tu comando (es),
  Crée ta commande (fr), Crie seu comando (pt), Crea il tuo comando (it), Buat Perintahmu (id).
- Ürün kimliği `pack.my_command.base`; fiyat Hata Avcısı ile aynı (müşteri 29,99 TL, yurt dışı 1,99 USD).
- Ana sayfa kartındaki oyun adı iki satıra sığmazsa yazı boyu 24 → 21 → 18 olarak küçülür; ad kesilmez.
- Görselli düğmelerde (`ImageButton`) boy anında değişir, yalnızca sarı ışık geçişlidir. Boy geçişi, program
  dolup düğmeler küçülürken tablette yan yana düzenin bir an taşmasına yol açıyordu.

### Başlangıç Seti (15.11.2026)

- Hata Avcısı ve Kendi Komutunu Oluştur'u birlikte açan ilk avantajlı paket. Kimlik `bundle.starter`.
- Fiyat: müşteri 49,99 TL görür (Play'e vergisiz 41,66 TRY); yurt dışı 3,29 USD.
- Adı 8 dilde: Başlangıç Seti, Starter Set, Starter-Set, Pack de inicio, Pack de démarrage, Pacote inicial,
  Pacchetto iniziale, Paket Pemula.

### Üçüncü ücretli oyun: Değişken Kutusu (16.11.2026)

- "Tekrar Et" haritaları ve program şeridiyle oynanır. Şeridin solunda kahverengi bir kutu durur; kutu 1 ile başlar
  ve her ok robotu kutudaki sayı kadar yürütür. Blok sınırı, kutu kullanılmadan aşılacak kadar dar tutulur.
- Bloklar: oklar, "kutu = N" (yanındaki −/+ ile 1–9 arası), "+1" ve "−1". Kutu bu sınırların dışına çıkmaz.
- Tekrarla bloğu yalnızca 11–20. seviyelerde açılır; 16–20'de kutu blokları tekrarın içine konur.
- 20 seviye, 4 zorluk grubu. Deneme diğer ücretli oyunlarla aynı: her grubun ilk seviyesi ücretsiz (toplam 4).
- Görünüm: karton kahvesi oyun rengi; ikonda üzerinde büyük beyaz sayı yazan açık kahverengi karton kutu.
  Kutu düğmeleri (= N, +1, −1) koyu altın renkte, içlerinde yalnızca yan kapakları olan tek renk kahverengi kutu
  simgesi durur; böylece şeritteki kahverengi kutu bloklarıyla karışmaz.
- Adlar: Değişken Kutusu (tr), Variable Box (en), Variablen-Box (de), Caja de variables (es), Boîte à variable
  (fr), Caixa de variável (pt), Scatola variabile (it), Kotak Variabel (id).
- Ürün kimliği `pack.variable_box.base`; fiyat diğer ücretli oyunlarla aynı (müşteri 29,99 TL, yurt dışı
  1,99 USD). Şimdilik bundle'a eklenmedi.

## Ses efektleri

- Web sürümünde sesler kodla üretilir. Flutter sürümünde bu sesler **dosya olarak** hazırlanır ve
  uygulama varlıklarından (assets) çalınır.
- Sesleri çalmak için uygun ve hafif tek bir ses paketi kullanılır.
- Ses çalma ayrı bir modüldür; oyun mekanikleri ses paketine veya dosyalara doğrudan bağlı olmaz.
- Uygulamadaki bütün tuşlar dokunulunca kısa bir tıklama sesi (`tap`) çalar; sürükle-bırak ses çıkarmaz.
  Tuşlar geri çağırmalarını `context.withTapSound` ile sarar (`lib/features/sound/tap_sound.dart`).
- Robot haritada her kareye geçtiğinde yumuşak bir adım sesi (`step`) çalar. Tıklama ve adım sesleri
  `tool/make_sounds.py` ile üretilir ve yalnızca uygulamada vardır. Ayrı bir ayar yoktur; ikisi de tek
  "Ses" anahtarına uyar.

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

## Reklam (15.11.2026)

- Uygulamada reklam **yoktur**; gelir yalnızca tek seferlik paket satışından gelir. Reklam izleyerek bölüm
  açma da yapılmaz.
- Gerekçe: Aileler politikası yalnızca Aileler için onaylı SDK'lara ve kişiselleştirilmemiş reklama izin
  verir, ödüllü reklamın da 5 saniyede kapatılabilmesini ister; gelir düşük kalır. Reklam, gizlilik
  politikasındaki "veri toplamaz" taahhüdünü bozar, mağazada "Reklam içerir" etiketi getirir ve çocuğun
  ebeveyn doğrulamasını aşarak içerik açmasına yol açar.

## Dil desteği (15.11.2026)

- Uygulama **Türkçe ve İngilizce** sunulur. Dil mekanizması ortaktır (ARB dosyaları ve `flutter gen-l10n`);
  ileride başka diller kod değiştirmeden eklenebilir.
- Varsayılan dil cihazın dilidir; desteklenmeyen bir cihaz dilinde uygulama İngilizce açılır. Dil
  Ayarlar'dan değiştirilebilir ve seçim saklanır. Dil değiştirmek için ebeveyn sorusu sorulmaz.
- İngilizce ad **Robi Codes**'tur; logoda "Robi" / "Codes" olarak iki satırda yazılır.
- Karakter adlarının çevirisi varsa İngilizceye çevrilir, yoksa Türkçe kalır; her ad ayrı
  değerlendirilir: Robi ve Fiyo aynı kalır; Işıl → Glow, Pembe → Pinky, Pırıl → Sparkle,
  Pervane → Propeller, Kahraman → Hero, Şövalye → Knight.
- İngilizce oyun adları: Find the Robot's Path, Order the Steps, If This, Then, Repeat It.
- Mağaza girişi tr-TR ve en-US dillerinde tutulur (`store/robi-codes/listing/`); öne çıkan görsel her
  dil için ayrı üretilir.

### Almanca, İspanyolca ve Fransızca (15.11.2026)

- Uygulamaya **Almanca, İspanyolca ve Fransızca** eklendi. Yalnızca uygulama içi metinler çevrildi;
  mağaza girişi, öne çıkan görsel ve ekran görüntüleri bu diller için hazırlanmadı.
- Uygulama adı başlatıcıda ve logoda her dile çevrilir; iki kelimenin de ilk harfi büyüktür:
  **Robi Programmiert** (de), **Robi Programa** (es), **Robi Programme** (fr).
- Karakter adları (Robi ve Fiyo her dilde aynı kalır):

  | Türkçe | Almanca | İspanyolca | Fransızca |
  | --- | --- | --- | --- |
  | Pervane | Propeller | Hélice | Hélice |
  | Işıl | Leuchti | Brillo | Lueur |
  | Kahraman | Held | Héroe | Héros |
  | Pembe | Rosa | Rosita | Rosie |
  | Şövalye | Ritter | Caballero | Chevalier |
  | Pırıl | Glitzer | Chispa | Étincelle |

- Ebeveyn sorusundaki sayılar her dilin kendi yazımıyla yazılır (`GermanNumberSpeller`,
  `SpanishNumberSpeller`, `FrenchNumberSpeller`).

### Portekizce, İtalyanca ve Endonezce (15.11.2026)

- Uygulamaya **Portekizce (Brezilya), İtalyanca ve Endonezce** eklendi; yine yalnızca uygulama içi metinler.
  Portekizce tek dosyadır (`app_pt.arb`) ve Brezilya Portekizcesiyle yazılır; Portekiz'deki cihazlar da
  bunu kullanır.
- Uygulama adları: **Robi Programa** (pt), **Robi Programma** (it), **Robi Ngoding** (id).
- Karakter adları (Robi ve Fiyo aynı kalır):

  | Türkçe | Portekizce | İtalyanca | Endonezce |
  | --- | --- | --- | --- |
  | Pervane | Hélice | Elica | Baling |
  | Işıl | Brilho | Luce | Kilau |
  | Kahraman | Herói | Eroe | Pahlawan |
  | Pembe | Rosinha | Rosina | Merah Muda |
  | Şövalye | Cavaleiro | Cavaliere | Kesatria |
  | Pırıl | Faísca | Scintilla | Kerlip |
