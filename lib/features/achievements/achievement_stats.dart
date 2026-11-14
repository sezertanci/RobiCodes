import '../../content/content_catalog.dart';
import '../../content/models/game_definition.dart';
import '../../content/models/level_pack.dart';
import '../progress/progress_repository.dart';
import '../progress/star_rule.dart';

/// Bir oyunun ödüllerde sayılan ilerlemesi. Yalnızca ücretsiz paketler sayılır; böylece hiçbir
/// ödül satın almaya bağlı olmaz.
final class GameStats {
  const GameStats({required this.game, required this.completed, required this.levels, required this.isFirstDone});

  final GameDefinition game;
  final int completed;
  final int levels;

  /// Oyunun ilk seviyesi bitirildi mi?
  final bool isFirstDone;

  int get remaining => levels - completed;

  bool get isStarted => completed > 0;

  bool get isFinished => levels > 0 && completed >= levels;
}

/// Ödül koşullarının kullandığı sayılar. Ödüller bu sayılardan hesaplanır; oyun ve seviye sayısı
/// katalogdan gelir, sabit bir sayı varsayılmaz.
final class AchievementStats {
  const AchievementStats({
    required this.games,
    required this.totalStars,
    required this.perfectCount,
    required this.noHintCount,
  });

  /// [games] oyunlarının ücretsiz paketlerinden istatistik çıkarır. Toplam yıldızda ise katalogdaki
  /// bütün paketler (satın alınanlar dahil) sayılır.
  factory AchievementStats.collect({
    required ContentCatalog catalog,
    required List<GameDefinition> games,
    required ProgressRepository progress,
  }) {
    final freePacks = [for (final game in games) ...catalog.packsOf(game.id).where((pack) => catalog.isFree(pack.id))];
    final freeStars = [for (final pack in freePacks) ..._starsOf(pack, progress)];
    return AchievementStats(
      games: [for (final game in games) _gameStats(game, freePacks, progress)],
      totalStars: catalog.packs.fold(0, (sum, pack) => sum + progress.totalStars(pack.id)),
      perfectCount: freeStars.where((stars) => stars == StarRule.perfect).length,
      // İpucu kullanılan seviye en fazla 1 yıldız alır; 2 ve üstü ipucusuz bitmiş demektir.
      noHintCount: freeStars.where((stars) => stars >= StarRule.noHint).length,
    );
  }

  final List<GameStats> games;
  final int totalStars;
  final int perfectCount;
  final int noHintCount;

  int get totalCompleted => games.fold(0, (sum, game) => sum + game.completed);

  int get totalLevels => games.fold(0, (sum, game) => sum + game.levels);

  int get bestGameCompleted => games.fold(0, (best, game) => game.completed > best ? game.completed : best);

  int get gamesStarted => games.where((game) => game.isStarted).length;

  int get gamesFirstDone => games.where((game) => game.isFirstDone).length;

  int get gamesFinished => games.where((game) => game.isFinished).length;

  /// Bitmesine en az seviye kalan oyun; sayılacak oyun yoksa `null`.
  GameStats? get closestToFinish => games.isEmpty ? null : games.reduce((a, b) => b.remaining < a.remaining ? b : a);

  GameStats? of(String gameId) {
    for (final game in games) {
      if (game.game.id == gameId) {
        return game;
      }
    }
    return null;
  }

  static GameStats _gameStats(GameDefinition game, List<LevelPack> freePacks, ProgressRepository progress) {
    final packs = freePacks.where((pack) => pack.gameId == game.id).toList();
    return GameStats(
      game: game,
      completed: packs.fold(0, (sum, pack) => sum + progress.completedCount(pack.id)),
      levels: packs.fold(0, (sum, pack) => sum + pack.levelCount),
      isFirstDone: packs.isNotEmpty && progress.isCompleted(packs.first.id, 1),
    );
  }

  static Iterable<int> _starsOf(LevelPack pack, ProgressRepository progress) => [
    for (var level = 1; level <= pack.levelCount; level++) progress.starsOf(pack.id, level),
  ];
}
