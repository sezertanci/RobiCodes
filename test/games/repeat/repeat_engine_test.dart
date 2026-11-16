import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_levels.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';

const _right = Direction.right;
const _down = Direction.down;
const _up = Direction.up;

/// Başlangıçtan üç kare sağda bayrak bulunan düz yol.
final _line = PathFinderBoard.parse(['S..G']);

void main() {
  test('parseSolution_RepeatAndMoves_ReturnsBlocks', () {
    expect(RepeatEngine.parseSolution('3(RD) U'), [
      const RepeatBlock(3, [_right, _down]),
      const MoveBlock(_up),
    ]);
  });

  test('countBlocks_RepeatWithBody_CountsBlockAndInnerMoves', () {
    expect(RepeatEngine.countBlocks(RepeatEngine.parseSolution('3(RD) U')), 4);
    expect(RepeatEngine.countBlocks(const []), 0);
  });

  test('expand_RepeatBlock_ListsEveryRoundWithPlace', () {
    final steps = RepeatEngine.expand(const [
      RepeatBlock(2, [_right, _down]),
      MoveBlock(_up),
    ]);

    expect(steps, [
      (direction: _right, block: 0, inner: 0, round: 0),
      (direction: _down, block: 0, inner: 1, round: 0),
      (direction: _right, block: 0, inner: 0, round: 1),
      (direction: _down, block: 0, inner: 1, round: 1),
      (direction: _up, block: 1, inner: Places.topLevel, round: 0),
    ]);
  });

  test('findEmptyRepeat_EmptyBlock_ReturnsItsIndex', () {
    expect(RepeatEngine.findEmptyRepeat(const [MoveBlock(_right), RepeatBlock(2, [])]), 1);
    expect(
      RepeatEngine.findEmptyRepeat(const [
        RepeatBlock(2, [_right]),
      ]),
      isNull,
    );
  });

  test('run_TooManyRounds_BlockedAtEdgeInLastRound', () {
    final run = RepeatEngine.run(_line, const [
      RepeatBlock(4, [_right]),
    ]);

    expect(run.result.outcome, RunOutcome.blocked);
    expect(run.result.obstacle, Obstacle.edge);
    expect(run.trace[run.result.failedIndex!], (direction: _right, block: 0, inner: 0, round: 3));
  });

  test('run_RightRounds_Succeeds', () {
    final run = RepeatEngine.run(_line, const [
      RepeatBlock(3, [_right]),
    ]);

    expect(run.result.outcome, RunOutcome.success);
    expect(run.result.steps, hasLength(3));
  });

  test('hint_EmptyRepeat_PointsToBlock', () {
    final hint = RepeatEngine.hint(_line, const [MoveBlock(_right), RepeatBlock(2, [])]);

    expect(hint, isA<EmptyRepeatHint>().having((hint) => hint.block, 'block', 1));
  });

  test('hint_WrongMove_PointsToStep', () {
    final hint = RepeatEngine.hint(_line, const [
      RepeatBlock(2, [_up]),
    ]);

    expect(
      hint,
      isA<FixPlaceHint>().having((hint) => hint.step, 'step', (direction: _up, block: 0, inner: 0, round: 0)),
    );
  });

  test('hint_ShortProgram_SuggestsNextMove', () {
    final hint = RepeatEngine.hint(_line, const [
      RepeatBlock(2, [_right]),
    ]);

    expect(hint, isA<NextStepHint>().having((hint) => hint.move.direction, 'direction', _right));
  });

  group('hint with solution', () {
    List<ProgramBlock> parse(String code) => RepeatEngine.parseSolution(code);

    /// Bayrak sağ alt köşede; çözüm "RRDD", "DDRR" de aynı uzunlukta doğru bir yol.
    final square = PathFinderBoard.parse(['S..', '...', '..G']);

    /// Bayrak çapraz merdivenin sonunda; çözüm "3(RD)".
    final stairs = PathFinderBoard.parse(['S...', '....', '....', '...G']);

    test('hint_AlternativeRouteOnTrack_SuggestsNextMove', () {
      final hint = RepeatEngine.hint(square, parse('DD'), solution: parse('RRDD'));

      expect(hint, isA<NextStepHint>().having((hint) => hint.move.direction, 'direction', _right));
    });

    test('hint_AlternativeRouteLooksLikeExtraArrow_SuggestsNextMove', () {
      // "DRR" yolu doğru; ilk ok silinince program çözümün başı olsa da fazla ok sayılmaz.
      final hint = RepeatEngine.hint(square, parse('DRR'), solution: parse('RRDD'));

      expect(hint, isA<NextStepHint>().having((hint) => hint.move.direction, 'direction', _down));
    });

    test('hint_RobotLeavesRouteWithoutBump_ReportsDifference', () {
      final hint = RepeatEngine.hint(
        PathFinderBoard.parse(['....', 'S..G', '....']),
        parse('RUR'),
        solution: parse('RRR'),
      );

      expect(
        hint,
        isA<DifferenceHint>().having((hint) => hint.difference, 'difference', (
          place: Places.top(1),
          kind: DifferenceKind.wrongBlock,
        )),
      );
    });

    test('hint_OpenRepeatIsStartOfSolutionBlock_SuggestsNextInnerArrow', () {
      final hint = RepeatEngine.hint(stairs, parse('3(R)'), solution: parse('3(RD)'), openBlock: 0);

      expect(
        hint,
        isA<NextStepHint>().having((hint) => hint.move.direction, 'direction', _down).having(
          (hint) => hint.move.target,
          'target',
          (x: 1, y: 1),
        ),
      );
    });

    test('hint_ClosedRepeatMissingInnerArrow_ReportsDifference', () {
      final hint = RepeatEngine.hint(stairs, parse('3(R)'), solution: parse('3(RD)'));

      expect(
        hint,
        isA<DifferenceHint>().having((hint) => hint.difference, 'difference', (
          place: Places.top(0),
          kind: DifferenceKind.wrongBlock,
        )),
      );
    });
  });

  group('firstDifference', () {
    List<ProgramBlock> parse(String code) => RepeatEngine.parseSolution(code);

    test('firstDifference_PrefixOfSolution_ReturnsNull', () {
      expect(RepeatEngine.firstDifference(parse('RRD'), parse('RRDD')), isNull);
    });

    test('firstDifference_WrongArrow_ReportsWrongBlock', () {
      expect(RepeatEngine.firstDifference(parse('RUR'), parse('RRR')), (
        place: Places.top(1),
        kind: DifferenceKind.wrongBlock,
      ));
    });

    test('firstDifference_WrongArrowInsteadOfNext_ReportsWrongBlock', () {
      expect(RepeatEngine.firstDifference(parse('RDL'), parse('RDDR')), (
        place: Places.top(2),
        kind: DifferenceKind.wrongBlock,
      ));
    });

    test('firstDifference_ExtraArrowAtEnd_ReportsExtraBlock', () {
      expect(RepeatEngine.firstDifference(parse('RDDRD'), parse('RDDR')), (
        place: Places.top(4),
        kind: DifferenceKind.extraBlock,
      ));
    });

    test('firstDifference_ExtraArrowInMiddle_ReportsExtraBlock', () {
      expect(RepeatEngine.firstDifference(parse('RDDDR'), parse('RDDR')), (
        place: Places.top(3),
        kind: DifferenceKind.extraBlock,
      ));
    });

    test('firstDifference_ExtraInnerArrow_ReportsExtraBlock', () {
      expect(RepeatEngine.firstDifference(parse('2(RRD)'), parse('2(RD)')), (
        place: (block: 0, inner: 1),
        kind: DifferenceKind.extraBlock,
      ));
    });

    test('firstDifference_SameArrowsOtherCount_ReportsWrongCount', () {
      expect(RepeatEngine.firstDifference(parse('2(RD)'), parse('3(RD)')), (
        place: Places.top(0),
        kind: DifferenceKind.wrongCount,
      ));
    });

    test('firstDifference_WrongInnerArrow_PointsToInnerArrow', () {
      expect(RepeatEngine.firstDifference(parse('2(RD)'), parse('2(RRD)')), (
        place: (block: 0, inner: 1),
        kind: DifferenceKind.wrongBlock,
      ));
    });

    test('firstDifference_MissingInnerArrow_PointsToRepeatBlock', () {
      expect(RepeatEngine.firstDifference(parse('2(R)'), parse('2(RD)')), (
        place: Places.top(0),
        kind: DifferenceKind.wrongBlock,
      ));
    });
  });

  test('hint_SolvedProgram_ReportsSolved', () {
    expect(
      RepeatEngine.hint(_line, const [
        RepeatBlock(3, [_right]),
      ]),
      isA<RepeatSolvedHint>(),
    );
  });

  test('repeatBaseLevels_Length_IsTwenty', () {
    expect(repeatBaseLevels, hasLength(20));
  });

  for (final (index, level) in repeatBaseLevels.indexed) {
    test('solution_Level${index + 1}_SucceedsInsideBlockLimitWithShortestPath', () {
      final board = level.board;
      final solution = RepeatEngine.parseSolution(level.solution);

      final run = RepeatEngine.run(board, solution);

      expect(run.result.outcome, RunOutcome.success);
      expect(RepeatEngine.countBlocks(solution), lessThanOrEqualTo(level.maxBlocks));
      expect(run.trace, hasLength(PathFinderEngine.optimalLength(board)));
    });
  }
}
