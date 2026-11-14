import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/widgets/robot_sprite.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/repeat/engine/repeat_level.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/repeat_controller.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';

import '../../support/fakes.dart';

const _intro = 'Başla.';
const _levelHint = 'Sağa git.';

/// Bayrak üç kare sağda; önerilen çözüm 2 blok, sınır 2 blok.
const _tight = RepeatLevel(map: ['S..G'], solution: '3(R)', maxBlocks: 2, hint: _levelHint, intro: _intro);

/// Aynı yol, ama blok sınırı geniş: fazla blokla da çözülebilir.
const _roomy = RepeatLevel(map: ['S..G'], solution: '3(R)', maxBlocks: 6, hint: _levelHint, intro: _intro);

const _right = Direction.right;

RepeatController _controller(
  List<int> stars, {
  RepeatLevel level = _tight,
  GameFeedback feedback = const SilentGameFeedback(),
}) => RepeatController(
  level: level,
  onCompleted: stars.add,
  feedback: feedback,
  stepDuration: Duration.zero,
  celebrateDuration: Duration.zero,
);

/// Tekrarla bloğu ekler, içine sağ oku koyar ve tekrar sayısını [times] yapar.
void _addRepeatRight(RepeatController controller, {int times = 3}) {
  controller.pressRepeatButton();
  controller.addMove(_right);
  final index = controller.program.length - 1;
  for (var i = RepeatBlock.defaultTimes; i < times; i++) {
    controller.changeTimes(index, 1);
  }
}

void main() {
  test('constructor_LevelWithIntro_SaysIntroAndStartsAtStart', () {
    final controller = _controller([]);

    expect(controller.message, _intro);
    expect(controller.robot, controller.board.start);
    expect(controller.targetBlocks, 2);
    expect(controller.program, isEmpty);
  });

  test('addMove_NoOpenBlock_AppendsMove', () {
    final controller = _controller([], level: _roomy);

    controller.addMove(_right);

    expect(controller.program, [const MoveBlock(_right)]);
    expect(controller.blockCount, 1);
  });

  test('pressRepeatButton_AddsOpenBlock_MovesGoInside', () {
    final controller = _controller([], level: _roomy);

    controller.pressRepeatButton();
    expect(controller.target, 0);
    expect(controller.message, RepeatTexts.insideRepeat);
    controller.addMove(_right);

    expect(controller.program, [
      const RepeatBlock(2, [_right]),
    ]);
  });

  test('pressRepeatButton_OpenBlock_LeavesBlockAndNextMoveGoesOutside', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();
    controller.addMove(_right);

    controller.pressRepeatButton();
    controller.addMove(_right);

    expect(controller.target, isNull);
    expect(controller.program, [
      const RepeatBlock(2, [_right]),
      const MoveBlock(_right),
    ]);
  });

  test('addMove_LimitReached_SaysFullAndIgnoresMore', () {
    final controller = _controller([]);
    controller.pressRepeatButton();

    controller.addMove(_right);
    controller.addMove(_right);

    expect(controller.isFull, isTrue);
    expect(controller.message, RepeatTexts.full);
    expect(controller.blockCount, 2);
  });

  test('canUseRepeatButton_NoRoomForBlockAndMove_IsFalse', () {
    final controller = _controller([]);

    controller.addMove(_right);

    expect(controller.canUseRepeatButton, isFalse);
    controller.pressRepeatButton();
    expect(controller.program, [const MoveBlock(_right)]);
  });

  test('changeTimes_OutOfRange_StaysBetweenMinAndMax', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();

    controller.changeTimes(0, -1);
    expect((controller.program.single as RepeatBlock).times, RepeatBlock.minTimes);
    for (var i = 0; i < 10; i++) {
      controller.changeTimes(0, 1);
    }
    expect((controller.program.single as RepeatBlock).times, RepeatBlock.maxTimes);
  });

  test('toggleTarget_TwiceOnSameBlock_OpensThenCloses', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();
    controller.pressRepeatButton();

    controller.toggleTarget(0);
    expect(controller.target, 0);
    expect(controller.selected, Places.top(0));
    controller.toggleTarget(0);

    expect(controller.target, isNull);
    expect(controller.selected, isNull);
    expect(controller.message, RepeatTexts.outsideRepeat);
  });

  test('deleteSelected_BlockBeforeOpenBlock_KeepsSameBlockOpen', () {
    final controller = _controller([], level: _roomy);
    controller.addMove(_right);
    controller.pressRepeatButton();

    controller.toggleSelection(Places.top(0));
    controller.deleteSelected();

    expect(controller.program, [const RepeatBlock(2, [])]);
    expect(controller.target, 0);
  });

  test('deleteSelected_OpenBlock_ClosesIt', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();

    controller.toggleSelection(Places.top(0));
    controller.deleteSelected();

    expect(controller.program, isEmpty);
    expect(controller.target, isNull);
  });

  test('deleteSelected_InnerMove_RemovesOnlyThatMove', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();
    controller.addMove(_right);
    controller.addMove(Direction.down);

    controller.toggleSelection((block: 0, inner: 0));
    controller.deleteSelected();

    expect(controller.program, [
      const RepeatBlock(2, [Direction.down]),
    ]);
  });

  test('moveSelectedOut_InnerMove_PutsItAfterBlockAndClosesBlock', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();
    controller.addMove(_right);
    controller.addMove(Direction.down);

    controller.toggleSelection((block: 0, inner: 1));
    controller.moveSelectedOut();

    expect(controller.program, [
      const RepeatBlock(2, [_right]),
      const MoveBlock(Direction.down),
    ]);
    expect(controller.target, isNull);
    expect(controller.selected, isNull);
    expect(controller.message, RepeatTexts.movedOut);
  });

  test('clear_Program_EmptiesAndSaysIntro', () {
    final controller = _controller([], level: _roomy);
    _addRepeatRight(controller);

    controller.clear();

    expect(controller.program, isEmpty);
    expect(controller.target, isNull);
    expect(controller.message, _intro);
  });

  test('run_EmptyProgram_SaysEmpty', () async {
    final controller = _controller([]);

    await controller.run();

    expect(controller.message, RepeatTexts.empty);
    expect(controller.isRunning, isFalse);
  });

  test('run_EmptyRepeat_OpensItAndDoesNotRun', () async {
    final stars = <int>[];
    final controller = _controller(stars, level: _roomy);
    controller.addMove(_right);
    controller.pressRepeatButton();
    controller.pressRepeatButton();

    await controller.run();

    expect(controller.target, 1);
    expect(controller.message, RepeatTexts.emptyRepeat);
    expect(stars, isEmpty);
  });

  test('run_ShortestFirstTry_ReachesGoalAndGivesThreeStars', () async {
    final stars = <int>[];
    final feedback = RecordingGameFeedback();
    final controller = _controller(stars, feedback: feedback);
    _addRepeatRight(controller);

    await controller.run();

    expect(controller.robot, controller.board.goal);
    expect(controller.reaction, RobotReaction.celebrate);
    expect(controller.mood, RobotMood.happy);
    expect(feedback.audibleMoods, [RobotMood.happy]);
    expect(controller.message, RepeatTexts.success);
    expect(stars, [3]);
  });

  test('run_MoreBlocksThanSolution_GivesTwoStars', () async {
    final stars = <int>[];
    final controller = _controller(stars, level: _roomy);
    for (var i = 0; i < 3; i++) {
      controller.addMove(_right);
    }

    await controller.run();

    expect(stars, [2]);
  });

  test('run_ActiveStep_ShowsBlockAndRound', () async {
    final controller = _controller([]);
    _addRepeatRight(controller);
    final rounds = <int>[];
    controller.addListener(() {
      if (controller.activeStep case final step?) {
        rounds.add(step.round);
      }
    });

    await controller.run();

    expect(rounds.toSet(), {0, 1, 2});
    expect(controller.activeStep, isNull);
  });

  test('run_TooManyRounds_BumpsAndMarksBlock', () async {
    final stars = <int>[];
    final feedback = RecordingGameFeedback();
    final controller = _controller(stars, feedback: feedback);
    _addRepeatRight(controller, times: 4);

    await controller.run();

    final step = (direction: _right, block: 0, inner: 0, round: 3);
    expect(controller.reaction, RobotReaction.bump);
    expect(controller.bumpDirection, _right);
    expect(controller.wrongPlace, (block: 0, inner: 0));
    expect(controller.message, RepeatTexts.blocked(Obstacle.edge, step));
    expect(controller.mood, RobotMood.sad);
    expect(feedback.audibleMoods, [RobotMood.sad]);
    expect(controller.isRunning, isFalse);
    expect(stars, isEmpty);
  });

  test('run_TooFewRounds_SaysMissedGoal', () async {
    final controller = _controller([]);
    _addRepeatRight(controller, times: 2);

    await controller.run();

    expect(controller.reaction, RobotReaction.shake);
    expect(controller.message, RepeatTexts.missedGoal);
  });

  test('showHint_ShortProgram_HighlightsNextMoveAndGivesOneStar', () async {
    final stars = <int>[];
    final controller = _controller(stars, level: _roomy);

    controller.showHint();

    expect(controller.hint?.direction, _right);
    expect(controller.message, RepeatTexts.nextMoveHint(_levelHint, _right));
    _addRepeatRight(controller);
    expect(controller.hint, isNull);
    await controller.run();
    expect(stars, [1]);
  });

  test('showHint_WrongMove_SelectsAndMarksPlace', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();
    controller.addMove(Direction.up);

    controller.showHint();

    final step = (direction: Direction.up, block: 0, inner: 0, round: 0);
    expect(controller.selected, (block: 0, inner: 0));
    expect(controller.wrongPlace, (block: 0, inner: 0));
    expect(controller.message, RepeatTexts.fixHint(step));
  });

  test('showHint_FullAndShort_SuggestsChangingPattern', () {
    final controller = _controller([]);
    _addRepeatRight(controller, times: 2);

    controller.showHint();

    expect(controller.hint, isNull);
    expect(controller.message, RepeatTexts.fullLevelHint(_levelHint));
  });

  test('showHint_EmptyRepeat_OpensIt', () {
    final controller = _controller([], level: _roomy);
    controller.pressRepeatButton();
    controller.pressRepeatButton();

    controller.showHint();

    expect(controller.target, 0);
    expect(controller.message, RepeatTexts.emptyRepeat);
  });

  test('showHint_SolvedProgram_SaysSolved', () {
    final controller = _controller([]);
    _addRepeatRight(controller);

    controller.showHint();

    expect(controller.message, RepeatTexts.solved);
  });

  test('run_DisposedWhileWalking_DoesNotComplete', () async {
    final stars = <int>[];
    final controller = RepeatController(
      level: _tight,
      onCompleted: stars.add,
      stepDuration: const Duration(milliseconds: 10),
      celebrateDuration: Duration.zero,
    );
    _addRepeatRight(controller);

    final running = controller.run();
    controller.dispose();
    await running;

    expect(stars, isEmpty);
  });
}
