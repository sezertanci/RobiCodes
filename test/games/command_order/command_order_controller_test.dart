import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/games/command_order/command_order_controller.dart';
import 'package:robi_codes/games/command_order/command_order_texts.dart';
import 'package:robi_codes/games/command_order/engine/command_order_engine.dart';
import 'package:robi_codes/games/command_order/engine/command_order_level.dart';

import '../../support/fakes.dart';
import '../../support/test_l10n.dart';

final _level = CommandOrderLevel(
  title: fixedText('Görev'),
  icon: 'task.svg',
  hint: fixedText('Önce başla.'),
  steps: [
    CommandStep(fixedText('Bir'), '1.svg'),
    CommandStep(fixedText('İki'), '2.svg'),
    CommandStep(fixedText('Üç'), '3.svg'),
  ],
);

final _levelWithExtra = CommandOrderLevel(
  title: fixedText('Görev'),
  icon: 'task.svg',
  hint: fixedText('Önce başla.'),
  steps: [CommandStep(fixedText('Bir'), '1.svg'), CommandStep(fixedText('İki'), '2.svg')],
  extras: [CommandStep(fixedText('Fazla'), 'x.svg')],
);

/// Kartlar ters sırayla verilir; böylece havuzdaki sıra testte bellidir.
CommandOrderController _controller(
  List<int> stars, {
  CommandOrderLevel? level,
  GameFeedback feedback = const SilentGameFeedback(),
}) => CommandOrderController(
  level: level ?? _level,
  cards: CommandOrderEngine.buildCards(level ?? _level).reversed.toList(),
  onCompleted: stars.add,
  feedback: feedback,
  celebrateDuration: Duration.zero,
);

void _fillInOrder(CommandOrderController controller) {
  for (var id = 0; id < controller.slots.length; id++) {
    controller.tapPoolCard(id);
  }
}

void main() {
  test('constructor_LevelWithExtras_SaysExtrasIntro', () {
    expect(_controller([]).message(texts), texts.commandOrderIntro);
    expect(_controller([], level: _levelWithExtra).message(texts), texts.commandOrderExtrasIntro);
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

    expect(controller.message(texts), texts.commandOrderFull);
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

    expect(controller.message(texts), texts.commandOrderNotFull);
    expect(controller.mark, isNull);
  });

  test('check_WrongOrder_MarksFirstWrongSlotAndIsSad', () async {
    final feedback = RecordingGameFeedback();
    final controller = _controller([], feedback: feedback);
    for (final id in [0, 2, 1]) {
      controller.tapPoolCard(id);
    }

    await controller.check();

    expect(controller.mark, (slot: 1, cardId: null, kind: SlotMarkKind.wrong));
    expect(controller.mood, RobotMood.sad);
    expect(feedback.audibleMoods, [RobotMood.sad]);
    expect(controller.wrongCount, 1);
    expect(
      controller.message(texts),
      CommandOrderTexts.wrong(const OrderWrong(1, WrongReason.tooEarly), controller.cardOf(2))(texts),
    );
  });

  test('change_AfterWrongMark_ClearsMarkAndSaysIntro', () async {
    final controller = _controller([]);
    for (final id in [0, 2, 1]) {
      controller.tapPoolCard(id);
    }
    await controller.check();

    controller.returnToPool(1);

    expect(controller.mark, isNull);
    expect(controller.message(texts), texts.commandOrderIntro);
  });

  test('check_CorrectFirstTry_CompletesWithThreeStars', () async {
    final stars = <int>[];
    final feedback = RecordingGameFeedback();
    final controller = _controller(stars, feedback: feedback);
    _fillInOrder(controller);

    await controller.check();

    expect(controller.isDone, isTrue);
    expect(controller.mood, RobotMood.happy);
    expect(feedback.audibleMoods, [RobotMood.happy]);
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
    expect(controller.message(texts), CommandOrderTexts.hint(_level.hint, controller.cardOf(0), 0)(texts));
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

    expect(controller.message(texts), texts.commandOrderSolved);
    expect(controller.mark, isNull);
  });

  test('clear_FilledSlots_EmptiesAllSlots', () {
    final controller = _controller([]);
    _fillInOrder(controller);

    controller.clear();

    expect(controller.slots, [null, null, null]);
    expect(controller.message(texts), texts.commandOrderIntro);
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
