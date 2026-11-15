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
import '../repeat/engine/repeat_engine.dart';
import '../repeat/engine/repeat_program.dart';
import '../repeat/program_editor.dart';
import '../repeat/program_models.dart';
import '../repeat/repeat_texts.dart';
import 'my_command_level.dart';
import 'my_command_texts.dart';

/// Yön tuşlarının eklediği şerit: üstteki komut ya da alttaki ana program.
enum CommandLane { command, main }

/// Ana programın bir hareketi komuttan geliyorsa komuttaki adımı; [firstCall] komutun ilk kullanımı mı.
typedef CommandStep = ({ProgramStep step, bool firstCall});

/// "Kendi Komutunu Oluştur" seviyesinin oynanış durumu: komut ve ana program şeritleri, etkin şerit,
/// ipucu ve robotun yolculuğu. Blok sınırı iki şeridin toplamına uygulanır. Ekrandan bağımsızdır.
final class MyCommandController extends ChangeNotifier
    with LevelLifecycle, BoardRunScene
    implements ProgramControlsModel {
  MyCommandController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.stepDuration = defaultStepDuration,
    this.celebrateDuration = defaultCelebrateDuration,
  }) : boardRun = BoardRun(level.board),
       voice = RobotVoice(feedback: feedback, intro: _introOf(level));

  static const defaultStepDuration = PathFinderController.defaultStepDuration;
  static const reducedStepDuration = PathFinderController.reducedStepDuration;
  static const defaultCelebrateDuration = PathFinderController.defaultCelebrateDuration;

  /// Tekrarla bloğu ile içindeki bir ok en az iki blok yer kaplar.
  static const repeatWithMove = 2;

  final MyCommandLevel level;
  final ValueChanged<int> onCompleted;
  final GameFeedback feedback;
  @override
  final Duration stepDuration;
  final Duration celebrateDuration;
  @override
  final BoardRun boardRun;
  @override
  final RobotVoice voice;

  late final ProgramStripModel commandStrip = _LaneStrip(this, CommandLane.command);
  late final ProgramStripModel mainStrip = _LaneStrip(this, CommandLane.main);

  final Map<CommandLane, ProgramEditor> _editors = {for (final lane in CommandLane.values) lane: ProgramEditor()};
  final Map<CommandLane, ProgramStep> _activeSteps = {};
  final Map<CommandLane, ProgramPlace> _wrongPlaces = {};
  CommandLane _lane = CommandLane.command;
  bool _hintUsed = false;
  bool _running = false;

  ProgramEditor get _command => _editors[CommandLane.command]!;
  ProgramEditor get _main => _editors[CommandLane.main]!;
  ProgramEditor get _active => _editors[_lane]!;

  CommandLane get lane => _lane;
  List<ProgramBlock> get command => _command.program;
  List<ProgramBlock> get main => _main.program;
  int get blockCount => _command.blockCount + _main.blockCount;
  int get maxBlocks => level.maxBlocks;
  bool get isFull => blockCount >= maxBlocks;
  bool get hintUsed => _hintUsed;
  LocalizedText get message => voice.message;
  RobotMood get mood => voice.mood;

  @override
  bool get isRunning => _running;
  @override
  bool get fixesProgram => false;
  @override
  bool get allowsRepeat => level.allowsRepeat;
  @override
  bool get isInsideRepeat => _active.target != null;
  @override
  bool get canAddMove => !_running && !isFull;
  @override
  bool get canUseRepeatButton =>
      allowsRepeat && !_running && (isInsideRepeat || blockCount + repeatWithMove <= maxBlocks);
  bool get canAddCommand => !_running && !isFull;

  /// Yön tuşlarını [lane] şeridine yönlendirir; diğer şeritteki açık blok ve seçim kapanır.
  void activate(CommandLane lane) {
    if (_running || lane == _lane) {
      return;
    }
    _setLane(lane);
    voice.say((t) => lane == CommandLane.command ? t.myCommandEditCommand : t.myCommandEditMain);
    notifyListeners();
  }

  @override
  void addMove(Direction direction) {
    if (!canAddMove) {
      return;
    }
    _changeProgram(() => _active.appendMove(direction));
    if (isFull) {
      voice.say((t) => t.repeatFull);
    }
    notifyListeners();
  }

  /// Komut düğmesi: ana programın sonuna komut bloğu ekler; sonraki oklar da ana programa eklenir.
  void addCommand() {
    if (!canAddCommand) {
      return;
    }
    _setLane(CommandLane.main);
    _changeProgram(() => _main.appendBlock(const CallBlock()));
    voice.say((t) => isFull ? t.repeatFull : t.myCommandCallAdded);
    notifyListeners();
  }

  /// Tekrarla düğmesi etkin şeritte çalışır: blok açıksa bloktan çıkar, değilse yeni blok ekleyip açar.
  @override
  void pressRepeatButton() {
    if (!canUseRepeatButton) {
      return;
    }
    if (isInsideRepeat) {
      _active.closeTarget();
      voice.say((t) => t.repeatOutsideRepeat);
    } else {
      _changeProgram(() => _active.appendBlock(const RepeatBlock(RepeatBlock.defaultTimes, [])));
      voice.say((t) => isFull ? t.repeatFull : t.repeatInsideRepeat);
    }
    notifyListeners();
  }

  /// İki şeridi de boşaltır; yön tuşları yeniden komuta ekler.
  @override
  void clear() {
    if (_running) {
      return;
    }
    _changeProgram(() {
      for (final editor in _editors.values) {
        editor.reset(const []);
      }
    });
    _lane = CommandLane.command;
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
    if (RepeatEngine.findEmptyRepeat(command) case final empty?) {
      _openEmpty(CommandLane.command, empty);
    } else {
      _showEngineHint();
    }
    notifyListeners();
  }

  void _showEngineHint() {
    switch (RepeatEngine.hint(board, main, command: command)) {
      case EmptyRepeatHint(:final block):
        _openEmpty(CommandLane.main, block);
      case FixPlaceHint(:final step, :final index):
        _showFix(step, _commandSteps()[index]);
      case NextStepHint(:final move):
        _showNextMove(move);
      case RepeatSolvedHint():
        voice.say((t) => t.repeatSolved);
    }
  }

  /// Komut hazır ama ana programda kullanılmıyorsa önce onu kullanması söylenir. Blok sınırı doluysa
  /// yön tuşları basılamaz; o zaman sıradaki yön yerine tekrar eden hareketleri komuta koyması önerilir.
  void _showNextMove(NextMoveHint move) {
    if (!_command.isEmpty && !_hasCall) {
      voice.say((t) => t.myCommandUseHint);
    } else if (isFull) {
      voice.say(MyCommandTexts.fullLevelHint(level.hint));
    } else {
      boardRun.hint = move;
      voice.say(RepeatTexts.nextMoveHint(level.hint, move.direction));
    }
  }

  /// Hata komutun ilk kullanımındaysa sorun komuttadır; sonraki bir kullanımdaysa ana programdadır.
  void _showFix(ProgramStep step, CommandStep? inCommand) {
    if (inCommand != null && inCommand.firstCall) {
      _markWrong(CommandLane.command, Places.of(inCommand.step));
      voice.say(MyCommandTexts.fixHintInCommand(inCommand.step));
    } else {
      _markWrong(CommandLane.main, Places.of(step));
      voice.say(RepeatTexts.fixHint(step));
    }
  }

  void _markWrong(CommandLane lane, ProgramPlace place) {
    _setLane(lane);
    _editors[lane]!.select(place);
    _wrongPlaces[lane] = place;
  }

  /// Ana programı çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  @override
  Future<void> run() async {
    if (_running) {
      return;
    }
    if (!_readyToRun()) {
      notifyListeners();
      return;
    }
    _running = true;
    for (final editor in _editors.values) {
      editor
        ..closeTarget()
        ..clearSelection();
    }
    _resetBoard();
    voice.say((t) => t.gameRobotRunning);
    notifyListeners();
    final run = RepeatEngine.run(board, main, command: command);
    final commandSteps = _commandSteps();
    final played = await boardRun.play(
      run.result,
      directions: [for (final step in run.trace) step.direction],
      stepDuration: stepDuration,
      onStep: (index) => _showStep(run.trace[index], commandSteps[index]),
      notify: notifyListeners,
      isStopped: () => isDisposed,
    );
    if (played) {
      await _finish(run, commandSteps);
    }
  }

  /// Çalıştırmadan önce eksikleri söyler: boş ana program, boş komut ya da içi boş tekrar bloğu.
  bool _readyToRun() {
    if (_main.isEmpty) {
      _setLane(CommandLane.main);
      voice.say((t) => t.myCommandEmptyMain);
      return false;
    }
    if (_command.isEmpty && _hasCall) {
      _setLane(CommandLane.command);
      voice.say((t) => t.myCommandEmptyCommand);
      return false;
    }
    for (final lane in CommandLane.values) {
      if (RepeatEngine.findEmptyRepeat(_editors[lane]!.program) case final empty?) {
        _openEmpty(lane, empty);
        return false;
      }
    }
    return true;
  }

  void _showStep(ProgramStep step, CommandStep? inCommand) {
    _activeSteps[CommandLane.main] = step;
    if (inCommand == null) {
      _activeSteps.remove(CommandLane.command);
    } else {
      _activeSteps[CommandLane.command] = inCommand.step;
    }
  }

  Future<void> _finish(RepeatRun run, List<CommandStep?> commandSteps) async {
    _activeSteps.clear();
    final result = run.result;
    switch (result.outcome) {
      case RunOutcome.success:
        voice.say((t) => t.gameRobotReachedFlag, RobotMood.happy);
        voice.react(RobotReaction.celebrate);
        notifyListeners();
        final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: blockCount <= level.targetBlocks);
        await completeAfter(celebrateDuration, onCompleted, stars);
        return;
      case RunOutcome.blocked:
        _showBlocked(result, run.trace[result.failedIndex!], commandSteps[result.failedIndex!]);
      case RunOutcome.missedGoal || RunOutcome.missingCoins:
        voice.react(RobotReaction.shake);
        final missingCoins = result.outcome == RunOutcome.missingCoins;
        voice.say((t) => missingCoins ? t.gameMissingCoins : t.myCommandMissedGoal, RobotMood.sad);
    }
    _running = false;
    notifyListeners();
  }

  void _showBlocked(RunResult result, ProgramStep step, CommandStep? inCommand) {
    _wrongPlaces[CommandLane.main] = Places.of(step);
    boardRun.bumpDirection = step.direction;
    voice.react(RobotReaction.bump);
    if (inCommand != null && inCommand.firstCall) {
      _wrongPlaces[CommandLane.command] = Places.of(inCommand.step);
      voice.say(MyCommandTexts.blockedInCommand(result.obstacle!, inCommand.step), RobotMood.sad);
    } else {
      voice.say(RepeatTexts.blocked(result.obstacle!, step), RobotMood.sad);
    }
  }

  /// Ana programın her hareketi için komuttaki karşılığı; hareket komuttan gelmiyorsa `null`.
  List<CommandStep?> _commandSteps() {
    final inner = RepeatEngine.expand(command);
    final steps = <CommandStep?>[];
    var firstCall = true;
    for (final block in main) {
      if (block is CallBlock) {
        steps.addAll([for (final step in inner) (step: step, firstCall: firstCall)]);
        firstCall = false;
      } else {
        steps.addAll(List.filled(RepeatEngine.expand([block]).length, null));
      }
    }
    return steps;
  }

  bool get _hasCall => main.any((block) => block is CallBlock);

  void _openEmpty(CommandLane lane, int block) {
    _setLane(lane);
    _editors[lane]!.openTarget(block);
    voice.say((t) => t.repeatEmptyRepeat);
  }

  /// Etkin şeridi değiştirir; diğer şeritteki açık blok ve seçim kapanır.
  void _setLane(CommandLane lane) {
    _lane = lane;
    for (final editor in _editors.values) {
      editor.clearSelection();
    }
    _editors[_otherLane(lane)]!.closeTarget();
  }

  static CommandLane _otherLane(CommandLane lane) =>
      lane == CommandLane.command ? CommandLane.main : CommandLane.command;

  void _changeTimes(CommandLane lane, int index, int offset) {
    final editor = _editors[lane]!;
    if (!_running && editor.program[index] is RepeatBlock) {
      _changeProgram(() => editor.changeTimes(index, offset));
      notifyListeners();
    }
  }

  void _toggleTarget(CommandLane lane, int index) {
    if (_running) {
      return;
    }
    _setLane(lane);
    final leaving = _editors[lane]!.toggleTarget(index);
    voice.say((t) => leaving ? t.repeatOutsideRepeat : t.repeatInsideRepeat);
    notifyListeners();
  }

  void _toggleSelection(CommandLane lane, ProgramPlace place) {
    if (_running) {
      return;
    }
    _editors[_otherLane(lane)]!.clearSelection();
    _editors[lane]!.toggleSelection(place);
    notifyListeners();
  }

  void _clearSelection(CommandLane lane) {
    if (_editors[lane]!.clearSelection()) {
      notifyListeners();
    }
  }

  void _deleteSelected(CommandLane lane) {
    final editor = _editors[lane]!;
    if (!_running && editor.selected != null) {
      _changeProgram(editor.deleteSelected);
      notifyListeners();
    }
  }

  void _moveSelectedOut(CommandLane lane) {
    final editor = _editors[lane]!;
    final place = editor.selected;
    if (_running || place == null || !Places.isInner(place)) {
      return;
    }
    _changeProgram(editor.moveSelectedOut);
    voice.say((t) => t.repeatMovedOut);
    notifyListeners();
  }

  /// Bloklar değişince robot başa döner, eski ipucu ve işaretler silinir.
  void _changeProgram(VoidCallback update) {
    update();
    for (final editor in _editors.values) {
      editor.clearSelection();
    }
    _resetBoard();
  }

  void _resetBoard() {
    boardRun.reset();
    _activeSteps.clear();
    _wrongPlaces.clear();
    voice.calm();
  }

  static LocalizedText _introOf(MyCommandLevel level) => level.intro ?? (t) => t.myCommandIntro;
}

/// Bir şeridin [ProgramStripModel] görünümü. Blok sayısı ve sınır iki şeridin toplamıdır.
final class _LaneStrip implements ProgramStripModel {
  _LaneStrip(this._controller, this._lane);

  final MyCommandController _controller;
  final CommandLane _lane;

  ProgramEditor get _editor => _controller._editors[_lane]!;

  @override
  List<ProgramBlock> get program => _editor.program;
  @override
  int get blockCount => _controller.blockCount;
  @override
  int get maxBlocks => _controller.maxBlocks;
  @override
  bool get isFull => _controller.isFull;
  @override
  bool get isRunning => _controller.isRunning;
  @override
  int? get target => _editor.target;
  @override
  ProgramPlace? get selected => _editor.selected;
  @override
  ProgramStep? get activeStep => _controller._activeSteps[_lane];
  @override
  ProgramPlace? get wrongPlace => _controller._wrongPlaces[_lane];
  @override
  bool get fixesProgram => false;
  @override
  bool get isInserting => false;
  @override
  bool get canInsert => false;

  @override
  void toggleSelection(ProgramPlace place) => _controller._toggleSelection(_lane, place);
  @override
  void clearSelection() => _controller._clearSelection(_lane);
  @override
  void deleteSelected() => _controller._deleteSelected(_lane);
  @override
  void moveSelectedOut() => _controller._moveSelectedOut(_lane);
  @override
  void toggleInserting() {}
  @override
  void changeTimes(int index, int offset) => _controller._changeTimes(_lane, index, offset);
  @override
  void toggleTarget(int index) => _controller._toggleTarget(_lane, index);
}
