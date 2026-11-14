import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/board_run.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';

const _right = Direction.right;

/// Robotun sağında bir altın, onun sağında bayrak.
final _board = PathFinderBoard.parse(['S*G']);

void main() {
  group('BoardRun', () {
    Future<bool> play(BoardRun run, {bool Function()? isStopped, List<int>? steps}) {
      const commands = [_right, _right];
      return run.play(
        PathFinderEngine.run(_board, commands),
        directions: commands,
        stepDuration: Duration.zero,
        onStep: (index) => steps?.add(index),
        notify: () {},
        isStopped: isStopped ?? () => false,
      );
    }

    test('play_FullRun_MovesRobotLeavesTrailAndCollectsCoin', () async {
      // Arrange
      final run = BoardRun(_board);
      final steps = <int>[];

      // Act
      final played = await play(run, steps: steps);

      // Assert
      expect(played, isTrue);
      expect(steps, [0, 1]);
      expect(run.robot, _board.goal);
      expect(run.trail, {_board.start: _right, _board.coins.first: _right});
      expect(run.collectedCoins, {0});
    });

    test('play_StoppedWhileWaiting_ReturnsFalseAfterFirstStep', () async {
      // Arrange
      final run = BoardRun(_board);
      final steps = <int>[];

      // Act
      final played = await play(run, steps: steps, isStopped: () => true);

      // Assert
      expect(played, isFalse);
      expect(steps, [0]);
      expect(run.collectedCoins, isEmpty);
    });

    test('reset_AfterRun_ReturnsRobotAndKeepsBumpDirection', () async {
      // Arrange
      final run = BoardRun(_board)
        ..hint = PathFinderEngine.hint(_board, const [], 2) as NextMoveHint
        ..bumpDirection = _right;
      await play(run);

      // Act
      run.reset();

      // Assert
      expect(run.robot, _board.start);
      expect(run.trail, isEmpty);
      expect(run.collectedCoins, isEmpty);
      expect(run.hint, isNull);
      expect(run.bumpDirection, _right);
    });
  });
}
