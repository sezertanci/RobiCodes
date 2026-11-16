import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/robot_sprite.dart';
import 'board_run.dart';
import 'engine/lamp.dart';
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

  /// Karelerdeki lambalar ("Desen Bulmacası" Uzman grubu); diğer oyunlarda boştur.
  BoardLamps get lamps;
}

/// [BoardScene]'i yolculuk ([boardRun]) ve robotun sesi ([voice]) üzerinden sağlar. Denetleyici
/// yalnızca bu ikisini ve adım süresini verir.
mixin BoardRunScene implements BoardScene {
  BoardRun get boardRun;
  RobotVoice get voice;

  @override
  PathFinderBoard get board => boardRun.board;
  @override
  GridPoint get robot => boardRun.robot;
  @override
  Map<GridPoint, Direction> get trail => boardRun.trail;
  @override
  Set<int> get collectedCoins => boardRun.collectedCoins;
  @override
  NextMoveHint? get hint => boardRun.hint;
  @override
  Direction? get bumpDirection => boardRun.bumpDirection;
  @override
  RobotReaction get reaction => voice.reaction;
  @override
  int get reactionCount => voice.reactionCount;
  @override
  BoardLamps get lamps => const {};
}
