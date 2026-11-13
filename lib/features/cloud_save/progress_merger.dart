import '../progress/progress_snapshot.dart';

/// Cihaz ve bulut kayıtlarını veri kaybetmeden birleştirir: iki kayıttaki bütün seviyeler
/// alınır, aynı seviye iki kayıtta da varsa yüksek yıldız kazanır.
/// Sonuç, hangi sırayla birleştirilirse birleştirilsin aynıdır.
abstract final class ProgressMerger {
  static ProgressSnapshot merge(ProgressSnapshot first, ProgressSnapshot second) {
    var result = first;
    for (final MapEntry(key: packId, value: levels) in second.stars.entries) {
      for (final MapEntry(key: level, value: stars) in levels.entries) {
        result = result.withBest(packId, level, stars);
      }
    }
    return result;
  }
}
