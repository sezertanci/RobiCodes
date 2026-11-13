import '../../features/play/widgets/robot_sprite.dart';
import 'engine/path_finder_board.dart';
import 'engine/path_finder_engine.dart';

/// Haritanın çizilmesi için gereken durum. "Robotun Yolunu Bul" ve "Tekrar Et" aynı haritayı
/// kullanır; [BoardView] yalnızca bu arayüzü okur.
abstract interface class BoardScene {
  PathFinderBoard get board;
  GridPoint get robot;

  /// Robotun ayrıldığı kareler ve o karelerden çıktığı son yön.
  Map<GridPoint, Direction> get trail;
  Set<int> get collectedCoins;

  /// İpucunun parlattığı kare ve yön.
  NextMoveHint? get hint;
  Duration get stepDuration;
  RobotReaction get reaction;

  /// Her tepkide artar; ekran aynı tepki art arda gelse de animasyonu yeniden başlatır.
  int get reactionCount;
  Direction? get bumpDirection;
}
