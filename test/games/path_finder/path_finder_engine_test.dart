import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_levels.dart';

/// Web sürümünün motor testlerindeki örnek harita: sol üstte altın, ortada taş.
const _rockMap = ['*..', 'S#G', '...'];

void main() {
  final board = PathFinderBoard.parse(_rockMap);
  const up = Direction.up;
  const down = Direction.down;
  const left = Direction.left;
  const right = Direction.right;

  group('pathFinderBaseLevels', () {
    test('length_BasePack_MatchesCatalogLevelCount', () {
      final pack = buildContentCatalog().packsOf(GameIds.pathFinder).single;

      expect(pathFinderBaseLevels.length, pack.levelCount);
      expect(pathFinderBaseLevels.length, 20);
    });

    for (final (index, level) in pathFinderBaseLevels.indexed) {
      test('solution_Level${index + 1}_ReachesGoalWithShortestPathInsideLimit', () {
        // Arrange
        final levelBoard = level.board;
        final solution = Direction.parseSolution(level.solution);

        // Act
        final result = PathFinderEngine.run(levelBoard, solution);

        // Assert
        expect(levelBoard.start, isNot(levelBoard.goal));
        expect(result.outcome, RunOutcome.success);
        expect(result.position, levelBoard.goal);
        expect(result.collected.length, levelBoard.coins.length);
        expect(PathFinderEngine.optimalLength(levelBoard), solution.length);
        expect(solution.length, lessThanOrEqualTo(level.commandLimit));
      });
    }

    test('commandLimit_ExpertLevels_KeepWebLimits', () {
      final limits = [for (final level in pathFinderBaseLevels) level.commandLimit];

      expect(limits.sublist(0, 15), everyElement(16));
      expect(limits.sublist(15), [10, 12, 12, 12, 15]);
    });
  });

  group('PathFinderBoard', () {
    test('parse_RockMap_ReadsStartGoalObstaclesAndCoins', () {
      expect(board.width, 3);
      expect(board.height, 3);
      expect(board.start, (x: 0, y: 1));
      expect(board.goal, (x: 2, y: 1));
      expect(board.obstacleAt((x: 1, y: 1)), Obstacle.rock);
      expect(board.obstacleAt((x: -1, y: 0)), Obstacle.edge);
      expect(board.coinIndexAt((x: 0, y: 0)), 0);
      expect(board.coinIndexAt((x: 1, y: 0)), isNull);
    });

    test('parse_WaterTile_IsNotWalkable', () {
      final water = PathFinderBoard.parse(['S~G']);

      expect(water.obstacleAt((x: 1, y: 0)), Obstacle.water);
      expect(water.isWalkable((x: 1, y: 0)), isFalse);
    });

    test('parse_MissingGoal_ThrowsArgumentError', () {
      expect(() => PathFinderBoard.parse(['S..']), throwsArgumentError);
    });

    test('parseSolution_Letters_ReturnsDirectionsInOrder', () {
      expect(Direction.parseSolution('URDL'), [up, right, down, left]);
    });
  });

  group('PathFinderEngine.run', () {
    test('run_HitsRock_StopsBeforeObstacle', () {
      final result = PathFinderEngine.run(board, [right]);

      expect(result.outcome, RunOutcome.blocked);
      expect(result.failedIndex, 0);
      expect(result.obstacle, Obstacle.rock);
      expect(result.position, (x: 0, y: 1));
      expect(result.steps, isEmpty);
    });

    test('run_LeavesMap_ReportsEdge', () {
      final result = PathFinderEngine.run(board, [left]);

      expect(result.outcome, RunOutcome.blocked);
      expect(result.obstacle, Obstacle.edge);
    });

    test('run_EndsAwayFromGoal_ReportsMissedGoal', () {
      final result = PathFinderEngine.run(board, [down, right]);

      expect(result.outcome, RunOutcome.missedGoal);
      expect(result.steps.length, 2);
      expect(result.position, (x: 1, y: 2));
    });

    test('run_GoalWithoutCoins_ReportsMissingCoins', () {
      final result = PathFinderEngine.run(board, [down, right, right, up]);

      expect(result.outcome, RunOutcome.missingCoins);
      expect(result.position, board.goal);
    });

    test('run_CollectsCoinThenGoal_Succeeds', () {
      final result = PathFinderEngine.run(board, [up, right, right, down]);

      expect(result.outcome, RunOutcome.success);
      expect(result.steps.first.coin, 0);
      expect(result.collected, {0});
    });

    test('run_OrderMatters_SameCommandsInOtherOrderFail', () {
      final result = PathFinderEngine.run(board, [right, right, up, down]);

      expect(result.outcome, RunOutcome.blocked);
    });
  });

  group('PathFinderEngine.hint', () {
    test('hint_EmptyProgram_SuggestsFirstMove', () {
      final hint = PathFinderEngine.hint(board, const [], 16);

      expect(hint, isA<NextMoveHint>());
      hint as NextMoveHint;
      expect(hint.direction, up);
      expect(hint.target, (x: 0, y: 0));
    });

    test('hint_BlockedCommand_PointsToWrongCommand', () {
      final hint = PathFinderEngine.hint(board, [up, left], 16);

      expect(hint, isA<FixCommandHint>().having((value) => value.index, 'index', 1));
    });

    test('hint_PathLongerThanLimit_ReportsTooManyCommands', () {
      expect(PathFinderEngine.hint(board, [down], 4), isA<TooManyCommandsHint>());
    });

    test('hint_SolvedProgram_ReportsSolved', () {
      expect(PathFinderEngine.hint(board, [up, right, right, down], 16), isA<SolvedHint>());
    });

    test('shortestPath_CoinsRequired_VisitsCoinFirst', () {
      expect(PathFinderEngine.shortestPath(board, board.start, const {}), [up, right, right, down]);
    });

    test('shortestPath_GoalUnreachable_ReturnsNull', () {
      final closed = PathFinderBoard.parse(['S#G']);

      expect(PathFinderEngine.shortestPath(closed, closed.start, const {}), isNull);
    });
  });
}
