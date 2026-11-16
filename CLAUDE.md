# Robi Kodluyor – proje kuralları

## Dil dosyaları

- Uygulama 8 dilde sunulur: `tr`, `en`, `de`, `es`, `fr`, `pt`, `it`, `id`. Dosyalar `lib/l10n/app_<dil>.arb`,
  şablon `app_tr.arb`.
- Her yeni oyunda ve her geliştirmede kullanıcıya görünen her metin **8 ARB dosyasının hepsine aynı anda**
  eklenir; değişen veya silinen metin de 8 dosyada birlikte güncellenir. Yalnızca Türkçe veya yalnızca
  Türkçe/İngilizce bırakılmaz.
- Koda sabit kullanıcı metni yazılmaz; metinler ARB'den okunur.
- **İstisna – yalnızca debug'da görünen geliştirici araçları:** `kDebugMode` ile korunan ve release
  derlemesinden çıkan girişlerin (ör. ayarlardaki `ParentalGateTrial`, test için kilitleri açan anahtarlar)
  metinleri ARB'ye eklenmez ve çevrilmez. Metinler ilgili sınıfta Türkçe `static const` sabit olarak durur
  ve sınıf yorumunda bu istisnaya atıf yapılır. Aynı metin hem debug'da hem gerçek kullanıcıya
  gösteriliyorsa istisna geçerli değildir; ARB'ye eklenir.
- Anahtarlar her dosyada şablondaki sırayla yer alır. Ardından `flutter gen-l10n` ve `flutter test`
  çalıştırılır; testler her ARB dosyasının şablonla aynı anahtarlara sahip olduğunu denetler.
