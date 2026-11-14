import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import 'engine/if_then_level.dart';
import 'engine/if_then_levels.dart';
import 'ui/if_then_view.dart';

/// "Eğer Böyleyse" oyun modülü. Seviyeler paket kimliğine göre bulunur.
final class IfThenModule implements GameModule {
  IfThenModule({Map<String, List<IfThenLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.ifThen): ifThenBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<IfThenLevel>> packs;

  @override
  String get gameId => GameIds.ifThen;

  IfThenLevel levelOf(String packId, int level) => levelFrom(packs, packId, level);

  @override
  Widget buildLevel(LevelSession session) => IfThenView(
    level: levelOf(session.packId, session.level),
    onCompleted: session.onCompleted,
    feedback: session.feedback,
  );
}
