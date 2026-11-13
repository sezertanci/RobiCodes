import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/level_select_screen.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/ui/board_view.dart';
import 'package:robi_codes/games/repeat/engine/repeat_level.dart';
import 'package:robi_codes/games/repeat/engine/repeat_levels.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';
import 'package:robi_codes/games/repeat/ui/program_strip.dart';
import 'package:robi_codes/games/repeat/ui/repeat_view.dart';

import '../../support/fakes.dart';

/// Denenen ekran boyutları: küçük bir telefon (telefon dikeye sabitlenir), yatay tablet ve test tabletinin
/// (2560x1600, yoğunluk 360) iki yöndeki mantıksal boyutu.
const _screens = {
  'phone': Size(360, 690),
  'tablet': Size(1024, 768),
  'tabletPortrait': Size(711, 1138),
  'tabletLandscape': Size(1138, 711),
};

const _gameTitle = 'Tekrar Et';

void _useScreen(WidgetTester tester, Size size) {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Future<void> _pumpLevel(WidgetTester tester, RepeatLevel level) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: RepeatView(key: UniqueKey(), level: level, onCompleted: (_) {}),
      ),
    ),
  );
  await tester.pump();
}

/// Ekran okuyucu etiketi [label] olan dokunulabilir düğme.
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

/// 1. seviyenin çözümü: Tekrarla bloğu, içine sağ ok, tekrar sayısı 3.
Future<void> _buildFirstSolution(WidgetTester tester) async {
  await _tap(tester, _button(RepeatTexts.addRepeatLabel));
  await _tap(tester, find.byTooltip(RepeatTexts.addMove(Direction.right)));
  await _tap(tester, _button(RepeatTexts.increase));
}

void main() {
  for (final MapEntry(key: name, value: size) in _screens.entries) {
    testWidgets('RepeatView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      _useScreen(tester, size);

      for (final (index, level) in repeatBaseLevels.indexed) {
        await _pumpLevel(tester, level);

        expect(tester.takeException(), isNull, reason: '${index + 1}. seviye');
        expect(find.byType(BoardView), findsOneWidget);
        expect(find.byType(ProgramStrip), findsOneWidget);
        expect(find.byTooltip(RepeatTexts.run), findsOneWidget);
      }
    });

    testWidgets('RepeatView_BlockWithSelectionOn${name}_RendersWithoutOverflow', (tester) async {
      _useScreen(tester, size);
      await _pumpLevel(tester, repeatBaseLevels.last);

      await _tap(tester, _button(RepeatTexts.addRepeatLabel));
      await _tap(tester, find.byTooltip(RepeatTexts.addMove(Direction.right)));
      await _tap(tester, find.byTooltip(RepeatTexts.addMove(Direction.down)));
      await _tap(tester, find.bySemanticsLabel(RepeatTexts.moveChip((block: 0, inner: 1), Direction.down)));

      expect(find.byTooltip(RepeatTexts.deleteLabel), findsOneWidget);
      expect(find.byTooltip(RepeatTexts.moveOutLabel), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('PlayFlow_FirstLevelOn${name}_SavesThreeStarsAndShowsResult', (tester) async {
      // Arrange
      _useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.repeat);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye → Tekrarla, sağ ok, 3 kez → Başlat
      // Ana ekrandaki ızgara yalnızca görünen kartları kurar; kart aşağıdaysa kaydırılır.
      await tester.scrollUntilVisible(find.text(_gameTitle), 200, scrollable: find.byType(Scrollable).first);
      await tester.tap(find.text(_gameTitle));
      await tester.pumpAndSettle();
      expect(find.byType(LevelSelectScreen), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Seviye 1'));
      await tester.pumpAndSettle();
      await _buildFirstSolution(tester);
      await _tap(tester, find.byTooltip(RepeatTexts.run));
      await _wait(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
    });
  }

  testWidgets('RepeatView_PortraitPhone_ButtonsVisibleWithoutScrolling', (tester) async {
    final screen = _screens['phone']!;
    _useScreen(tester, screen);

    for (final level in repeatBaseLevels) {
      await _pumpLevel(tester, level);

      for (final tooltip in [RepeatTexts.run, RepeatTexts.hint, RepeatTexts.clear]) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
      expect(tester.getRect(_button(RepeatTexts.addRepeatLabel)).bottom, lessThanOrEqualTo(screen.height));
    }
  });

  testWidgets('RepeatView_TooManyRounds_ShowsBlockedMessage', (tester) async {
    _useScreen(tester, _screens['tablet']!);
    await _pumpLevel(tester, repeatBaseLevels.first);

    await _buildFirstSolution(tester);
    await _tap(tester, _button(RepeatTexts.increase));
    await _tap(tester, find.byTooltip(RepeatTexts.run));
    await _wait(tester, steps: 15);

    final step = (direction: Direction.right, block: 0, inner: 0, round: 3);
    expect(find.text(RepeatTexts.blocked(Obstacle.edge, step)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('RepeatView_RepeatButtonPressedTwice_LeavesBlock', (tester) async {
    _useScreen(tester, _screens['phone']!);
    await _pumpLevel(tester, repeatBaseLevels[5]);

    await _tap(tester, _button(RepeatTexts.addRepeatLabel));
    await _tap(tester, find.byTooltip(RepeatTexts.addMove(Direction.right)));
    await _tap(tester, _button(RepeatTexts.leaveRepeatLabel));

    expect(_button(RepeatTexts.addRepeatLabel), findsOneWidget);
    expect(find.text(RepeatTexts.outsideRepeat), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('RepeatView_HintPressed_ShowsLevelHint', (tester) async {
    _useScreen(tester, _screens['phone']!);
    final level = repeatBaseLevels.first;
    await _pumpLevel(tester, level);

    await _tap(tester, find.byTooltip(RepeatTexts.hint));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(RepeatTexts.nextMoveHint(level.hint, Direction.right)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
