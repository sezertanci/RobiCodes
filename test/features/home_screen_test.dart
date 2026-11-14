import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_assets.dart';
import 'package:robi_codes/app/app_background.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/app_texts.dart';
import 'package:robi_codes/app/app_theme.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/app/widgets/top_bar.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/features/home/game_card.dart';
import 'package:robi_codes/features/home/home_header.dart';
import 'package:robi_codes/features/home/home_screen.dart';
import 'package:robi_codes/features/play/level_screen.dart';
import 'package:robi_codes/features/play/level_select_screen.dart';
import 'package:robi_codes/features/play/widgets/level_button.dart';
import 'package:robi_codes/games/path_finder/path_finder_texts.dart';

import '../support/fakes.dart';
import '../support/ui_test_helpers.dart';

Finder _inCard(String gameTitle, String text) => find.descendant(
  of: find.ancestor(of: find.text(gameTitle), matching: find.byType(GameCard)),
  matching: find.text(text),
);

void main() {
  testWidgets('HomeScreen_DefaultCatalog_ShowsEveryGameWithProgress', (tester) async {
    // Arrange
    final services = AppServices.production(InMemoryKeyValueStore());
    final packId = basePackId(GameIds.pathFinder);
    await services.progress.completeLevel(packId, 1, 3);
    final levels = services.entitlements.playablePacksOf(GameIds.pathFinder).levelCount;

    // Act
    await tester.pumpWidget(RobiCodesApp(services: services));

    // Assert
    expect(find.byType(GameCard), findsNWidgets(services.catalog.games.length));
    expect(_inCard(PathFinderTexts.title, GameCard.levelsText(1, levels)), findsOneWidget);
    expect(_inCard(PathFinderTexts.title, '3'), findsOneWidget);
    expect(find.text('Komutları Sırala'), findsOneWidget);
    expect(find.text('Eğer Böyleyse'), findsOneWidget);
    expect(find.text('Tekrar Et'), findsOneWidget);
    final playable = services.catalog.games.where((game) => services.games.isPlayable(game.id)).length;
    expect(playable, 4);
    expect(find.text(GameCard.comingSoonLabel), findsNWidgets(services.catalog.games.length - playable));
  });

  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('HomeScreen_On${name}_RendersCardsWithoutOverflow', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());

      // Act
      await tester.pumpWidget(RobiCodesApp(services: services));
      await tester.pumpAndSettle();

      // Assert
      for (final game in services.catalog.games) {
        await tester.scrollUntilVisible(find.text(game.title), 200, scrollable: find.byType(Scrollable).first);
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('GameCard_NotPlayable_ShowsComingSoonInsteadOfLevels', (tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 280,
            child: GameCard(
              title: 'Oyun',
              description: 'Açıklama',
              tone: AppTones.blue,
              icon: AppAssets.gamePath,
              completed: 0,
              levels: 10,
              stars: 0,
              isPlayable: false,
            ),
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(GameCard.comingSoonLabel), findsOneWidget);
    expect(find.text(GameCard.levelsText(0, 10)), findsNothing);
  });

  testWidgets('PageRoute_PushedScreen_HasItsOwnBackground', (tester) async {
    // Arrange
    final services = AppServices.production(InMemoryKeyValueStore());
    await tester.pumpWidget(RobiCodesApp(services: services));
    expect(find.byType(AppBackground), findsOneWidget);

    // Act
    await openLevelSelect(tester, PathFinderTexts.title);

    // Assert: ana ekran alttaki rotada kalır, seviye seçim ekranı kendi arka planıyla çizilir.
    expect(find.ancestor(of: find.byType(LevelSelectScreen), matching: find.byType(AppBackground)), findsOneWidget);
  });

  testWidgets('HomeHeader_SomeLevelsDone_ShowsLogoTaglineAndTotalStars', (tester) async {
    // Arrange
    final services = AppServices.production(InMemoryKeyValueStore());
    await services.progress.completeLevel(basePackId(GameIds.pathFinder), 1, 3);
    await services.progress.completeLevel(basePackId(GameIds.repeat), 1, 2);

    // Act
    await tester.pumpWidget(RobiCodesApp(services: services));

    // Assert
    expect(find.bySemanticsLabel(RobiCodesApp.title), findsOneWidget);
    expect(find.text(HomeHeader.tagline), findsOneWidget);
    expect(find.bySemanticsLabel(AppTexts.stars(5)), findsOneWidget);
  });

  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('TopBar_On${name}_LevelSelectAndLevelRenderWithoutOverflow', (tester) async {
      // Arrange
      useScreen(tester, size);
      await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
      await openLevelSelect(tester, PathFinderTexts.title);

      // Act
      await tapVisible(tester, find.byType(LevelButton).first);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(LevelScreen), findsOneWidget);
      expect(find.byType(TopBar), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('TopBar_BackPressed_ReturnsToPreviousScreen', (tester) async {
    // Arrange
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, PathFinderTexts.title);

    // Act
    await tester.tap(findButton(AppTexts.backToHome));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(LevelSelectScreen), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('TopBar_LongTitleOnPhone_ShortensTitleWithoutOverflow', (tester) async {
    // Arrange
    useScreen(tester, TestScreens.phone);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TopBar(
            title: 'Çok uzun bir oyun başlığı ' * 4,
            icon: AppAssets.gamePath,
            backLabel: AppTexts.backToHome,
            actions: const [SizedBox(width: 120, height: 40)],
          ),
        ),
      ),
    );

    // Assert
    expect(tester.takeException(), isNull);
  });
}
