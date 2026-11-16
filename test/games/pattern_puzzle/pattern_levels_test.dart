import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/engine/lamp.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/pattern_puzzle/engine/pattern_level.dart';
import 'package:robi_codes/games/pattern_puzzle/engine/pattern_levels.dart';
import 'package:robi_codes/games/pattern_puzzle/engine/pattern_tile.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/program_editor.dart';

/// Her zorluk grubundaki seviye sayısı; Uzman grubu son 5 seviyedir.
const _groupSize = 5;
const _firstProgramLevel = 15;

/// Seçenek satırına sığan en fazla seçenek.
const _maxOptions = 4;

void main() {
  test('patternPuzzleBaseLevels_Length_IsTwenty', () {
    expect(patternPuzzleBaseLevels, hasLength(20));
  });

  test('patternPuzzleBaseLevels_Groups_FirstFifteenPuzzlesLastFivePrograms', () {
    expect(patternPuzzleBaseLevels.take(_firstProgramLevel), everyElement(isA<PatternPuzzleLevel>()));
    expect(patternPuzzleBaseLevels.skip(_firstProgramLevel), everyElement(isA<PatternProgramLevel>()));
  });

  test('easyLevels_Missing_HaveOneMissingLampInTwoColors', () {
    for (final level in patternPuzzleBaseLevels.take(_groupSize).cast<PatternPuzzleLevel>()) {
      expect(level.missing, hasLength(1));
      expect(level.options, hasLength(2));
    }
  });

  for (final (index, level) in patternPuzzleBaseLevels.indexed) {
    final number = index + 1;
    switch (level) {
      case PatternPuzzleLevel():
        test('options_Level${number}_ContainEveryAnswerAndAreDistinct', () {
          expect(level.missing, isNotEmpty);
          expect(level.options.toSet(), hasLength(level.options.length));
          expect(level.options.length, lessThanOrEqualTo(_maxOptions));
          for (final slot in level.missing) {
            expect(level.options, contains(level.tiles[slot]));
          }
        });
      case PatternProgramLevel():
        test('solution_Level${number}_LightsEveryLampWithinBlockLimit', () {
          final editor = ProgramEditor()..reset(level.solution);
          final colors = [
            for (final step in RepeatEngine.expand(level.solution))
              (editor.blockAt(Places.of(step)) as LightBlock).color,
          ];

          expect(colors, level.lamps);
          expect(RepeatEngine.run(level.board, level.solution).result.outcome, RunOutcome.success);
          expect(level.targetBlocks, lessThanOrEqualTo(level.maxBlocks));
        });

        test('lightsOnly_Level${number}_ExceedBlockLimit', () {
          expect(level.lamps.length, greaterThan(level.maxBlocks));
        });
    }
  }

  group('PatternNotation', () {
    test('parseTiles_ColorShapeAndNumber_ReturnsTiles', () {
      expect(PatternNotation.parseTiles('R Bs Yt 12'), [
        const LampTile(LampColor.red),
        const LampTile(LampColor.blue, LampShape.square),
        const LampTile(LampColor.yellow, LampShape.triangle),
        const NumberTile(12),
      ]);
    });

    test('parseMissing_BracketedTiles_ReturnsTheirIndexes', () {
      expect(PatternNotation.parseMissing('R [B] R [B]'), [1, 3]);
    });

    test('parseTiles_UnknownToken_Throws', () {
      expect(() => PatternNotation.parseTiles('X'), throwsArgumentError);
    });
  });
}
