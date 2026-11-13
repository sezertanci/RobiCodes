import '../../content/models/level_pack.dart';
import 'progress_repository.dart';

/// Seviye ve grup kilitleri. Mevcut oyundaki kuralların aynısıdır:
/// - Bir grup, önceki grubun bütün seviyeleri tamamlanınca açılır.
/// - Bir seviye, grubu açıksa ve önceki seviye tamamlandıysa açılır.
/// - Bir seviyeyi açmak için önceki seviyede 1 yıldız yeterlidir.
///
/// Paketin satın alınmış olup olmadığı burada denetlenmez; o iş `EntitlementService`'indir.
final class UnlockPolicy {
  const UnlockPolicy(this._progress);

  final ProgressRepository _progress;

  int groupCompletedCount(LevelPack pack, GroupRange range) {
    var count = 0;
    for (var level = range.firstLevel; level <= range.lastLevel; level++) {
      count += _progress.isCompleted(pack.id, level) ? 1 : 0;
    }
    return count;
  }

  bool isGroupUnlocked(LevelPack pack, GroupRange range) {
    if (range.index == 0) {
      return true;
    }
    final previous = pack.groupRanges[range.index - 1];
    return groupCompletedCount(pack, previous) == previous.levelCount;
  }

  bool isLevelUnlocked(LevelPack pack, int level) {
    if (!pack.containsLevel(level)) {
      return false;
    }
    final range = pack.groupRanges.firstWhere((candidate) => candidate.contains(level));
    if (!isGroupUnlocked(pack, range)) {
      return false;
    }
    return level == 1 || _progress.isCompleted(pack.id, level - 1);
  }

  /// Sıradaki oynanacak seviye: açık ama henüz bitmemiş ilk seviye. Hepsi bittiyse `null`.
  int? nextLevel(LevelPack pack) {
    for (var level = 1; level <= pack.levelCount; level++) {
      if (!_progress.isCompleted(pack.id, level) && isLevelUnlocked(pack, level)) {
        return level;
      }
    }
    return null;
  }
}
