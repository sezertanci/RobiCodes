import 'package:flutter/widgets.dart';

import '../features/play/game_feedback.dart';

/// Oynanan seviyenin bilgileri ve bitince çağrılacak geri bildirim.
/// Oyun yalnızca kendi mekaniğini bilir; yıldızın kaydedilmesi, kilitlerin açılması ve
/// ödüller uygulamanın işidir.
final class LevelSession {
  const LevelSession({required this.packId, required this.level, required this.onCompleted, required this.feedback});

  final String packId;
  final int level;

  /// Seviye bitince kazanılan yıldızla çağrılır (bkz. `StarRule`).
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses.
  final GameFeedback feedback;
}

/// Bir oyunun mekaniği. Her oyun bu arayüzü uygulayan bir sınıfla eklenir ve
/// `GameRegistry`'ye kaydedilir. Seviye verisi oyunun kendi içerik dosyalarından okunur.
abstract interface class GameModule {
  /// Katalogdaki oyun kimliği (bkz. `GameIds`).
  String get gameId;

  Widget buildLevel(LevelSession session);
}
