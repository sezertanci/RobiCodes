import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/robot_voice.dart';
import 'package:robi_codes/features/play/widgets/robot_sprite.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';

import '../support/fakes.dart';

void main() {
  late RecordingGameFeedback feedback;

  setUp(() => feedback = RecordingGameFeedback());

  group('RobotVoice', () {
    test('constructor_Intro_ShowsIntroWithoutSound', () {
      // Act
      final voice = RobotVoice(feedback: feedback, intro: 'Merhaba');

      // Assert
      expect(voice.message, 'Merhaba');
      expect(voice.mood, RobotMood.talk);
      expect(voice.reaction, RobotReaction.none);
      expect(feedback.moods, isEmpty);
    });

    test('say_HappyMood_ChangesMessageAndPlaysMood', () {
      // Arrange
      final voice = RobotVoice(feedback: feedback, intro: 'Merhaba');

      // Act
      voice.say('Harika', RobotMood.happy);

      // Assert
      expect(voice.message, 'Harika');
      expect(voice.mood, RobotMood.happy);
      expect(feedback.moods, [RobotMood.happy]);
    });

    test('react_SameReactionTwice_CountsEachReaction', () {
      // Arrange
      final voice = RobotVoice(feedback: feedback, intro: 'Merhaba');

      // Act
      voice
        ..react(RobotReaction.bump)
        ..react(RobotReaction.bump);

      // Assert
      expect(voice.reaction, RobotReaction.bump);
      expect(voice.reactionCount, 2);
    });

    test('calm_AfterReaction_ClearsReactionAndKeepsCount', () {
      // Arrange
      final voice = RobotVoice(feedback: feedback, intro: 'Merhaba')..react(RobotReaction.shake);

      // Act
      voice.calm();

      // Assert
      expect(voice.reaction, RobotReaction.none);
      expect(voice.reactionCount, 1);
    });
  });
}
