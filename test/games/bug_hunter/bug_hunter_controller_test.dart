import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_level.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/engine/starting_program.dart';
import 'package:robi_codes/games/repeat/repeat_controller.dart';
import 'package:robi_codes/l10n/l10n.dart';

import '../../support/test_l10n.dart';

String _intro(AppLocalizations t) => t.bugHunterIntro;

String _levelHint(AppLocalizations _) => 'Sağa git.';

const _right = Direction.right;
const _down = Direction.down;

/// Bayrak üç kare sağda; bozuk kodun ortasındaki ok yukarı bakıyor. Sınır 3 blok, yani program dolu.
const _fullLevel = RepeatLevel(
  map: ['....', 'S..G', '....'],
  solution: 'RRR',
  maxBlocks: 3,
  hint: _levelHint,
  intro: _intro,
);

const _roomyLevel = RepeatLevel(
  map: ['....', 'S..G', '....'],
  solution: 'RRR',
  maxBlocks: 6,
  hint: _levelHint,
  intro: _intro,
);

/// Bayrak üç kare sağda; çözüm üç turlu tekrar bloğu.
const _repeatLevel = RepeatLevel(
  map: ['....', 'S..G', '....'],
  solution: '3(R)',
  maxBlocks: 3,
  hint: _levelHint,
  intro: _intro,
);

RepeatController _controller(String bugged, {RepeatLevel level = _roomyLevel, bool allowsRepeat = false}) =>
    RepeatController(
      level: level,
      startingProgram: StartingProgram(RepeatEngine.parseSolution(bugged), allowsRepeat: allowsRepeat),
      onCompleted: (_) {},
      feedback: const SilentGameFeedback(),
      stepDuration: Duration.zero,
      celebrateDuration: Duration.zero,
    );

void main() {
  test('constructor_StartingProgram_OpensWithBuggedCode', () {
    final controller = _controller('RUR');

    expect(controller.program, RepeatEngine.parseSolution('RUR'));
    expect(controller.fixesProgram, isTrue);
    expect(controller.message(texts), texts.bugHunterIntro);
  });

  test('addMove_SelectedArrowWhileFull_ReplacesIt', () {
    // Arrange
    final controller = _controller('RUR', level: _fullLevel);
    controller.toggleSelection(Places.top(1));
    expect(controller.canAddMove, isTrue);

    // Act
    controller.addMove(_right);

    // Assert
    expect(controller.program, RepeatEngine.parseSolution('RRR'));
  });

  test('addMove_NothingSelectedWhileFull_DoesNothing', () {
    final controller = _controller('RUR', level: _fullLevel);

    expect(controller.canAddMove, isFalse);
    expect(controller.canInsert, isFalse);
  });

  test('addMove_InsertingAtTopLevel_PutsArrowBeforeSelection', () {
    // Arrange
    final controller = _controller('DU');
    controller.toggleSelection(Places.top(1));
    controller.toggleInserting();

    // Act
    controller.addMove(_right);

    // Assert
    expect(controller.program, RepeatEngine.parseSolution('DRU'));
    expect(controller.isInserting, isFalse);
    expect(controller.selected, isNull);
  });

  test('addMove_InsertingInsideRepeat_PutsArrowBeforeInnerArrow', () {
    // Arrange
    final controller = _controller('2(D)', allowsRepeat: true);
    controller.toggleSelection((block: 0, inner: 0));
    controller.toggleInserting();

    // Act
    controller.addMove(_right);

    // Assert
    expect(controller.program, RepeatEngine.parseSolution('2(RD)'));
  });

  test('addMove_SelectedInnerArrow_ReplacesIt', () {
    final controller = _controller('2(RU)', allowsRepeat: true);
    controller.toggleSelection((block: 0, inner: 1));

    controller.addMove(_down);

    expect(controller.program, RepeatEngine.parseSolution('2(RD)'));
  });

  test('toggleInserting_PressedTwice_GoesBackToReplacing', () {
    final controller = _controller('RU');
    controller.toggleSelection(Places.top(1));

    controller
      ..toggleInserting()
      ..toggleInserting()
      ..addMove(_right);

    expect(controller.program, RepeatEngine.parseSolution('RR'));
  });

  test('clear_AfterEdits_GoesBackToBuggedCode', () {
    // Arrange
    final controller = _controller('RUR');
    controller.toggleSelection(Places.top(1));
    controller.addMove(_right);

    // Act
    controller.clear();

    // Assert
    expect(controller.program, RepeatEngine.parseSolution('RUR'));
  });

  test('canUseRepeatButton_ArrowOnlyLevel_IsFalse', () {
    final controller = _controller('RUR');

    expect(controller.allowsRepeat, isFalse);
    expect(controller.canUseRepeatButton, isFalse);
  });

  test('showHint_WrongArrowWithoutBump_MarksArrowInsteadOfAddingMove', () {
    // Arrange: yukarı ok robotu çarptırmadan yoldan çıkarır.
    final controller = _controller('RUR');

    // Act
    controller.showHint();

    // Assert
    expect(controller.wrongPlace, Places.top(1));
    expect(controller.selected, Places.top(1));
    expect(controller.boardRun.hint, isNull);
    expect(controller.message(texts), texts.repeatFixHint(texts.repeatOffPath(texts.repeatBlockName(2))));
  });

  test('showHint_WrongRepeatCount_SaysChangeCount', () {
    // Arrange
    final controller = _controller('2(R)', level: _repeatLevel, allowsRepeat: true);

    // Act
    controller.showHint();

    // Assert
    expect(controller.wrongPlace, Places.top(0));
    expect(controller.message(texts), texts.repeatFixHint(texts.repeatFixCount(1)));
  });

  test('showHint_MissingArrowAtEnd_SuggestsNextMove', () {
    // Arrange
    final controller = _controller('RR');

    // Act
    controller.showHint();

    // Assert
    expect(controller.wrongPlace, isNull);
    expect(controller.boardRun.hint?.direction, _right);
  });

  test('run_FixedCode_CompletesLevel', () async {
    // Arrange
    final stars = <int>[];
    final controller = RepeatController(
      level: _fullLevel,
      startingProgram: StartingProgram(RepeatEngine.parseSolution('RUR'), allowsRepeat: false),
      onCompleted: stars.add,
      feedback: const SilentGameFeedback(),
      stepDuration: Duration.zero,
      celebrateDuration: Duration.zero,
    );
    controller.toggleSelection(Places.top(1));
    controller.addMove(_right);

    // Act
    await controller.run();

    // Assert
    expect(stars, hasLength(1));
  });
}
