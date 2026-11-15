import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/parental_gate/number_speller.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/parental_gate/parental_question.dart';
import 'package:robi_codes/features/parental_gate/protected_action_runner.dart';
import 'package:robi_codes/features/store/entitlement_service.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';
import 'package:robi_codes/l10n/l10n.dart';

import '../support/fakes.dart';
import '../support/parental_approvals.dart';
import '../support/test_l10n.dart';

/// Sahte kapılar bağlamı kullanmadığı için ağaca bağlanmamış bir öğe yeter.
final BuildContext _context = const SizedBox().createElement();

/// "Yirmi yedi çarpı sekiz kaç eder?" metnindeki iki sayıyı yazıdan geri çevirir.
(int, int) _parseQuestion(String text) {
  const speller = TurkishNumberSpeller();
  final byWords = {for (var number = 1; number < 100; number++) speller.spell(number): number};
  final match = RegExp(r'^(.+) çarpı (.+) kaç eder\?$').firstMatch(text.toLowerCase())!;
  return (byWords[match.group(1)]!, byWords[match.group(2)]!);
}

void main() {
  group('ParentalQuestionGenerator', () {
    test('spell_TurkishSampleNumbers_ReturnsTurkishSpelling', () {
      const speller = TurkishNumberSpeller();
      expect(speller.spell(9), 'dokuz');
      expect(speller.spell(12), 'on iki');
      expect(speller.spell(20), 'yirmi');
      expect(speller.spell(27), 'yirmi yedi');
      expect(speller.spell(99), 'doksan dokuz');
    });

    test('spell_EnglishSampleNumbers_ReturnsEnglishSpelling', () {
      const speller = EnglishNumberSpeller();
      expect(speller.spell(9), 'nine');
      expect(speller.spell(10), 'ten');
      expect(speller.spell(12), 'twelve');
      expect(speller.spell(20), 'twenty');
      expect(speller.spell(27), 'twenty-seven');
      expect(speller.spell(99), 'ninety-nine');
    });

    test('forLanguage_EverySupportedLanguage_HasOwnSpeller', () {
      for (final locale in AppLocalizations.supportedLocales) {
        expect(NumberSpellers.byLanguage, contains(locale.languageCode));
      }
    });

    test('forLanguage_UnknownLanguage_FallsBackToEnglish', () {
      expect(NumberSpellers.forLanguage('xx').spell(27), 'twenty-seven');
    });

    test('text_EnglishTexts_UsesEnglishSpelling', () {
      final question = ParentalQuestionGenerator(Random(7)).next();
      expect(question.text(texts), isNot(question.text(trTexts)));
      expect(question.text(texts), contains('-'));
    });

    test('next_ManyQuestions_AnswerMatchesWrittenNumbersWithinRange', () {
      // Arrange
      final generator = ParentalQuestionGenerator(Random(7));

      for (var i = 0; i < 200; i++) {
        // Act
        final question = generator.next();

        // Assert
        final (first, second) = _parseQuestion(question.text(trTexts));
        expect(question.answer, first * second);
        expect(first, inInclusiveRange(12, 29));
        expect(second, inInclusiveRange(3, 9));
        expect(question.text(trTexts)[0], question.text(trTexts)[0].toUpperCase());
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
        expect(current.text(trTexts), isNot(previous.text(trTexts)));
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
}
