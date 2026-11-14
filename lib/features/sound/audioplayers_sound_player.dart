import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'sound_player.dart';

/// Android'de `audioplayers` paketiyle çalışan altyapı. Kısa efektler için gecikmesi düşük kip
/// kullanılır ve her dosya için bir oynatıcı bir kez kurulup yeniden kullanılır.
final class AudioplayersSoundPlayer implements SoundPlayer {
  AudioplayersSoundPlayer._();

  /// Dosya yolları `assets/` önekiyle birlikte verildiği için önbelleğe ayrıca önek eklenmez.
  final _cache = AudioCache(prefix: '');
  final _players = <String, AudioPlayer>{};

  /// Efektler başka uygulamaların sesini (ör. müzik) durdurmaz, onunla birlikte çalar.
  static Future<AudioplayersSoundPlayer> create() async {
    try {
      await AudioPlayer.global.setAudioContext(
        AudioContextConfig(focus: AudioContextConfigFocus.mixWithOthers).build(),
      );
    } on Exception catch (error) {
      debugPrint('Ses ayarı yapılamadı: $error');
    }
    return AudioplayersSoundPlayer._();
  }

  @override
  Future<void> play(String asset) async {
    try {
      final player = _players.putIfAbsent(asset, () => AudioPlayer()..audioCache = _cache);
      await player.stop();
      await player.play(AssetSource(asset), mode: PlayerMode.lowLatency);
    } on Exception catch (error) {
      debugPrint('Ses çalınamadı ($asset): $error');
    }
  }
}
