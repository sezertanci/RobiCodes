import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../content/content_catalog.dart';
import '../../content/models/game_definition.dart';
import '../../core/json_utils.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import '../../games/game_registry.dart';
import '../progress/progress_repository.dart';
import 'achievement.dart';
import 'achievement_catalog.dart';
import 'achievement_stats.dart';

/// Rozet ve kupaların durumunu hesaplar ve kazanılanları cihazda saklar. Her ödül yalnızca bir kez
/// kazanılır: kazanılmış bir ödülün koşulu yeniden sağlansa da tekrar kazanılmış gibi gösterilmez.
///
/// Ödüllerde yalnızca oynanabilir oyunların ücretsiz paketleri sayılır; "Yakında" görünen oyunlar
/// hiçbir hedefe girmez. Satın alınan paketlerdeki yıldızlar yalnızca yıldız sayısı rozetlerine eklenir.
final class AchievementService extends ChangeNotifier {
  AchievementService({
    required this._store,
    required ContentCatalog catalog,
    required GameRegistry games,
    required this._progress,
  }) : _catalog = catalog,
       _games = _countedGames(catalog, games) {
    all = AchievementCatalog.build(_games);
    _earned = _readEarned();
  }

  static const _earnedField = 'earned';

  final KeyValueStore _store;
  final ContentCatalog _catalog;
  final ProgressRepository _progress;
  final List<GameDefinition> _games;

  /// Bütün ödüller; önce rozetler, sonra kupalar.
  late final List<Achievement> all;
  late Set<String> _earned;

  int get earnedCount => _earned.length;

  bool isEarned(String id) => _earned.contains(id);

  /// Bütün ödüllerin o anki durumu, [all] sırasıyla.
  List<AchievementStatus> statuses() {
    final stats = _stats();
    return [
      for (final achievement in all)
        AchievementStatus(
          achievement: achievement,
          progress: achievement.measure(stats),
          isEarned: _earned.contains(achievement.id),
        ),
    ];
  }

  /// Koşulu yeni sağlanan ödülleri kaydeder ve kazanılmış durumlarıyla döndürür (önce rozetler, sonra kupalar).
  /// Açılışta sonucu kullanılmadan çağrılır; böylece önceden sağlanmış ödüller pencere açılmadan eşitlenir.
  Future<List<AchievementStatus>> sync() async {
    final fresh = [
      for (final status in statuses())
        if (!status.isEarned && status.progress.isReached)
          AchievementStatus(achievement: status.achievement, progress: status.progress, isEarned: true),
    ];
    if (fresh.isNotEmpty) {
      _earned = {..._earned, for (final status in fresh) status.achievement.id};
      notifyListeners();
      await _store.write(StorageKeys.achievements, jsonEncode({_earnedField: _earned.toList()}));
    }
    return fresh;
  }

  AchievementStats _stats() => AchievementStats.collect(catalog: _catalog, games: _games, progress: _progress);

  /// Kayıttaki kimlikler; bozuk kayıt ve artık bulunmayan ödüller yok sayılır.
  Set<String> _readEarned() {
    final known = {for (final achievement in all) achievement.id};
    return switch (decodeJsonObject(_store.read(StorageKeys.achievements))?[_earnedField]) {
      final List<Object?> ids => {
        for (final id in ids.whereType<String>())
          if (known.contains(id)) id,
      },
      _ => <String>{},
    };
  }

  /// Ödüllerde sayılan oyunlar: modülü eklenmiş (oynanabilir) ve ücretsiz paketi olan oyunlar.
  static List<GameDefinition> _countedGames(ContentCatalog catalog, GameRegistry games) => [
    for (final game in catalog.games)
      if (games.isPlayable(game.id) && catalog.packsOf(game.id).any((pack) => catalog.isFree(pack.id))) game,
  ];
}
