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

import '../../support/test_l10n.dart';
import '../../support/fakes.dart';
import '../../support/ui_test_helpers.dart';

final _gameTitle = texts.gameCommandOrderTitle;

/// Kartları ters sırayla veren tek seviyelik oyun ekranı.
Future<void> _pumpLevel(WidgetTester tester, CommandOrderLevel level, {ValueChanged<int>? onCompleted}) async {
  await tester.pumpWidget(
    localizedApp(
      Scaffold(
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

/// Seviyenin [id] numaralı adımının kartı.
OrderCard _card(CommandOrderLevel level, int id) => OrderCard(id: id, step: level.steps[id], extra: false);

void main() {
  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('CommandOrderView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);

      for (final level in commandOrderBaseLevels) {
        await _pumpLevel(tester, level);

        expect(tester.takeException(), isNull, reason: level.title(texts));
        expect(find.byType(SlotBoard), findsOneWidget);
        expect(find.byType(CardPool), findsOneWidget);
        expect(find.byTooltip(texts.commandOrderCheck), findsOneWidget);
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
        await tapVisible(tester, findButton(step.text(texts)));
      }
      await tapVisible(tester, find.byTooltip(texts.commandOrderCheck));
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

      for (final tooltip in [texts.commandOrderCheck, texts.commonHint, texts.commonClear]) {
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
      await tapVisible(tester, findButton(step.text(texts)));
    }
    await tapVisible(tester, find.byTooltip(texts.commandOrderCheck));
    await tester.pump(const Duration(milliseconds: 500));

    final wrong = CommandOrderEngine.checkOrder([for (var i = level.steps.length - 1; i >= 0; i--) i]) as OrderWrong;
    expect(find.text(CommandOrderTexts.wrong(wrong, _card(level, level.steps.length - 1))(texts)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommandOrderView_CardDraggedToSlot_PlacesCard', (tester) async {
    useScreen(tester, TestScreens.tablet);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);
    final card = findButton(level.steps.first.text(texts));
    final slot = findButton(CommandOrderTexts.emptySlot(texts, 1));

    final gesture = await tester.startGesture(tester.getCenter(card));
    await tester.pump(const Duration(seconds: 1));
    await gesture.moveTo(tester.getCenter(slot));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(findButton(CommandOrderTexts.slotCard(texts, 1, _card(level, 0))), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommandOrderView_HintPressed_ShowsHintMessage', (tester) async {
    useScreen(tester, TestScreens.phone);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);

    await tapVisible(tester, find.byTooltip(texts.commonHint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(CommandOrderTexts.hint(level.hint, _card(level, 0), 0)(texts)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
