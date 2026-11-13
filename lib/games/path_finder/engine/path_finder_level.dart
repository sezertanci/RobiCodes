import 'path_finder_board.dart';

/// Bir seviyenin verisi. Oyun kuralları bu veriyi okur; seviye eklemek için kod değişmez.
final class PathFinderLevel {
  const PathFinderLevel({required this.map, required this.solution, this.intro, this.maxCommands});

  /// Harita satırları (işaretler için bkz. [TileSymbols]).
  final List<String> map;

  /// En kısa çözümün kısaltması ("URR"). Oyunda gösterilmez; testlerde seviyenin çözülebildiği doğrulanır.
  final String solution;

  /// Seviyeye özel açılış mesajı. Yoksa oyunun genel açılış mesajı gösterilir.
  final String? intro;

  /// Komut sınırı. Yoksa oyunun varsayılan sınırı geçerlidir.
  final int? maxCommands;

  static const defaultMaxCommands = 16;

  int get commandLimit => maxCommands ?? defaultMaxCommands;

  PathFinderBoard get board => PathFinderBoard.parse(map);
}
