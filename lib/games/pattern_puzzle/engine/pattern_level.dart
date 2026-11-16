import '../../../l10n/l10n.dart';
import '../../path_finder/engine/lamp.dart';
import '../../path_finder/engine/path_finder_board.dart';
import '../../repeat/engine/repeat_engine.dart';
import '../../repeat/engine/repeat_program.dart';
import 'pattern_tile.dart';

/// "Desen Bulmacası" seviyesi: eksik parçaları seçilen bulmaca ([PatternPuzzleLevel]) ya da lambaları
/// "renk yak" bloklarıyla yakan program ([PatternProgramLevel]).
sealed class PatternLevel {
  const PatternLevel({required this.intro, required this.hint});

  /// Seviyenin açılış mesajı.
  final LocalizedText intro;

  /// İpucu düğmesine basılınca söylenen metin.
  final LocalizedText hint;
}

/// Eksik parçaları altta çıkan seçeneklerden seçilen desen. Desen metni [PatternNotation] ile yazılır;
/// köşeli parantezli parçalar eksiktir ve doğru cevaplarıdır.
final class PatternPuzzleLevel extends PatternLevel {
  PatternPuzzleLevel({required String pattern, required super.intro, required super.hint, String? options})
    : tiles = PatternNotation.parseTiles(pattern),
      missing = PatternNotation.parseMissing(pattern),
      options = options == null
          ? PatternNotation.distinctTiles(PatternNotation.parseTiles(pattern))
          : PatternNotation.parseTiles(options);

  /// Desenin bütün parçaları; eksik parçalar da doğru cevaplarıyla yer alır.
  final List<PatternTile> tiles;

  /// Eksik parçaların sırası, soldan sağa.
  final List<int> missing;

  /// Altta çıkan seçenekler. Verilmezse desendeki farklı parçalardır (en fazla 4).
  final List<PatternTile> options;
}

/// Uzman grubu: tek sıra lamba şeridi. Robot alttaki yolda sağa yürür; her "renk yak" bloğunda üstündeki
/// lambayı yakıp bir kare ilerler. Blok sınırı, Tekrarla kullanılmadan aşılır.
final class PatternProgramLevel extends PatternLevel {
  PatternProgramLevel({
    required String lamps,
    required this.solution,
    required this.maxBlocks,
    required super.intro,
    required super.hint,
  }) : lamps = [for (final tile in PatternNotation.parseTiles(lamps)) (tile as LampTile).color];

  /// Lambaların sırayla yakılması gereken renkleri.
  final List<LampColor> lamps;

  /// Önerilen çözüm; blok sayısı 3 yıldız hedefidir.
  final List<ProgramBlock> solution;

  /// Blok sınırı. Tekrar bloğu ve içindeki her blok birer blok sayılır.
  final int maxBlocks;

  /// Lambaların durduğu satır; robot bir alttaki satırda yürür.
  static const lampRow = 0;

  int get targetBlocks => RepeatEngine.countBlocks(solution);

  /// Üstte lamba satırı, altta başlangıçtan bayrağa düz yol. Bayrak son lambanın sağındadır.
  PathFinderBoard get board => PathFinderBoard.parse([
    TileSymbols.empty * (lamps.length + 1),
    '${TileSymbols.start}${TileSymbols.empty * (lamps.length - 1)}${TileSymbols.goal}',
  ]);

  /// [index]. lambanın haritadaki yeri.
  static GridPoint lampAt(int index) => (x: index, y: lampRow);
}
