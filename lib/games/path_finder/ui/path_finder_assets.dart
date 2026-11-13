import '../engine/path_finder_board.dart';

/// Oyunun görselleri. Dosyalar web sürümünden değiştirilmeden kopyalandı.
abstract final class PathFinderAssets {
  static const flag = 'assets/puzzles/goal-flag.svg';
  static const rock = 'assets/puzzles/rock.svg';
  static const water = 'assets/puzzles/tile-water.svg';
  static const coin = 'assets/icons/points.svg';
  static const run = 'assets/ui/button-play.svg';

  static String arrow(Direction direction) => 'assets/ui/button-arrow-${direction.name}.svg';
}
