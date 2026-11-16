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
    this.usesBox = false,
  }) : boardRun = BoardRun(level.board),
       voice = RobotVoice(
         feedback: feedback,
         intro: _introOf(level, usesBox: usesBox),
       ),
       _solution = RepeatEngine.parseSolution(level.solution),
       _editor = ProgramEditor(startingProgram?.blocks ?? const []);

  final RepeatLevel level;
  @override
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  @override
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  @override
  final Duration celebrateDuration;

  /// Verilirse program bu bloklarla açılır ve okları seçip düzeltme kuralları geçerli olur.
  final StartingProgram? startingProgram;

  /// "Değişken Kutusu": kutu blokları eklenebilir ve her ok robotu kutudaki sayı kadar yürütür. Tekrarla
  /// yalnızca önerilen çözümde tekrar bloğu varsa gösterilir.
  final bool usesBox;

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
  int _box = BoxRules.start;

  /// Çalışan okun bu turda robotu daha kaç kare yürüteceği.
  int _remainingSteps = 0;

  /// Kutudaki sayı: robot yürürken o anki hareketin kutusu, aksi halde başlangıç değeri.
  int get box => _box;

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

  /// Okun değeri o anki turun kutusudur: çalışan tekrar bloğunda o tur, değilse ilk tur. Kutu bloğu kutuyu en az
  /// [BoxRules.minValue] yaptığı için her ok en az bir hareket olur; değer açılmış hareketlerden okunur.
  @override
  int? arrowSteps(ProgramPlace place) {
    if (!usesBox) {
      return null;
    }
    final active = _activeStep;
    if (active != null && Places.of(active) == place) {
      return _remainingSteps;
    }
    final round = active != null && active.block == place.block ? active.round : 0;
    final trace = isRunning ? _trace : RepeatEngine.expand(program);
    for (final step in trace) {
      if (Places.of(step) == place && step.round == round) {
        return step.box;
      }
    }
    return null;
  }

  @override
  ProgramPlace? get wrongPlace => _wrongPlace;

  /// Hazır programı düzeltme kuralları geçerli mi (bkz. [StartingProgram]).
  @override
  bool get fixesProgram => startingProgram != null;

  @override
  bool get allowsRepeat =>
      startingProgram?.allowsRepeat ?? (!usesBox || _solution.any((block) => block is RepeatBlock));

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

  bool get canAddBox => !isRunning && !isFull;

  /// Kutu bloğunu açık tekrar bloğunun içine, yoksa programın sonuna ekler.
  void addBox(InnerBlock block) {
    if (!canAddBox) {
      return;
    }
    _changeProgram(() => _editor.appendInner(block));
    if (isFull) {
      voice.say((t) => t.repeatFull);
    }
    notifyListeners();
  }

  /// "kutu = N" bloğunun sayısını bir azaltır (-1) ya da artırır (+1); sayı kutu sınırlarında kalır.
  @override
  void changeBoxValue(ProgramPlace place, int offset) {
    if (!isRunning) {
      _changeProgram(() => _editor.changeBoxValue(place, offset));
      notifyListeners();
    }
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
    voice.say(_introOf(level, usesBox: usesBox));
    notifyListeners();
  }

  /// İpucu ister. İpucu bir kez kullanılınca seviyeden en fazla 1 yıldız alınır.
  @override
  void showHint() {
    if (isRunning) {
      return;
    }
    useHint();
    final solution = fixesProgram || usesBox ? _solution : null;
    switch (RepeatEngine.hint(board, program, solution: solution, openBlock: target)) {
      case EmptyRepeatHint(:final block):
        _editor.openTarget(block);
        voice.say((t) => t.repeatEmptyRepeat);
      case FixPlaceHint(:final step):
        _markWrong(Places.of(step));
        voice.say(RepeatTexts.withBox(RepeatTexts.fixHint(step), step.box));
      case DifferenceHint(:final difference):
        _markWrong(difference.place);
        voice.say(RepeatTexts.differenceHint(difference, _editor.blockAt(difference.place)));
      case NextStepHint(:final move):
        // Blok sınırı doluysa yön tuşları basılamaz; o zaman sıradaki yön yerine deseni değiştirmesi önerilir.
        if (isFull) {
          voice.say(RepeatTexts.fullLevelHint(level.hint, usesBox: usesBox));
        } else {
          boardRun.hint = move;
          voice.say(RepeatTexts.nextMoveHint(level.hint, move.direction));
        }
      case RepeatSolvedHint():
        voice.say((t) => t.repeatSolved);
    }
    notifyListeners();
  }

  void _markWrong(ProgramPlace place) {
    _editor.select(place);
    _wrongPlace = place;
  }

  @override
  LocalizedText get missedGoalText =>
      (t) => usesBox ? t.variableBoxMissedGoal : t.repeatMissedGoal;

  @override
  bool readyToRun() {
    if (_editor.isEmpty) {
      voice.say((t) => usesBox ? t.variableBoxEmpty : t.repeatEmpty);
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
  void showStep(int index) {
    final step = _trace[index];
    _activeStep = step;
    _box = step.box;
    _remainingSteps = _countRemaining(index);
  }

  /// [index]teki hareketten sonra aynı okun aynı turda yapacağı hareket sayısı; okun hareketleri ardışıktır.
  int _countRemaining(int index) {
    final step = _trace[index];
    var next = index + 1;
    while (next < _trace.length && Places.of(_trace[next]) == Places.of(step) && _trace[next].round == step.round) {
      next++;
    }
    return next - index - 1;
  }

  @override
  void clearActiveStep() => _activeStep = null;

  @override
  void showBlocked(RunResult result, ProgramStep step, int index) {
    _wrongPlace = Places.of(step);
    voice.say(RepeatTexts.withBox(RepeatTexts.blocked(result.obstacle!, step), step.box), RobotMood.sad);
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
    _box = BoxRules.start;
  }

  /// Açılış mesajı: seviyenin kendi mesajı, yoksa oyuna ve altın olup olmamasına göre genel mesaj.
  static LocalizedText _introOf(RepeatLevel level, {required bool usesBox}) =>
      level.intro ??
      (t) => switch ((usesBox, level.board.coins.isEmpty)) {
        (true, _) => t.variableBoxIntro,
        (false, true) => t.repeatIntro,
        (false, false) => t.repeatCoinIntro,
      };
}
