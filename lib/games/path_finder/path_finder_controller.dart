import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/play_timings.dart';
import '../../features/play/widgets/robot_sprite.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import 'board_scene.dart';
import 'engine/path_finder_board.dart';
import 'engine/path_finder_engine.dart';
import 'engine/path_finder_level.dart';
import 'path_finder_texts.dart';

/// Bir seviyenin oynanış durumu: komut listesi, seçim, ipucu ve robotun yolculuğu.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class PathFinderController extends ChangeNotifier implements BoardScene {
  PathFinderController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.stepDuration = defaultStepDuration,
    this.celebrateDuration = defaultCelebrateDuration,
  }) : board = level.board,
       _message = _introOf(level) {
    optimalLength = PathFinderEngine.optimalLength(board);
    _robot = board.start;
  }

  static const defaultStepDuration = Duration(milliseconds: 450);
  static const reducedStepDuration = PlayTimings.reducedStep;
  static const defaultCelebrateDuration = PlayTimings.celebrate;

  final PathFinderLevel level;
  @override
  final PathFinderBoard board;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  final Duration celebrateDuration;
  late final int optimalLength;

  final List<Direction> _commands = [];
  final Set<int> _collected = {};
  final Map<GridPoint, Direction> _trail = {};
  late GridPoint _robot;
  String _message;
  RobotMood _mood = RobotMood.talk;
  RobotReaction _reaction = RobotReaction.none;
  Direction? _bumpDirection;
  int _reactionCount = 0;
  int? _selected;
  int? _activeIndex;
  int? _wrongIndex;
  NextMoveHint? _hint;
  bool _hintUsed = false;
  bool _running = false;
  bool _disposed = false;

  List<Direction> get commands => List.unmodifiable(_commands);
  int get commandLimit => level.commandLimit;
  bool get isFull => _commands.length >= commandLimit;
  @override
  GridPoint get robot => _robot;
  @override
  Set<int> get collectedCoins => Set.unmodifiable(_collected);

  @override
  Map<GridPoint, Direction> get trail => Map.unmodifiable(_trail);
  String get message => _message;
  RobotMood get mood => _mood;
  @override
  RobotReaction get reaction => _reaction;
  @override
  Direction? get bumpDirection => _bumpDirection;

  @override
  int get reactionCount => _reactionCount;
  int? get selectedIndex => _selected;
  int? get activeIndex => _activeIndex;
  int? get wrongIndex => _wrongIndex;
  @override
  NextMoveHint? get hint => _hint;
  bool get hintUsed => _hintUsed;
  bool get isRunning => _running;

  void addCommand(Direction direction) {
    if (_running || isFull) {
      return;
    }
    _changeProgram(() => _commands.add(direction));
    if (isFull) {
      _say(PathFinderTexts.full);
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
    _say(_introOf(level));
    notifyListeners();
  }

  /// İpucu ister. İpucu bir kez kullanılınca seviyeden en fazla 1 yıldız alınır.
  void showHint() {
    if (_running) {
      return;
    }
    _hintUsed = true;
    _hint = null;
    switch (PathFinderEngine.hint(board, _commands, commandLimit)) {
      case final NextMoveHint next:
        _hint = next;
        _say(PathFinderTexts.nextMove(next.direction));
      case FixCommandHint(:final index):
        _selected = index;
        _wrongIndex = index;
        _say(PathFinderTexts.fixCommand(index));
      case TooManyCommandsHint():
        _say(PathFinderTexts.tooMany);
      case SolvedHint():
        _say(PathFinderTexts.solved);
    }
    notifyListeners();
  }

  /// Komutları çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  Future<void> run() async {
    if (_running) {
      return;
    }
    if (_commands.isEmpty) {
      _say(PathFinderTexts.empty);
      notifyListeners();
      return;
    }
    _running = true;
    _selected = null;
    _resetBoard();
    _say(PathFinderTexts.running);
    notifyListeners();
    final result = PathFinderEngine.run(board, _commands);
    if (await _playSteps(result)) {
      await _finish(result);
    }
  }

  /// Adımları sırayla oynatır. Ekran kapanırsa `false` döner.
  Future<bool> _playSteps(RunResult result) async {
    for (final (index, step) in result.steps.indexed) {
      _activeIndex = index;
      _trail[_robot] = _commands[index];
      _robot = step.position;
      notifyListeners();
      await Future<void>.delayed(stepDuration);
      if (_disposed) {
        return false;
      }
      if (step.coin case final coin?) {
        _collected.add(coin);
        notifyListeners();
      }
    }
    return true;
  }

  Future<void> _finish(RunResult result) async {
    _activeIndex = null;
    switch (result.outcome) {
      case RunOutcome.success:
        _say(PathFinderTexts.success, RobotMood.happy);
        _react(RobotReaction.celebrate);
        notifyListeners();
        final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: _commands.length <= optimalLength);
        await Future<void>.delayed(celebrateDuration);
        if (!_disposed) {
          onCompleted(stars);
        }
        return;
      case RunOutcome.blocked:
        final index = result.failedIndex!;
        _wrongIndex = index;
        _bumpDirection = _commands[index];
        _react(RobotReaction.bump);
        _say(PathFinderTexts.blocked(result.obstacle!, index), RobotMood.sad);
      case RunOutcome.missedGoal || RunOutcome.missingCoins:
        _react(RobotReaction.shake);
        final text = result.outcome == RunOutcome.missingCoins
            ? PathFinderTexts.missingCoins
            : PathFinderTexts.missedGoal;
        _say(text, RobotMood.sad);
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
    _robot = board.start;
    _collected.clear();
    _trail.clear();
    _activeIndex = null;
    _wrongIndex = null;
    _hint = null;
    _reaction = RobotReaction.none;
  }

  /// Açılış mesajı: seviyenin kendi mesajı, yoksa altın olup olmamasına göre genel mesaj.
  static String _introOf(PathFinderLevel level) =>
      level.intro ?? (level.board.coins.isEmpty ? PathFinderTexts.intro : PathFinderTexts.coinIntro);

  void _react(RobotReaction reaction) {
    _reaction = reaction;
    _reactionCount++;
  }

  void _say(String text, [RobotMood mood = RobotMood.talk]) {
    _message = text;
    _mood = mood;
    feedback.react(mood);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
