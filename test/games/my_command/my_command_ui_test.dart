import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/my_command/my_command_levels.dart';
import 'package:robi_codes/games/my_command/ui/my_command_view.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/ui/command_chip.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';
import 'package:robi_codes/games/repeat/ui/call_chip.dart';

import '../../support/test_l10n.dart';
import '../../support/ui_test_helpers.dart';

/// Tekrarla bloğunun ilk göründüğü seviyenin sırası (11. seviye).
const _firstRepeatLevel = 10;

void main() {
  testWidgets('MyCommandView_ArrowThenCommandPressed_ShowsCallChip', (tester) async {
    // Arrange
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: MyCommandView(level: myCommandBaseLevels.first, onCompleted: (_) {}),
        ),
      ),
    );
    await tester.pump();

    // Act
    await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.right)));
    await tapVisible(tester, find.text(texts.myCommandButton));

    // Assert
    expect(find.byType(CommandChip), findsOneWidget);
    expect(find.byType(CallChip), findsOneWidget);
  });

  for (final MapEntry(key: name, value: size) in {...TestScreens.all, 'SmallTablet': TestScreens.smallTablet}.entries) {
    testWidgets('MyCommandView_RepeatLevelsOn${name}_FitWithoutOverflow', (tester) async {
      // Arrange: 11–20. seviyelerde iki şerit ve Tekrarla satırı birlikte görünür.
      useScreen(tester, size);

      for (final level in myCommandBaseLevels.skip(_firstRepeatLevel)) {
        // Act
        await tester.pumpWidget(
          localizedApp(
            Scaffold(
              body: MyCommandView(key: UniqueKey(), level: level, onCompleted: (_) {}),
            ),
          ),
        );
        await tester.pump();
        for (var i = 0; i < level.maxBlocks; i++) {
          await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.right)));
        }

        // Assert
        expect(tester.takeException(), isNull);
        expect(find.byType(CommandChip), findsNWidgets(level.maxBlocks));
      }
    });
  }
}
