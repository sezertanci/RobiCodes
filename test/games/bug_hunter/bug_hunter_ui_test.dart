import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/bug_hunter/bug_hunter_levels.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/ui/command_chip.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';
import 'package:robi_codes/games/repeat/ui/repeat_view.dart';

import '../../support/test_l10n.dart';
import '../../support/ui_test_helpers.dart';

List<Direction> _chipDirections(WidgetTester tester) => [
  for (final chip in tester.widgetList<CommandChip>(find.byType(CommandChip))) chip.direction,
];

void main() {
  testWidgets('RepeatView_ArrowSelectedThenDirectionPressed_ReplacesSelectedArrow', (tester) async {
    // Arrange: 1. seviyenin bozuk kodu sağ, yukarı, sağ.
    final level = bugHunterBaseLevels.first;
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: RepeatView(level: level.puzzle, startingProgram: level.startingProgram, onCompleted: (_) {}),
        ),
      ),
    );
    await tester.pump();

    // Act
    await tapVisible(tester, find.byType(CommandChip).at(1));
    await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.right)));

    // Assert
    expect(_chipDirections(tester), [Direction.right, Direction.right, Direction.right]);
  });
}
