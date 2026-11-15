import '../path_finder/engine/path_finder_board.dart';
import 'engine/repeat_engine.dart';
import 'engine/repeat_program.dart';

/// Bir blok şeridinin düzenleme durumu: bloklar, açık tekrar bloğu, seçim ve "Önüne ekle". Kurallar
/// (blok sınırı, robotun sözleri) denetleyicidedir; bu sınıf yalnızca blokları değiştirir.
/// "Tekrar Et" tek, "Kendi Komutunu Oluştur" iki (komut ve ana program) düzenleyici kullanır.
final class ProgramEditor {
  ProgramEditor([List<ProgramBlock> blocks = const []]) {
    _program.addAll(blocks);
  }

  final List<ProgramBlock> _program = [];
  int? _target;
  ProgramPlace? _selected;
  bool _inserting = false;

  List<ProgramBlock> get program => List.unmodifiable(_program);
  int get blockCount => RepeatEngine.countBlocks(_program);
  bool get isEmpty => _program.isEmpty;

  /// Okların içine eklendiği (açık) tekrar bloğunun sırası.
  int? get target => _target;
  ProgramPlace? get selected => _selected;

  /// "Önüne ekle" seçili: sonraki yön, seçili bloğun önüne eklenir.
  bool get isInserting => _inserting;

  /// Seçili yerdeki ok; seçili yer ok değilse ya da seçim yoksa `null`.
  Direction? get selectedMove => switch (_selected) {
    null => null,
    final place when Places.isInner(place) => (_program[place.block] as RepeatBlock).body[place.inner],
    final place => switch (_program[place.block]) {
      MoveBlock(:final direction) => direction,
      RepeatBlock() || CallBlock() => null,
    },
  };

  /// Oku açık tekrar bloğunun içine, yoksa programın sonuna ekler.
  void appendMove(Direction direction) {
    final target = _target;
    if (target == null) {
      _program.add(MoveBlock(direction));
    } else {
      final block = _program[target] as RepeatBlock;
      _program[target] = block.copyWith(body: [...block.body, direction]);
    }
  }

  /// Bloğu programın sonuna ekler; tekrar bloğuysa onu açar.
  void appendBlock(ProgramBlock block) {
    _program.add(block);
    _target = block is RepeatBlock ? _program.length - 1 : null;
  }

  /// Oku seçili yerin yerine koyar ([replace]) ya da önüne ekler. Önüne eklemede açık blok kayar.
  void putMove(Direction direction, {required bool replace}) {
    final place = _selected!;
    final remove = replace ? 1 : 0;
    if (Places.isInner(place)) {
      final block = _program[place.block] as RepeatBlock;
      final body = [...block.body]..replaceRange(place.inner, place.inner + remove, [direction]);
      _program[place.block] = block.copyWith(body: body);
      return;
    }
    _program.replaceRange(place.block, place.block + remove, [MoveBlock(direction)]);
    final target = _target;
    if (!replace && target != null && target >= place.block) _target = target + 1;
  }

  void closeTarget() => _target = null;

  /// Tekrar sayısını bir azaltır (-1) ya da artırır (+1); sayı sınırlar içinde kalır. Değiştiyse `true`.
  bool changeTimes(int index, int offset) {
    final block = _program[index];
    if (block is! RepeatBlock) {
      return false;
    }
    final times = (block.times + offset).clamp(RepeatBlock.minTimes, RepeatBlock.maxTimes);
    _program[index] = block.copyWith(times: times);
    return true;
  }

  /// Tekrar bloğunu açar ya da kapatır. Blok kapandıysa `true`.
  bool toggleTarget(int index) {
    final leaving = _target == index;
    _target = leaving ? null : index;
    _selected = leaving ? null : Places.top(index);
    _inserting = false;
    return leaving;
  }

  /// Açık bloğu [index] yapar ve seçimi kaldırır (ör. ipucu boş bloğu gösterirken).
  void openTarget(int index) {
    _target = index;
    _selected = null;
  }

  void toggleSelection(ProgramPlace place) {
    _selected = _selected == place ? null : place;
    _inserting = false;
  }

  void select(ProgramPlace place) => _selected = place;

  void toggleInserting() => _inserting = !_inserting;

  /// Seçimi ve "Önüne ekle"yi kaldırır. Bir şey değiştiyse `true`.
  bool clearSelection() {
    final changed = _selected != null || _inserting;
    _selected = null;
    _inserting = false;
    return changed;
  }

  void deleteSelected() {
    final place = _selected!;
    if (Places.isInner(place)) {
      final block = _program[place.block] as RepeatBlock;
      _program[place.block] = block.copyWith(body: [...block.body]..removeAt(place.inner));
      return;
    }
    _program.removeAt(place.block);
    _target = switch (_target) {
      final target? when target == place.block => null,
      final target? when target > place.block => target - 1,
      final target => target,
    };
  }

  /// Bloğun içindeki seçili oku bloğun hemen arkasına taşır ve bloğu kapatır.
  void moveSelectedOut() {
    final place = _selected!;
    final block = _program[place.block] as RepeatBlock;
    _program[place.block] = block.copyWith(body: [...block.body]..removeAt(place.inner));
    _program.insert(place.block + 1, MoveBlock(block.body[place.inner]));
    _target = null;
  }

  /// Programı [blocks] ile değiştirir; açık blok kapanır.
  void reset(List<ProgramBlock> blocks) {
    _program
      ..clear()
      ..addAll(blocks);
    _target = null;
  }
}
