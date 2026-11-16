import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/ui/board_view.dart';
import 'package:robi_codes/games/path_finder/ui/command_chip.dart';
import 'package:robi_codes/games/repeat/engine/repeat_level.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';
import 'package:robi_codes/games/repeat/ui/program_strip.dart';
import 'package:robi_codes/games/repeat/ui/repeat_view.dart';
import 'package:robi_codes/games/variable_box/variable_box_levels.dart';

import '../../support/test_l10n.dart';
import '../../support/ui_test_helpers.dart';

/// Tekrarla bloğunun ilk göründüğü seviyenin sırası (11. seviye).
const _firstRepeatLevel = 10;

const _first = (block: 0, inner: Places.topLevel);

Future<void> _pumpLevel(WidgetTester tester, RepeatLevel level) async {
  await tester.pumpWidget(
    localizedApp(
      Scaffold(
        body: RepeatView(key: UniqueKey(), level: level, onCompleted: (_) {}, usesBox: true),
      ),
    ),
  );
  await tester.pump();
}

Finder _boxChip(InnerBlock block) => find.bySemanticsLabel(RepeatTexts.boxChip(texts, _first, block));

void main() {
  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('VariableBoxView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);

      for (final (index, level) in variableBoxBaseLevels.indexed) {
        await _pumpLevel(tester, level);

        expect(tester.takeException(), isNull, reason: '${index + 1}. seviye');
        expect(find.byType(BoardView), findsOneWidget);
        expect(find.byType(ProgramStrip), findsOneWidget);
        expect(findButton(texts.variableBoxSetLabel), findsOneWidget);
        expect(findButton(texts.repeatAddRepeatLabel), index < _firstRepeatLevel ? findsNothing : findsOneWidget);
      }
    });

    testWidgets('VariableBoxView_BoxBlocksOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);
      await _pumpLevel(tester, variableBoxBaseLevels.last);

      await tapVisible(tester, findButton(texts.repeatAddRepeatLabel));
      await tapVisible(tester, findButton(texts.variableBoxSetLabel));
      await tapVisible(tester, findButton(texts.variableBoxIncreaseLabel));
      await tapVisible(tester, findButton(texts.variableBoxDecreaseLabel));

      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('VariableBoxView_SetBoxPressed_AddsBlockThatStepperChanges', (tester) async {
    // Arrange
    await _pumpLevel(tester, variableBoxBaseLevels.first);

    // Act
    await tapVisible(tester, findButton(texts.variableBoxSetLabel));
    await tapVisible(tester, findButton(texts.variableBoxIncrease));

    // Assert
    expect(_boxChip(const SetBoxBlock(SetBoxBlock.defaultValue + 1)), findsOneWidget);
    expect(find.text(RepeatTexts.boxSign(const SetBoxBlock(SetBoxBlock.defaultValue + 1))), findsWidgets);
  });

  testWidgets('VariableBoxView_IncreasePressed_AddsIncrementBlock', (tester) async {
    await _pumpLevel(tester, variableBoxBaseLevels.first);

    await tapVisible(tester, findButton(texts.variableBoxIncreaseLabel));

    expect(_boxChip(AddBoxBlock.increment), findsOneWidget);
  });

  testWidgets('VariableBoxView_ArrowAfterBox_ShowsBoxValueOnArrow', (tester) async {
    // Arrange
    await _pumpLevel(tester, variableBoxBaseLevels.first);
    const arrow = (block: 1, inner: Places.topLevel);

    // Act
    await tapVisible(tester, findButton(texts.variableBoxSetLabel));
    await tapVisible(tester, findButton(RepeatTexts.addMove(texts, Direction.right)));

    // Assert
    const steps = SetBoxBlock.defaultValue;
    expect(find.descendant(of: find.byType(StepsBadge), matching: find.text('$steps')), findsOneWidget);
    expect(find.bySemanticsLabel(RepeatTexts.moveChip(texts, arrow, Direction.right, steps: steps)), findsOneWidget);
  });
}
