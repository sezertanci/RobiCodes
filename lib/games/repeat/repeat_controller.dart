import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/speech_bubble.dart';
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
import 'program_runner.dart';
import 'repeat_texts.dart';

/// Bir seviyenin oynanış durumu: bloklar, açık tekrar bloğu, seçim, ipucu ve robotun yolculuğu.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class RepeatController extends ChangeNotifier
    with LevelLifecycle, BoardRunScene, ProgramRunner
    implements ProgramStripModel, ProgramControlsModel {
  RepeatController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.stepDuration = PathFinderController.defaultStepDuration,
    this.celebrateDuration = PathFinderController.defaultCelebrateDuration,
    this.startingProgram,
  }) : boardRun = BoardRun(level.board),
       voice = RobotVoice(feedback: feedback, intro: _introOf(level)),
       _solution = RepeatEngine.parseSolution(level.solution),
       _editor = ProgramEditor(startingProgram?.blocks ?? const []);

  final RepeatLevel level;
  @override
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  @override
  final Duration celebrateDuration;

  /// Verilirse program bu bloklarla açılır ve okları seçip düzeltme kuralları geçerli olur.
  final StartingProgram? startingProgram;

  /// 3 yıldız için en fazla blok sayısı: önerilen çözümün blok sayısı.
  @override
  late final int targetBlocks = RepeatEngine.countBlocks(_solution);
  @override
  final BoardRun boardRun;
  @override
  final RobotVoice voice;

  /// Önerilen çözüm; düzeltme kurallarında ipucu bozuk kodun ondan ayrıldığı yeri gösterir.
  final List<ProgramBlock> _solution;
  final ProgramEditor _editor;
  ProgramStep? _activeStep;

  /// Son çalıştırmanın hareketleri; robot yürürken etkin hareketi göstermek için tutulur.
  List<ProgramStep> _trace = const [];
  ProgramPlace? _wrongPlace;

  @override
  List<ProgramBlock> get program => _editor.program;
  @override
  int get blockCount => _editor.blockCount;
  @override
  int get maxBlocks => level.maxBlocks;
  @override
  bool get isFull => blockCount >= maxBlocks;

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

  /// Hazır programı düzeltme kuralları geçerli mi (bkz. [StartingProgram]).
  @override
  bool get fixesProgram => startingProgram != null;

  @override
  bool get allowsRepeat => startingProgram?.allowsRepeat ?? true;

  @override
  bool get isInserting => _editor.isInserting;

  @override
  bool get canInsert => fixesProgram && !isRunning && selected != null && !isFull;

  /// Yön tuşu seçili oku değiştirir mi.
  bool get _replacesSelection => fixesProgram && !isInserting && _editor.selectedMove != null;

  /// Ok değiştirmek blok sayısını artırmadığı için sınır doluyken de yapılabilir.
  @override
  bool get canAddMove => !isRunning && (!isFull || _replacesSelection);

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
    if (!isRunning && program[index] is RepeatBlock) {
      _changeProgram(() => _editor.changeTimes(index, offset));
      notifyListeners();
    }
  }

  /// Tekrar bloğunun etiketine dokunulunca blok açılır (oklar içine eklenir) ya da kapanır.
  @override
  void toggleTarget(int index) {
    if (isRunning) {
      return;
    }
    final leaving = _editor.toggleTarget(index);
    voice.say((t) => leaving ? t.repeatOutsideRepeat : t.repeatInsideRepeat);
    notifyListeners();
  }

  @override
  void toggleSelection(ProgramPlace place) {
    if (isRunning) {
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
    if (!isRunning && selected != null) {
      _changeProgram(_editor.deleteSelected);
      notifyListeners();
    }
  }

  /// Bloğun içindeki seçili oku bloğun hemen arkasına taşır; sonraki oklar da dışarıya eklenir.
  @override
  void moveSelectedOut() {
    final place = selected;
    if (isRunning || place == null || !Places.isInner(place)) {
      return;
    }
    _changeProgram(_editor.moveSelectedOut);
    voice.say((t) => t.repeatMovedOut);
    notifyListeners();
  }

  /// Programı boşaltır; düzeltme kurallarında hazır programa geri döner ("Baştan al").
  @override
  void clear() {
    if (isRunning) {
      return;
    }
    _changeProgram(() => _editor.reset(startingProgram?.blocks ?? const []));
    voice.say(_introOf(level));
    notifyListeners();
  }

  /// İpucu ister. İpucu bir kez kullanılınca seviyeden en fazla 1 yıldız alınır.
  @override
  void showHint() {
    if (isRunning) {
      return;
    }
    useHint();
    switch (RepeatEngine.hint(board, program)) {
      case EmptyRepeatHint(:final block):
        _editor.openTarget(block);
        voice.say((t) => t.repeatEmptyRepeat);
      case FixPlaceHint(:final step):
        // Hata Avcısı'nda robotu çarptıran yer fazlaysa çarptığı yer yerine onu silmesi söylenir.
        if (_differenceFromSolution() case final difference? when difference.kind == DifferenceKind.extraBlock) {
          _showDifference(difference);
        } else {
          _markWrong(Places.of(step));
          voice.say(RepeatTexts.fixHint(step));
        }
      case NextStepHint(:final move):
        // Hata Avcısı'nda robot çarpmadan yoldan çıkıyorsa ok eklemek yerine bozuk yer gösterilir. Blok sınırı
        // doluysa yön tuşları basılamaz; o zaman sıradaki yön yerine deseni değiştirmesi önerilir.
        if (_differenceFromSolution() case final difference?) {
          _showDifference(difference);
        } else if (isFull) {
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

  /// Düzeltme kurallarında programın önerilen çözümden ayrıldığı ilk yer; diğer oyunlarda `null`.
  SolutionDifference? _differenceFromSolution() =>
      fixesProgram ? RepeatEngine.firstDifference(program, _solution) : null;

  void _showDifference(SolutionDifference difference) {
    _markWrong(difference.place);
    voice.say(RepeatTexts.differenceHint(difference));
  }

  void _markWrong(ProgramPlace place) {
    _editor.select(place);
    _wrongPlace = place;
  }

  @override
  LocalizedText get missedGoalText =>
      (t) => t.repeatMissedGoal;

  @override
  bool readyToRun() {
    if (_editor.isEmpty) {
      voice.say((t) => t.repeatEmpty);
      return false;
    }
    if (RepeatEngine.findEmptyRepeat(program) case final empty?) {
      _editor.openTarget(empty);
      voice.say((t) => t.repeatEmptyRepeat);
      return false;
    }
    return true;
  }

  @override
  void prepareRun() => _editor
    ..closeTarget()
    ..clearSelection();

  @override
  RepeatRun startRun() {
    final run = RepeatEngine.run(board, program);
    _trace = run.trace;
    return run;
  }

  @override
  void showStep(int index) => _activeStep = _trace[index];

  @override
  void clearActiveStep() => _activeStep = null;

  @override
  void showBlocked(RunResult result, ProgramStep step, int index) {
    _wrongPlace = Places.of(step);
    voice.say(RepeatTexts.blocked(result.obstacle!, step), RobotMood.sad);
  }

  /// Bloklar değişince robot başa döner, eski ipucu ve işaretler silinir.
  void _changeProgram(VoidCallback update) {
    update();
    _editor.clearSelection();
    resetBoard();
  }

  @override
  void clearRunMarks() {
    _activeStep = null;
    _wrongPlace = null;
  }

  /// Açılış mesajı: seviyenin kendi mesajı, yoksa altın olup olmamasına göre genel mesaj.
  static LocalizedText _introOf(RepeatLevel level) =>
      level.intro ?? (t) => level.board.coins.isEmpty ? t.repeatIntro : t.repeatCoinIntro;
}
