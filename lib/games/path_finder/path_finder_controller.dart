import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/play_timings.dart';
import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/robot_sprite.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import 'board_run.dart';
import 'board_scene.dart';
import 'engine/path_finder_board.dart';
import 'engine/path_finder_engine.dart';
import 'engine/path_finder_level.dart';
import 'path_finder_texts.dart';

/// Bir seviyenin oynanış durumu: komut listesi, seçim, ipucu ve robotun yolculuğu.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class PathFinderController extends ChangeNotifier with LevelLifecycle, BoardRunScene {
  PathFinderController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.stepDuration = defaultStepDuration,
    this.celebrateDuration = defaultCelebrateDuration,
  }) : boardRun = BoardRun(level.board),
       voice = RobotVoice(feedback: feedback, intro: _introOf(level)) {
    optimalLength = PathFinderEngine.optimalLength(board);
  }

  static const defaultStepDuration = Duration(milliseconds: 450);
  static const reducedStepDuration = PlayTimings.reducedStep;
  static const defaultCelebrateDuration = PlayTimings.celebrate;

  final PathFinderLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  final Duration celebrateDuration;
  late final int optimalLength;
  @override
  final BoardRun boardRun;
  @override
  final RobotVoice voice;

  final List<Direction> _commands = [];
  int? _selected;
  int? _activeIndex;
  int? _wrongIndex;
  bool _hintUsed = false;
  bool _running = false;

  List<Direction> get commands => List.unmodifiable(_commands);
  int get commandLimit => level.commandLimit;
  bool get isFull => _commands.length >= commandLimit;
  String get message => voice.message;
  RobotMood get mood => voice.mood;
  int? get selectedIndex => _selected;
  int? get activeIndex => _activeIndex;
  int? get wrongIndex => _wrongIndex;
  bool get hintUsed => _hintUsed;
  bool get isRunning => _running;

  void addCommand(Direction direction) {
    if (_running || isFull) {
      return;
    }
    _changeProgram(() => _commands.add(direction));
    if (isFull) {
      voice.say(PathFinderTexts.full);
    }
    notifyListeners();
  }

  void toggleSelection(int index) {
    if (_running) {
      return;
    }
    _selected = _selected == index ? null : index;
    notifyListeners();
  }

  void clearSelection() {
    if (_selected != null) {
      _selected = null;
      notifyListeners();
    }
  }

  /// Seçili komutu bir sola (-1) ya da bir sağa (+1) taşır; seçim komutla birlikte gider.
  void moveSelected(int offset) {
    final from = _selected;
    if (_running || from == null || from + offset < 0 || from + offset >= _commands.length) {
      return;
    }
    final to = from + offset;
    _changeProgram(() {
      final moved = _commands[from];
      _commands[from] = _commands[to];
      _commands[to] = moved;
    });
    _selected = to;
    notifyListeners();
  }

  /// Sürüklenen komutu [to] sırasına taşır. [to] `null` ise (listenin boş yeri) sona gider.
  void reorder(int from, int? to) {
    final target = to ?? _commands.length - 1;
    if (_running || from == target || from < 0 || from >= _commands.length) {
      return;
    }
    _changeProgram(() => _commands.insert(target, _commands.removeAt(from)));
    notifyListeners();
  }

  void deleteSelected() {
    final index = _selected;
    if (_running || index == null) {
      return;
    }
    _changeProgram(() => _commands.removeAt(index));
    notifyListeners();
  }

  void clear() {
    if (_running) {
      return;
    }
    _changeProgram(_commands.clear);
    voice.say(_introOf(level));
    notifyListeners();
  }

  /// İpucu ister. İpucu bir kez kullanılınca seviyeden en fazla 1 yıldız alınır.
  void showHint() {
    if (_running) {
      return;
    }
    _hintUsed = true;
    boardRun.hint = null;
    switch (PathFinderEngine.hint(board, _commands, commandLimit)) {
      case final NextMoveHint next:
        boardRun.hint = next;
        voice.say(PathFinderTexts.nextMove(next.direction));
      case FixCommandHint(:final index):
        _selected = index;
        _wrongIndex = index;
        voice.say(PathFinderTexts.fixCommand(index));
      case TooManyCommandsHint():
        voice.say(PathFinderTexts.tooMany);
      case SolvedHint():
        voice.say(PathFinderTexts.solved);
    }
    notifyListeners();
  }

  /// Komutları çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  Future<void> run() async {
    if (_running) {
      return;
    }
    if (_commands.isEmpty) {
      voice.say(PathFinderTexts.empty);
      notifyListeners();
      return;
    }
    _running = true;
    _selected = null;
    _resetBoard();
    voice.say(PathFinderTexts.running);
    notifyListeners();
    final result = PathFinderEngine.run(board, _commands);
    final played = await boardRun.play(
      result,
      directions: _commands,
      stepDuration: stepDuration,
      onStep: (index) => _activeIndex = index,
      notify: notifyListeners,
      isStopped: () => isDisposed,
    );
    if (played) {
      await _finish(result);
    }
  }

  Future<void> _finish(RunResult result) async {
    _activeIndex = null;
    switch (result.outcome) {
      case RunOutcome.success:
        voice.say(PathFinderTexts.success, RobotMood.happy);
        voice.react(RobotReaction.celebrate);
        notifyListeners();
        final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: _commands.length <= optimalLength);
        await completeAfter(celebrateDuration, onCompleted, stars);
        return;
      case RunOutcome.blocked:
        final index = result.failedIndex!;
        _wrongIndex = index;
        boardRun.bumpDirection = _commands[index];
        voice.react(RobotReaction.bump);
        voice.say(PathFinderTexts.blocked(result.obstacle!, index), RobotMood.sad);
      case RunOutcome.missedGoal || RunOutcome.missingCoins:
        voice.react(RobotReaction.shake);
        final text = result.outcome == RunOutcome.missingCoins
            ? PathFinderTexts.missingCoins
            : PathFinderTexts.missedGoal;
        voice.say(text, RobotMood.sad);
    }
    _running = false;
    notifyListeners();
  }

  /// Komut listesi değişince robot başa döner, eski ipucu ve işaretler silinir.
  void _changeProgram(VoidCallback update) {
    update();
    _selected = null;
    _resetBoard();
  }

  void _resetBoard() {
    boardRun.reset();
    _activeIndex = null;
    _wrongIndex = null;
    voice.calm();
  }

  /// Açılış mesajı: seviyenin kendi mesajı, yoksa altın olup olmamasına göre genel mesaj.
  static String _introOf(PathFinderLevel level) =>
      level.intro ?? (level.board.coins.isEmpty ? PathFinderTexts.intro : PathFinderTexts.coinIntro);
}
