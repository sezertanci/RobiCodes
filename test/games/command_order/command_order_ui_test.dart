import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/level_select_screen.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/command_order/command_order_texts.dart';
import 'package:robi_codes/games/command_order/engine/command_order_engine.dart';
import 'package:robi_codes/games/command_order/engine/command_order_level.dart';
import 'package:robi_codes/games/command_order/engine/command_order_levels.dart';
import 'package:robi_codes/games/command_order/ui/card_pool.dart';
import 'package:robi_codes/games/command_order/ui/command_order_view.dart';
import 'package:robi_codes/games/command_order/ui/slot_board.dart';

import '../../support/fakes.dart';

/// Denenen ekran boyutları: küçük bir telefon, yatay telefon, yatay tablet ve test tabletinin
/// (2560x1600, yoğunluk 360) iki yöndeki mantıksal boyutu.
const _screens = {
  'telefon': Size(360, 690),
  'yatayTelefon': Size(690, 360),
  'tablet': Size(1024, 768),
  'dikeyTablet': Size(711, 1138),
  'yatayTablet': Size(1138, 711),
};

const _gameTitle = 'Komutları Sırala';

void _useScreen(WidgetTester tester, Size size) {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

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

/// Yazısı [text] olan dokunulabilir kart veya kutu. Görev adı bir adımla aynı olabildiği için
/// yalnızca düğmeler aranır.
Finder _button(String text) => find.byWidgetPredicate(
  (widget) => widget is Semantics && widget.properties.button == true && widget.properties.label == text,
);

/// Öğe ekran dışındaysa önce görünür hale getirilir, sonra dokunulur.
Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pump();
}

/// Kutlama ve sonuç paneli animasyonlarının bitmesi için yeterli süre.
Future<void> _waitForResult(WidgetTester tester) async {
  for (var i = 0; i < 15; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void main() {
  for (final MapEntry(key: name, value: size) in _screens.entries) {
    testWidgets('CommandOrderView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      _useScreen(tester, size);

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
      _useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.commandOrder);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye → kartları sırayla yerleştir → kontrol et
      await tester.ensureVisible(find.text(_gameTitle));
      await tester.tap(find.text(_gameTitle));
      await tester.pumpAndSettle();
      expect(find.byType(LevelSelectScreen), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Seviye 1'));
      await tester.pumpAndSettle();
      for (final step in commandOrderBaseLevels.first.steps) {
        await _tap(tester, _button(step.text));
      }
      await _tap(tester, find.byTooltip(CommandOrderTexts.check));
      await _waitForResult(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
    });
  }

  testWidgets('CommandOrderView_PortraitPhone_ButtonsVisibleWithoutScrolling', (tester) async {
    final screen = _screens['telefon']!;
    _useScreen(tester, screen);

    for (final level in commandOrderBaseLevels) {
      await _pumpLevel(tester, level);

      for (final tooltip in [CommandOrderTexts.check, CommandOrderTexts.hint, CommandOrderTexts.clear]) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
    }
  });

  testWidgets('CommandOrderView_WrongOrderChecked_ShowsWrongMessage', (tester) async {
    _useScreen(tester, _screens['tablet']!);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);

    // Kartlar havuzda ters sırada; havuz sırasıyla dokunmak yanlış sıra oluşturur.
    for (final step in level.steps.reversed) {
      await _tap(tester, _button(step.text));
    }
    await _tap(tester, find.byTooltip(CommandOrderTexts.check));
    await tester.pump(const Duration(milliseconds: 500));

    final wrong = CommandOrderEngine.checkOrder([for (var i = level.steps.length - 1; i >= 0; i--) i]) as OrderWrong;
    expect(find.text(CommandOrderTexts.wrong(wrong, level.steps.last.text)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommandOrderView_CardDraggedToSlot_PlacesCard', (tester) async {
    _useScreen(tester, _screens['tablet']!);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);
    final card = _button(level.steps.first.text);
    final slot = _button(CommandOrderTexts.emptySlot(1));

    final gesture = await tester.startGesture(tester.getCenter(card));
    await tester.pump(const Duration(seconds: 1));
    await gesture.moveTo(tester.getCenter(slot));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(_button(CommandOrderTexts.slotCard(1, level.steps.first.text)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommandOrderView_HintPressed_ShowsHintMessage', (tester) async {
    _useScreen(tester, _screens['telefon']!);
    final level = commandOrderBaseLevels.first;
    await _pumpLevel(tester, level);

    await _tap(tester, find.byTooltip(CommandOrderTexts.hint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(CommandOrderTexts.hintText(level.hint, level.steps.first.text, 0)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
