import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import '../repeat/engine/repeat_level.dart';
import '../repeat/ui/repeat_view.dart';
import 'variable_box_levels.dart';

/// "Değişken Kutusu" oyun modülü. Oynanış "Tekrar Et" ile aynı ekrandır; kutu blokları açıktır.
final class VariableBoxModule implements GameModule {
  VariableBoxModule({Map<String, List<RepeatLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.variableBox): variableBoxBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<RepeatLevel>> packs;

  @override
  String get gameId => GameIds.variableBox;

  RepeatLevel levelOf(String packId, int level) => levelFrom(packs, packId, level);

  @override
  Widget buildLevel(LevelSession session) => RepeatView(
    level: levelOf(session.packId, session.level),
    onCompleted: session.onCompleted,
    feedback: session.feedback,
    usesBox: true,
  );
}
