import '../app/app_assets.dart';
import '../app/app_theme.dart';
import 'content_catalog.dart';
import 'models/game_definition.dart';
import 'models/level_pack.dart';
import 'models/store_product.dart';

/// Oyun kimlikleri. Mevcut web sürümündeki kimliklerle aynıdır; ilerleme ve paket kayıtları
/// bunlara bağlı olduğu için değiştirilmez.
abstract final class GameIds {
  static const pathFinder = 'path-finder';
  static const commandOrder = 'command-order';
  static const ifThen = 'if-then';
  static const repeat = 'repeat';
}

/// Mevcut oyunlardaki seviye düzeni: her zorluk grubunda 5 seviye.
const _levelsPerGroup = 5;

const _standardGroups = [
  DifficultyGroup(Difficulty.easy, _levelsPerGroup),
  DifficultyGroup(Difficulty.medium, _levelsPerGroup),
  DifficultyGroup(Difficulty.hard, _levelsPerGroup),
  DifficultyGroup(Difficulty.expert, _levelsPerGroup),
];

const _basePackTitle = 'Temel Seviyeler';

/// Oyunun ücretsiz temel paketinin kimliği: `<oyun>.base`.
String basePackId(String gameId) => '$gameId.base';

LevelPack _basePack(String gameId) =>
    LevelPack(id: basePackId(gameId), gameId: gameId, title: _basePackTitle, groups: _standardGroups);

const _games = [
  GameDefinition(
    id: GameIds.pathFinder,
    title: 'Robotun Yolunu Bul',
    description: 'Yön komutlarıyla robotu hedefe ulaştır.',
    tone: AppTones.blue,
    icon: AppAssets.gamePath,
    trophy: GameTrophy(title: 'Robot Ustası', description: 'Robot artık her yolu biliyor!'),
  ),
  GameDefinition(
    id: GameIds.commandOrder,
    title: 'Komutları Sırala',
    description: 'Adımları doğru sıraya diz.',
    tone: AppTones.green,
    icon: AppAssets.gameOrder,
    trophy: GameTrophy(title: 'Algoritma Ustası', description: 'Adımları sıralamakta bir numarasın!'),
  ),
  GameDefinition(
    id: GameIds.ifThen,
    title: 'Eğer Böyleyse',
    description: 'Duruma göre doğru komutu seç.',
    tone: AppTones.purple,
    icon: AppAssets.gameIf,
    trophy: GameTrophy(title: 'Karar Ustası', description: 'Her durumda doğru kararı veriyorsun!'),
  ),
  GameDefinition(
    id: GameIds.repeat,
    title: 'Tekrar Et',
    description: 'Tekrarlanan hareketleri tek blokla yap.',
    tone: AppTones.orange,
    icon: AppAssets.gameRepeat,
    trophy: GameTrophy(title: 'Döngü Ustası', description: 'Tekrarları ustaca kullanıyorsun!'),
  ),
];

/// Uygulamanın içerik kataloğu. Şu an dört oyunun ücretsiz temel paketleri vardır.
/// Ücretli paketler ve avantajlı paketler Play Console'da ürün açıldığında `products`
/// listesine eklenir.
ContentCatalog buildContentCatalog() => ContentCatalog(
  games: _games,
  packs: [for (final game in _games) _basePack(game.id)],
  products: const <StoreProduct>[],
);
