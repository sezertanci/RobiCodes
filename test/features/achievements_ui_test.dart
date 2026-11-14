import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/features/achievements/achievement.dart';
import 'package:robi_codes/features/achievements/achievements_screen.dart';
import 'package:robi_codes/features/achievements/widgets/achievement_card.dart';
import 'package:robi_codes/features/achievements/widgets/badge_toast.dart';
import 'package:robi_codes/features/achievements/widgets/trophy_celebration.dart';
import 'package:robi_codes/features/home/achievements_button.dart';
import 'package:robi_codes/features/play/widgets/confetti.dart';
import 'package:robi_codes/features/sound/sound_effect.dart';
import 'package:robi_codes/features/sound/sound_player.dart';

import '../support/fakes.dart';
import '../support/ui_test_helpers.dart';

/// Ödüllerin hepsinin kazanılmış ve kilitli hali birlikte görünsün diye ilk paketin ilk seviyesi bitirilir.
Future<AppServices> _servicesWithFirstLevelDone(RecordingSoundPlayer player) async {
  final services = AppServices.production(InMemoryKeyValueStore(), soundPlayer: player);
  await services.progress.completeLevel(services.catalog.packs.first.id, 1, 3);
  return services;
}

AchievementStatus _statusOf(AppServices services, AchievementKind kind) =>
    services.achievements.statuses().firstWhere((status) => status.achievement.kind == kind);

/// İlk çağrıda hata fırlatan, sonra sesleri kaydeden çalıcı; kutlama kuyruğunun hatadan sonra sürdüğünü dener.
final class _FailingOnceSoundPlayer implements SoundPlayer {
  bool _failed = false;

  @override
  Future<void> play(String asset) {
    if (!_failed) {
      _failed = true;
      throw StateError('ses çalınamadı');
    }
    return Future.value();
  }
}

NavigatorState _navigator(WidgetTester tester) => tester.state<NavigatorState>(find.byType(Navigator).first);

void main() {
  late RecordingSoundPlayer player;

  setUp(() => player = RecordingSoundPlayer());

  for (final MapEntry(key: name, value: size) in TestScreens.all.entries) {
    testWidgets('AchievementsScreen_On${name}_RendersEveryRewardWithoutOverflow', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = await _servicesWithFirstLevelDone(player);
      await services.achievements.sync();
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act
      await tester.tap(find.byType(AchievementsButton));
      await settle(tester);

      // Assert
      expect(find.byType(AchievementsScreen), findsOneWidget);
      expect(find.text(AchievementsScreen.summaryText(services.achievements.earnedCount)), findsOneWidget);
      final scrollable = find.byType(Scrollable).last;
      for (final achievement in services.achievements.all) {
        await tester.scrollUntilVisible(find.text(achievement.title), 300, scrollable: scrollable);
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('Celebrations_On${name}_RenderWithoutOverflow', (tester) async {
      // Arrange
      useScreen(tester, size);
      final services = await _servicesWithFirstLevelDone(player);
      await tester.pumpWidget(RobiCodesApp(services: services));

      // Act
      final statuses = services.achievements.statuses();
      final perfect = statuses.firstWhere((status) => status.achievement.symbol.stars > 0);
      services.celebration.show(_navigator(tester), [perfect, _statusOf(services, AchievementKind.trophy)]);
      await tester.pump();
      await tester.pump(BadgeToast.enterDuration);
      expect(find.byType(BadgeToast), findsOneWidget);
      await tester.pump(BadgeToast.totalDuration);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Assert
      expect(find.byType(TrophyCelebration), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('AchievementsButton_Home_ShowsEarnedAndTotalCount', (tester) async {
    // Arrange
    final services = await _servicesWithFirstLevelDone(player);
    await tester.pumpWidget(RobiCodesApp(services: services));
    final total = services.achievements.all.length;
    expect(find.bySemanticsLabel(AchievementsButton.semanticLabel(0, total)), findsOneWidget);

    // Act
    await services.achievements.sync();
    await tester.pump();

    // Assert
    final earned = services.achievements.earnedCount;
    expect(earned, greaterThan(0));
    expect(find.bySemanticsLabel(AchievementsButton.semanticLabel(earned, total)), findsOneWidget);
  });

  testWidgets('AchievementCard_LockedReward_ShowsProgressInsteadOfEarned', (tester) async {
    // Arrange
    final services = await _servicesWithFirstLevelDone(player);
    final locked = services.achievements.statuses().firstWhere((status) => !status.progress.isReached);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AchievementCard(status: locked)),
      ),
    );

    // Assert
    expect(find.text(AchievementCard.earnedLabel), findsNothing);
    expect(find.text('${locked.progress.shownCurrent}/${locked.progress.goal}'), findsOneWidget);
    final label = AchievementCard.semanticLabel(locked.achievement.title, isEarned: false);
    expect(find.bySemanticsLabel(RegExp('^${RegExp.escape(label)}')), findsOneWidget);
  });

  testWidgets('BadgeToast_Shown_PlaysBadgeSoundAndClosesByItself', (tester) async {
    // Arrange
    final services = await _servicesWithFirstLevelDone(player);
    await tester.pumpWidget(RobiCodesApp(services: services));

    // Act
    services.celebration.show(_navigator(tester), [_statusOf(services, AchievementKind.badge)]);
    await tester.pump();
    await tester.pump(BadgeToast.enterDuration);

    // Assert
    expect(find.byType(BadgeToast), findsOneWidget);
    expect(player.played, [SoundEffect.badge.assetFor()]);
    await tester.pump(BadgeToast.totalDuration);
    expect(find.byType(BadgeToast), findsNothing);
  });

  testWidgets('BadgeToast_Tapped_ClosesEarly', (tester) async {
    // Arrange
    final services = await _servicesWithFirstLevelDone(player);
    await tester.pumpWidget(RobiCodesApp(services: services));
    services.celebration.show(_navigator(tester), [_statusOf(services, AchievementKind.badge)]);
    // Bildirim bir karede eklenir, animasyonu sonraki karede başlar; giriş bitince kart yerine oturur.
    await tester.pump();
    await tester.pump();
    await tester.pump(BadgeToast.enterDuration);

    // Act
    await tester.tap(find.byType(BadgeToast));
    // Çıkış animasyonu bir kare sonra başlar, kart da bir kare sonra katmandan kaldırılır. Kayan nokta
    // yuvarlaması yüzünden çıkış süresinin iki katı beklenir; bu yine de görünme süresinden çok kısadır.
    await tester.pump();
    await tester.pump(BadgeToast.leaveDuration * 2);
    await tester.pump();

    // Assert
    expect(find.byType(BadgeToast), findsNothing);
  });

  testWidgets('TrophyCelebration_HarikaPressed_ClosesAndShowsNextReward', (tester) async {
    // Arrange
    final services = await _servicesWithFirstLevelDone(player);
    await tester.pumpWidget(RobiCodesApp(services: services));
    final trophies = services.achievements.statuses().where((s) => s.achievement.kind == AchievementKind.trophy);
    services.celebration.show(_navigator(tester), trophies.take(2).toList());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    // Başlık kontur ve dolgu için iki kez çizilir.
    expect(find.text(trophies.first.achievement.title), findsWidgets);

    // Act
    await tester.tap(find.text(TrophyCelebration.closeLabel));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(find.text(trophies.first.achievement.title), findsNothing);
    expect(find.text(trophies.elementAt(1).achievement.title), findsWidgets);
    expect(player.played, [SoundEffect.trophy.assetFor(), SoundEffect.trophy.assetFor()]);
  });

  testWidgets('TrophyCelebration_Shown_ConfettiKeepsFalling', (tester) async {
    // Arrange
    final services = await _servicesWithFirstLevelDone(player);
    await tester.pumpWidget(RobiCodesApp(services: services));

    // Act
    services.celebration.show(_navigator(tester), [_statusOf(services, AchievementKind.trophy)]);
    await tester.pump();
    await tester.pump(Confetti.totalDuration * 2);

    // Assert
    expect(find.descendant(of: find.byType(Confetti), matching: find.byType(CustomPaint)), findsOneWidget);
  });

  testWidgets('Celebration_FirstRewardFails_ReportsErrorAndShowsNextReward', (tester) async {
    // Arrange
    final services = AppServices.production(InMemoryKeyValueStore(), soundPlayer: _FailingOnceSoundPlayer());
    await services.progress.completeLevel(services.catalog.packs.first.id, 1, 3);
    await tester.pumpWidget(RobiCodesApp(services: services));
    final trophy = _statusOf(services, AchievementKind.trophy);

    // Act
    services.celebration.show(_navigator(tester), [_statusOf(services, AchievementKind.badge), trophy]);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(tester.takeException(), isA<StateError>());
    expect(find.byType(TrophyCelebration), findsOneWidget);
  });
}
