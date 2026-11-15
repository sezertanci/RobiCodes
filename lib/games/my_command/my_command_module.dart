import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import 'my_command_level.dart';
import 'my_command_levels.dart';
import 'ui/my_command_view.dart';

/// "Kendi Komutunu Oluştur" oyun modülü.
final class MyCommandModule implements GameModule {
  MyCommandModule({Map<String, List<MyCommandLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.myCommand): myCommandBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<MyCommandLevel>> packs;

  @override
  String get gameId => GameIds.myCommand;

  MyCommandLevel levelOf(String packId, int level) => levelFrom(packs, packId, level);

  @override
  Widget buildLevel(LevelSession session) => MyCommandView(
    level: levelOf(session.packId, session.level),
    onCompleted: session.onCompleted,
    feedback: session.feedback,
  );
}
