import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/if_then/engine/if_then_engine.dart';
import 'package:robi_codes/games/if_then/engine/if_then_level.dart';
import 'package:robi_codes/games/if_then/engine/if_then_levels.dart';

const _rockAndWater = IfThenProgram(
  rules: [
    (condition: LaneObject.rock, action: LaneAction.jump),
    (condition: LaneObject.water, action: LaneAction.bridge),
  ],
  otherwise: LaneAction.forward,
);

/// Açık kutulara palet bloklarının bütün birleşimlerini dener; doğru bir program varsa onu döndürür.
IfThenProgram? _solve(IfThenLevel level) {
  final palette = IfThenEngine.paletteFor(level);
  final lane = IfThenEngine.parseLane(level.lane);
  final conditionChoices = [
    for (final rule in level.rules) rule.condition == null ? palette.conditions : [rule.condition!],
  ];
  final actionChoices = [
    for (final rule in level.rules) rule.action == null ? palette.actions : [rule.action!],
  ];
  final otherwiseChoices = level.otherwise == null ? palette.actions : [level.otherwise!];

  Iterable<List<Rule>> rules(int index) sync* {
    if (index == level.rules.length) {
      yield [];
      return;
    }
    for (final condition in conditionChoices[index]) {
      for (final action in actionChoices[index]) {
        for (final rest in rules(index + 1)) {
          yield [(condition: condition, action: action), ...rest];
        }
      }
    }
  }

  for (final candidate in rules(0)) {
    for (final otherwise in otherwiseChoices) {
      final program = IfThenProgram(rules: candidate, otherwise: otherwise);
      if (IfThenEngine.run(lane, program).succeeded) {
        return program;
      }
    }
  }
  return null;
}

void main() {
  test('parseLane_AllSymbols_ReturnsObjects', () {
    expect(IfThenEngine.parseLane('.#~D*'), [
      LaneObject.empty,
      LaneObject.rock,
      LaneObject.water,
      LaneObject.door,
      LaneObject.star,
    ]);
  });

  test('parseLane_UnknownSymbol_Throws', () {
    expect(() => IfThenEngine.parseLane('.x'), throwsArgumentError);
  });

  test('paletteFor_LevelWithExtra_ReturnsLaneObjectsExtrasAndTheirActions', () {
    final palette = IfThenEngine.paletteFor(ifThenBaseLevels[4]);

    expect(palette.conditions, [LaneObject.rock, LaneObject.water]);
    expect(palette.actions, [LaneAction.forward, LaneAction.jump, LaneAction.bridge]);
  });

  test('decide_FirstMatchingRuleWins_OtherwiseUsesElse', () {
    expect(IfThenEngine.decide(_rockAndWater, LaneObject.water), (action: LaneAction.bridge, rule: 1));
    expect(IfThenEngine.decide(_rockAndWater, LaneObject.empty), (
      action: LaneAction.forward,
      rule: IfThenEngine.elseRule,
    ));
  });

  test('run_CorrectProgram_Succeeds', () {
    final result = IfThenEngine.run(IfThenEngine.parseLane('.#~.'), _rockAndWater);

    expect(result.succeeded, isTrue);
    expect(result.steps.map((step) => step.action), [
      LaneAction.forward,
      LaneAction.jump,
      LaneAction.bridge,
      LaneAction.forward,
    ]);
  });

  test('run_WrongAction_StopsAtFirstWrongCell', () {
    final result = IfThenEngine.run(IfThenEngine.parseLane('.#D#'), _rockAndWater);

    expect(result.failedIndex, 2);
    expect(result.steps, hasLength(3));
    expect(result.steps.last, (
      index: 2,
      object: LaneObject.door,
      action: LaneAction.forward,
      rule: IfThenEngine.elseRule,
    ));
  });

  test('findHint_WrongProgram_ReturnsCellRuleAndNeededAction', () {
    final hint = IfThenEngine.findHint(IfThenEngine.parseLane('.~D'), _rockAndWater);

    expect(hint, (index: 2, object: LaneObject.door, action: LaneAction.open, rule: IfThenEngine.elseRule));
    expect(IfThenEngine.findHint(IfThenEngine.parseLane('.#~'), _rockAndWater), isNull);
  });

  test('ifThenBaseLevels_EveryLevel_IsSolvableWithPaletteBlocks', () {
    expect(ifThenBaseLevels, hasLength(20));
    for (final (index, level) in ifThenBaseLevels.indexed) {
      expect(_solve(level), isNotNull, reason: '${index + 1}. seviye');
    }
  });
}
