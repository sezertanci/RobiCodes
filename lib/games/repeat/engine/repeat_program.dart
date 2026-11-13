import '../../path_finder/engine/path_finder_board.dart';

/// Programın bir bloğu: tek bir yön oku ya da "N kez tekrarla" bloğu.
/// Tekrar bloğunun içinde yalnızca oklar bulunur; iç içe tekrar yoktur (7 yaş için sade tutuldu).
sealed class ProgramBlock {
  const ProgramBlock();

  /// Bloğun blok sınırından kapladığı yer: ok 1, tekrar bloğu 1 + içindeki ok sayısı.
  int get size;
}

final class MoveBlock extends ProgramBlock {
  const MoveBlock(this.direction);

  final Direction direction;

  @override
  int get size => 1;

  @override
  bool operator ==(Object other) => other is MoveBlock && other.direction == direction;

  @override
  int get hashCode => direction.hashCode;
}

final class RepeatBlock extends ProgramBlock {
  const RepeatBlock(this.times, this.body);

  static const minTimes = 2;
  static const maxTimes = 6;
  static const defaultTimes = 2;

  final int times;
  final List<Direction> body;

  @override
  int get size => 1 + body.length;

  RepeatBlock copyWith({int? times, List<Direction>? body}) => RepeatBlock(times ?? this.times, body ?? this.body);

  @override
  bool operator ==(Object other) =>
      other is RepeatBlock &&
      other.times == times &&
      other.body.length == body.length &&
      body.indexed.every((entry) => other.body[entry.$1] == entry.$2);

  @override
  int get hashCode => Object.hash(times, Object.hashAll(body));
}

/// Şeritteki bir yer. [inner] üst düzey blok için [ProgramPlace.topLevel], tekrar bloğunun
/// içindeki ok için o okun sırasıdır.
typedef ProgramPlace = ({int block, int inner});

/// Bir hareketin hangi bloktan, bloğun kaçıncı okundan ve kaçıncı turdan geldiği.
/// Ekran bunu çalışırken bloğu ve tur rozetini vurgulamak için kullanır.
typedef ProgramStep = ({Direction direction, int block, int inner, int round});

abstract final class Places {
  /// Üst düzey bloğun [ProgramPlace.inner] değeri.
  static const topLevel = -1;

  static ProgramPlace top(int block) => (block: block, inner: topLevel);

  static ProgramPlace of(ProgramStep step) => (block: step.block, inner: step.inner);

  static bool isInner(ProgramPlace place) => place.inner != topLevel;
}
