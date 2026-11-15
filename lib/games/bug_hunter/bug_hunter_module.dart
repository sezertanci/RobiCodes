import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import '../repeat/ui/repeat_view.dart';
import 'bug_hunter_level.dart';
import 'bug_hunter_levels.dart';

/// "Hata Avcısı" oyun modülü. Seviye, "Tekrar Et" ekranında bozuk kodla açılır.
final class BugHunterModule implements GameModule {
  BugHunterModule({Map<String, List<BugHunterLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.bugHunter): bugHunterBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<BugHunterLevel>> packs;

  @override
  String get gameId => GameIds.bugHunter;

  BugHunterLevel levelOf(String packId, int level) => levelFrom(packs, packId, level);

  @override
  Widget buildLevel(LevelSession session) {
    final level = levelOf(session.packId, session.level);
    return RepeatView(
      level: level.puzzle,
      startingProgram: level.startingProgram,
      onCompleted: session.onCompleted,
      feedback: session.feedback,
    );
  }
}
