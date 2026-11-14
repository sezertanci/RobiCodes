import '../sound/sound_effect.dart';
import '../sound/sound_service.dart';
import 'widgets/speech_bubble.dart';

/// Oyunların ve sonuç panelinin sesli geri bildirimi. Oyunlar ses servisini kendileri bilmez;
/// robotun sevindiği veya üzüldüğü anı ve sonuç panelindeki anları buraya bildirir.
abstract interface class GameFeedback {
  /// Robot sevinirse doğru, üzülürse yanlış sesi çalınır; konuşurken ses çalınmaz.
  void react(RobotMood mood);

  /// Sonuç panelinde [index]. yıldız (0'dan başlar) belirdi; ton her yıldızda yükselir.
  void star(int index);

  void levelComplete();
}

/// Ses çalmayan geri bildirim; oyunların tek başına denendiği testlerde kullanılır.
final class SilentGameFeedback implements GameFeedback {
  const SilentGameFeedback();

  @override
  void react(RobotMood mood) {}

  @override
  void star(int index) {}

  @override
  void levelComplete() {}
}

/// Ses servisiyle çalışan geri bildirim. Ses kapalıysa servis hiçbir şey çalmaz.
final class SoundGameFeedback implements GameFeedback {
  const SoundGameFeedback(this._sound);

  final SoundService _sound;

  @override
  void react(RobotMood mood) {
    final effect = switch (mood) {
      RobotMood.happy => SoundEffect.correct,
      RobotMood.sad => SoundEffect.wrong,
      RobotMood.talk => null,
    };
    if (effect != null) {
      _sound.play(effect);
    }
  }

  @override
  void star(int index) => _sound.play(SoundEffect.star, step: index);

  @override
  void levelComplete() => _sound.play(SoundEffect.levelComplete);
}
