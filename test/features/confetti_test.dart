import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_theme.dart';
import 'package:robi_codes/features/play/widgets/confetti.dart';

/// Konfetiyi verilen hareket azaltma tercihiyle tam ekran çizer.
Widget _host({bool reduceMotion = false}) => MediaQuery(
  data: MediaQueryData(size: const Size(400, 800), disableAnimations: reduceMotion),
  child: const Directionality(textDirection: TextDirection.ltr, child: Confetti()),
);

Finder get _paint => find.descendant(of: find.byType(Confetti), matching: find.byType(CustomPaint));

void main() {
  test('ConfettiPiece_FirstPieces_MatchWebFormula', () {
    // Act
    final pieces = [for (var i = 0; i < 5; i++) ConfettiPiece.at(i)];

    // Assert
    expect([for (final piece in pieces) piece.left], [0, 0.37, 0.74, 0.11, 0.48]);
    expect([for (final piece in pieces) piece.delay.inMilliseconds], [0, 180, 360, 540, 720]);
    expect([for (final piece in pieces) piece.turns], [-1.5, 1.5, -1.5, 1.5, -1.5]);
    expect(
      [for (final piece in pieces) piece.color],
      [AppColors.blue, AppColors.green, AppColors.red, AppColors.purple, AppColors.yellow],
    );
    expect([for (final piece in pieces) piece.isRound], [false, false, false, true, false]);
  });

  test('totalDuration_LastDelayedPiece_IncludesItsDelay', () {
    // Act
    final total = Confetti.totalDuration;

    // Assert
    expect(total, const Duration(milliseconds: 3200 + 6 * 180));
  });

  testWidgets('Confetti_Default_FallsOnceThenDisappears', (tester) async {
    // Act
    await tester.pumpWidget(_host());
    await tester.pump(const Duration(seconds: 1));

    // Assert
    expect(_paint, findsOneWidget);
    await tester.pumpAndSettle();
    expect(_paint, findsNothing);
  });

  testWidgets('Confetti_ReduceMotion_ShowsNothing', (tester) async {
    // Act
    await tester.pumpWidget(_host(reduceMotion: true));

    // Assert
    expect(_paint, findsNothing);
  });
}
