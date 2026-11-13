import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_levels.dart';
import 'package:robi_codes/games/path_finder/path_finder_texts.dart';
import 'package:robi_codes/games/path_finder/ui/board_view.dart';
import 'package:robi_codes/games/path_finder/ui/path_finder_controls.dart';
import 'package:robi_codes/games/path_finder/ui/path_finder_view.dart';

import '../../support/fakes.dart';
import '../../support/ui_test_helpers.dart';

/// Tek seviyelik oyun ekranı; ölçüm testleri için.
Future<void> _pumpLevel(WidgetTester tester, Size size) async {
  useScreen(tester, size);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(PathFinderTexts.title)),
        body: PathFinderView(key: UniqueKey(), level: pathFinderBaseLevels.first, onCompleted: (_) {}),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('PathFinderView_AllLevelsOn${name}_RenderWithoutOverflow', (tester) async {
      useScreen(tester, size);

      for (final level in pathFinderBaseLevels) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PathFinderView(key: UniqueKey(), level: level, onCompleted: (_) {}),
            ),
          ),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.byType(BoardView), findsOneWidget);
        expect(find.byTooltip(PathFinderTexts.run), findsOneWidget);
      }
    });

    testWidgets('PlayFlow_FirstLevelOn${name}_SavesThreeStarsAndShowsResult', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());
      final packId = basePackId(GameIds.pathFinder);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act: ana ekran → seviye seçimi → 1. seviye
      await openLevelSelect(tester, PathFinderTexts.title);
      expect(find.bySemanticsLabel('Seviye 2, kilitli'), findsOneWidget);
      await openLevel(tester, 1);
      await tapVisible(tester, find.byTooltip(PathFinderTexts.addCommand(Direction.right)));
      await tapVisible(tester, find.byTooltip(PathFinderTexts.run));
      await waitForAnimations(tester);

      // Assert
      expect(tester.takeException(), isNull);
      expect(services.progress.starsOf(packId, 1), 3);
      expect(find.byType(ResultPanel), findsOneWidget);
      expect(find.text(ResultPanel.nextLabel), findsOneWidget);

      await tester.tap(find.text(ResultPanel.backLabel));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Seviye 1, 3 yıldız'), findsOneWidget);
      expect(find.bySemanticsLabel('Seviye 2'), findsOneWidget);
    });
  }

  testWidgets('PathFinderView_AllLevelsOnPortraitPhone_ControlsVisibleWithoutScrolling', (tester) async {
    final screen = TestScreens.phone;
    useScreen(tester, screen);

    for (final level in pathFinderBaseLevels) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text(PathFinderTexts.title)),
            body: PathFinderView(key: UniqueKey(), level: level, onCompleted: (_) {}),
          ),
        ),
      );
      await tester.pump();

      final tooltips = [
        PathFinderTexts.run,
        PathFinderTexts.hint,
        PathFinderTexts.clear,
        for (final direction in Direction.values) PathFinderTexts.addCommand(direction),
      ];
      for (final tooltip in tooltips) {
        expect(tester.getRect(find.byTooltip(tooltip)).bottom, lessThanOrEqualTo(screen.height));
      }
      expect(tester.getRect(find.byType(BoardView)).bottom, lessThanOrEqualTo(screen.height));
    }
  });

  testWidgets('PathFinderView_LeavesMap_ShowsEdgeMessage', (tester) async {
    useScreen(tester, TestScreens.phone);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PathFinderView(level: pathFinderBaseLevels.first, onCompleted: (_) {}),
        ),
      ),
    );

    await tester.tap(find.byTooltip(PathFinderTexts.addCommand(Direction.left)));
    await tester.pump();
    await tester.tap(find.byTooltip(PathFinderTexts.run));
    await waitForAnimations(tester);

    expect(find.text(PathFinderTexts.blocked(Obstacle.edge, 0)), findsOneWidget);
  });

  for (final name in ['TabletPortrait', 'TabletLandscape']) {
    testWidgets('PathFinderView_On${name}_UsesLargerButtonsAndBoardThanPhone', (tester) async {
      await _pumpLevel(tester, TestScreens.phone);
      final phoneButton = tester.getSize(find.byTooltip(PathFinderTexts.run));
      final phoneBoard = tester.getSize(find.byType(BoardView));

      await _pumpLevel(tester, TestScreens.all[name]!);
      final tabletButton = tester.getSize(find.byTooltip(PathFinderTexts.run));
      final tabletBoard = tester.getSize(find.byType(BoardView));

      expect(tabletButton.width, greaterThan(phoneButton.width));
      expect(tabletBoard.width, greaterThan(phoneBoard.width));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('PathFinderView_OnLandscapeTablet_ControlsSitNextToBoard', (tester) async {
    await _pumpLevel(tester, TestScreens.tabletLandscape);

    final board = tester.getRect(find.byType(BoardView));
    final controls = tester.getRect(find.byType(PathFinderControls));
    final screenWidth = TestScreens.tabletLandscape.width;

    // Harita ile kontroller ortalanmış bir grup: sol ve sağ boşluklar birbirine yakın.
    expect(board.left - 16, closeTo(screenWidth - 16 - controls.right, 8));
    expect(controls.left - board.right, lessThan(48));
  });

  /// Seviye seçim ekranını açar ve ilk [groups] grubun ilk seviye satırının konumunu döndürür.
  Future<List<Rect>> groupRows(WidgetTester tester, Size size, {int groups = 4}) async {
    useScreen(tester, size);
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, PathFinderTexts.title);
    expect(tester.takeException(), isNull);
    return [
      for (final label in ['Seviye 1', 'Seviye 6, kilitli', 'Seviye 11, kilitli', 'Seviye 16, kilitli'].take(groups))
        tester.getRect(find.bySemanticsLabel(label)),
    ];
  }

  testWidgets('LevelSelectScreen_OnLandscapeTablet_ShowsGroupsInFourColumns', (tester) async {
    final [easy, medium, hard, expert] = await groupRows(tester, TestScreens.tabletLandscape);

    // Bütün gruplar yan yana durur; kilitli gruplarda uyarı olduğu için satırları biraz aşağıda başlar.
    for (final (left, right) in [(easy, medium), (medium, hard), (hard, expert)]) {
      expect(right.left, greaterThan(left.right));
    }
    expect(hard.top, medium.top);
    expect(expert.top, medium.top);
    expect(medium.top, lessThan(TestScreens.tabletLandscape.height / 2));
    expect(easy.height, greaterThan(64));
  });

  testWidgets('LevelSelectScreen_OnPortraitTablet_ShowsGroupsInTwoColumns', (tester) async {
    final [easy, medium, hard, _] = await groupRows(tester, TestScreens.tabletPortrait);

    expect(medium.top, lessThan(easy.bottom));
    expect(medium.left, greaterThan(easy.right));
    expect(hard.left, easy.left);
    expect(hard.top, greaterThan(medium.bottom));
  });

  testWidgets('LevelSelectScreen_OnPhone_ShowsGroupsInOneColumn', (tester) async {
    final [easy, medium] = await groupRows(tester, TestScreens.phone, groups: 2);

    expect(medium.left, easy.left);
    expect(medium.top, greaterThan(easy.bottom));
    expect(easy.height, greaterThanOrEqualTo(64));
  });
}
