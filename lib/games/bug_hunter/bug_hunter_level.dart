import '../../l10n/l10n.dart';
import '../repeat/engine/repeat_engine.dart';
import '../repeat/engine/repeat_level.dart';
import '../repeat/engine/repeat_program.dart';
import '../repeat/engine/starting_program.dart';

/// "Hata Avcısı" seviyesi: haritası, bozuk kodu ve düzeltilmiş çözümü. Harita işaretleri ve kısaltma
/// biçimi "Tekrar Et" ile aynıdır (ör. "3(RD) U"); oynanış da onun denetleyicisiyle yürür.
final class BugHunterLevel {
  const BugHunterLevel({
    required this.map,
    required this.bugged,
    required this.solution,
    required this.maxBlocks,
    required this.hint,
    this.intro,
  });

  final List<String> map;

  /// Seviyenin açıldığı bozuk kod; robotu bayrağa götürmez.
  final String bugged;

  /// Düzeltilmiş kod. Oyunda gösterilmez; blok sayısı 3 yıldız hedefidir.
  final String solution;

  /// Blok sınırı. Tekrar bloğu ve içindeki her ok birer blok sayılır.
  final int maxBlocks;

  final LocalizedText hint;

  /// Seviyeye özel açılış mesajı. Yoksa oyunun genel açılış mesajı gösterilir.
  final LocalizedText? intro;

  /// "Tekrar Et" denetleyicisinin okuduğu seviye verisi.
  RepeatLevel get puzzle =>
      RepeatLevel(map: map, solution: solution, maxBlocks: maxBlocks, hint: hint, intro: intro ?? _defaultIntro);

  /// Bozuk kod; Tekrarla düğmesi yalnızca bozuk kodda ya da çözümde tekrar bloğu varsa gösterilir.
  StartingProgram get startingProgram {
    final blocks = RepeatEngine.parseSolution(bugged);
    final usesRepeat = [...blocks, ...RepeatEngine.parseSolution(solution)].any((block) => block is RepeatBlock);
    return StartingProgram(blocks, allowsRepeat: usesRepeat);
  }

  static String _defaultIntro(AppLocalizations t) => t.bugHunterIntro;
}
