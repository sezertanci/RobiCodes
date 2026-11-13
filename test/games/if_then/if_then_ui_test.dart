import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/level_select_screen.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/if_then/engine/if_then_level.dart';
import 'package:robi_codes/games/if_then/engine/if_then_levels.dart';
import 'package:robi_codes/games/if_then/if_then_texts.dart';
import 'package:robi_codes/games/if_then/ui/block_palette.dart';
import 'package:robi_codes/games/if_then/ui/if_then_view.dart';
import 'package:robi_codes/games/if_then/ui/lane_scene.dart';
import 'package:robi_codes/games/if_then/ui/rule_board.dart';

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

const _gameTitle = 'Eğer Böyleyse';
final _emptyAction = IfThenTexts.slot(condition: false, value: null, locked: false);

void _useScreen(WidgetTester tester, Size size) {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

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

/// Ekran okuyucu etiketi [label] olan dokunulabilir blok veya kutu.
Finder _button(String label) => find.byWidgetPredicate(
  (widget) => widget is Semantics && widget.properties.button == true && widget.properties.label == label,
);

/// Öğe ekran dışındaysa önce görünür hale getirilir, sonra dokunulur.
Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pump();
}

/// Robotun yürüyüşü, kutlama ve sonuç paneli animasyonlarının bitmesi için yeterli süre.
Future<void> _wait(WidgetTester tester, {int steps = 50}) async {
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void main() {
  for (final MapEntry(key: name, value: size) in _screens.entries) {
    testWidgets('IfThenView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      _useScreen(tester, size);

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
      _useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.ifThen);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye → Zıpla bloğu → Başlat
      await tester.ensureVisible(find.text(_gameTitle));
      await tester.tap(find.text(_gameTitle));
      await tester.pumpAndSettle();
      expect(find.byType(LevelSelectScreen), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Seviye 1'));
      await tester.pumpAndSettle();
      await _tap(tester, _button(IfThenTexts.paletteBlock(LaneAction.jump)));
      await _tap(tester, find.byTooltip(IfThenTexts.run));
      await _wait(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
    });
  }

  testWidgets('IfThenView_PortraitPhone_ButtonsVisibleWithoutScrolling', (tester) async {
    final screen = _screens['telefon']!;
    _useScreen(tester, screen);

    for (final level in ifThenBaseLevels) {
      await _pumpLevel(tester, level);

      for (final tooltip in [IfThenTexts.run, IfThenTexts.hint, IfThenTexts.clear]) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
    }
  });

  testWidgets('IfThenView_WrongActionRun_ShowsWrongMessage', (tester) async {
    _useScreen(tester, _screens['tablet']!);
    await _pumpLevel(tester, ifThenBaseLevels.first);

    await _tap(tester, _button(IfThenTexts.paletteBlock(LaneAction.forward)));
    await _tap(tester, find.byTooltip(IfThenTexts.run));
    await _wait(tester, steps: 10);

    final step = (index: 2, object: LaneObject.rock, action: LaneAction.forward, rule: 0);
    expect(find.text(IfThenTexts.wrong(step)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('IfThenView_BlockDraggedToSlot_FillsSlot', (tester) async {
    _useScreen(tester, _screens['tablet']!);
    await _pumpLevel(tester, ifThenBaseLevels.first);
    final block = _button(IfThenTexts.paletteBlock(LaneAction.jump));

    final gesture = await tester.startGesture(tester.getCenter(block));
    await tester.pump(const Duration(seconds: 1));
    await gesture.moveTo(tester.getCenter(_button(_emptyAction)));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(_button(IfThenTexts.slot(condition: false, value: LaneAction.jump, locked: false)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('IfThenView_HintPressed_ShowsHintMessage', (tester) async {
    _useScreen(tester, _screens['telefon']!);
    await _pumpLevel(tester, ifThenBaseLevels.first);

    await _tap(tester, find.byTooltip(IfThenTexts.hint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(IfThenTexts.hintText(LaneObject.rock)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
