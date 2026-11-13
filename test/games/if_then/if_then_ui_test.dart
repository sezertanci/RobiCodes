import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/if_then/engine/if_then_level.dart';
import 'package:robi_codes/games/if_then/engine/if_then_levels.dart';
import 'package:robi_codes/games/if_then/if_then_texts.dart';
import 'package:robi_codes/games/if_then/ui/block_palette.dart';
import 'package:robi_codes/games/if_then/ui/if_then_view.dart';
import 'package:robi_codes/games/if_then/ui/lane_scene.dart';
import 'package:robi_codes/games/if_then/ui/rule_board.dart';

import '../../support/fakes.dart';
import '../../support/ui_test_helpers.dart';

const _gameTitle = 'Eğer Böyleyse';
final _emptyAction = IfThenTexts.slot(condition: false, value: null, locked: false);

Future<void> _pumpLevel(WidgetTester tester, IfThenLevel level) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: IfThenView(key: UniqueKey(), level: level, onCompleted: (_) {}),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('IfThenView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);

      for (final (index, level) in ifThenBaseLevels.indexed) {
        await _pumpLevel(tester, level);

        expect(tester.takeException(), isNull, reason: '${index + 1}. seviye');
        expect(find.byType(LaneScene), findsOneWidget);
        expect(find.byType(RuleBoard), findsOneWidget);
        expect(find.byType(BlockPalette), findsOneWidget);
        expect(find.byTooltip(IfThenTexts.run), findsOneWidget);
      }
    });

    testWidgets('PlayFlow_FirstLevelOn${name}_SavesThreeStarsAndShowsResult', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.ifThen);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye → Zıpla bloğu → Başlat
      await openLevelSelect(tester, _gameTitle);
      await openLevel(tester, 1);
      await tapVisible(tester, findButton(IfThenTexts.paletteBlock(LaneAction.jump)));
      await tapVisible(tester, find.byTooltip(IfThenTexts.run));
      await waitForAnimations(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
    });
  }

  testWidgets('IfThenView_PortraitPhone_ButtonsVisibleWithoutScrolling', (tester) async {
    final screen = TestScreens.phone;
    useScreen(tester, screen);

    for (final level in ifThenBaseLevels) {
      await _pumpLevel(tester, level);

      for (final tooltip in [IfThenTexts.run, IfThenTexts.hint, IfThenTexts.clear]) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
    }
  });

  testWidgets('IfThenView_WrongActionRun_ShowsWrongMessage', (tester) async {
    useScreen(tester, TestScreens.tablet);
    await _pumpLevel(tester, ifThenBaseLevels.first);

    await tapVisible(tester, findButton(IfThenTexts.paletteBlock(LaneAction.forward)));
    await tapVisible(tester, find.byTooltip(IfThenTexts.run));
    await waitForAnimations(tester, steps: 10);

    final step = (index: 2, object: LaneObject.rock, action: LaneAction.forward, rule: 0);
    expect(find.text(IfThenTexts.wrong(step)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('IfThenView_BlockDraggedToSlot_FillsSlot', (tester) async {
    useScreen(tester, TestScreens.tablet);
    await _pumpLevel(tester, ifThenBaseLevels.first);
    final block = findButton(IfThenTexts.paletteBlock(LaneAction.jump));

    final gesture = await tester.startGesture(tester.getCenter(block));
    await tester.pump(const Duration(seconds: 1));
    await gesture.moveTo(tester.getCenter(findButton(_emptyAction)));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(findButton(IfThenTexts.slot(condition: false, value: LaneAction.jump, locked: false)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('IfThenView_HintPressed_ShowsHintMessage', (tester) async {
    useScreen(tester, TestScreens.phone);
    await _pumpLevel(tester, ifThenBaseLevels.first);

    await tapVisible(tester, find.byTooltip(IfThenTexts.hint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(IfThenTexts.hintText(LaneObject.rock)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
