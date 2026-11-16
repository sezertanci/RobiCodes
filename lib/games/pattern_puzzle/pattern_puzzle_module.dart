import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import 'engine/pattern_level.dart';
import 'engine/pattern_levels.dart';
import 'ui/lamp_program_view.dart';
import 'ui/pattern_puzzle_view.dart';

/// "Desen Bulmacası" oyun modülü. Kolay–Zor seviyelerde eksik parçalar seçilir, Uzman seviyelerde lambalar
/// "renk yak" bloklarıyla yakılır.
final class PatternPuzzleModule implements GameModule {
  PatternPuzzleModule({Map<String, List<PatternLevel>>? packs})
    : packs = packs ?? {basePackId(GameIds.patternPuzzle): patternPuzzleBaseLevels};

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<PatternLevel>> packs;

  @override
  String get gameId => GameIds.patternPuzzle;

  PatternLevel levelOf(String packId, int level) => levelFrom(packs, packId, level);

  @override
  Widget buildLevel(LevelSession session) => switch (levelOf(session.packId, session.level)) {
    final PatternPuzzleLevel level => PatternPuzzleView(
      level: level,
      onCompleted: session.onCompleted,
      feedback: session.feedback,
    ),
    final PatternProgramLevel level => LampProgramView(
      level: level,
      onCompleted: session.onCompleted,
      feedback: session.feedback,
    ),
  };
}
