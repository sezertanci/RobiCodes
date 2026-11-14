import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import 'engine/repeat_level.dart';
import 'engine/repeat_levels.dart';
import 'ui/repeat_view.dart';

/// "Tekrar Et" oyun modülü. Seviyeler paket kimliğine göre bulunur.
final class RepeatModule implements GameModule {
  RepeatModule({Map<String, List<RepeatLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.repeat): repeatBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<RepeatLevel>> packs;

  @override
  String get gameId => GameIds.repeat;

  RepeatLevel levelOf(String packId, int level) => levelFrom(packs, packId, level);

  @override
  Widget buildLevel(LevelSession session) => RepeatView(
    level: levelOf(session.packId, session.level),
    onCompleted: session.onCompleted,
    feedback: session.feedback,
  );
}
