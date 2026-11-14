import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/play_timings.dart';
import 'package:robi_codes/features/play/widgets/idle_sway.dart';

/// Sallanan kutunun o anki dönüşümü.
Matrix4 _transformOf(WidgetTester tester) =>
    tester.widget<Transform>(find.descendant(of: find.byType(IdleSway), matching: find.byType(Transform))).transform;

Widget _sway({required bool reduceMotion}) => MediaQuery(
  data: MediaQueryData(disableAnimations: reduceMotion),
  child: const IdleSway(child: SizedBox.square(dimension: 64)),
);

void main() {
  testWidgets('IdleSway_QuarterCycle_TiltsAndStretches', (tester) async {
    // Arrange
    await tester.pumpWidget(_sway(reduceMotion: false));

    // Act
    await tester.pump(PlayTimings.robotIdle ~/ 4);

    // Assert
    final transform = _transformOf(tester);
    expect(transform, isNot(Matrix4.identity()));
    expect(transform.entry(1, 1), greaterThan(1), reason: 'Robot nefes alırken boyu uzamalı.');
    expect(tester.hasRunningAnimations, isTrue, reason: 'Sallanma sürekli olmalı.');
  });

  testWidgets('IdleSway_ReduceMotion_StaysStill', (tester) async {
    // Arrange
    await tester.pumpWidget(_sway(reduceMotion: true));

    // Act
    await tester.pump(PlayTimings.robotIdle ~/ 4);

    // Assert
    expect(_transformOf(tester), Matrix4.identity());
    expect(tester.hasRunningAnimations, isFalse);
  });
}
