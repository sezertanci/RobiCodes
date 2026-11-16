import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/repeat/engine/repeat_level.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/repeat_controller.dart';
import 'package:robi_codes/l10n/l10n.dart';

import '../../support/test_l10n.dart';

/// Seviyenin ipucu cümlesi.
String _levelHint(AppLocalizations _) => 'Kutuya 3 koy.';

/// Bayrak üç kare sağda; çözüm kutuya 3 koyup tek sağ ok, sınır 2 blok.
const _line = RepeatLevel(map: ['S..G'], solution: '=3 R', maxBlocks: 2, hint: _levelHint);

/// Basamaklı yol; çözümde Tekrarla var.
const _stairs = RepeatLevel(map: ['S.#', '#..', '##G'], solution: '2(RD)', maxBlocks: 3, hint: _levelHint);

/// Basamaklar her turda bir kare uzar; çözümde tekrar içinde +1 var.
const _growing = RepeatLevel(map: ['S.##', '#...', '###.', '###G'], solution: '2(RD+)', maxBlocks: 4, hint: _levelHint);

const _right = Direction.right;
const _down = Direction.down;
const _first = (block: 0, inner: Places.topLevel);

RepeatController _controller(List<int> stars, {RepeatLevel level = _line}) => RepeatController(
  level: level,
  onCompleted: stars.add,
  stepDuration: Duration.zero,
  celebrateDuration: Duration.zero,
  usesBox: true,
);

void main() {
  test('constructor_UsesBox_SaysBoxIntroAndStartsBoxAtOne', () {
    final controller = _controller([]);

    expect(controller.message(texts), texts.variableBoxIntro);
    expect(controller.box, BoxRules.start);
  });

  test('allowsRepeat_SolutionWithoutRepeat_IsFalse', () {
    expect(_controller([]).allowsRepeat, isFalse);
    expect(_controller([], level: _stairs).allowsRepeat, isTrue);
  });

  test('addBox_NoOpenBlock_AppendsBoxBlock', () {
    final controller = _controller([]);

    controller.addBox(const SetBoxBlock(SetBoxBlock.defaultValue));

    expect(controller.program, [const SetBoxBlock(SetBoxBlock.defaultValue)]);
  });

  test('addBox_OpenRepeat_PutsBoxBlockInside', () {
    final controller = _controller([], level: _stairs);
    controller.pressRepeatButton();

    controller.addBox(AddBoxBlock.increment);

    expect(controller.program, [
      const RepeatBlock(RepeatBlock.defaultTimes, [AddBoxBlock.increment]),
    ]);
  });

  test('addBox_LimitReached_SaysFullAndIgnoresMore', () {
    final controller = _controller([]);
    controller.addBox(AddBoxBlock.increment);
    controller.addBox(AddBoxBlock.increment);

    controller.addBox(AddBoxBlock.decrement);

    expect(controller.canAddBox, isFalse);
    expect(controller.message(texts), texts.repeatFull);
    expect(controller.blockCount, 2);
  });

  test('changeBoxValue_OutOfRange_StaysBetweenMinAndMax', () {
    final controller = _controller([]);
    controller.addBox(const SetBoxBlock(BoxRules.minValue));

    controller.changeBoxValue(_first, -1);
    final atMin = controller.program.single;
    for (var i = BoxRules.minValue; i <= BoxRules.maxValue; i++) {
      controller.changeBoxValue(_first, 1);
    }

    expect(atMin, const SetBoxBlock(BoxRules.minValue));
    expect(controller.program.single, const SetBoxBlock(BoxRules.maxValue));
  });

  test('changeBoxValue_MoveBlock_LeavesProgramUnchanged', () {
    final controller = _controller([]);
    controller.addMove(_right);

    controller.changeBoxValue(_first, 1);

    expect(controller.program, [const MoveBlock(_right)]);
  });

  test('run_BoxSolution_ReachesGoalAndGivesThreeStars', () async {
    final stars = <int>[];
    final controller = _controller(stars);
    controller.addBox(const SetBoxBlock(SetBoxBlock.defaultValue));
    controller.changeBoxValue(_first, 1);
    controller.addMove(_right);

    await controller.run();

    expect(controller.robot, controller.board.goal);
    expect(stars, [3]);
  });

  test('run_ArrowsWithoutBox_MissesGoalAndSaysBoxMessage', () async {
    final stars = <int>[];
    final controller = _controller(stars, level: _stairs);
    controller.addMove(_right);
    controller.addMove(_down);

    await controller.run();

    expect(stars, isEmpty);
    expect(controller.message(texts), texts.variableBoxMissedGoal);
  });

  test('arrowSteps_WithoutBox_IsNull', () {
    final controller = RepeatController(level: _line, onCompleted: (_) {});
    controller.addMove(_right);

    expect(controller.arrowSteps(_first), isNull);
  });

  test('arrowSteps_Editing_ShowsBoxValueBeforeArrow', () {
    final controller = _controller([]);
    controller.addBox(const SetBoxBlock(SetBoxBlock.defaultValue));
    controller.changeBoxValue(_first, 1);
    controller.addMove(_right);

    expect(controller.arrowSteps((block: 1, inner: Places.topLevel)), 3);
  });

  test('arrowSteps_Running_CountsDownRemainingSquares', () async {
    final controller = _controller([]);
    controller.addBox(const SetBoxBlock(SetBoxBlock.defaultValue));
    controller.changeBoxValue(_first, 1);
    controller.addMove(_right);
    const arrow = (block: 1, inner: Places.topLevel);
    final seen = <int?>[];
    controller.addListener(() {
      if (controller.activeStep != null) {
        seen.add(controller.arrowSteps(arrow));
      }
    });

    await controller.run();

    expect(seen, [2, 1, 0]);
    expect(controller.arrowSteps(arrow), 3);
  });

  test('arrowSteps_RepeatWithIncrement_ShowsCurrentRoundValue', () async {
    final controller = _controller([], level: _growing);
    controller.pressRepeatButton();
    controller.addMove(_right);
    controller.addMove(_down);
    controller.addBox(AddBoxBlock.increment);
    const down = (block: 0, inner: 1);
    final secondRound = <int?>{};
    controller.addListener(() {
      if (controller.activeStep case (inner: 0, round: 1, direction: _, block: _, box: _)) {
        secondRound.add(controller.arrowSteps(down));
      }
    });

    expect(controller.arrowSteps(down), 1);
    await controller.run();

    expect(controller.robot, controller.board.goal);
    expect(secondRound, {2});
    expect(controller.arrowSteps(down), 1);
  });
}
