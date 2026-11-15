import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/ui/board_view.dart';
import 'package:robi_codes/games/repeat/engine/repeat_level.dart';
import 'package:robi_codes/games/repeat/engine/repeat_levels.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';
import 'package:robi_codes/games/repeat/ui/program_strip.dart';
import 'package:robi_codes/games/repeat/ui/repeat_view.dart';

import '../../support/test_l10n.dart';
import '../../support/fakes.dart';
import '../../support/ui_test_helpers.dart';

final _gameTitle = texts.gameRepeatTitle;

Future<void> _pumpLevel(WidgetTester tester, RepeatLevel level) async {
  await tester.pumpWidget(
    localizedApp(
      Scaffold(
        body: RepeatView(key: UniqueKey(), level: level, onCompleted: (_) {}),
      ),
    ),
  );
  await tester.pump();
}

/// 1. seviyenin çözümü: Tekrarla bloğu, içine sağ ok, tekrar sayısı 3.
Future<void> _buildFirstSolution(WidgetTester tester) async {
  await tapVisible(tester, findButton(texts.repeatAddRepeatLabel));
  await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.right)));
  await tapVisible(tester, findButton(texts.repeatIncrease));
}

void main() {
  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('RepeatView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);

      for (final (index, level) in repeatBaseLevels.indexed) {
        await _pumpLevel(tester, level);

        expect(tester.takeException(), isNull, reason: '${index + 1}. seviye');
        expect(find.byType(BoardView), findsOneWidget);
        expect(find.byType(ProgramStrip), findsOneWidget);
        expect(find.byTooltip(texts.commonRun), findsOneWidget);
      }
    });

    testWidgets('RepeatView_BlockWithSelectionOn${name}_RendersWithoutOverflow', (tester) async {
      useScreen(tester, size);
      await _pumpLevel(tester, repeatBaseLevels.last);

      await tapVisible(tester, findButton(texts.repeatAddRepeatLabel));
      await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.right)));
      await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.down)));
      await tapVisible(
        tester,
        find.bySemanticsLabel(RepeatTexts.moveChip(texts, (block: 0, inner: 1), Direction.down)),
      );

      expect(find.byTooltip(texts.repeatDeleteLabel), findsOneWidget);
      expect(find.byTooltip(texts.repeatMoveOutLabel), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('PlayFlow_FirstLevelOn${name}_SavesThreeStarsAndShowsResult', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.repeat);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye → Tekrarla, sağ ok, 3 kez → Başlat
      await openLevelSelect(tester, _gameTitle);
      await openLevel(tester, 1);
      await _buildFirstSolution(tester);
      await tapVisible(tester, find.byTooltip(texts.commonRun));
      await waitForAnimations(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
    });
  }

  testWidgets('RepeatView_PortraitPhone_ButtonsVisibleWithoutScrolling', (tester) async {
    final screen = TestScreens.phone;
    useScreen(tester, screen);

    for (final level in repeatBaseLevels) {
      await _pumpLevel(tester, level);

      for (final tooltip in [texts.commonRun, texts.commonHint, texts.commonClear]) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
      expect(tester.getRect(findButton(texts.repeatAddRepeatLabel)).bottom, lessThanOrEqualTo(screen.height));
    }
  });

  testWidgets('RepeatView_TooManyRounds_ShowsBlockedMessage', (tester) async {
    useScreen(tester, TestScreens.tablet);
    await _pumpLevel(tester, repeatBaseLevels.first);

    await _buildFirstSolution(tester);
    await tapVisible(tester, findButton(texts.repeatIncrease));
    await tapVisible(tester, find.byTooltip(texts.commonRun));
    await waitForAnimations(tester, steps: 15);

    final step = (direction: Direction.right, block: 0, inner: 0, round: 3);
    expect(find.text(RepeatTexts.blocked(Obstacle.edge, step)(texts)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('RepeatView_RepeatButtonPressedTwice_LeavesBlock', (tester) async {
    useScreen(tester, TestScreens.phone);
    await _pumpLevel(tester, repeatBaseLevels[5]);

    await tapVisible(tester, findButton(texts.repeatAddRepeatLabel));
    await tapVisible(tester, find.byTooltip(RepeatTexts.addMove(texts, Direction.right)));
    await tapVisible(tester, findButton(texts.repeatLeaveRepeatLabel));

    expect(findButton(texts.repeatAddRepeatLabel), findsOneWidget);
    expect(find.text(texts.repeatOutsideRepeat), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('RepeatView_HintPressed_ShowsLevelHint', (tester) async {
    useScreen(tester, TestScreens.phone);
    final level = repeatBaseLevels.first;
    await _pumpLevel(tester, level);

    await tapVisible(tester, find.byTooltip(texts.commonHint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(RepeatTexts.nextMoveHint(level.hint, Direction.right)(texts)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
