import '../../content/models/level_pack.dart';
import '../developer/developer_unlock.dart';
import 'progress_repository.dart';

/// Paketin tamamına erişim olup olmadığını söyler (bkz. `EntitlementService.canPlayPack`).
typedef PackAccess = bool Function(String packId);

/// Seviye ve grup kilitleri. Paketin tamamına erişim varsa mevcut oyundaki kurallar geçerlidir:
/// - Bir grup, önceki grubun bütün seviyeleri tamamlanınca açılır.
/// - Bir seviye, grubu açıksa ve önceki seviye tamamlandıysa açılır.
/// - Bir seviyeyi açmak için önceki seviyede 1 yıldız yeterlidir.
///
/// Erişim yoksa yalnızca paketin deneme seviyeleri (her grubun ilk seviyesi) sırayla açılır: ilki hemen,
/// sonraki ise önceki deneme seviyesi tamamlanınca. Deneme seviyesi açık olan grup açık görünür.
/// Erişimin kendisi burada hesaplanmaz; [PackAccess] ile `EntitlementService`'ten alınır.
/// [DeveloperUnlock] açıksa (yalnızca debug) bütün gruplar ve seviyeler açıktır.
final class UnlockPolicy {
  const UnlockPolicy(this._progress, this._canPlayPack, {this._developerUnlock});

  final ProgressRepository _progress;
  final PackAccess _canPlayPack;
  final DeveloperUnlock? _developerUnlock;

  bool get _unlocksAll => _developerUnlock?.isEnabled ?? false;

  int groupCompletedCount(LevelPack pack, GroupRange range) {
    var count = 0;
    for (var level = range.firstLevel; level <= range.lastLevel; level++) {
      count += _progress.isCompleted(pack.id, level) ? 1 : 0;
    }
    return count;
  }

  bool isGroupUnlocked(LevelPack pack, GroupRange range) {
    if (_unlocksAll) {
      return true;
    }
    if (!_canPlayPack(pack.id)) {
      return isLevelUnlocked(pack, range.firstLevel);
    }
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
    if (_unlocksAll) {
      return true;
    }
    if (!_canPlayPack(pack.id)) {
      return _isPreviewUnlocked(pack, level);
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

  bool _isPreviewUnlocked(LevelPack pack, int level) {
    final previews = pack.previewLevels;
    final index = previews.indexOf(level);
    return index == 0 || (index > 0 && _progress.isCompleted(pack.id, previews[index - 1]));
  }
}
