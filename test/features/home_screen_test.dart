import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_assets.dart';
import 'package:robi_codes/app/app_background.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/app_theme.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/app/widgets/top_bar.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/features/home/game_card.dart';
import 'package:robi_codes/features/home/home_screen.dart';
import 'package:robi_codes/features/play/level_screen.dart';
import 'package:robi_codes/features/play/level_select_screen.dart';
import 'package:robi_codes/features/play/widgets/level_button.dart';
import 'package:robi_codes/games/game_registry.dart';

import '../support/fakes.dart';
import '../support/test_l10n.dart';
import '../support/ui_test_helpers.dart';

/// Yol Bul oyununun test dilindeki adı.
final _pathFinder = texts.gamePathFinderTitle;

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
    expect(_inCard(_pathFinder, texts.homeLevels(1, levels)), findsOneWidget);
    expect(_inCard(_pathFinder, '3'), findsOneWidget);
    expect(find.text(texts.gameCommandOrderTitle), findsOneWidget);
    expect(find.text(texts.gameIfThenTitle), findsOneWidget);
    expect(find.text(texts.gameRepeatTitle), findsOneWidget);
    final playable = services.catalog.games.where((game) => services.games.isPlayable(game.id)).length;
    expect(find.text(texts.gameBugHunterTitle), findsOneWidget);
    expect(find.text(texts.gameMyCommandTitle), findsOneWidget);
    expect(find.text(texts.homeLocked), findsNWidgets(2));
    expect(playable, 6);
    expect(find.text(texts.homeComingSoon), findsNWidgets(services.catalog.games.length - playable));
  });

  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('HomeScreen_On${name}_RendersCardsWithoutOverflow', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = AppServices.production(InMemoryKeyValueStore());

      // Act
      await tester.pumpWidget(RobiCodesApp(services: services));
      await settle(tester);

      // Assert
      for (final game in services.catalog.games) {
        await tester.scrollUntilVisible(find.text(game.title(texts)), 200, scrollable: find.byType(Scrollable).first);
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('HomeScreen_PaidGameNotOwned_ShowsPriceInsteadOfLevels', (tester) async {
    // Arrange
    const price = '₺49,99';
    final catalog = TestCatalog.withPaidGame();
    final services = AppServices(
      catalog: catalog,
      games: GameRegistry([const FakeGameModule(TestCatalog.gameId), const FakeGameModule(TestCatalog.paidGameId)]),
      store: InMemoryKeyValueStore(),
      purchaseGateway: FakePurchaseGateway()..prices = {TestCatalog.paidProduct: price},
    );
    final title = catalog.findGame(TestCatalog.paidGameId)!.title(texts);

    // Act
    await tester.pumpWidget(RobiCodesApp(services: services));
    expect(_inCard(title, texts.homeLocked), findsOneWidget);
    await services.listings.load();
    await settle(tester);

    // Assert
    expect(_inCard(title, price), findsOneWidget);
    expect(_inCard(title, texts.homeLevels(0, 4)), findsNothing);
  });

  testWidgets('GameCard_NotPlayable_ShowsComingSoonInsteadOfLevels', (tester) async {
    // Act
    await tester.pumpWidget(
      localizedApp(
        const Scaffold(
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
    expect(find.text(texts.homeComingSoon), findsOneWidget);
    expect(find.text(texts.homeLevels(0, 10)), findsNothing);
  });

  testWidgets('PageRoute_PushedScreen_HasItsOwnBackground', (tester) async {
    // Arrange
    final services = AppServices.production(InMemoryKeyValueStore());
    await tester.pumpWidget(RobiCodesApp(services: services));
    expect(find.byType(AppBackground), findsOneWidget);

    // Act
    await openLevelSelect(tester, _pathFinder);

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
    expect(find.bySemanticsLabel(texts.appTitle), findsOneWidget);
    expect(find.text(texts.homeTagline), findsOneWidget);
    expect(find.bySemanticsLabel(texts.commonStars(5)), findsOneWidget);
  });

  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('TopBar_On${name}_LevelSelectAndLevelRenderWithoutOverflow', (tester) async {
      // Arrange
      useScreen(tester, size);
      await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
      await openLevelSelect(tester, _pathFinder);

      // Act
      await tapVisible(tester, find.byType(LevelButton).first);
      await settle(tester);

      // Assert
      expect(find.byType(LevelScreen), findsOneWidget);
      expect(find.byType(TopBar), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('TopBar_LevelOnPhone_ShowsOnlyIconAndKeepsTitleForScreenReader', (tester) async {
    // Arrange
    useScreen(tester, TestScreens.phone);
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, _pathFinder);

    // Act
    await tapVisible(tester, find.byType(LevelButton).first);
    await settle(tester);

    // Assert
    final inTopBar = find.descendant(of: find.byType(TopBar), matching: find.text(_pathFinder));
    expect(inTopBar, findsNothing);
    expect(find.bySemanticsLabel(_pathFinder), findsOneWidget);
  });

  testWidgets('TopBar_LevelOnTablet_ShowsTitleText', (tester) async {
    // Arrange
    useScreen(tester, TestScreens.tabletPortrait);
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, _pathFinder);

    // Act
    await tapVisible(tester, find.byType(LevelButton).first);
    await settle(tester);

    // Assert
    final inTopBar = find.descendant(of: find.byType(TopBar), matching: find.text(_pathFinder));
    expect(inTopBar, findsOneWidget);
  });

  testWidgets('TopBar_LevelOnSmallTablet_WrapsTitleToTwoLines', (tester) async {
    // Arrange
    useScreen(tester, TestScreens.smallTablet);
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, _pathFinder);

    // Act
    await tapVisible(tester, find.byType(LevelButton).first);
    await settle(tester);

    // Assert
    final title = find.descendant(of: find.byType(TopBar), matching: find.text(_pathFinder));
    expect(tester.widget<Text>(title).maxLines, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('TopBar_ShortTitleOnSmallTablet_KeepsTitleOnOneLine', (tester) async {
    // Arrange
    const shortTitle = 'Yol';
    useScreen(tester, TestScreens.smallTablet);

    // Act
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: TopBar(title: shortTitle, icon: AppAssets.gamePath, backLabel: texts.commonBackToHome, dense: true),
        ),
      ),
    );

    // Assert
    expect(tester.widget<Text>(find.text(shortTitle)).maxLines, 1);
  });

  testWidgets('TopBar_BackPressed_ReturnsToPreviousScreen', (tester) async {
    // Arrange
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, _pathFinder);

    // Act
    await tester.tap(findButton(texts.commonBackToHome));
    await settle(tester);

    // Assert
    expect(find.byType(LevelSelectScreen), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('TopBar_HomePressedOnLevel_ReturnsToHomeScreen', (tester) async {
    // Arrange
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
    await openLevelSelect(tester, _pathFinder);
    await tapVisible(tester, find.byType(LevelButton).first);
    await settle(tester);

    // Act
    await tester.tap(findButton(texts.commonBackToHome));
    await settle(tester);

    // Assert
    expect(find.byType(LevelScreen), findsNothing);
    expect(find.byType(LevelSelectScreen), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('TopBar_LevelSelect_HasNoSeparateHomeButton', (tester) async {
    // Arrange
    await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));

    // Act
    await openLevelSelect(tester, _pathFinder);

    // Assert
    expect(findButton(texts.commonBackToHome), findsOneWidget);
  });

  testWidgets('TopBar_LongTitleOnPhone_ShortensTitleWithoutOverflow', (tester) async {
    // Arrange
    useScreen(tester, TestScreens.phone);

    // Act
    await tester.pumpWidget(
      localizedApp(
        Scaffold(
          body: TopBar(
            title: 'Çok uzun bir oyun başlığı ' * 4,
            icon: AppAssets.gamePath,
            backLabel: texts.commonBackToHome,
            actions: const [SizedBox(width: 120, height: 40)],
          ),
        ),
      ),
    );

    // Assert
    expect(tester.takeException(), isNull);
  });
}
