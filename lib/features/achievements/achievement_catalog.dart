import '../../app/app_assets.dart';
import '../../app/app_theme.dart';
import '../../content/models/game_definition.dart';
import '../character/character.dart';
import '../progress/star_rule.dart';
import 'achievement.dart';
import 'achievement_stats.dart';

/// Bütün rozet ve kupa tanımları. Liste web sürümündeki `js/core/achievements.js` ile aynıdır; yalnızca
/// oyun sayısına bağlı olanlar ("Dört Dörtlük" gibi) her oyun sayısında doğru kalacak şekilde yazıldı.
/// Oyuna özel kupalar sabit yazılmaz, sayılan her oyun için `GameDefinition.trophy` bilgisinden üretilir.
abstract final class AchievementCatalog {
  // Sabit hedefli rozetlerin hedef sayıları.
  static const firstGameGoal = 1;
  static const quickStartGoal = 5;
  static const determinedGoal = 10;
  static const starHunterGoal = 20;
  static const starMasterGoal = 50;
  static const perfectGoal = 1;
  static const noHintGoal = 5;

  /// [games] ödüllerde sayılan oyunlardır (oynanabilir ve ücretsiz paketi olanlar). Liste önce rozetleri,
  /// sonra kupaları içerir; aynı anda kazanılanlar da bu sırayla gösterilir.
  static List<Achievement> build(List<GameDefinition> games) => [..._badges, ..._trophies(games)];

  /// Oyun kupasının kimliği: `<oyun>-master`.
  static String gameTrophyId(String gameId) => '$gameId-master';

  /// Hedefi olmayan ödül; sayılacak oyun yoksa kullanılır ve hiç kazanılmaz.
  static const _noGoal = AchievementProgress(0, 0);

  static final _badges = [
    _badge(
      id: 'first-game',
      title: 'İlk Oyunum',
      description: 'Kodlama macerana ilk adımı attın!',
      condition: 'İlk oyun seviyeni tamamla.',
      tone: AppTones.green,
      symbol: const RewardSymbol(showsGoal: true),
      measure: (stats) => AchievementProgress(stats.totalCompleted, firstGameGoal),
    ),
    _badge(
      id: 'quick-start',
      title: 'Hızlı Başlangıç',
      description: 'Robotlar seninle gurur duyuyor!',
      condition: 'Bir oyunda $quickStartGoal seviye tamamla.',
      tone: AppTones.blue,
      symbol: const RewardSymbol(showsGoal: true),
      measure: (stats) => AchievementProgress(stats.bestGameCompleted, quickStartGoal),
    ),
    _badge(
      id: 'determined',
      title: 'Azimli Oyuncu',
      description: 'Pes etmeden devam ettin!',
      condition: 'Bir oyunda $determinedGoal seviye tamamla.',
      tone: AppTones.purple,
      symbol: const RewardSymbol(showsGoal: true),
      measure: (stats) => AchievementProgress(stats.bestGameCompleted, determinedGoal),
    ),
    _badge(
      id: 'master-coder',
      title: 'Usta Kodlayıcı',
      description: 'Bir oyunun bütün seviyelerini bitirdin!',
      condition: 'Bir oyunun bütün seviyelerini tamamla.',
      tone: AppTones.orange,
      symbol: const RewardSymbol(showsGoal: true),
      // Oyunların seviye sayısı farklı olabilir; bitmesine en az seviye kalan oyun gösterilir.
      measure: (stats) => switch (stats.closestToFinish) {
        final game? => AchievementProgress(game.completed, game.levels),
        null => _noGoal,
      },
    ),
    _badge(
      id: 'all-games',
      title: 'Oyun Kaşifi',
      description: 'Bütün oyunları denedin!',
      condition: 'Bütün oyunlarda en az bir seviye bitir.',
      tone: AppTones.pink,
      symbol: const RewardSymbol(showsGoal: true),
      measure: (stats) => AchievementProgress(stats.gamesStarted, stats.games.length),
    ),
    _badge(
      id: 'star-hunter',
      title: 'Yıldız Avcısı',
      description: 'Yıldızları toplamaya başladın!',
      condition: 'Toplam $starHunterGoal yıldız kazan.',
      tone: AppTones.red,
      symbol: const RewardSymbol(image: AppAssets.star, showsGoal: true),
      measure: (stats) => AchievementProgress(stats.totalStars, starHunterGoal),
    ),
    _badge(
      id: 'star-master',
      title: 'Yıldız Ustası',
      description: 'Gökyüzü kadar yıldızın var!',
      condition: 'Toplam $starMasterGoal yıldız kazan.',
      tone: AppTones.navy,
      symbol: const RewardSymbol(image: AppAssets.star, showsGoal: true),
      measure: (stats) => AchievementProgress(stats.totalStars, starMasterGoal),
    ),
    _badge(
      id: 'perfect',
      title: 'Mükemmel Oyuncu',
      description: 'Bir seviyeyi kusursuz bitirdin!',
      condition: 'Bir seviyeyi ${StarRule.perfect} yıldızla tamamla.',
      tone: AppTones.green,
      symbol: const RewardSymbol(stars: StarRule.perfect),
      measure: (stats) => AchievementProgress(stats.perfectCount, perfectGoal),
    ),
    _badge(
      id: 'no-hint',
      title: 'İpucusuz Kahraman',
      description: 'Kendi başına çözmeyi başardın!',
      condition: '$noHintGoal seviyeyi ipucu kullanmadan tamamla.',
      tone: AppTones.purple,
      symbol: const RewardSymbol(image: AppAssets.hint, isCrossed: true, showsGoal: true),
      measure: (stats) => AchievementProgress(stats.noHintCount, noHintGoal),
    ),
    _badge(
      id: 'big-success',
      title: 'Büyük Başarı',
      description: 'Bütün oyunları baştan sona bitirdin!',
      condition: 'Bütün oyunların tüm seviyelerini tamamla.',
      tone: AppTones.blue,
      symbol: const RewardSymbol(image: AppAssets.medal),
      measure: (stats) => AchievementProgress(stats.gamesFinished, stats.games.length),
    ),
  ];

  static List<Achievement> _trophies(List<GameDefinition> games) => [
    Achievement(
      id: 'first-adventure',
      kind: AchievementKind.trophy,
      title: 'İlk Macera Kupası',
      description: 'Bütün oyunlarda ilk adımı attın!',
      condition: 'Her oyunda ilk seviyeyi tamamla.',
      tone: AppTones.green,
      symbol: RewardSymbol(image: CharacterRoster.defaultCharacter.image),
      measure: (stats) => AchievementProgress(stats.gamesFirstDone, stats.games.length),
    ),
    for (final game in games) _gameTrophy(game),
    Achievement(
      id: 'champion',
      kind: AchievementKind.trophy,
      title: 'Kodlama Şampiyonu',
      description: 'Sen gerçek bir kodlama şampiyonusun!',
      condition: 'Bütün oyunların bütün seviyelerini bitir.',
      tone: AppTones.gold,
      symbol: const RewardSymbol(image: AppAssets.star),
      measure: (stats) => AchievementProgress(stats.totalCompleted, stats.totalLevels),
    ),
  ];

  /// Oyunun kupası: oyunun ücretsiz seviyelerinin hepsi bitince kazanılır.
  static Achievement _gameTrophy(GameDefinition game) => Achievement(
    id: gameTrophyId(game.id),
    kind: AchievementKind.trophy,
    title: game.trophy.title,
    description: game.trophy.description,
    condition: '${game.title} oyununu bitir.',
    tone: game.tone,
    symbol: RewardSymbol(image: game.icon),
    measure: (stats) => switch (stats.of(game.id)) {
      final played? => AchievementProgress(played.completed, played.levels),
      null => _noGoal,
    },
  );

  static Achievement _badge({
    required String id,
    required String title,
    required String description,
    required String condition,
    required ColorTone tone,
    required RewardSymbol symbol,
    required AchievementProgress Function(AchievementStats stats) measure,
  }) => Achievement(
    id: id,
    kind: AchievementKind.badge,
    title: title,
    description: description,
    condition: condition,
    tone: tone,
    symbol: symbol,
    measure: measure,
  );
}
