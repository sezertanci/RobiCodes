import '../../l10n/l10n.dart';

/// Seviyelerin zorluk grubu. Seviye seçim ekranında grup başlığı olarak görünür.
enum Difficulty {
  easy,
  medium,
  hard,
  expert;

  String title(AppLocalizations t) => t.difficulty(name);
}

/// Paket içindeki bir zorluk grubu ve bu gruptaki seviye sayısı.
final class DifficultyGroup {
  const DifficultyGroup(this.difficulty, this.levelCount);

  final Difficulty difficulty;
  final int levelCount;
}

/// Paket içindeki bir grubun seviye aralığı (sınırlar dahil, 1'den başlar).
final class GroupRange {
  const GroupRange({required this.index, required this.group, required this.firstLevel, required this.lastLevel});

  final int index;
  final DifficultyGroup group;
  final int firstLevel;
  final int lastLevel;

  int get levelCount => lastLevel - firstLevel + 1;

  bool contains(int level) => level >= firstLevel && level <= lastLevel;
}

/// Bir oyuna ait, birlikte sunulan seviyeler. Seviyeler paket içinde 1'den başlayarak numaralanır.
///
/// Bir oyunun birden çok paketi olabilir (ör. ücretsiz temel seviyeler ve ücretli zor seviyeler).
/// Paketin ücretli olup olmadığı burada yazılmaz: paketi açan bir mağaza ürünü varsa ücretlidir,
/// yoksa ücretsizdir (bkz. `ContentCatalog.isFree`). Böylece aynı bilgi iki yerde tutulmaz.
final class LevelPack {
  const LevelPack({required this.id, required this.gameId, required this.title, required this.groups});

  /// Kalıcı kimlik. İlerleme kaydı bu kimlikle tutulur; yayından sonra değiştirilmez.
  final String id;
  final String gameId;
  final LocalizedText title;
  final List<DifficultyGroup> groups;

  int get levelCount => groups.fold(0, (sum, group) => sum + group.levelCount);

  /// Grupların seviye aralıkları; ör. 5'erli dört grup için 1–5, 6–10, 11–15, 16–20.
  List<GroupRange> get groupRanges {
    final ranges = <GroupRange>[];
    var first = 1;
    for (final (index, group) in groups.indexed) {
      final last = first + group.levelCount - 1;
      ranges.add(GroupRange(index: index, group: group, firstLevel: first, lastLevel: last));
      first = last + 1;
    }
    return ranges;
  }

  bool containsLevel(int level) => level >= 1 && level <= levelCount;
}

/// Birden çok paketin toplam seviye sayısı.
extension LevelPackTotals on Iterable<LevelPack> {
  int get levelCount => fold(0, (sum, pack) => sum + pack.levelCount);
}
