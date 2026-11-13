import '../engine/path_finder_board.dart';

/// Oyuna özgü görseller (bayrak, taş, su ve Başlat düğmesi `AppAssets` içinde). Dosyalar web sürümünden değiştirilmeden kopyalandı.
abstract final class PathFinderAssets {
  static const coin = 'assets/icons/points.svg';

  static String arrow(Direction direction) => 'assets/ui/button-arrow-${direction.name}.svg';
}
