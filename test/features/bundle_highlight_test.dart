import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/store/widgets/bundle_highlight.dart';

const _label = 'Avantajlı paket';
const _pulse = Duration(milliseconds: 700);
const _cardKey = Key('card');

Widget _highlight({required bool reduceMotion}) => MediaQuery(
  data: MediaQueryData(disableAnimations: reduceMotion),
  child: const Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: BundleHighlight(
        label: _label,
        child: SizedBox(key: _cardKey, width: 400, height: 240),
      ),
    ),
  ),
);

/// Kartın etrafındaki ışığın o anki gölgesi.
BoxShadow _glowOf(WidgetTester tester) {
  final box = tester.widget<DecoratedBox>(
    find.descendant(of: find.byType(AnimatedBuilder), matching: find.byType(DecoratedBox)).first,
  );
  return (box.decoration as BoxDecoration).boxShadow!.single;
}

void main() {
  testWidgets('BundleHighlight_Pulsing_ChangesGlowAndKeepsRunning', (tester) async {
    // Arrange
    await tester.pumpWidget(_highlight(reduceMotion: false));
    final first = _glowOf(tester).blurRadius;

    // Act
    await tester.pump(_pulse);

    // Assert
    expect(_glowOf(tester).blurRadius, isNot(first), reason: 'Işık nabız gibi değişmeli.');
    expect(tester.hasRunningAnimations, isTrue);
  });

  testWidgets('BundleHighlight_ReduceMotion_GlowStaysStill', (tester) async {
    // Arrange
    await tester.pumpWidget(_highlight(reduceMotion: true));
    final first = _glowOf(tester).blurRadius;

    // Act
    await tester.pump(_pulse);

    // Assert
    expect(_glowOf(tester).blurRadius, first);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('BundleHighlight_Ribbon_ShowsLabelInTopRightCorner', (tester) async {
    // Act
    await tester.pumpWidget(_highlight(reduceMotion: true));

    // Assert
    final card = tester.getRect(find.byKey(_cardKey));
    final label = tester.getCenter(find.text(_label));
    expect(label.dx, greaterThan(card.center.dx));
    expect(label.dy, lessThan(card.center.dy));
    expect(tester.takeException(), isNull);
  });
}
