import 'dart:math';

import '../../app/app_theme.dart';
import 'achievement_stats.dart';

/// Ödülün türü: rozetler küçük başarılar, kupalar büyük hedeflerdir. Rozet kazanılınca ekranın
/// üstünde kısa bir bildirim, kupa kazanılınca konfetili tam ekran bir pencere açılır.
enum AchievementKind { badge, trophy }

/// Rozetin veya kupanın ortasındaki işaret: hedef sayısı, ikon, yıldız sırası veya üstü çizili ikon.
final class RewardSymbol {
  const RewardSymbol({this.image, this.showsGoal = false, this.isCrossed = false, this.stars = 0});

  /// Ortadaki ikon; yoksa yalnızca sayı veya yıldızlar çizilir.
  final String? image;

  /// Ödülün hedef sayısı yazılır (ör. "Yıldız Avcısı" rozetinde 20).
  final bool showsGoal;

  /// İkonun üstüne kırmızı çizgi çekilir (ör. "İpucusuz Kahraman").
  final bool isCrossed;

  /// Yan yana çizilen yıldız sayısı; 0 ise yıldız çizilmez.
  final int stars;
}

/// Bir ödülün hedefe ne kadar yaklaştığı.
final class AchievementProgress {
  const AchievementProgress(this.current, this.goal);

  final int current;
  final int goal;

  /// Hedefi olmayan ödül (ör. sayılacak oyun yoksa) hiç kazanılmaz.
  bool get isReached => goal > 0 && current >= goal;

  /// Ekranda gösterilen sayı; hedefi aşmaz.
  int get shownCurrent => min(current, goal);
}

/// Bir ödülün tanımı. Koşul ilerleme kaydından hesaplanır ([measure]); böylece ödül sistemi
/// eklenmeden önce bitirilmiş seviyeler de hesaba katılır.
final class Achievement {
  const Achievement({
    required this.id,
    required this.kind,
    required this.title,
    required this.description,
    required this.condition,
    required this.tone,
    required this.symbol,
    required this.measure,
  });

  /// Kayıtta saklanan kalıcı kimlik. Yayından sonra değiştirilmez.
  final String id;
  final AchievementKind kind;
  final String title;
  final String description;

  /// "Nasıl kazanılır?" sorusunun cevabı.
  final String condition;
  final ColorTone tone;
  final RewardSymbol symbol;
  final AchievementProgress Function(AchievementStats stats) measure;
}

/// Bir ödülün o anki durumu: hedefe ne kadar yaklaşıldığı ve kazanılıp kazanılmadığı.
final class AchievementStatus {
  const AchievementStatus({required this.achievement, required this.progress, required this.isEarned});

  final Achievement achievement;
  final AchievementProgress progress;
  final bool isEarned;
}
