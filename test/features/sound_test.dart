import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/features/settings/settings_dialog.dart';
import 'package:robi_codes/features/sound/sound_effect.dart';
import 'package:robi_codes/features/sound/sound_service.dart';

import '../support/fakes.dart';
import '../support/test_l10n.dart';
import '../support/ui_test_helpers.dart';

void main() {
  late InMemoryKeyValueStore store;
  late RecordingSoundPlayer player;

  SoundService createService() => SoundService(store: store, player: player);

  setUp(() {
    store = InMemoryKeyValueStore();
    player = RecordingSoundPlayer();
  });

  group('SoundService', () {
    test('play_FirstLaunch_PlaysEffect', () {
      // Arrange
      final sound = createService();

      // Act
      sound.play(SoundEffect.correct);

      // Assert
      expect(sound.isEnabled, isTrue);
      expect(player.played, ['assets/sounds/correct.wav']);
    });

    test('play_Disabled_PlaysNothing', () async {
      // Arrange
      final sound = createService();
      await sound.setEnabled(false);

      // Act
      sound.play(SoundEffect.wrong);

      // Assert
      expect(player.played, isEmpty);
    });

    test('setEnabled_False_IsKeptAfterRestart', () async {
      // Arrange
      await createService().setEnabled(false);

      // Act
      final restarted = createService();

      // Assert
      expect(restarted.isEnabled, isFalse);
      expect(jsonDecode(store.values[StorageKeys.sound]!), {'enabled': false});
    });

    test('isEnabled_CorruptRecord_DefaultsToEnabled', () {
      // Arrange
      store.values[StorageKeys.sound] = 'bozuk{';

      // Act
      final sound = createService();

      // Assert
      expect(sound.isEnabled, isTrue);
    });
  });

  group('SoundEffect', () {
    test('assetFor_StarSteps_RaisesStepAndClampsToLastStar', () {
      // Act
      final assets = [
        for (final step in [-1, 0, 1, 2, 5]) SoundEffect.star.assetFor(step),
      ];

      // Assert
      expect(assets, [
        'assets/sounds/star-0.wav',
        'assets/sounds/star-0.wav',
        'assets/sounds/star-1.wav',
        'assets/sounds/star-2.wav',
        'assets/sounds/star-2.wav',
      ]);
    });

    test('assetFor_EveryEffectAndStep_FileExists', () {
      // Arrange
      final assets = {
        for (final effect in SoundEffect.values)
          for (final step in [0, 1, 2]) effect.assetFor(step),
      };

      // Act
      final missing = assets.where((asset) => !File(asset).existsSync());

      // Assert
      expect(missing, isEmpty);
    });
  });

  group('SoundGameFeedback', () {
    test('react_EachMood_PlaysCorrectOrWrongButNothingWhileTalking', () {
      // Arrange
      final feedback = SoundGameFeedback(createService());

      // Act
      feedback
        ..react(RobotMood.happy)
        ..react(RobotMood.talk)
        ..react(RobotMood.sad);

      // Assert
      expect(player.played, ['assets/sounds/correct.wav', 'assets/sounds/wrong.wav']);
    });

    test('starAndLevelComplete_Called_PlaysMatchingFiles', () {
      // Arrange
      final feedback = SoundGameFeedback(createService());

      // Act
      feedback
        ..levelComplete()
        ..star(0)
        ..star(1);

      // Assert
      expect(player.played, [
        'assets/sounds/level-complete.wav',
        'assets/sounds/star-0.wav',
        'assets/sounds/star-1.wav',
      ]);
    });
  });

  group('SettingsDialog', () {
    testWidgets('SettingsDialog_SwitchTurnedOff_DisablesAndSavesSound', (tester) async {
      // Arrange
      final services = AppServices.production(store, soundPlayer: player);
      await tester.pumpWidget(RobiCodesApp(services: services));
      await tester.tap(find.byTooltip(texts.settingsTitle));
      await settle(tester);

      // Act
      await tester.tap(find.byType(Switch));
      await settle(tester);
      await tester.tap(find.text(texts.commonClose));
      await settle(tester);

      // Assert
      expect(services.sound.isEnabled, isFalse);
      expect(find.byType(SettingsDialog), findsNothing);
      expect(createService().isEnabled, isFalse);
    });
  });
}
