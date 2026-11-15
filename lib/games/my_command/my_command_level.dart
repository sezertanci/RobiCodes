import '../../l10n/l10n.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../repeat/engine/repeat_engine.dart';
import '../repeat/engine/repeat_program.dart';

/// "Kendi Komutunu Oluştur" seviyesi: harita, önerilen komut ve ana program. Harita işaretleri ve
/// kısaltma biçimi "Tekrar Et" ile aynıdır; ana programda "C" komut bloğudur (ör. komut "RD", ana
/// program "C C C R").
final class MyCommandLevel {
  const MyCommandLevel({
    required this.map,
    required this.command,
    required this.main,
    required this.maxBlocks,
    required this.hint,
    this.intro,
  });

  final List<String> map;

  /// Önerilen komut. Oyunda gösterilmez.
  final String command;

  /// Önerilen ana program. Oyunda gösterilmez; komutla birlikte blok sayısı 3 yıldız hedefidir.
  final String main;

  /// Komut ve ana programın birlikte blok sınırı. Komut bloğu ana programda bir blok sayılır.
  final int maxBlocks;

  /// İpucu düğmesine basılınca söylenen seviyeye özel ipucu.
  final LocalizedText hint;

  /// Seviyeye özel açılış mesajı. Yoksa oyunun genel açılış mesajı gösterilir.
  final LocalizedText? intro;

  PathFinderBoard get board => PathFinderBoard.parse(map);

  List<ProgramBlock> get commandBlocks => RepeatEngine.parseSolution(command);
  List<ProgramBlock> get mainBlocks => RepeatEngine.parseSolution(main);

  /// 3 yıldız için en fazla blok sayısı: önerilen komut ve ana programın blok sayısı.
  int get targetBlocks => RepeatEngine.countBlocks(commandBlocks) + RepeatEngine.countBlocks(mainBlocks);

  /// Tekrarla düğmesi yalnızca önerilen çözümde tekrar bloğu varsa gösterilir.
  bool get allowsRepeat => [...commandBlocks, ...mainBlocks].any((block) => block is RepeatBlock);
}
