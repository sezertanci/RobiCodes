import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/command_order/engine/command_order_engine.dart';
import 'package:robi_codes/games/command_order/engine/command_order_level.dart';
import 'package:robi_codes/games/command_order/engine/command_order_levels.dart';

List<int> _ids(List<OrderCard> cards) => [for (final card in cards) card.id];

void main() {
  test('commandOrderBaseLevels_AllLevels_HaveValidData', () {
    expect(commandOrderBaseLevels, hasLength(20));
    for (final level in commandOrderBaseLevels) {
      expect(level.steps, isNotEmpty);
      final stages = level.stages;
      if (stages != null) {
        expect(stages.fold(0, (sum, stage) => sum + stage.size), level.steps.length, reason: level.title);
      }
      final groups = level.slotGroups;
      expect([for (final group in groups) ...group.slots], [for (var i = 0; i < level.steps.length; i++) i]);
    }
  });

  test('buildCards_LevelWithExtras_NumbersExtrasAfterSteps', () {
    final level = commandOrderBaseLevels.firstWhere((level) => level.extras.isNotEmpty);

    final cards = CommandOrderEngine.buildCards(level);

    expect(cards, hasLength(level.steps.length + level.extras.length));
    expect(cards.where((card) => card.extra).map((card) => card.id), [
      for (var i = 0; i < level.extras.length; i++) level.steps.length + i,
    ]);
    expect(cards.first.text, level.steps.first.text);
  });

  test('shuffleCards_ManySeeds_NeverInOrderAndKeepsAllCards', () {
    for (final level in commandOrderBaseLevels) {
      final cards = CommandOrderEngine.buildCards(level);
      for (var seed = 0; seed < 50; seed++) {
        final shuffled = _ids(CommandOrderEngine.shuffleCards(cards, seed));

        expect(shuffled, isNot(_ids(cards)));
        expect([...shuffled]..sort(), _ids(cards));
      }
    }
  });

  test('shuffleCards_SameSeed_GivesSameOrder', () {
    final cards = CommandOrderEngine.buildCards(commandOrderBaseLevels[5]);

    expect(_ids(CommandOrderEngine.shuffleCards(cards, 42)), _ids(CommandOrderEngine.shuffleCards(cards, 42)));
  });

  test('shuffleCards_AvoidOrderGiven_ReturnsDifferentOrder', () {
    final cards = CommandOrderEngine.buildCards(commandOrderBaseLevels[5]);
    final first = _ids(CommandOrderEngine.shuffleCards(cards, 7));

    final second = _ids(CommandOrderEngine.shuffleCards(cards, 7, first));

    expect(second, isNot(first));
  });

  test('shuffleCards_TwoCards_ReturnsReversedOrder', () {
    const level = CommandOrderLevel(
      title: 'İki',
      icon: 'a.svg',
      hint: '',
      steps: [CommandStep('A', 'a.svg'), CommandStep('B', 'b.svg')],
    );

    final cards = CommandOrderEngine.shuffleCards(CommandOrderEngine.buildCards(level), 1);

    expect(_ids(cards), [1, 0]);
  });

  test('checkOrder_CorrectOrder_ReturnsCorrect', () {
    expect(CommandOrderEngine.checkOrder([0, 1, 2]), isA<OrderCorrect>());
  });

  test('checkOrder_LaterStepEarly_ReturnsTooEarlyAtFirstWrongSlot', () {
    final result = CommandOrderEngine.checkOrder([0, 2, 1]);

    expect(result, isA<OrderWrong>().having((wrong) => wrong.slot, 'slot', 1));
    expect((result as OrderWrong).reason, WrongReason.tooEarly);
  });

  test('checkOrder_ExtraCardInSlot_ReturnsExtra', () {
    final result = CommandOrderEngine.checkOrder([0, 3, 2]) as OrderWrong;

    expect(result.slot, 1);
    expect(result.reason, WrongReason.extra);
  });

  test('nextHint_EmptyOrWrongSlot_ReturnsFirstMismatch', () {
    expect(CommandOrderEngine.nextHint([0, null, 2]), (slot: 1, cardId: 1));
    expect(CommandOrderEngine.nextHint([1, 0, 2]), (slot: 0, cardId: 0));
    expect(CommandOrderEngine.nextHint([0, 1, 2]), isNull);
  });
}
