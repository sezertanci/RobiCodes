/// Ses dosyasını çalan altyapı. Uygulamada ses paketiyle çalışan sürüm kullanılır; testlerde ve
/// ses çalınamayan ortamlarda hiçbir şey yapmayan sürüm verilir.
abstract interface class SoundPlayer {
  /// [asset] dosyasını çalar. Ses çalınamazsa hata fırlatmaz; oyun etkilenmez.
  Future<void> play(String asset);
}

/// Hiç ses çalmayan altyapı.
final class SilentSoundPlayer implements SoundPlayer {
  const SilentSoundPlayer();

  @override
  Future<void> play(String asset) async {}
}
