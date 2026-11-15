import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/bug_hunter/bug_hunter_levels.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';

bool _usesRepeat(String code) => RepeatEngine.parseSolution(code).any((block) => block is RepeatBlock);

void main() {
  test('bugHunterBaseLevels_Length_IsTwenty', () {
    expect(bugHunterBaseLevels, hasLength(20));
  });

  for (final (index, level) in bugHunterBaseLevels.indexed) {
    final number = index + 1;

    test('solution_Level${number}_SucceedsInsideBlockLimitWithShortestPath', () {
      // Arrange
      final board = level.puzzle.board;
      final solution = RepeatEngine.parseSolution(level.solution);

      // Act
      final run = RepeatEngine.run(board, solution);

      // Assert
      expect(run.result.outcome, RunOutcome.success);
      expect(RepeatEngine.countBlocks(solution), lessThanOrEqualTo(level.maxBlocks));
      expect(run.trace, hasLength(PathFinderEngine.optimalLength(board)));
    });

    test('bugged_Level${number}_FailsInsideBlockLimit', () {
      // Arrange
      final bugged = level.startingProgram.blocks;

      // Act
      final run = RepeatEngine.run(level.puzzle.board, bugged);

      // Assert
      expect(run.result.outcome, isNot(RunOutcome.success));
      expect(RepeatEngine.countBlocks(bugged), lessThanOrEqualTo(level.maxBlocks));
    });

    test('allowsRepeat_Level${number}_TrueOnlyWhenCodeUsesRepeat', () {
      expect(level.startingProgram.allowsRepeat, _usesRepeat(level.bugged) || _usesRepeat(level.solution));
    });
  }

  test('allowsRepeat_EasyAndMediumLevels_IsFalse', () {
    expect(bugHunterBaseLevels.take(10).map((level) => level.startingProgram.allowsRepeat), everyElement(isFalse));
    expect(bugHunterBaseLevels.skip(10).map((level) => level.startingProgram.allowsRepeat), everyElement(isTrue));
  });
}
