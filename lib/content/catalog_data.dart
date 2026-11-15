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

/// Oyunun ücretsiz temel paketinin kimliği: `<oyun>.base`.
String basePackId(String gameId) => '$gameId.base';

LevelPack _basePack(String gameId) =>
    LevelPack(id: basePackId(gameId), gameId: gameId, title: (t) => t.basePackTitle, groups: _standardGroups);

final _games = [
  GameDefinition(
    id: GameIds.pathFinder,
    title: (t) => t.gamePathFinderTitle,
    description: (t) => t.gamePathFinderDescription,
    tone: AppTones.blue,
    icon: AppAssets.gamePath,
    trophy: GameTrophy(title: (t) => t.gamePathFinderTrophy, description: (t) => t.gamePathFinderTrophyDescription),
  ),
  GameDefinition(
    id: GameIds.commandOrder,
    title: (t) => t.gameCommandOrderTitle,
    description: (t) => t.gameCommandOrderDescription,
    tone: AppTones.green,
    icon: AppAssets.gameOrder,
    trophy: GameTrophy(title: (t) => t.gameCommandOrderTrophy, description: (t) => t.gameCommandOrderTrophyDescription),
  ),
  GameDefinition(
    id: GameIds.ifThen,
    title: (t) => t.gameIfThenTitle,
    description: (t) => t.gameIfThenDescription,
    tone: AppTones.purple,
    icon: AppAssets.gameIf,
    trophy: GameTrophy(title: (t) => t.gameIfThenTrophy, description: (t) => t.gameIfThenTrophyDescription),
  ),
  GameDefinition(
    id: GameIds.repeat,
    title: (t) => t.gameRepeatTitle,
    description: (t) => t.gameRepeatDescription,
    tone: AppTones.orange,
    icon: AppAssets.gameRepeat,
    trophy: GameTrophy(title: (t) => t.gameRepeatTrophy, description: (t) => t.gameRepeatTrophyDescription),
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
