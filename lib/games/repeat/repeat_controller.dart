import 'package:flutter/foundation.dart';

import '../../features/play/widgets/robot_sprite.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import '../path_finder/board_scene.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/engine/path_finder_engine.dart';
import '../path_finder/path_finder_controller.dart';
import 'engine/repeat_engine.dart';
import 'engine/repeat_level.dart';
import 'engine/repeat_program.dart';
import 'repeat_texts.dart';

/// Bir seviyenin oynanış durumu: bloklar, açık tekrar bloğu, seçim, ipucu ve robotun yolculuğu.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class RepeatController extends ChangeNotifier implements BoardScene {
  RepeatController({
    required this.level,
    required this.onCompleted,
    this.stepDuration = defaultStepDuration,
    this.celebrateDuration = defaultCelebrateDuration,
  }) : board = level.board,
       targetBlocks = RepeatEngine.countBlocks(RepeatEngine.parseSolution(level.solution)),
       _message = _introOf(level) {
    _robot = board.start;
  }

  static const defaultStepDuration = PathFinderController.defaultStepDuration;
  static const reducedStepDuration = PathFinderController.reducedStepDuration;
  static const defaultCelebrateDuration = PathFinderController.defaultCelebrateDuration;

  /// Tekrarla bloğu ile içindeki bir ok en az iki blok yer kaplar.
  static const repeatWithMove = 2;

  final RepeatLevel level;
  @override
  final PathFinderBoard board;
  final ValueChanged<int> onCompleted;
  @override
  final Duration stepDuration;
  final Duration celebrateDuration;

  /// 3 yıldız için en fazla blok sayısı: önerilen çözümün blok sayısı.
  final int targetBlocks;

  final List<ProgramBlock> _program = [];
  final Set<int> _collected = {};
  final Map<GridPoint, Direction> _trail = {};
  late GridPoint _robot;
  String _message;
  RobotMood _mood = RobotMood.talk;
  RobotReaction _reaction = RobotReaction.none;
  Direction? _bumpDirection;
  int _reactionCount = 0;
  int? _target;
  ProgramPlace? _selected;
  ProgramStep? _activeStep;
  ProgramPlace? _wrongPlace;
  NextMoveHint? _hint;
  bool _hintUsed = false;
  bool _running = false;
  bool _disposed = false;

  List<ProgramBlock> get program => List.unmodifiable(_program);
  int get blockCount => RepeatEngine.countBlocks(_program);
  int get maxBlocks => level.maxBlocks;
  bool get isFull => blockCount >= maxBlocks;
  bool get isRunning => _running;

  /// Okların içine eklendiği (açık) tekrar bloğunun sırası.
  int? get target => _target;
  ProgramPlace? get selected => _selected;

  /// Çalışırken o anki hareketin geldiği yer ve tur.
  ProgramStep? get activeStep => _activeStep;

  /// Robotu yoldan çıkaran yer (kırmızıyla gösterilir).
  ProgramPlace? get wrongPlace => _wrongPlace;
  bool get hintUsed => _hintUsed;

  bool get canAddMove => !_running && !isFull;

  /// Tekrarla düğmesi blok açıkken bloktan çıkarır; kapalıyken ancak blok ve içine bir ok sığıyorsa ekler.
  bool get canUseRepeatButton => !_running && (_target != null || blockCount + repeatWithMove <= maxBlocks);

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
  @override
  NextMoveHint? get hint => _hint;

  /// Oku açık tekrar bloğunun içine, yoksa programın sonuna ekler.
  void addMove(Direction direction) {
    if (!canAddMove) {
      return;
    }
    _changeProgram(() {
      final target = _target;
      if (target == null) {
        _program.add(MoveBlock(direction));
      } else {
        final block = _program[target] as RepeatBlock;
        _program[target] = block.copyWith(body: [...block.body, direction]);
      }
    });
    if (isFull) {
      _say(RepeatTexts.full);
    }
    notifyListeners();
  }

  /// Tekrarla düğmesi: blok açıksa bloktan çıkar, değilse yeni bir tekrar bloğu ekleyip açar.
  void pressRepeatButton() {
    if (!canUseRepeatButton) {
      return;
    }
    if (_target != null) {
      _target = null;
      _say(RepeatTexts.outsideRepeat);
      notifyListeners();
      return;
    }
    _changeProgram(() => _program.add(const RepeatBlock(RepeatBlock.defaultTimes, [])));
    _target = _program.length - 1;
    _say(isFull ? RepeatTexts.full : RepeatTexts.insideRepeat);
    notifyListeners();
  }

  /// Tekrar sayısını bir azaltır (-1) ya da artırır (+1); sayı sınırlar içinde kalır.
  void changeTimes(int index, int offset) {
    final block = _program[index];
    if (_running || block is! RepeatBlock) {
      return;
    }
    final times = (block.times + offset).clamp(RepeatBlock.minTimes, RepeatBlock.maxTimes);
    _changeProgram(() => _program[index] = block.copyWith(times: times));
    notifyListeners();
  }

  /// Tekrar bloğunun etiketine dokunulunca blok açılır (oklar içine eklenir) ya da kapanır.
  void toggleTarget(int index) {
    if (_running) {
      return;
    }
    final leaving = _target == index;
    _target = leaving ? null : index;
    _selected = leaving ? null : Places.top(index);
    _say(leaving ? RepeatTexts.outsideRepeat : RepeatTexts.insideRepeat);
    notifyListeners();
  }

  void toggleSelection(ProgramPlace place) {
    if (_running) {
      return;
    }
    _selected = _selected == place ? null : place;
    notifyListeners();
  }

  void clearSelection() {
    if (_selected != null) {
      _selected = null;
      notifyListeners();
    }
  }

  void deleteSelected() {
    final place = _selected;
    if (_running || place == null) {
      return;
    }
    _changeProgram(() {
      if (Places.isInner(place)) {
        final block = _program[place.block] as RepeatBlock;
        _program[place.block] = block.copyWith(body: [...block.body]..removeAt(place.inner));
        return;
      }
      _program.removeAt(place.block);
      _target = switch (_target) {
        final target? when target == place.block => null,
        final target? when target > place.block => target - 1,
        final target => target,
      };
    });
    notifyListeners();
  }

  /// Bloğun içindeki seçili oku bloğun hemen arkasına taşır; sonraki oklar da dışarıya eklenir.
  void moveSelectedOut() {
    final place = _selected;
    if (_running || place == null || !Places.isInner(place)) {
      return;
    }
    _changeProgram(() {
      final block = _program[place.block] as RepeatBlock;
      _program[place.block] = block.copyWith(body: [...block.body]..removeAt(place.inner));
      _program.insert(place.block + 1, MoveBlock(block.body[place.inner]));
      _target = null;
    });
    _say(RepeatTexts.movedOut);
    notifyListeners();
  }

  void clear() {
    if (_running) {
      return;
    }
    _changeProgram(() {
      _program.clear();
      _target = null;
    });
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
    switch (RepeatEngine.hint(board, _program)) {
      case EmptyRepeatHint(:final block):
        _target = block;
        _selected = null;
        _say(RepeatTexts.emptyRepeat);
      case FixPlaceHint(:final step):
        _selected = Places.of(step);
        _wrongPlace = Places.of(step);
        _say(RepeatTexts.fixHint(step));
      case NextStepHint(:final move):
        // Blok sınırı doluysa yön tuşları basılamaz; o zaman sıradaki yön yerine deseni değiştirmesi önerilir.
        if (isFull) {
          _say(RepeatTexts.fullLevelHint(level.hint));
        } else {
          _hint = move;
          _say(RepeatTexts.nextMoveHint(level.hint, move.direction));
        }
      case RepeatSolvedHint():
        _say(RepeatTexts.solved);
    }
    notifyListeners();
  }

  /// Blokları çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  Future<void> run() async {
    if (_running) {
      return;
    }
    if (_program.isEmpty) {
      _say(RepeatTexts.empty);
      notifyListeners();
      return;
    }
    if (RepeatEngine.findEmptyRepeat(_program) case final empty?) {
      _target = empty;
      _say(RepeatTexts.emptyRepeat);
      notifyListeners();
      return;
    }
    _running = true;
    _target = null;
    _selected = null;
    _resetBoard();
    _say(RepeatTexts.running);
    notifyListeners();
    final run = RepeatEngine.run(board, _program);
    if (await _playSteps(run)) {
      await _finish(run);
    }
  }

  /// Adımları sırayla oynatır. Ekran kapanırsa `false` döner.
  Future<bool> _playSteps(RepeatRun run) async {
    for (final (index, step) in run.result.steps.indexed) {
      _activeStep = run.trace[index];
      _trail[_robot] = run.trace[index].direction;
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

  Future<void> _finish(RepeatRun run) async {
    _activeStep = null;
    final result = run.result;
    switch (result.outcome) {
      case RunOutcome.success:
        _say(RepeatTexts.success, RobotMood.happy);
        _react(RobotReaction.celebrate);
        notifyListeners();
        final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: blockCount <= targetBlocks);
        await Future<void>.delayed(celebrateDuration);
        if (!_disposed) {
          onCompleted(stars);
        }
        return;
      case RunOutcome.blocked:
        final step = run.trace[result.failedIndex!];
        _wrongPlace = Places.of(step);
        _bumpDirection = step.direction;
        _react(RobotReaction.bump);
        _say(RepeatTexts.blocked(result.obstacle!, step), RobotMood.sad);
      case RunOutcome.missedGoal || RunOutcome.missingCoins:
        _react(RobotReaction.shake);
        final text = result.outcome == RunOutcome.missingCoins ? RepeatTexts.missingCoins : RepeatTexts.missedGoal;
        _say(text, RobotMood.sad);
    }
    _running = false;
    notifyListeners();
  }

  /// Bloklar değişince robot başa döner, eski ipucu ve işaretler silinir.
  void _changeProgram(VoidCallback update) {
    update();
    _selected = null;
    _resetBoard();
  }

  void _resetBoard() {
    _robot = board.start;
    _collected.clear();
    _trail.clear();
    _activeStep = null;
    _wrongPlace = null;
    _hint = null;
    _reaction = RobotReaction.none;
  }

  /// Açılış mesajı: seviyenin kendi mesajı, yoksa altın olup olmamasına göre genel mesaj.
  static String _introOf(RepeatLevel level) =>
      level.intro ?? (level.board.coins.isEmpty ? RepeatTexts.intro : RepeatTexts.coinIntro);

  void _react(RobotReaction reaction) {
    _reaction = reaction;
    _reactionCount++;
  }

  void _say(String text, [RobotMood mood = RobotMood.talk]) {
    _message = text;
    _mood = mood;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
