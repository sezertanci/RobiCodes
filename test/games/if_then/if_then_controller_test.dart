import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/widgets/robot_sprite.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/games/if_then/engine/if_then_engine.dart';
import 'package:robi_codes/games/if_then/engine/if_then_level.dart';
import 'package:robi_codes/games/if_then/if_then_controller.dart';
import 'package:robi_codes/games/if_then/if_then_texts.dart';

import '../../support/fakes.dart';

const _intro = 'Başla.';

/// Tek koşulu ve "Değilse" kutusu hazır gelen kolay seviye; yalnızca bir hareket kutusu açık.
const _easy = IfThenLevel(
  lane: '.#.',
  rules: [RuleSlot(condition: LaneObject.rock)],
  otherwise: LaneAction.forward,
  intro: _intro,
);

/// Bütün kutuları açık iki kurallı seviye.
const _open = IfThenLevel(lane: '.#~', rules: [RuleSlot(), RuleSlot()], intro: _intro);

const _rockAction = (rule: 0, part: SlotPart.action);
const _rockCondition = (rule: 0, part: SlotPart.condition);
const _elseAction = (rule: IfThenEngine.elseRule, part: SlotPart.action);

IfThenController _controller(
  List<int> stars, {
  IfThenLevel level = _easy,
  GameFeedback feedback = const SilentGameFeedback(),
}) => IfThenController(
  level: level,
  onCompleted: stars.add,
  feedback: feedback,
  stepDuration: Duration.zero,
  celebrateDuration: Duration.zero,
);

void main() {
  test('constructor_EasyLevel_SaysIntroAndLocksGivenSlots', () {
    final controller = _controller([]);

    expect(controller.message, _intro);
    expect(controller.isLocked(_rockCondition), isTrue);
    expect(controller.isLocked(_elseAction), isTrue);
    expect(controller.isLocked(_rockAction), isFalse);
    expect(controller.needsConditions, isFalse);
    expect(controller.robotCell, IfThenController.startCell);
  });

  test('tapBlock_NoTarget_FillsFirstEmptySlotOfSameType', () {
    final controller = _controller([], level: _open);

    controller.tapBlock(LaneAction.jump);
    controller.tapBlock(LaneObject.water);

    expect(controller.valueOf(_rockAction), LaneAction.jump);
    expect(controller.valueOf(_rockCondition), LaneObject.water);
  });

  test('tapBlock_TargetSelected_FillsTargetAndClearsIt', () {
    final controller = _controller([], level: _open);

    controller.tapSlot(_elseAction);
    controller.tapBlock(LaneAction.forward);

    expect(controller.valueOf(_elseAction), LaneAction.forward);
    expect(controller.valueOf(_rockAction), isNull);
    expect(controller.target, isNull);
  });

  test('tapBlock_NoEmptySlot_SaysNoSlot', () {
    final controller = _controller([]);

    controller.tapBlock(LaneAction.jump);
    controller.tapBlock(LaneAction.bridge);

    expect(controller.valueOf(_rockAction), LaneAction.jump);
    expect(controller.message, IfThenTexts.noSlot);
  });

  test('dropBlock_LockedOrWrongTypeSlot_SaysWhyAndKeepsSlot', () {
    final controller = _controller([], level: _open);

    controller.dropBlock(LaneAction.jump, _rockCondition);
    expect(controller.message, IfThenTexts.wrongType);
    expect(controller.valueOf(_rockCondition), isNull);

    final easy = _controller([]);
    easy.dropBlock(LaneAction.jump, _elseAction);
    expect(easy.message, IfThenTexts.lockedSlot);
    expect(easy.valueOf(_elseAction), LaneAction.forward);
  });

  test('dropBlock_FilledSlot_ReplacesBlock', () {
    final controller = _controller([]);

    controller.dropBlock(LaneAction.forward, _rockAction);
    controller.dropBlock(LaneAction.jump, _rockAction);

    expect(controller.valueOf(_rockAction), LaneAction.jump);
  });

  test('tapSlot_FilledSlot_EmptiesIt_LockedSlotSaysLocked', () {
    final controller = _controller([]);
    controller.tapBlock(LaneAction.jump);

    controller.tapSlot(_rockAction);
    controller.tapSlot(_rockCondition);

    expect(controller.valueOf(_rockAction), isNull);
    expect(controller.message, IfThenTexts.lockedSlot);
  });

  test('tapSlot_EmptySlotTwice_SelectsThenClearsTarget', () {
    final controller = _controller([]);

    controller.tapSlot(_rockAction);
    expect(controller.target, _rockAction);
    controller.tapSlot(_rockAction);
    expect(controller.target, isNull);
  });

  test('run_IncompleteProgram_SaysIncompleteAndDoesNotCountRun', () async {
    final stars = <int>[];
    final controller = _controller(stars);

    await controller.run();
    controller.tapBlock(LaneAction.jump);
    await controller.run();

    expect(stars, [3]);
  });

  test('run_CorrectFirstTry_WalksToFlagAndGivesThreeStars', () async {
    final stars = <int>[];
    final feedback = RecordingGameFeedback();
    final controller = _controller(stars, feedback: feedback);
    controller.tapBlock(LaneAction.jump);

    await controller.run();

    expect(controller.isDone, isTrue);
    expect(controller.robotCell, controller.lane.length);
    expect(controller.reaction, RobotReaction.celebrate);
    expect(controller.mood, RobotMood.happy);
    expect(feedback.audibleMoods, [RobotMood.happy]);
    expect(controller.message, IfThenTexts.success);
    expect(stars, [3]);
  });

  test('run_JumpOverRock_LandsAfterRockWithHop', () async {
    final controller = _controller([]);
    controller.tapBlock(LaneAction.jump);
    final moves = <(int, RobotReaction)>[];
    controller.addListener(() => moves.add((controller.robotCell, controller.reaction)));

    await controller.run();

    expect(moves.map((move) => move.$1), isNot(contains(1)));
    expect(moves, contains((2, RobotReaction.hop)));
  });

  test('run_WrongAction_StopsBeforeWrongCellAndMarksRule', () async {
    final stars = <int>[];
    final feedback = RecordingGameFeedback();
    final controller = _controller(stars, feedback: feedback);
    controller.tapBlock(LaneAction.forward);

    await controller.run();

    final step = (index: 1, object: LaneObject.rock, action: LaneAction.forward, rule: 0);
    expect(controller.robotCell, 0);
    expect(controller.wrongCell, 1);
    expect(controller.wrongRule, 0);
    expect(controller.wrongCount, 1);
    expect(controller.reaction, RobotReaction.bump);
    expect(controller.mood, RobotMood.sad);
    expect(feedback.audibleMoods, [RobotMood.sad]);
    expect(controller.message, IfThenTexts.wrong(step));
    expect(controller.isEditable, isTrue);
    expect(stars, isEmpty);
  });

  test('run_FixedAfterWrongTry_GivesTwoStars', () async {
    final stars = <int>[];
    final controller = _controller(stars);
    controller.tapBlock(LaneAction.forward);
    await controller.run();

    controller.dropBlock(LaneAction.jump, _rockAction);
    expect(controller.wrongCell, isNull);
    expect(controller.robotCell, IfThenController.startCell);
    expect(controller.message, _intro);
    await controller.run();

    expect(stars, [2]);
  });

  test('showHint_WrongProgram_MarksCellRuleAndAction_GivesOneStar', () async {
    final stars = <int>[];
    final controller = _controller(stars);
    controller.tapBlock(LaneAction.forward);

    controller.showHint();

    expect(controller.hint, (index: 1, object: LaneObject.rock, action: LaneAction.jump, rule: 0));
    expect(controller.message, IfThenTexts.hintText(LaneObject.rock));
    controller.dropBlock(LaneAction.jump, _rockAction);
    expect(controller.hint, isNull);
    await controller.run();
    expect(stars, [1]);
  });

  test('showHint_CorrectProgram_SaysSolved', () {
    final controller = _controller([]);
    controller.tapBlock(LaneAction.jump);

    controller.showHint();

    expect(controller.hint, isNull);
    expect(controller.message, IfThenTexts.solved);
  });

  test('clear_FilledSlots_EmptiesOnlyOpenSlots', () {
    final controller = _controller([]);
    controller.tapBlock(LaneAction.jump);

    controller.clear();

    expect(controller.valueOf(_rockAction), isNull);
    expect(controller.valueOf(_rockCondition), LaneObject.rock);
    expect(controller.valueOf(_elseAction), LaneAction.forward);
    expect(controller.message, _intro);
  });

  test('run_DisposedWhileWalking_DoesNotComplete', () async {
    final stars = <int>[];
    final controller = IfThenController(
      level: _easy,
      onCompleted: stars.add,
      stepDuration: const Duration(milliseconds: 10),
      celebrateDuration: Duration.zero,
    );
    controller.tapBlock(LaneAction.jump);

    final running = controller.run();
    controller.dispose();
    await running;

    expect(stars, isEmpty);
  });
}
