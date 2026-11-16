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
  static const bugHunter = 'bug-hunter';
  static const myCommand = 'my-command';
  static const variableBox = 'variable-box';
}

/// Play Console'daki ürün kimlikleri. Yayından sonra değiştirilmez.
abstract final class ProductIds {
  static const bugHunterBase = 'pack.bug_hunter.base';
  static const myCommandBase = 'pack.my_command.base';
  static const variableBoxBase = 'pack.variable_box.base';

  /// Başlangıç Seti: açıldığı gün var olan iki ücretli oyunu (Hata Avcısı, Kendi Komutunu Oluştur) birlikte açar.
  static const starterBundle = 'bundle.starter';
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

/// Oyunun temel paketi. Ücretli oyunun paketinde her zorluğun ilk seviyesi ücretsiz denenir ([freePreview]).
LevelPack _basePack(String gameId, {bool freePreview = false}) => LevelPack(
  id: basePackId(gameId),
  gameId: gameId,
  title: (t) => t.basePackTitle,
  groups: _standardGroups,
  freePreview: freePreview,
);

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

/// Ücretli oyunlar: temel paketleri satın alınınca açılır.
final _paidGames = [
  GameDefinition(
    id: GameIds.bugHunter,
    title: (t) => t.gameBugHunterTitle,
    description: (t) => t.gameBugHunterDescription,
    tone: AppTones.red,
    icon: AppAssets.gameBug,
    trophy: GameTrophy(title: (t) => t.gameBugHunterTrophy, description: (t) => t.gameBugHunterTrophyDescription),
  ),
  GameDefinition(
    id: GameIds.myCommand,
    title: (t) => t.gameMyCommandTitle,
    description: (t) => t.gameMyCommandDescription,
    tone: AppTones.teal,
    icon: AppAssets.gameCommand,
    trophy: GameTrophy(title: (t) => t.gameMyCommandTrophy, description: (t) => t.gameMyCommandTrophyDescription),
  ),
  GameDefinition(
    id: GameIds.variableBox,
    title: (t) => t.gameVariableBoxTitle,
    description: (t) => t.gameVariableBoxDescription,
    tone: AppTones.brown,
    icon: AppAssets.gameBox,
    trophy: GameTrophy(title: (t) => t.gameVariableBoxTrophy, description: (t) => t.gameVariableBoxTrophyDescription),
  ),
];

/// Uygulamanın içerik kataloğu: ücretsiz oyunların temel paketleri ve ücretli oyunların satın alınan
/// paketleri. Avantajlı paket (bundle) yalnızca açıldığı gün var olan paketleri kapsar; sonradan eklenen
/// paketler için yeni bundle açılır.
ContentCatalog buildContentCatalog() => ContentCatalog(
  games: [..._games, ..._paidGames],
  packs: [
    for (final game in _games) _basePack(game.id),
    for (final game in _paidGames) _basePack(game.id, freePreview: true),
  ],
  products: [
    StoreProduct(
      id: ProductIds.bugHunterBase,
      title: (t) => t.gameBugHunterTitle,
      packIds: [basePackId(GameIds.bugHunter)],
    ),
    StoreProduct(
      id: ProductIds.myCommandBase,
      title: (t) => t.gameMyCommandTitle,
      packIds: [basePackId(GameIds.myCommand)],
    ),
    StoreProduct(
      id: ProductIds.variableBoxBase,
      title: (t) => t.gameVariableBoxTitle,
      packIds: [basePackId(GameIds.variableBox)],
    ),
    StoreProduct(
      id: ProductIds.starterBundle,
      title: (t) => t.storeStarterBundleTitle,
      packIds: [basePackId(GameIds.bugHunter), basePackId(GameIds.myCommand)],
    ),
  ],
);
