import 'dart:convert';
import 'dart:math';

import '../../core/json_utils.dart';
import 'star_rule.dart';

/// Oyuncu ilerlemesinin değişmez kopyası: her paketteki seviyelerin en iyi yıldız sayısı.
/// Cihaz kaydı ve bulut kaydı aynı biçimi kullanır. Satın alma bilgisi burada tutulmaz.
final class ProgressSnapshot {
  const ProgressSnapshot(this.stars);

  /// Paket kimliği → seviye numarası → yıldız (1–3). Tamamlanmayan seviye listede yer almaz.
  final Map<String, Map<int, int>> stars;

  static const empty = ProgressSnapshot({});

  static const _formatVersion = 1;
  static const _versionField = 'version';
  static const _packsField = 'packs';

  int starsOf(String packId, int level) => stars[packId]?[level] ?? 0;

  /// Seviyenin yıldızını en iyi sonucu koruyarak günceller.
  ProgressSnapshot withBest(String packId, int level, int value) {
    final best = max(StarRule.clamp(value), starsOf(packId, level));
    return ProgressSnapshot({
      ...stars,
      packId: {...?stars[packId], level: best},
    });
  }

  String toJson() => jsonEncode({
    _versionField: _formatVersion,
    _packsField: {
      for (final MapEntry(key: packId, value: levels) in stars.entries)
        packId: {for (final MapEntry(key: level, value: count) in levels.entries) '$level': count},
    },
  });

  /// Kayıttan okur. Bozuk veya beklenmeyen değerler atlanır; kayıt hiç okunamazsa boş ilerleme döner.
  static ProgressSnapshot fromJson(String? raw) {
    final packs = decodeJsonObject(raw)?[_packsField];
    if (packs is! Map<String, Object?>) {
      return empty;
    }
    final result = <String, Map<int, int>>{};
    for (final MapEntry(key: packId, value: levels) in packs.entries) {
      if (levels is Map<String, Object?>) {
        result[packId] = _readLevels(levels);
      }
    }
    return ProgressSnapshot(result);
  }

  static Map<int, int> _readLevels(Map<String, Object?> levels) => {
    for (final MapEntry(key: key, value: value) in levels.entries)
      if (int.tryParse(key) case final level? when level > 0 && value is int && StarRule.isValid(value)) level: value,
  };
}
