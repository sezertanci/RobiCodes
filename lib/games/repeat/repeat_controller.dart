import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/robot_sprite.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import '../../l10n/l10n.dart';
import '../path_finder/board_run.dart';
import '../path_finder/board_scene.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/engine/path_finder_engine.dart';
import '../path_finder/path_finder_controller.dart';
import 'engine/repeat_engine.dart';
import 'engine/repeat_level.dart';
import 'engine/repeat_program.dart';
import 'engine/starting_program.dart';
import 'program_editor.dart';
import 'program_models.dart';
import 'repeat_texts.dart';

/// Bir seviyenin oynanış durumu: bloklar, açık tekrar bloğu, seçim, ipucu ve robotun yolculuğu.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class RepeatController extends ChangeNotifier
    with LevelLifecycle, BoardRunScene
    implements ProgramStripModel, ProgramControlsModel {
  RepeatController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.stepDuration = defaultStepDuration,
    this.celebrateDuration = defaultCelebrateDuration,
    this.startingProgram,
  }) : boardRun = BoardRun(level.board),
       voice = RobotVoice(feedback: feedback, intro: _introOf(level)),
       targetBlocks = RepeatEngine.countBlocks(RepeatEngine.parseSolution(level.solution)),
       _editor = ProgramEditor(startingProgram?.blocks ?? const []);

  static const defaultStepDuration = PathFinderController.defaultStepDuration;
  static const reducedStepDuration = PathFinderController.reducedStepDuration;
  static const defaultCelebrateDuration = PathFinderController.defaultCelebrateDuration;

  /// Tekrarla bloğu ile içindeki bir ok en az iki blok yer kaplar.
  static const repeatWithMove = 2;

  final RepeatLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  final Duration celebrateDuration;

  /// Verilirse program bu bloklarla açılır ve okları seçip düzeltme kuralları geçerli olur.
  final StartingProgram? startingProgram;

  /// 3 yıldız için en fazla blok sayısı: önerilen çözümün blok sayısı.
  final int targetBlocks;
  @override
  final BoardRun boardRun;
  @override
  final RobotVoice voice;

  final ProgramEditor _editor;
  ProgramStep? _activeStep;
  ProgramPlace? _wrongPlace;
  bool _hintUsed = false;
  bool _running = false;

  @override
  List<ProgramBlock> get program => _editor.program;
  @override
  int get blockCount => _editor.blockCount;
  @override
  int get maxBlocks => level.maxBlocks;
  @override
  bool get isFull => blockCount >= maxBlocks;
  @override
  bool get isRunning => _running;

  @override
  int? get target => _editor.target;
  @override
  bool get isInsideRepeat => target != null;
  @override
  ProgramPlace? get selected => _editor.selected;

  @override
  ProgramStep? get activeStep => _activeStep;

  @override
  ProgramPlace? get wrongPlace => _wrongPlace;
  bool get hintUsed => _hintUsed;

  /// Hazır programı düzeltme kuralları geçerli mi (bkz. [StartingProgram]).
  @override
  bool get fixesProgram => startingProgram != null;

  @override
  bool get allowsRepeat => startingProgram?.allowsRepeat ?? true;

  @override
  bool get isInserting => _editor.isInserting;

  @override
  bool get canInsert => fixesProgram && !_running && selected != null && !isFull;

  /// Yön tuşu seçili oku değiştirir mi.
  bool get _replacesSelection => fixesProgram && !isInserting && _editor.selectedMove != null;

  /// Ok değiştirmek blok sayısını artırmadığı için sınır doluyken de yapılabilir.
  @override
  bool get canAddMove => !_running && (!isFull || _replacesSelection);

  /// Tekrarla düğmesi blok açıkken bloktan çıkarır; kapalıyken ancak blok ve içine bir ok sığıyorsa ekler.
  @override
  bool get canUseRepeatButton =>
      allowsRepeat && !_running && (target != null || blockCount + repeatWithMove <= maxBlocks);

  LocalizedText get message => voice.message;
  RobotMood get mood => voice.mood;

  /// Düzeltme kurallarında seçili oku değiştirir ya da "Önüne ekle" seçiliyse oku seçili bloğun önüne
  /// ekler. Bunların dışında oku açık tekrar bloğunun içine, yoksa programın sonuna ekler.
  @override
  void addMove(Direction direction) {
    if (!canAddMove) {
      return;
    }
    final replace = _replacesSelection;
    final insert = isInserting && selected != null;
    _changeProgram(() {
      if (replace || insert) {
        _editor.putMove(direction, replace: replace);
      } else {
        _editor.appendMove(direction);
      }
    });
    if (isFull) {
      voice.say((t) => t.repeatFull);
    }
    notifyListeners();
  }

  /// "Önüne ekle" düğmesi: sonraki yönün seçili bloğun önüne eklenmesini açar ya da kapatır.
  @override
  void toggleInserting() {
    if (!canInsert) {
      return;
    }
    _editor.toggleInserting();
    voice.say((t) => isInserting ? t.bugHunterPickInsert : t.bugHunterSelected);
    notifyListeners();
  }

  /// Tekrarla düğmesi: blok açıksa bloktan çıkar, değilse yeni bir tekrar bloğu ekleyip açar.
  @override
  void pressRepeatButton() {
    if (!canUseRepeatButton) {
      return;
    }
    if (target != null) {
      _editor.closeTarget();
      voice.say((t) => t.repeatOutsideRepeat);
      notifyListeners();
      return;
    }
    _changeProgram(() => _editor.appendBlock(const RepeatBlock(RepeatBlock.defaultTimes, [])));
    voice.say((t) => isFull ? t.repeatFull : t.repeatInsideRepeat);
    notifyListeners();
  }

  /// Tekrar sayısını bir azaltır (-1) ya da artırır (+1); sayı sınırlar içinde kalır.
  @override
  void changeTimes(int index, int offset) {
    if (!_running && program[index] is RepeatBlock) {
      _changeProgram(() => _editor.changeTimes(index, offset));
      notifyListeners();
    }
  }

  /// Tekrar bloğunun etiketine dokunulunca blok açılır (oklar içine eklenir) ya da kapanır.
  @override
  void toggleTarget(int index) {
    if (_running) {
      return;
    }
    final leaving = _editor.toggleTarget(index);
    voice.say((t) => leaving ? t.repeatOutsideRepeat : t.repeatInsideRepeat);
    notifyListeners();
  }

  @override
  void toggleSelection(ProgramPlace place) {
    if (_running) {
      return;
    }
    _editor.toggleSelection(place);
    if (fixesProgram && selected != null) {
      voice.say((t) => t.bugHunterSelected);
    }
    notifyListeners();
  }

  @override
  void clearSelection() {
    if (_editor.clearSelection()) {
      notifyListeners();
    }
  }

  @override
  void deleteSelected() {
    if (!_running && selected != null) {
      _changeProgram(_editor.deleteSelected);
      notifyListeners();
    }
  }

  /// Bloğun içindeki seçili oku bloğun hemen arkasına taşır; sonraki oklar da dışarıya eklenir.
  @override
  void moveSelectedOut() {
    final place = selected;
    if (_running || place == null || !Places.isInner(place)) {
      return;
    }
    _changeProgram(_editor.moveSelectedOut);
    voice.say((t) => t.repeatMovedOut);
    notifyListeners();
  }

  /// Programı boşaltır; düzeltme kurallarında hazır programa geri döner ("Baştan al").
  @override
  void clear() {
    if (_running) {
      return;
    }
    _changeProgram(() => _editor.reset(startingProgram?.blocks ?? const []));
    voice.say(_introOf(level));
    notifyListeners();
  }

  /// İpucu ister. İpucu bir kez kullanılınca seviyeden en fazla 1 yıldız alınır.
  @override
  void showHint() {
    if (_running) {
      return;
    }
    _hintUsed = true;
    boardRun.hint = null;
    switch (RepeatEngine.hint(board, program)) {
      case EmptyRepeatHint(:final block):
        _editor.openTarget(block);
        voice.say((t) => t.repeatEmptyRepeat);
      case FixPlaceHint(:final step):
        _editor.select(Places.of(step));
        _wrongPlace = Places.of(step);
        voice.say(RepeatTexts.fixHint(step));
      case NextStepHint(:final move):
        // Blok sınırı doluysa yön tuşları basılamaz; o zaman sıradaki yön yerine deseni değiştirmesi önerilir.
        if (isFull) {
          voice.say(RepeatTexts.fullLevelHint(level.hint));
        } else {
          boardRun.hint = move;
          voice.say(RepeatTexts.nextMoveHint(level.hint, move.direction));
        }
      case RepeatSolvedHint():
        voice.say((t) => t.repeatSolved);
    }
    notifyListeners();
  }

  /// Blokları çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  @override
  Future<void> run() async {
    if (_running) {
      return;
    }
    if (_editor.isEmpty) {
      voice.say((t) => t.repeatEmpty);
      notifyListeners();
      return;
    }
    if (RepeatEngine.findEmptyRepeat(program) case final empty?) {
      _editor.openTarget(empty);
      voice.say((t) => t.repeatEmptyRepeat);
      notifyListeners();
      return;
    }
    _running = true;
    _editor
      ..closeTarget()
      ..clearSelection();
    _resetBoard();
    voice.say((t) => t.gameRobotRunning);
    notifyListeners();
    final run = RepeatEngine.run(board, program);
    final played = await boardRun.play(
      run.result,
      directions: [for (final step in run.trace) step.direction],
      stepDuration: stepDuration,
      onStep: (index) => _activeStep = run.trace[index],
      notify: notifyListeners,
      isStopped: () => isDisposed,
    );
    if (played) {
      await _finish(run);
    }
  }

  Future<void> _finish(RepeatRun run) async {
    _activeStep = null;
    final result = run.result;
    switch (result.outcome) {
      case RunOutcome.success:
        voice.say((t) => t.gameRobotReachedFlag, RobotMood.happy);
        voice.react(RobotReaction.celebrate);
        notifyListeners();
        final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: blockCount <= targetBlocks);
        await completeAfter(celebrateDuration, onCompleted, stars);
        return;
      case RunOutcome.blocked:
        final step = run.trace[result.failedIndex!];
        _wrongPlace = Places.of(step);
        boardRun.bumpDirection = step.direction;
        voice.react(RobotReaction.bump);
        voice.say(RepeatTexts.blocked(result.obstacle!, step), RobotMood.sad);
      case RunOutcome.missedGoal || RunOutcome.missingCoins:
        voice.react(RobotReaction.shake);
        final missingCoins = result.outcome == RunOutcome.missingCoins;
        voice.say((t) => missingCoins ? t.gameMissingCoins : t.repeatMissedGoal, RobotMood.sad);
    }
    _running = false;
    notifyListeners();
  }

  /// Bloklar değişince robot başa döner, eski ipucu ve işaretler silinir.
  void _changeProgram(VoidCallback update) {
    update();
    _editor.clearSelection();
    _resetBoard();
  }

  void _resetBoard() {
    boardRun.reset();
    _activeStep = null;
    _wrongPlace = null;
    voice.calm();
  }

  /// Açılış mesajı: seviyenin kendi mesajı, yoksa altın olup olmamasına göre genel mesaj.
  static LocalizedText _introOf(RepeatLevel level) =>
      level.intro ?? (t) => level.board.coins.isEmpty ? t.repeatIntro : t.repeatCoinIntro;
}
