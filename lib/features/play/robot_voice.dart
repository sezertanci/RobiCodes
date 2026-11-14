import 'game_feedback.dart';
import 'widgets/robot_sprite.dart';
import 'widgets/speech_bubble.dart';

/// Oyun ekranındaki robotun konuşma balonu, ruh hâli ve hareketli tepkisi. Oynanış denetleyicileri
/// bu sınıfı kullanır; değişiklikten sonra ekranı denetleyicinin kendisi haberdar eder.
final class RobotVoice {
  /// [intro] açılış mesajıdır; ses çalmadan gösterilir.
  RobotVoice({required this.feedback, required String intro}) : _message = intro;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses.
  final GameFeedback feedback;

  String _message;
  RobotMood _mood = RobotMood.talk;
  RobotReaction _reaction = RobotReaction.none;
  int _reactionCount = 0;

  String get message => _message;
  RobotMood get mood => _mood;
  RobotReaction get reaction => _reaction;

  /// Her tepkide artar; ekran aynı tepki art arda gelse de animasyonu yeniden başlatır.
  int get reactionCount => _reactionCount;

  /// Balondaki metni ve ruh hâlini değiştirir; ruh hâline uygun ses çalınır.
  void say(String text, [RobotMood mood = RobotMood.talk]) {
    _message = text;
    _mood = mood;
    feedback.react(mood);
  }

  /// Robotun tepki animasyonunu başlatır.
  void react(RobotReaction reaction) {
    _reaction = reaction;
    _reactionCount++;
  }

  /// Tepkiyi kaldırır (ör. robot başa döndüğünde).
  void calm() => _reaction = RobotReaction.none;
}
