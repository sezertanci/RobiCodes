import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/games/command_order/command_order_controller.dart';
import 'package:robi_codes/games/command_order/command_order_texts.dart';
import 'package:robi_codes/games/command_order/engine/command_order_engine.dart';
import 'package:robi_codes/games/command_order/engine/command_order_level.dart';

const _level = CommandOrderLevel(
  title: 'Görev',
  icon: 'task.svg',
  hint: 'Önce başla.',
  steps: [CommandStep('Bir', '1.svg'), CommandStep('İki', '2.svg'), CommandStep('Üç', '3.svg')],
);

const _levelWithExtra = CommandOrderLevel(
  title: 'Görev',
  icon: 'task.svg',
  hint: 'Önce başla.',
  steps: [CommandStep('Bir', '1.svg'), CommandStep('İki', '2.svg')],
  extras: [CommandStep('Fazla', 'x.svg')],
);

/// Kartlar ters sırayla verilir; böylece havuzdaki sıra testte bellidir.
CommandOrderController _controller(List<int> stars, {CommandOrderLevel level = _level}) => CommandOrderController(
  level: level,
  cards: CommandOrderEngine.buildCards(level).reversed.toList(),
  onCompleted: stars.add,
  celebrateDuration: Duration.zero,
);

void _fillInOrder(CommandOrderController controller) {
  for (var id = 0; id < controller.slots.length; id++) {
    controller.tapPoolCard(id);
  }
}

void main() {
  test('constructor_LevelWithExtras_SaysExtrasIntro', () {
    expect(_controller([]).message, CommandOrderTexts.intro);
    expect(_controller([], level: _levelWithExtra).message, CommandOrderTexts.extrasIntro);
  });

  test('tapPoolCard_NoTarget_FillsFirstEmptySlot', () {
    final controller = _controller([]);

    controller.tapPoolCard(2);
    controller.tapPoolCard(0);

    expect(controller.slots, [2, 0, null]);
    expect(controller.poolCards.map((card) => card.id), [1]);
  });

  test('tapPoolCard_TargetSelected_FillsTargetAndClearsIt', () {
    final controller = _controller([]);

    controller.toggleTarget(2);
    controller.tapPoolCard(1);

    expect(controller.slots, [null, null, 1]);
    expect(controller.target, isNull);
  });

  test('tapPoolCard_AllSlotsFull_SaysFull', () {
    final controller = _controller([], level: _levelWithExtra);
    _fillInOrder(controller);

    controller.tapPoolCard(2);

    expect(controller.message, CommandOrderTexts.full);
    expect(controller.slots, [0, 1]);
  });

  test('toggleTarget_SameSlotTwice_RemovesTarget', () {
    final controller = _controller([]);

    controller.toggleTarget(1);
    controller.toggleTarget(1);

    expect(controller.target, isNull);
  });

  test('returnToPool_FilledSlot_EmptiesSlot', () {
    final controller = _controller([]);
    controller.tapPoolCard(1);

    controller.returnToPool(0);

    expect(controller.slots, [null, null, null]);
    expect(controller.poolCards, hasLength(3));
  });

  test('dropOnSlot_FromAnotherSlot_SwapsCards', () {
    final controller = _controller([]);
    controller.tapPoolCard(0);
    controller.tapPoolCard(1);

    controller.dropOnSlot(0, 0, 1);

    expect(controller.slots, [1, 0, null]);
  });

  test('dropOnSlot_FromPoolOnFilledSlot_ReturnsOldCardToPool', () {
    final controller = _controller([]);
    controller.tapPoolCard(0);

    controller.dropOnSlot(2, null, 0);

    expect(controller.slots, [2, null, null]);
    expect(controller.poolCards.map((card) => card.id), containsAll([0, 1]));
  });

  test('check_NotFull_SaysNotFull', () async {
    final controller = _controller([]);
    controller.tapPoolCard(0);

    await controller.check();

    expect(controller.message, CommandOrderTexts.notFull);
    expect(controller.mark, isNull);
  });

  test('check_WrongOrder_MarksFirstWrongSlotAndIsSad', () async {
    final controller = _controller([]);
    for (final id in [0, 2, 1]) {
      controller.tapPoolCard(id);
    }

    await controller.check();

    expect(controller.mark, (slot: 1, cardId: null, kind: SlotMarkKind.wrong));
    expect(controller.mood, RobotMood.sad);
    expect(controller.wrongCount, 1);
    expect(controller.message, CommandOrderTexts.wrong(const OrderWrong(1, WrongReason.tooEarly), 'Üç'));
  });

  test('change_AfterWrongMark_ClearsMarkAndSaysIntro', () async {
    final controller = _controller([]);
    for (final id in [0, 2, 1]) {
      controller.tapPoolCard(id);
    }
    await controller.check();

    controller.returnToPool(1);

    expect(controller.mark, isNull);
    expect(controller.message, CommandOrderTexts.intro);
  });

  test('check_CorrectFirstTry_CompletesWithThreeStars', () async {
    final stars = <int>[];
    final controller = _controller(stars);
    _fillInOrder(controller);

    await controller.check();

    expect(controller.isDone, isTrue);
    expect(controller.mood, RobotMood.happy);
    expect(stars, [3]);
  });

  test('check_CorrectAfterWrongCheck_CompletesWithTwoStars', () async {
    final stars = <int>[];
    final controller = _controller(stars);
    for (final id in [1, 0, 2]) {
      controller.tapPoolCard(id);
    }
    await controller.check();

    controller.dropOnSlot(0, 1, 0);
    await controller.check();

    expect(stars, [2]);
  });

  test('showHint_EmptyBoard_MarksFirstSlotAndTargetsIt', () {
    final controller = _controller([]);

    controller.showHint();

    expect(controller.mark, (slot: 0, cardId: 0, kind: SlotMarkKind.hint));
    expect(controller.target, 0);
    expect(controller.hintUsed, isTrue);
    expect(controller.message, CommandOrderTexts.hintText(_level.hint, 'Bir', 0));
  });

  test('showHint_ThenTapHintedCard_PlacesItAndCompletesWithOneStar', () async {
    final stars = <int>[];
    final controller = _controller(stars);
    controller.tapPoolCard(1);

    controller.showHint();
    controller.tapPoolCard(0);
    controller.tapPoolCard(1);
    controller.tapPoolCard(2);
    await controller.check();

    expect(stars, [1]);
  });

  test('showHint_OrderAlreadyCorrect_SaysSolved', () {
    final controller = _controller([]);
    _fillInOrder(controller);

    controller.showHint();

    expect(controller.message, CommandOrderTexts.solved);
    expect(controller.mark, isNull);
  });

  test('clear_FilledSlots_EmptiesAllSlots', () {
    final controller = _controller([]);
    _fillInOrder(controller);

    controller.clear();

    expect(controller.slots, [null, null, null]);
    expect(controller.message, CommandOrderTexts.intro);
  });

  test('actions_AfterDone_AreIgnored', () async {
    final controller = _controller([]);
    _fillInOrder(controller);
    await controller.check();

    controller.returnToPool(0);
    controller.clear();
    controller.showHint();

    expect(controller.slots, [0, 1, 2]);
    expect(controller.hintUsed, isFalse);
  });
}
