import 'models/game_definition.dart';
import 'models/level_pack.dart';
import 'models/store_product.dart';

/// Uygulamadaki bütün oyunlar, seviye paketleri ve mağaza ürünleri.
/// Yeni oyun, paket veya ürün eklemek için yalnızca katalog verisine kayıt eklenir;
/// ilerleme, kilit ve erişim kuralları sabit oyun veya seviye sayısı varsaymaz.
final class ContentCatalog {
  ContentCatalog({required this.games, required this.packs, required this.products});

  final List<GameDefinition> games;
  final List<LevelPack> packs;
  final List<StoreProduct> products;

  GameDefinition? findGame(String id) => _firstOrNull(games, (game) => game.id == id);

  LevelPack? findPack(String id) => _firstOrNull(packs, (pack) => pack.id == id);

  StoreProduct? findProduct(String id) => _firstOrNull(products, (product) => product.id == id);

  /// Oyunun paketleri, katalogdaki sırayla.
  List<LevelPack> packsOf(String gameId) => packs.where((pack) => pack.gameId == gameId).toList();

  /// Paketi açan ürünler: paketin kendi ürünü ve paketi içeren avantajlı paketler.
  List<StoreProduct> productsGranting(String packId) =>
      products.where((product) => product.packIds.contains(packId)).toList();

  /// Hiçbir ürün paketi açmıyorsa paket ücretsizdir.
  bool isFree(String packId) => productsGranting(packId).isEmpty;

  /// Katalog verisindeki hataları listeler (tekrarlanan kimlik, bulunmayan oyun veya paket,
  /// seviyesiz paket). Testler kataloğun hatasız olduğunu denetler.
  List<String> validate() => [
    ..._duplicates('Oyun', games.map((game) => game.id)),
    ..._duplicates('Paket', packs.map((pack) => pack.id)),
    ..._duplicates('Ürün', products.map((product) => product.id)),
    for (final pack in packs) ..._validatePack(pack),
    for (final product in products) ..._validateProduct(product),
  ];

  List<String> _validatePack(LevelPack pack) => [
    if (findGame(pack.gameId) == null) '${pack.id}: bilinmeyen oyun ${pack.gameId}',
    if (pack.groups.any((group) => group.levelCount < 1)) '${pack.id}: seviyesiz grup var',
    if (pack.groups.isEmpty) '${pack.id}: grup yok',
  ];

  List<String> _validateProduct(StoreProduct product) => [
    if (product.packIds.isEmpty) '${product.id}: paket içermiyor',
    ..._duplicates('${product.id} içindeki paket', product.packIds),
    for (final packId in product.packIds)
      if (findPack(packId) == null) '${product.id}: bilinmeyen paket $packId',
  ];

  static List<String> _duplicates(String label, Iterable<String> ids) {
    final seen = <String>{};
    return [
      for (final id in ids)
        if (!seen.add(id)) '$label kimliği tekrarlanıyor: $id',
    ];
  }

  static T? _firstOrNull<T>(Iterable<T> items, bool Function(T) test) {
    for (final item in items) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }
}
