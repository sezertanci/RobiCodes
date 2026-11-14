import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import 'engine/path_finder_level.dart';
import 'engine/path_finder_levels.dart';
import 'ui/path_finder_view.dart';

/// "Robotun Yolunu Bul" oyun modülü. Seviyeler paket kimliğine göre bulunur; yeni bir paket
/// eklemek için yalnızca seviye verisi ve katalog kaydı gerekir.
final class PathFinderModule implements GameModule {
  PathFinderModule({Map<String, List<PathFinderLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.pathFinder): pathFinderBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<PathFinderLevel>> packs;

  @override
  String get gameId => GameIds.pathFinder;

  PathFinderLevel levelOf(String packId, int level) {
    final levels = packs[packId];
    if (levels == null || level < 1 || level > levels.length) {
      throw ArgumentError('Bilinmeyen seviye: $packId / $level');
    }
    return levels[level - 1];
  }

  @override
  Widget buildLevel(LevelSession session) => PathFinderView(
    level: levelOf(session.packId, session.level),
    onCompleted: session.onCompleted,
    feedback: session.feedback,
  );
}
