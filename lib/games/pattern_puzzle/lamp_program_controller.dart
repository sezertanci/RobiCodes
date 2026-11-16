import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../l10n/l10n.dart';
import '../path_finder/board_run.dart';
import '../path_finder/board_scene.dart';
import '../path_finder/engine/lamp.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/engine/path_finder_engine.dart';
import '../path_finder/path_finder_controller.dart';
import '../repeat/engine/repeat_engine.dart';
import '../repeat/engine/repeat_program.dart';
import '../repeat/program_editing.dart';
import '../repeat/program_editor.dart';
import '../repeat/program_models.dart';
import '../repeat/program_runner.dart';
import '../repeat/repeat_texts.dart';
import 'engine/pattern_level.dart';

/// "Desen Bulmacası" Uzman grubunun oynanışı: lambalar "renk yak" blokları ve Tekrarla ile yakılır. Robot alttaki
/// yolda sağa yürür; her blokta üstündeki lambayı yakıp bir kare ilerler. Yanlış renkte yanan lamba robotu
/// durdurur. Ekrandan bağımsızdır; widget olmadan test edilebilir.
final class LampProgramController extends ChangeNotifier
    with LevelLifecycle, BoardRunScene, ProgramRunner, ProgramEditing
    implements ProgramStripModel, ProgramControlsModel {
  LampProgramController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.stepDuration = PathFinderController.defaultStepDuration,
    this.celebrateDuration = PathFinderController.defaultCelebrateDuration,
  }) : boardRun = BoardRun(level.board),
       voice = RobotVoice(feedback: feedback, intro: level.intro);

  final PatternProgramLevel level;
  @override
  final ValueChanged<int> onCompleted;
  @override
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  @override
  final Duration celebrateDuration;
  @override
  final BoardRun boardRun;
  @override
  final RobotVoice voice;
  @override
  final ProgramEditor editor = ProgramEditor();

  ProgramStep? _activeStep;
  ProgramPlace? _wrongPlace;

  /// Son çalıştırmanın hareketleri ve her hareketin yaktığı renk.
  List<ProgramStep> _trace = const [];
  List<LampColor> _colors = const [];

  /// Şimdiye kadar yakılan lambaların renkleri, soldan sağa.
  final List<LampColor> _lit = [];

  /// Yanlış renkte yanan lambanın sırası.
  int? _wrongLamp;

  @override
  int get maxBlocks => level.maxBlocks;
  @override
  int get targetBlocks => level.targetBlocks;
  @override
  ProgramStep? get activeStep => _activeStep;
  @override
  ProgramPlace? get wrongPlace => _wrongPlace;
  @override
  bool get allowsRepeat => true;

  /// Lambalar yalnızca "renk yak" bloklarıyla yakılır; yön tuşu, kutu ve hazır program yoktur.
  @override
  bool get fixesProgram => false;
  @override
  bool get canAddMove => false;
  @override
  void addMove(Direction direction) {}
  @override
  int? arrowSteps(ProgramPlace place) => null;
  @override
  bool get isInserting => false;
  @override
  bool get canInsert => false;
  @override
  void toggleInserting() {}
  @override
  void changeBoxValue(ProgramPlace place, int offset) {}

  /// Yakılan lambalar kendi renginde, sönük lambalar yakılması gereken renkte (soluk) görünür.
  @override
  BoardLamps get lamps => {
    for (final (index, color) in level.lamps.indexed)
      PatternProgramLevel.lampAt(index): (
        color: index < _lit.length ? _lit[index] : color,
        lit: index < _lit.length,
        wrong: index == _wrongLamp,
      ),
  };

  /// "renk yak" bloğunu açık tekrar bloğunun içine, yoksa programın sonuna ekler.
  void addLight(LampColor color) => addInner(LightBlock(color));

  @override
  void toggleSelection(ProgramPlace place) {
    if (!isRunning) {
      editor.toggleSelection(place);
      notifyListeners();
    }
  }

  @override
  void clear() {
    if (isRunning) {
      return;
    }
    changeProgram(() => editor.reset(const []));
    voice.say(level.intro);
    notifyListeners();
  }

  /// İpucu ister: lambayı yanlış renkte yakacak ilk bloğu işaretler; yoksa eksik ya da fazla blokları söyler.
  @override
  void showHint() {
    if (isRunning) {
      return;
    }
    useHint();
    final trace = RepeatEngine.expand(program);
    final colors = _colorsOf(trace);
    final wrong = _firstWrong(colors);
    if (wrong != null) {
      final place = Places.of(trace[wrong]);
      editor.select(place);
      _wrongPlace = place;
      final want = level.lamps[wrong];
      voice.say((t) => t.patternProgramHintWrong(RepeatTexts.lampColor(t, want)));
    } else if (colors.length > level.lamps.length) {
      voice.say((t) => t.patternTooManyLights);
    } else if (colors.length < level.lamps.length) {
      voice.say(level.hint);
    } else {
      voice.say((t) => t.repeatSolved);
    }
    notifyListeners();
  }

  @override
  LocalizedText get missedGoalText =>
      (t) => t.patternLampsDark;

  @override
  LocalizedText get insideRepeatText =>
      (t) => t.patternInsideRepeat;

  @override
  LocalizedText get outsideRepeatText =>
      (t) => t.patternOutsideRepeat;

  @override
  LocalizedText get movedOutText =>
      (t) => t.patternMovedOut;

  @override
  bool readyToRun() {
    if (editor.isEmpty) {
      voice.say((t) => t.patternProgramEmpty);
      return false;
    }
    if (RepeatEngine.findEmptyRepeat(program) case final empty?) {
      editor.openTarget(empty);
      voice.say((t) => t.patternEmptyRepeat);
      return false;
    }
    return true;
  }

  @override
  void prepareRun() => editor
    ..closeTarget()
    ..clearSelection();

  /// Robot ilk yanlış renkli lambada durur; lamba sayısını aşan blok, robotu şeridin sonunda kenara çarptırır.
  @override
  RepeatRun startRun() {
    final run = RepeatEngine.run(board, program);
    _trace = run.trace;
    _colors = _colorsOf(run.trace);
    final wrong = _firstWrong(_colors);
    if (wrong == null) {
      return run;
    }
    final steps = run.result.steps.take(wrong).toList();
    final result = RunResult(
      outcome: RunOutcome.blocked,
      steps: steps,
      position: steps.isEmpty ? board.start : steps.last.position,
      collected: const {},
      failedIndex: wrong,
    );
    return (result: result, trace: run.trace);
  }

  @override
  void showStep(int index) {
    _activeStep = _trace[index];
    if (index < level.lamps.length) {
      _lit.add(_colors[index]);
    }
  }

  @override
  void clearActiveStep() => _activeStep = null;

  @override
  void showBlocked(RunResult result, ProgramStep step, int index) {
    _wrongPlace = Places.of(step);
    if (index >= level.lamps.length) {
      voice.say((t) => t.patternTooManyLights, RobotMood.sad);
      return;
    }
    _lit.add(_colors[index]);
    _wrongLamp = index;
    final color = _colors[index];
    voice.say((t) => t.patternWrongColor(RepeatTexts.lampColor(t, color)), RobotMood.sad);
  }

  @override
  void clearRunMarks() {
    _activeStep = null;
    _wrongPlace = null;
    _wrongLamp = null;
    _lit.clear();
  }

  /// Her hareketin yaktığı renk; hareketler yalnızca "renk yak" bloklarından gelir.
  List<LampColor> _colorsOf(List<ProgramStep> trace) => [
    for (final step in trace) (editor.blockAt(Places.of(step)) as LightBlock).color,
  ];

  /// Lambayı yanlış renkte yakan ilk hareketin sırası; lamba sayısını aşan hareketler sayılmaz.
  int? _firstWrong(List<LampColor> colors) {
    for (final (index, color) in colors.indexed) {
      if (index < level.lamps.length && color != level.lamps[index]) {
        return index;
      }
    }
    return null;
  }
}
