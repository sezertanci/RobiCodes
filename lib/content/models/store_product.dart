/// Google Play Console'da tanımlanan, tek seferlik ve tüketilmeyen (non-consumable) bir ürün.
///
/// Bir ürün bir veya birden çok paketin erişimini açar. Birden çok paket açan ürün,
/// avantajlı paket (bundle) olarak satılır. Google Play'de "bundle" diye ayrı bir ürün türü
/// olmadığından bundle da sıradan bir tek seferlik üründür; hangi paketleri açtığını
/// uygulama bu eşlemeyle bilir. Fiyat burada tutulmaz, Google Play'den okunur.
final class StoreProduct {
  const StoreProduct({required this.id, required this.title, required this.packIds});

  /// Play Console'daki ürün kimliği. Yayından sonra değiştirilmez.
  final String id;

  /// Mağaza ekranında gösterilen ad. Play Console'daki ürün adıyla aynı tutulması önerilir.
  final String title;

  /// Ürün satın alındığında açılan paketler.
  final List<String> packIds;

  bool get isBundle => packIds.length > 1;
}
