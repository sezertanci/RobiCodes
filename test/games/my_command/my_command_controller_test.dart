import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/games/my_command/my_command_controller.dart';
import 'package:robi_codes/games/my_command/my_command_level.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/l10n/l10n.dart';

import '../../support/test_l10n.dart';

String _levelHint(AppLocalizations _) => 'Sağa git.';

const _right = Direction.right;

/// Bayrak altı kare sağda; komut iki sağ ok, ana program üç komut bloğu. Sınır 5 blok.
const _level = MyCommandLevel(map: ['S.....G'], command: 'RR', main: 'C C C', maxBlocks: 5, hint: _levelHint);

/// Üçüncü karede taş var; iki sağ oklu komutun ilk kullanımı taşa çarpar.
const _stoneLevel = MyCommandLevel(map: ['S.#...G'], command: 'RR', main: 'C C C', maxBlocks: 5, hint: _levelHint);

MyCommandController _controller({MyCommandLevel level = _level, ValueChanged<int>? onCompleted}) => MyCommandController(
  level: level,
  onCompleted: onCompleted ?? (_) {},
  feedback: const SilentGameFeedback(),
  stepDuration: Duration.zero,
  celebrateDuration: Duration.zero,
);

/// Komut şeridine iki sağ ok, ana programa [calls] komut bloğu ekler.
void _build(MyCommandController controller, {int calls = 3}) {
  controller
    ..addMove(_right)
    ..addMove(_right);
  for (var i = 0; i < calls; i++) {
    controller.addCommand();
  }
}

void main() {
  test('constructor_NewLevel_StartsOnCommandLane', () {
    final controller = _controller();

    expect(controller.lane, CommandLane.command);
    expect(controller.blockCount, 0);
    expect(controller.message(texts), texts.myCommandIntro);
  });

  test('addMove_CommandLane_AddsToCommand', () {
    // Arrange
    final controller = _controller();

    // Act
    controller.addMove(_right);

    // Assert
    expect(controller.command, [const MoveBlock(_right)]);
    expect(controller.main, isEmpty);
  });

  test('addCommand_CommandReady_AddsCallAndSwitchesToMain', () {
    // Arrange
    final controller = _controller()..addMove(_right);

    // Act
    controller.addCommand();

    // Assert
    expect(controller.main, [const CallBlock()]);
    expect(controller.lane, CommandLane.main);
    expect(controller.message(texts), texts.myCommandCallAdded);
  });

  test('addMove_AfterAddCommand_AddsToMain', () {
    // Arrange
    final controller = _controller()
      ..addMove(_right)
      ..addCommand();

    // Act
    controller.addMove(_right);

    // Assert
    expect(controller.main, [const CallBlock(), const MoveBlock(_right)]);
  });

  test('isFull_BothLanesReachLimit_BlocksNewBlocks', () {
    // Arrange
    final controller = _controller();

    // Act
    _build(controller);
    controller.addCommand();

    // Assert
    expect(controller.blockCount, 5);
    expect(controller.isFull, isTrue);
    expect(controller.canAddMove, isFalse);
    expect(controller.canAddCommand, isFalse);
    expect(controller.main, hasLength(3));
  });

  test('activate_MainLane_SaysEditMain', () {
    // Arrange
    final controller = _controller();

    // Act
    controller.activate(CommandLane.main);

    // Assert
    expect(controller.lane, CommandLane.main);
    expect(controller.message(texts), texts.myCommandEditMain);
  });

  test('run_EmptyMain_SaysEmptyMain', () async {
    // Arrange
    final controller = _controller()..addMove(_right);

    // Act
    await controller.run();

    // Assert
    expect(controller.lane, CommandLane.main);
    expect(controller.message(texts), texts.myCommandEmptyMain);
    expect(controller.isRunning, isFalse);
  });

  test('run_CallWithEmptyCommand_SaysEmptyCommand', () async {
    // Arrange
    final controller = _controller()..addCommand();

    // Act
    await controller.run();

    // Assert
    expect(controller.lane, CommandLane.command);
    expect(controller.message(texts), texts.myCommandEmptyCommand);
  });

  test('run_Solution_CompletesWithThreeStars', () async {
    // Arrange
    int? stars;
    final controller = _controller(onCompleted: (value) => stars = value);
    _build(controller);

    // Act
    await controller.run();

    // Assert
    expect(stars, 3);
  });

  test('run_TooFewCalls_SaysMissedGoal', () async {
    // Arrange
    final controller = _controller();
    _build(controller, calls: 2);

    // Act
    await controller.run();

    // Assert
    expect(controller.message(texts), texts.myCommandMissedGoal);
    expect(controller.isRunning, isFalse);
  });

  test('run_BlockedInFirstCall_MarksCommandAndMain', () async {
    // Arrange
    final controller = _controller(level: _stoneLevel);
    _build(controller);

    // Act
    await controller.run();

    // Assert
    expect(controller.commandStrip.wrongPlace, isNotNull);
    expect(controller.mainStrip.wrongPlace, isNotNull);
  });

  test('showHint_CommandReadyNoCall_SaysUseHint', () {
    // Arrange
    final controller = _controller()..addMove(_right);

    // Act
    controller.showHint();

    // Assert
    expect(controller.hintUsed, isTrue);
    expect(controller.message(texts), texts.myCommandUseHint);
  });

  test('clear_AfterEdits_EmptiesBothLanes', () {
    // Arrange
    final controller = _controller();
    _build(controller);

    // Act
    controller.clear();

    // Assert
    expect(controller.command, isEmpty);
    expect(controller.main, isEmpty);
    expect(controller.lane, CommandLane.command);
    expect(controller.message(texts), texts.myCommandIntro);
  });
}
