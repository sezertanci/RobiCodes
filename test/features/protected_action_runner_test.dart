import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/parental_gate/protected_action_runner.dart';

import '../support/fakes.dart';

void main() {
  Future<BuildContext> pumpContext(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    return tester.element(find.byType(SizedBox));
  }

  testWidgets('run_GateApproves_RunsAction', (tester) async {
    // Arrange
    final gate = FakeParentalGate(approves: true);
    final context = await pumpContext(tester);

    // Act
    final result = await ProtectedActionRunner(gate).run(context, ParentalAction.purchase, () async => 42);

    // Assert
    expect(result, 42);
    expect(gate.requests, [ParentalAction.purchase]);
  });

  testWidgets('run_GateRejects_DoesNotRunAction', (tester) async {
    // Arrange
    var ran = false;
    final context = await pumpContext(tester);

    // Act
    final result = await ProtectedActionRunner(FakeParentalGate(approves: false))
        .run(context, ParentalAction.enableCloudSync, () async => ran = true);

    // Assert
    expect(result, isNull);
    expect(ran, isFalse);
  });

  testWidgets('run_LockedGate_BlocksEveryAction', (tester) async {
    // Arrange
    final context = await pumpContext(tester);
    const runner = ProtectedActionRunner(LockedParentalGate());

    // Act
    final results = [for (final action in ParentalAction.values) await runner.run(context, action, () async => true)];

    // Assert
    expect(results, everyElement(isNull));
  });
}
