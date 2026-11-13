import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/command_order/command_order_texts.dart';
import 'package:robi_codes/games/command_order/engine/command_order_engine.dart';
import 'package:robi_codes/games/command_order/engine/command_order_level.dart';
import 'package:robi_codes/games/command_order/engine/command_order_levels.dart';
import 'package:robi_codes/games/command_order/ui/card_pool.dart';
import 'package:robi_codes/games/command_order/ui/command_order_view.dart';
import 'package:robi_codes/games/command_order/ui/slot_board.dart';

import '../../support/fakes.dart';
import '../../support/ui_test_helpers.dart';

const _gameTitle = 'Komutları Sırala';

/// Kartları ters sırayla veren tek seviyelik oyun ekranı.
Future<void> _pumpLevel(WidgetTester tester, CommandOrderLevel level, {ValueChanged<int>? onCompleted}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CommandOrderView(
          key: UniqueKey(),
          level: level,
          shuffle: () => CommandOrderEngine.buildCards(level).reversed.toList(),
          onCompleted: onCompleted ?? (_) {},
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('CommandOrderView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);

      for (final level in commandOrderBaseLevels) {
        await _pumpLevel(tester, level);

        expect(tester.takeException(), isNull, reason: level.title);
        expect(find.byType(SlotBoard), findsOneWidget);
        expect(find.byType(CardPool), findsOneWidget);
        expect(find.byTooltip(CommandOrderTexts.check), findsOneWidget);
      }
    });

    testWidgets('PlayFlow_FirstLevelOn${name}_SavesThreeStarsAndShowsResult', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.commandOrder);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye → kartları sırayla yerleştir → kontrol et
      await openLevelSelect(tester, _gameTitle);
      await openLevel(tester, 1);
      for (final step in commandOrderBaseLevels.first.steps) {
        await tapVisible(tester, findButton(step.text));
      }
      await tapVisible(tester, find.byTooltip(CommandOrderTexts.check));
      await waitForAnimations(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
    });
  }

  testWidgets('CommandOrderView_PortraitPhone_ButtonsVisibleWithoutScrolling', (tester) async {
    final screen = TestScreens.phone;
    useScreen(tester, screen);

    for (final level in commandOrderBaseLevels) {
      await _pumpLevel(tester, level);

      for (final tooltip in [CommandOrderTexts.check, CommandOrderTexts.hint, CommandOrderTexts.clear]) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
    }
  });

  testWidgets('CommandOrderView_WrongOrderChecked_ShowsWrongMessage', (tester) async {
    useScreen(tester, TestScreens.tablet);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);

    // Kartlar havuzda ters sırada; havuz sırasıyla dokunmak yanlış sıra oluşturur.
    for (final step in level.steps.reversed) {
      await tapVisible(tester, findButton(step.text));
    }
    await tapVisible(tester, find.byTooltip(CommandOrderTexts.check));
    await tester.pump(const Duration(milliseconds: 500));

    final wrong = CommandOrderEngine.checkOrder([for (var i = level.steps.length - 1; i >= 0; i--) i]) as OrderWrong;
    expect(find.text(CommandOrderTexts.wrong(wrong, level.steps.last.text)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommandOrderView_CardDraggedToSlot_PlacesCard', (tester) async {
    useScreen(tester, TestScreens.tablet);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);
    final card = findButton(level.steps.first.text);
    final slot = findButton(CommandOrderTexts.emptySlot(1));

    final gesture = await tester.startGesture(tester.getCenter(card));
    await tester.pump(const Duration(seconds: 1));
    await gesture.moveTo(tester.getCenter(slot));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(findButton(CommandOrderTexts.slotCard(1, level.steps.first.text)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommandOrderView_HintPressed_ShowsHintMessage', (tester) async {
    useScreen(tester, TestScreens.phone);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);

    await tapVisible(tester, find.byTooltip(CommandOrderTexts.hint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(CommandOrderTexts.hintText(level.hint, level.steps.first.text, 0)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
