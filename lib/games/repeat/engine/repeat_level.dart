import '../../path_finder/engine/path_finder_board.dart';

/// Bir seviyenin verisi. Harita işaretleri "Robotun Yolunu Bul" ile aynıdır (bkz. [TileSymbols]).
final class RepeatLevel {
  const RepeatLevel({
    required this.map,
    required this.solution,
    required this.maxBlocks,
    required this.hint,
    this.intro,
  });

  final List<String> map;

  /// Önerilen çözümün kısaltması: "3(RD) U" = 3 kez (sağa, aşağı), sonra yukarı. Oyunda gösterilmez;
  /// blok sayısı 3 yıldız hedefidir.
  final String solution;

  /// Blok sınırı. Tekrar bloğu ve içindeki her ok birer blok sayılır.
  final int maxBlocks;

  /// İpucu düğmesine basılınca söylenen seviyeye özel ipucu.
  final String hint;

  /// Seviyeye özel açılış mesajı. Yoksa oyunun genel açılış mesajı gösterilir.
  final String? intro;

  PathFinderBoard get board => PathFinderBoard.parse(map);
}
