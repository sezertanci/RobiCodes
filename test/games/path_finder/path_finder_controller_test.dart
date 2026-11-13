import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/widgets/robot_sprite.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_level.dart';
import 'package:robi_codes/games/path_finder/path_finder_controller.dart';
import 'package:robi_codes/games/path_finder/path_finder_texts.dart';

const _up = Direction.up;
const _down = Direction.down;
const _right = Direction.right;

/// Bayrak robotun hemen sağında; en kısa çözüm tek komut.
const _straight = PathFinderLevel(map: ['....', 'SG..', '....'], solution: 'R', maxCommands: 3);

/// Ortada taş olan harita; robot taşa çarptırılabilir.
const _rock = PathFinderLevel(map: ['...', 'S#G', '...'], solution: 'URRD');

void main() {
  late List<int> completed;

  PathFinderController create(PathFinderLevel level) => PathFinderController(
    level: level,
    onCompleted: completed.add,
    stepDuration: Duration.zero,
    celebrateDuration: Duration.zero,
  );

  setUp(() => completed = []);

  group('Komut listesi', () {
    test('addCommand_UntilLimit_StopsAtLimitAndWarns', () {
      final controller = create(_straight);

      for (var i = 0; i < 5; i++) {
        controller.addCommand(_up);
      }

      expect(controller.commands.length, 3);
      expect(controller.isFull, isTrue);
      expect(controller.message, PathFinderTexts.full);
    });

    test('moveSelected_Right_SwapsAndKeepsSelection', () {
      final controller = create(_straight)
        ..addCommand(_up)
        ..addCommand(_right)
        ..toggleSelection(0);

      controller.moveSelected(1);

      expect(controller.commands, [_right, _up]);
      expect(controller.selectedIndex, 1);
    });

    test('moveSelected_PastEnd_DoesNothing', () {
      final controller = create(_straight)
        ..addCommand(_up)
        ..toggleSelection(0);

      controller.moveSelected(1);

      expect(controller.commands, [_up]);
    });

    test('reorder_ToIndexOrEnd_MovesCommand', () {
      final controller = create(_straight)
        ..addCommand(_up)
        ..addCommand(_right)
        ..addCommand(_down);

      controller.reorder(2, 0);
      expect(controller.commands, [_down, _up, _right]);

      controller.reorder(0, null);
      expect(controller.commands, [_up, _right, _down]);
    });

    test('deleteSelected_SelectedCommand_RemovesItAndClearsSelection', () {
      final controller = create(_straight)
        ..addCommand(_up)
        ..addCommand(_right)
        ..toggleSelection(0);

      controller.deleteSelected();

      expect(controller.commands, [_right]);
      expect(controller.selectedIndex, isNull);
    });

    test('clear_AfterCommands_EmptiesListAndRestoresIntro', () {
      final controller = create(_rock)
        ..addCommand(_up)
        ..clear();

      expect(controller.commands, isEmpty);
      expect(controller.message, PathFinderTexts.intro);
    });
  });

  group('Run and stars', () {
    test('run_EmptyProgram_AsksForCommand', () async {
      final controller = create(_straight);

      await controller.run();

      expect(controller.message, PathFinderTexts.empty);
      expect(completed, isEmpty);
    });

    test('run_ShortestSolution_CompletesWithThreeStars', () async {
      final controller = create(_straight)..addCommand(_right);

      await controller.run();

      expect(controller.robot, controller.board.goal);
      expect(controller.mood, RobotMood.happy);
      expect(completed, [3]);
    });

    test('run_LongerSolution_CompletesWithTwoStars', () async {
      final controller = create(_straight)
        ..addCommand(_up)
        ..addCommand(_right)
        ..addCommand(_down);

      await controller.run();

      expect(completed, [2]);
    });

    test('run_AfterHint_CompletesWithOneStar', () async {
      final controller = create(_straight)..showHint();
      expect(controller.hint?.direction, _right);

      controller.addCommand(_right);
      await controller.run();

      expect(controller.hintUsed, isTrue);
      expect(completed, [1]);
    });

    test('run_HitsRock_MarksWrongCommandWithoutCompleting', () async {
      final controller = create(_rock)
        ..addCommand(_up)
        ..addCommand(_down)
        ..addCommand(_right);

      await controller.run();

      expect(controller.wrongIndex, 2);
      expect(controller.reaction, RobotReaction.bump);
      expect(controller.message, PathFinderTexts.blocked(Obstacle.rock, 2));
      expect(controller.isRunning, isFalse);
      expect(completed, isEmpty);
    });

    test('run_MissesGoal_ShakesAndExplains', () async {
      final controller = create(_rock)..addCommand(_up);

      await controller.run();

      expect(controller.reaction, RobotReaction.shake);
      expect(controller.message, PathFinderTexts.missedGoal);
      expect(controller.trail.keys, [controller.board.start]);
    });

    test('showHint_WrongCommand_SelectsIt', () {
      final controller = create(_rock)
        ..addCommand(_right)
        ..showHint();

      expect(controller.selectedIndex, 0);
      expect(controller.wrongIndex, 0);
      expect(controller.message, PathFinderTexts.fixCommand(0));
    });

    test('run_DisposedDuringWalk_DoesNotComplete', () async {
      final controller = PathFinderController(
        level: _straight,
        onCompleted: completed.add,
        stepDuration: const Duration(milliseconds: 10),
      )..addCommand(_right);

      final running = controller.run();
      controller.dispose();
      await running;

      expect(completed, isEmpty);
    });
  });
}
