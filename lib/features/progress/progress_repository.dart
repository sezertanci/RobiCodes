import 'package:flutter/foundation.dart';

import '../../content/models/level_pack.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import 'progress_snapshot.dart';

/// Oyuncu ilerlemesinin cihazdaki kaydı. Varsayılan kayıt yeri cihazdır; internet gerekmez.
/// İlerleme değişince dinleyiciler (ekranlar) haberdar edilir.
final class ProgressRepository extends ChangeNotifier {
  ProgressRepository(this._store) : _snapshot = ProgressSnapshot.fromJson(_store.read(StorageKeys.progress));

  final KeyValueStore _store;
  ProgressSnapshot _snapshot;

  ProgressSnapshot get snapshot => _snapshot;

  int starsOf(String packId, int level) => _snapshot.starsOf(packId, level);

  bool isCompleted(String packId, int level) => starsOf(packId, level) > 0;

  int totalStars(String packId) => _snapshot.stars[packId]?.values.fold<int>(0, (sum, value) => sum + value) ?? 0;

  /// [packs] paketlerinde kazanılan yıldızların toplamı.
  int starsIn(Iterable<LevelPack> packs) => packs.fold(0, (sum, pack) => sum + totalStars(pack.id));

  int completedCount(String packId) => _snapshot.stars[packId]?.length ?? 0;

  /// [packs] paketlerinde tamamlanan seviyelerin toplamı.
  int completedIn(Iterable<LevelPack> packs) => packs.fold(0, (sum, pack) => sum + completedCount(pack.id));

  /// Seviyeyi kaydeder. Daha önce daha çok yıldız alındıysa en iyi sonuç korunur.
  Future<void> completeLevel(String packId, int level, int stars) => replace(_snapshot.withBest(packId, level, stars));

  /// Kaydın tamamını değiştirir (ör. bulut kaydıyla birleştirildikten sonra).
  Future<void> replace(ProgressSnapshot snapshot) async {
    _snapshot = snapshot;
    notifyListeners();
    await _store.write(StorageKeys.progress, snapshot.toJson());
  }

  Future<void> reset() async {
    _snapshot = ProgressSnapshot.empty;
    notifyListeners();
    await _store.remove(StorageKeys.progress);
  }
}
