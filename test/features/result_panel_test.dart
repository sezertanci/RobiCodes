import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/result_panel.dart';
import 'package:robi_codes/features/play/widgets/confetti.dart';
import 'package:robi_codes/features/progress/star_rule.dart';

import '../support/test_l10n.dart';
import '../support/fakes.dart';

void main() {
  testWidgets('ResultPanel_TwoStars_PlaysLevelCompleteOnceAndOnlyEarnedStars', (tester) async {
    // Arrange
    final feedback = RecordingGameFeedback();

    // Act
    await tester.pumpWidget(localizedApp(ResultPanel(stars: 2, feedback: feedback, onBackToLevels: () {})));
    await tester.pump(ResultPanel.firstStarDelay);
    for (var i = 0; i < StarRule.perfect; i++) {
      await tester.pump(ResultPanel.starInterval);
    }
    await tester.pumpAndSettle();

    // Assert
    expect(feedback.levelCompleteCount, 1);
    expect(feedback.stars, [0, 1]);
  });

  testWidgets('ResultPanel_Opened_ShowsConfettiOverPanel', (tester) async {
    // Act
    await tester.pumpWidget(_panel());
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(_confettiPaint, findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('ResultPanel_ReduceMotion_ShowsNoConfettiAndOpensAtFullSize', (tester) async {
    // Act
    await tester.pumpWidget(_panel(reduceMotion: true));
    await tester.pump();

    // Assert
    expect(_confettiPaint, findsNothing);
    final scale = tester.widget<Transform>(
      find.ancestor(of: find.byType(Card), matching: find.byType(Transform)).first,
    );
    expect(scale.transform.getMaxScaleOnAxis(), 1);
    await tester.pumpAndSettle();
  });
}

/// Sonuç panelini verilen hareket azaltma tercihiyle açar.
Widget _panel({bool reduceMotion = false}) => localizedApp(
  MediaQuery(
    data: MediaQueryData(size: const Size(400, 800), disableAnimations: reduceMotion),
    child: ResultPanel(stars: StarRule.perfect, feedback: const SilentGameFeedback(), onBackToLevels: () {}),
  ),
);

Finder get _confettiPaint => find.descendant(of: find.byType(Confetti), matching: find.byType(CustomPaint));
