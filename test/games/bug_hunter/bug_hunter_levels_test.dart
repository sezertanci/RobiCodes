import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/games/bug_hunter/bug_hunter_levels.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/repeat_controller.dart';

import '../../support/test_l10n.dart';

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

  test('showHint_BuggedCode_MarksBugUnlessOnlyLastArrowIsMissing', () {
    // Arrange: ipucu bozuk yeri göstermeli; ok ekletmesi yalnızca bozuk kodun sonunda ok eksikse doğrudur.
    final levelsSuggestingMove = <int>[];

    // Act
    for (final (index, level) in bugHunterBaseLevels.indexed) {
      final controller = RepeatController(
        level: level.puzzle,
        startingProgram: level.startingProgram,
        onCompleted: (_) {},
        feedback: const SilentGameFeedback(),
      )..showHint();
      if (controller.wrongPlace == null) {
        levelsSuggestingMove.add(index + 1);
      }
    }

    // Assert: 3. seviyede ("RRD", çözüm "RRDD") yalnızca son ok eksik.
    expect(levelsSuggestingMove, [3]);
  });

  test('showHint_ExtraArrowLevels_SaysDeleteExtraArrow', () {
    for (final number in [9, 15]) {
      // Arrange: bu seviyelerde bozuk kod, fazla bir ok silinince çözüme uyuyor.
      final level = bugHunterBaseLevels[number - 1];
      final controller = RepeatController(
        level: level.puzzle,
        startingProgram: level.startingProgram,
        onCompleted: (_) {},
        feedback: const SilentGameFeedback(),
      );

      // Act
      controller.showHint();

      // Assert
      final place = controller.wrongPlace!;
      final name = Places.isInner(place)
          ? texts.repeatInnerArrowName(place.block + 1, place.inner + 1)
          : texts.repeatBlockName(place.block + 1);
      expect(controller.message(texts), texts.repeatFixHint(texts.repeatExtraBlock(name)), reason: 'Seviye $number');
    }
  });

  test('allowsRepeat_EasyAndMediumLevels_IsFalse', () {
    expect(bugHunterBaseLevels.take(10).map((level) => level.startingProgram.allowsRepeat), everyElement(isFalse));
    expect(bugHunterBaseLevels.skip(10).map((level) => level.startingProgram.allowsRepeat), everyElement(isTrue));
  });
}
