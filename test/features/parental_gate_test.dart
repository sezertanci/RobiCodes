import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/cloud_save/cloud_sync_service.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/parental_gate/parental_question.dart';
import 'package:robi_codes/features/parental_gate/protected_action_runner.dart';
import 'package:robi_codes/features/progress/progress_repository.dart';
import 'package:robi_codes/features/store/entitlement_service.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';

import '../support/fakes.dart';
import '../support/parental_approvals.dart';

/// Sahte kapılar bağlamı kullanmadığı için ağaca bağlanmamış bir öğe yeter.
final BuildContext _context = const SizedBox().createElement();

/// "Yirmi yedi çarpı sekiz kaç eder?" metnindeki iki sayıyı yazıdan geri çevirir.
(int, int) _parseQuestion(String text) {
  final byWords = {for (var number = 1; number < 100; number++) TurkishNumbers.toWords(number): number};
  final match = RegExp(r'^(.+) çarpı (.+) kaç eder\?$').firstMatch(text.toLowerCase())!;
  return (byWords[match.group(1)]!, byWords[match.group(2)]!);
}

void main() {
  group('ParentalQuestionGenerator', () {
    test('toWords_SampleNumbers_ReturnsTurkishSpelling', () {
      expect(TurkishNumbers.toWords(9), 'dokuz');
      expect(TurkishNumbers.toWords(12), 'on iki');
      expect(TurkishNumbers.toWords(20), 'yirmi');
      expect(TurkishNumbers.toWords(27), 'yirmi yedi');
      expect(TurkishNumbers.toWords(99), 'doksan dokuz');
    });

    test('next_ManyQuestions_AnswerMatchesWrittenNumbersWithinRange', () {
      // Arrange
      final generator = ParentalQuestionGenerator(Random(7));

      for (var i = 0; i < 200; i++) {
        // Act
        final question = generator.next();

        // Assert
        final (first, second) = _parseQuestion(question.text);
        expect(question.answer, first * second);
        expect(first, inInclusiveRange(12, 29));
        expect(second, inInclusiveRange(3, 9));
        expect(question.text[0], question.text[0].toUpperCase());
        expect('${question.answer}'.length, lessThanOrEqualTo(ParentalQuestionGenerator.maxAnswerDigits));
      }
    });

    test('next_CalledRepeatedly_NeverRepeatsPreviousQuestion', () {
      // Arrange
      final generator = ParentalQuestionGenerator(Random(3));
      var previous = generator.next();

      for (var i = 0; i < 500; i++) {
        // Act
        final current = generator.next();

        // Assert
        expect(current.text, isNot(previous.text));
        previous = current;
      }
    });
  });

  group('ParentalApproval', () {
    test('consume_SameActionTwice_OnlyFirstSucceeds', () async {
      // Arrange
      final approval = await grantApproval(ParentalAction.purchase);

      // Act & Assert
      expect(approval.consume(ParentalAction.purchase), isTrue);
      expect(approval.consume(ParentalAction.purchase), isFalse);
    });

    test('consume_OtherAction_Fails', () async {
      // Arrange
      final approval = await grantApproval(ParentalAction.enableCloudSync);

      // Act & Assert
      expect(approval.consume(ParentalAction.purchase), isFalse);
      expect(approval.consume(ParentalAction.enableCloudSync), isTrue);
    });
  });

  group('ProtectedActionRunner', () {
    test('run_CalledTwice_AsksGateEachTime', () async {
      // Arrange
      final gate = FakeParentalGate(approves: true);
      final runner = ProtectedActionRunner(gate);

      // Act
      await runner.run(_context, ParentalAction.purchase, (_) async => true);
      await runner.run(_context, ParentalAction.purchase, (_) async => true);

      // Assert
      expect(gate.requests, [ParentalAction.purchase, ParentalAction.purchase]);
    });

    test('run_AfterRestartWithLockedGate_EarlierApprovalDoesNotCarryOver', () async {
      // Arrange: önceki oturumda onay alınıp kullanıldı.
      await ProtectedActionRunner(FakeParentalGate(approves: true))
          .run(_context, ParentalAction.purchase, (_) async {});
      const restarted = ProtectedActionRunner(LockedParentalGate());

      // Act
      final results = [
        for (final action in ParentalAction.values) await restarted.run(_context, action, (_) async => true),
      ];

      // Assert
      expect(results, everyElement(isNull));
    });
  });

  group('EntitlementService protection', () {
    late FakePurchaseGateway gateway;
    late EntitlementService service;

    setUp(() {
      gateway = FakePurchaseGateway();
      service = EntitlementService(catalog: TestCatalog.build(), gateway: gateway, store: InMemoryKeyValueStore());
    });

    test('purchase_GateRejects_StoreIsNeverReached', () async {
      // Act
      final outcome = await ProtectedActionRunner(FakeParentalGate(approves: false)).run(
        _context,
        ParentalAction.purchase,
        (approval) => service.purchase(TestCatalog.productB, approval: approval),
      );

      // Assert
      expect(outcome, isNull);
      expect(gateway.purchaseRequests, isEmpty);
      expect(service.canPlayPack(TestCatalog.packB), isFalse);
    });

    test('purchase_ApprovalForOtherAction_ReturnsNotApproved', () async {
      // Arrange
      final approval = await grantApproval(ParentalAction.enableCloudSync);

      // Act
      final outcome = await service.purchase(TestCatalog.productB, approval: approval);

      // Assert
      expect(outcome, PurchaseOutcome.notApproved);
      expect(gateway.purchaseRequests, isEmpty);
    });

    test('purchase_ApprovalReused_SecondPurchaseDoesNotReachStore', () async {
      // Arrange
      final approval = await grantApproval(ParentalAction.purchase);
      await service.purchase(TestCatalog.productA, approval: approval);

      // Act
      final outcome = await service.purchase(TestCatalog.productB, approval: approval);

      // Assert
      expect(outcome, PurchaseOutcome.notApproved);
      expect(gateway.purchaseRequests, [TestCatalog.productA]);
    });
  });

  group('CloudSyncService protection', () {
    late CloudSyncService service;

    setUp(() {
      final store = InMemoryKeyValueStore();
      service = CloudSyncService(gateway: FakeCloudSaveGateway(), progress: ProgressRepository(store), store: store);
    });

    test('setEnabled_EnableWithDisableApproval_StaysOff', () async {
      // Act
      final changed = await service.setEnabled(
        enabled: true,
        approval: await grantApproval(ParentalAction.disableCloudSync),
      );

      // Assert
      expect(changed, isFalse);
      expect(service.isEnabled, isFalse);
    });

    test('setEnabled_DisableWithEnableApproval_StaysOn', () async {
      // Arrange
      await service.setEnabled(enabled: true, approval: await grantApproval(ParentalAction.enableCloudSync));

      // Act
      final changed = await service.setEnabled(
        enabled: false,
        approval: await grantApproval(ParentalAction.enableCloudSync),
      );

      // Assert
      expect(changed, isFalse);
      expect(service.isEnabled, isTrue);
    });

    test('setEnabled_DisableWithDisableApproval_TurnsOff', () async {
      // Arrange
      await service.setEnabled(enabled: true, approval: await grantApproval(ParentalAction.enableCloudSync));

      // Act
      final changed = await service.setEnabled(
        enabled: false,
        approval: await grantApproval(ParentalAction.disableCloudSync),
      );

      // Assert
      expect(changed, isTrue);
      expect(service.isEnabled, isFalse);
    });

    test('setEnabled_ApprovalReused_SecondChangeIsRejected', () async {
      // Arrange
      final approval = await grantApproval(ParentalAction.enableCloudSync);
      await service.setEnabled(enabled: true, approval: approval);
      await service.setEnabled(enabled: false, approval: await grantApproval(ParentalAction.disableCloudSync));

      // Act
      final changed = await service.setEnabled(enabled: true, approval: approval);

      // Assert
      expect(changed, isFalse);
      expect(service.isEnabled, isFalse);
    });
  });
}
