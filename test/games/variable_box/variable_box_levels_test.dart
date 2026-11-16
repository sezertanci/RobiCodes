import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/variable_box/variable_box_levels.dart';

import '../../support/program_search.dart';

/// Tekrarla bloğunun ilk göründüğü seviyenin sırası (11. seviye).
const _firstRepeatLevel = 10;

/// Tekrarla bloğunun içinde kutu bloğunun ilk göründüğü seviyenin sırası (16. seviye).
const _firstBoxInRepeatLevel = 15;

bool _hasRepeat(List<ProgramBlock> solution) => solution.any((block) => block is RepeatBlock);

bool _hasBoxInRepeat(List<ProgramBlock> solution) =>
    solution.any((block) => block is RepeatBlock && block.body.any((item) => item is! MoveBlock));

void main() {
  test('variableBoxBaseLevels_Length_IsTwenty', () {
    expect(variableBoxBaseLevels, hasLength(20));
  });

  for (final (index, level) in variableBoxBaseLevels.indexed) {
    final number = index + 1;
    final solution = RepeatEngine.parseSolution(level.solution);

    test('solution_Level${number}_SucceedsWithinBlockLimit', () {
      // Act
      final run = RepeatEngine.run(level.board, solution);

      // Assert
      expect(run.result.outcome, RunOutcome.success);
      expect(RepeatEngine.countBlocks(solution), lessThanOrEqualTo(level.maxBlocks));
    });

    test('solution_Level${number}_UsesBoxBlock', () {
      expect(RepeatEngine.expand(solution).any((step) => step.box != BoxRules.start), isTrue);
    });

    test('arrowsOnly_Level${number}_ExceedBlockLimit', () {
      expect(PathFinderEngine.optimalLength(level.board), greaterThan(level.maxBlocks));
    });
  }

  for (final (index, level) in variableBoxBaseLevels.indexed.skip(_firstRepeatLevel)) {
    test('repeatWithoutBox_Level${index + 1}_ExceedBlockLimit', () {
      expect(fewestArrowAndRepeatBlocks(level.board, level.maxBlocks), isNull);
    });
  }

  test('solutions_RepeatOnlyInLastTwoGroups_BoxInsideRepeatOnlyInLastGroup', () {
    final solutions = [for (final level in variableBoxBaseLevels) RepeatEngine.parseSolution(level.solution)];

    expect(solutions.take(_firstRepeatLevel).map(_hasRepeat), everyElement(isFalse));
    expect(solutions.skip(_firstRepeatLevel).map(_hasRepeat), everyElement(isTrue));
    expect(solutions.take(_firstBoxInRepeatLevel).map(_hasBoxInRepeat), everyElement(isFalse));
    expect(solutions.skip(_firstBoxInRepeatLevel).map(_hasBoxInRepeat), everyElement(isTrue));
  });
}
