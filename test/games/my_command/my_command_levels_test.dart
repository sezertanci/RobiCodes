import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/my_command/my_command_levels.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';

void main() {
  test('myCommandBaseLevels_Length_IsTwenty', () {
    expect(myCommandBaseLevels, hasLength(20));
  });

  for (final (index, level) in myCommandBaseLevels.indexed) {
    final number = index + 1;

    test('solution_Level${number}_SucceedsWithExactlyBlockLimit', () {
      // Act
      final run = RepeatEngine.run(level.board, level.mainBlocks, command: level.commandBlocks);

      // Assert
      expect(run.result.outcome, RunOutcome.success);
      expect(level.targetBlocks, level.maxBlocks);
    });

    test('arrowsOnly_Level${number}_ExceedBlockLimit', () {
      expect(PathFinderEngine.optimalLength(level.board), greaterThan(level.maxBlocks));
    });
  }

  test('allowsRepeat_OnlyLastTwoGroups_IsTrue', () {
    expect(myCommandBaseLevels.take(10).map((level) => level.allowsRepeat), everyElement(isFalse));
    expect(myCommandBaseLevels.skip(10).map((level) => level.allowsRepeat), everyElement(isTrue));
  });
}
