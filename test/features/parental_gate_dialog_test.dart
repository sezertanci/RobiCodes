import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/parental_gate/parental_gate_dialog.dart';
import 'package:robi_codes/features/parental_gate/parental_gate_trial.dart';
import 'package:robi_codes/features/parental_gate/parental_question.dart';
import 'package:robi_codes/features/parental_gate/protected_action_runner.dart';
import 'package:robi_codes/features/settings/settings_dialog.dart';
import 'package:robi_codes/features/sound/sound_player.dart';
import 'package:robi_codes/features/sound/sound_service.dart';

import '../support/fakes.dart';
import '../support/ui_test_helpers.dart';

const _seed = 11;
const _openLabel = 'Aç';

/// Pencerenin kullandığıyla aynı tohumdan üretilen sorular; testin cevabı bilmesini sağlar.
ParentalQuestionGenerator _twin() => ParentalQuestionGenerator(Random(_seed));

/// Telefonun yatay tutulduğu en alçak ekran.
const _phoneLandscape = Size(690, 360);

/// Pencerenin döndürdüğü sonuç; pencere kapanınca dolar.
final class _Outcome {
  bool? value;
}

/// Pencereyi açar; sonucu dönen nesneye yazılır.
Future<_Outcome> _openDialog(WidgetTester tester) async {
  final outcome = _Outcome();
  final questions = _twin();
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () async =>
                  outcome.value = await ParentalGateDialog.show(context, ParentalAction.purchase, questions),
              child: const Text(_openLabel),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text(_openLabel));
  await tester.pumpAndSettle();
  return outcome;
}

Finder _key(String digit) => find.widgetWithText(FilledButton, digit);

Future<void> _press(WidgetTester tester, Finder key) async {
  await tester.ensureVisible(key);
  await tester.tap(key);
  await tester.pump();
}

Future<void> _enter(WidgetTester tester, int answer) async {
  for (final digit in '$answer'.split('')) {
    await _press(tester, _key(digit));
  }
  await _press(tester, find.byIcon(Icons.check_rounded));
  await tester.pumpAndSettle();
}

Widget _settings(ProtectedActionRunner runner) => MaterialApp(
  home: Scaffold(
    body: SettingsDialog(
      sound: SoundService(store: InMemoryKeyValueStore(), player: const SilentSoundPlayer()),
      protectedActions: runner,
    ),
  ),
);

void main() {
  group('ParentalGateDialog', () {
    testWidgets('show_CorrectAnswer_ReturnsTrue', (tester) async {
      // Arrange
      final outcome = await _openDialog(tester);
      final question = _twin().next();
      expect(find.text(question.text), findsOneWidget);
      expect(find.textContaining(ParentalAction.purchase.description), findsOneWidget);

      // Act
      await _enter(tester, question.answer);

      // Assert
      expect(find.byType(ParentalGateDialog), findsNothing);
      expect(outcome.value, isTrue);
    });

    testWidgets('show_WrongAnswer_LocksKeysThenAsksNewQuestion', (tester) async {
      // Arrange
      final outcome = await _openDialog(tester);
      final twin = _twin();
      final first = twin.next();
      final second = twin.next();

      // Act
      await _enter(tester, first.answer + 1);

      // Assert: pencere açık kalır, yeni soru gelir, tuşlar bekleme süresince kilitlidir.
      expect(find.byType(ParentalGateDialog), findsOneWidget);
      expect(find.text(second.text), findsOneWidget);
      expect(find.text(ParentalGateDialog.wrongAnswer), findsOneWidget);
      expect(tester.widget<FilledButton>(_key('1')).onPressed, isNull);

      await tester.pump(ParentalGateDialog.wrongAnswerDelay);
      expect(find.text(ParentalGateDialog.wrongAnswer), findsNothing);
      expect(tester.widget<FilledButton>(_key('1')).onPressed, isNotNull);

      // Eski sorunun cevabı artık geçmez; yeni sorunun cevabı geçer.
      await _enter(tester, second.answer);
      expect(outcome.value, isTrue);
    });

    testWidgets('show_OldAnswerAfterNewQuestion_IsRejected', (tester) async {
      // Arrange
      final outcome = await _openDialog(tester);
      final first = _twin().next();
      await _enter(tester, first.answer + 1);
      await tester.pump(ParentalGateDialog.wrongAnswerDelay);

      // Act
      await _enter(tester, first.answer);

      // Assert
      expect(find.byType(ParentalGateDialog), findsOneWidget);
      expect(outcome.value, isNull);
      await tester.pump(ParentalGateDialog.wrongAnswerDelay);
    });

    testWidgets('show_CancelPressed_ReturnsFalse', (tester) async {
      // Arrange
      final outcome = await _openDialog(tester);

      // Act
      await tester.tap(find.text(ParentalGateDialog.cancelLabel));
      await tester.pumpAndSettle();

      // Assert
      expect(outcome.value, isFalse);
    });

    testWidgets('show_TappedOutside_ReturnsFalse', (tester) async {
      // Arrange
      final outcome = await _openDialog(tester);

      // Act
      await tester.tapAt(const Offset(4, 4));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ParentalGateDialog), findsNothing);
      expect(outcome.value, isFalse);
    });

    testWidgets('show_DeletePressed_RemovesLastDigit', (tester) async {
      // Arrange
      await _openDialog(tester);
      await _press(tester, _key('4'));
      await _press(tester, _key('2'));

      // Act
      await _press(tester, find.byIcon(Icons.backspace_rounded));

      // Assert
      expect(find.bySemanticsLabel(ParentalGateDialog.answerLabel), findsOneWidget);
      expect(tester.getSemantics(find.bySemanticsLabel(ParentalGateDialog.answerLabel)).value, '4');
    });

    for (final MapEntry(key: name, value: size) in {...TestScreens.all, 'PhoneLandscape': _phoneLandscape}.entries) {
      testWidgets('ParentalGateDialog_On${name}_AnswersWithoutOverflow', (tester) async {
        // Arrange
        useScreen(tester, size);
        final outcome = await _openDialog(tester);

        // Act
        await _enter(tester, _twin().next().answer);

        // Assert
        expect(tester.takeException(), isNull);
        expect(outcome.value, isTrue);
      });
    }
  });

  group('ParentalGateTrial', () {
    testWidgets('SettingsDialog_DebugBuild_ShowsTrialEntry', (tester) async {
      // Act
      await tester.pumpWidget(_settings(const ProtectedActionRunner(LockedParentalGate())));

      // Assert
      expect(find.text(ParentalGateTrial.label), findsOneWidget);
    });

    testWidgets('trial_GateApproves_RunsHarmlessActionOnly', (tester) async {
      // Arrange
      final gate = FakeParentalGate(approves: true);
      await tester.pumpWidget(_settings(ProtectedActionRunner(gate)));

      // Act
      await tester.tap(find.text(ParentalGateTrial.label));
      await tester.pumpAndSettle();

      // Assert
      expect(gate.requests, [ParentalGateTrial.action]);
      expect(find.text(ParentalGateTrial.passed), findsOneWidget);
    });

    testWidgets('trial_GateRejects_ShowsBlocked', (tester) async {
      // Arrange
      await tester.pumpWidget(_settings(ProtectedActionRunner(FakeParentalGate(approves: false))));

      // Act
      await tester.tap(find.text(ParentalGateTrial.label));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(ParentalGateTrial.blocked), findsOneWidget);
    });

    testWidgets('production_TrialFromSettings_OpensQuestionDialogAndCancelBlocks', (tester) async {
      // Arrange
      await tester.pumpWidget(RobiCodesApp(services: AppServices.production(InMemoryKeyValueStore())));
      await tester.tap(find.byTooltip(SettingsDialog.title));
      await settle(tester);

      // Act
      await tester.tap(find.text(ParentalGateTrial.label));
      await settle(tester);

      // Assert
      expect(find.byType(ParentalGateDialog), findsOneWidget);
      await tester.tap(find.text(ParentalGateDialog.cancelLabel));
      await settle(tester);
      expect(find.byType(ParentalGateDialog), findsNothing);
      expect(find.text(ParentalGateTrial.blocked), findsOneWidget);
    });
  });
}
