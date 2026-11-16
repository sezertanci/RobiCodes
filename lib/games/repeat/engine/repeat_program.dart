import '../../path_finder/engine/lamp.dart';
import '../../path_finder/engine/path_finder_board.dart';

/// Programın bir bloğu: tek bir yön oku, kutu bloğu, "N kez tekrarla" bloğu ya da tanımlanan komutu
/// çağıran blok. Tekrar bloğunun içinde yalnızca oklar ve kutu blokları ([InnerBlock]) bulunur; iç içe
/// tekrar yoktur (7 yaş için sade tutuldu).
sealed class ProgramBlock {
  const ProgramBlock();

  /// Bloğun blok sınırından kapladığı yer: ok ve kutu bloğu 1, tekrar bloğu 1 + içindeki blok sayısı.
  int get size;
}

/// Tekrar bloğunun içine de konabilen tek parçalı bloklar: ok ve kutu blokları.
sealed class InnerBlock extends ProgramBlock {
  const InnerBlock();

  @override
  int get size => 1;
}

/// Robotu kutudaki sayı kadar kare yürüten ok. Kutu kullanılmayan oyunlarda kutu hep 1'dir.
final class MoveBlock extends InnerBlock {
  const MoveBlock(this.direction);

  final Direction direction;

  @override
  bool operator ==(Object other) => other is MoveBlock && other.direction == direction;

  @override
  int get hashCode => direction.hashCode;
}

/// "Değişken Kutusu" kuralları: kutu 1 ile başlar ve değeri hep [minValue]–[maxValue] arasında kalır.
abstract final class BoxRules {
  static const start = 1;
  static const minValue = 1;
  static const maxValue = 9;

  static int clamp(int value) => value.clamp(minValue, maxValue);
}

/// "kutu = N" bloğu: kutuya [value] koyar.
final class SetBoxBlock extends InnerBlock {
  const SetBoxBlock(this.value);

  /// Kutu düğmesinin eklediği bloğun değeri.
  static const defaultValue = 2;

  final int value;

  @override
  bool operator ==(Object other) => other is SetBoxBlock && other.value == value;

  @override
  int get hashCode => Object.hash(SetBoxBlock, value);
}

/// "kutu +1" ya da "kutu −1" bloğu: kutudaki sayıya [amount] ekler.
final class AddBoxBlock extends InnerBlock {
  const AddBoxBlock(this.amount);

  static const increment = AddBoxBlock(1);
  static const decrement = AddBoxBlock(-1);

  final int amount;

  @override
  bool operator ==(Object other) => other is AddBoxBlock && other.amount == amount;

  @override
  int get hashCode => Object.hash(AddBoxBlock, amount);
}

/// "Desen Bulmacası" Uzman grubunun "renk yak" bloğu: robot bulunduğu yerdeki lambayı [color] renginde yakar ve
/// bir kare ilerler ([direction]).
final class LightBlock extends InnerBlock {
  const LightBlock(this.color);

  /// Lambalar düz bir şerittir; robot her lambadan sonra sağa geçer.
  static const direction = Direction.right;

  final LampColor color;

  @override
  bool operator ==(Object other) => other is LightBlock && other.color == color;

  @override
  int get hashCode => Object.hash(LightBlock, color);
}

final class RepeatBlock extends ProgramBlock {
  const RepeatBlock(this.times, this.body);

  static const minTimes = 2;
  static const maxTimes = 6;
  static const defaultTimes = 2;

  final int times;
  final List<InnerBlock> body;

  @override
  int get size => 1 + body.length;

  RepeatBlock copyWith({int? times, List<InnerBlock>? body}) => RepeatBlock(times ?? this.times, body ?? this.body);

  @override
  bool operator ==(Object other) =>
      other is RepeatBlock &&
      other.times == times &&
      other.body.length == body.length &&
      body.indexed.every((entry) => other.body[entry.$1] == entry.$2);

  @override
  int get hashCode => Object.hash(times, Object.hashAll(body));
}

/// Oyuncunun tanımladığı komutu çağıran turkuaz yapboz bloğu ("Kendi Komutunu Oluştur"). Yalnızca ana
/// programda bulunur; komutun okları ayrı bir şeritte tanımlanır.
final class CallBlock extends ProgramBlock {
  const CallBlock();

  @override
  int get size => 1;

  @override
  bool operator ==(Object other) => other is CallBlock;

  @override
  int get hashCode => (CallBlock).hashCode;
}

/// Şeritteki bir yer. [inner] üst düzey blok için [ProgramPlace.topLevel], tekrar bloğunun
/// içindeki ok için o okun sırasıdır.
typedef ProgramPlace = ({int block, int inner});

/// Bir hareketin hangi bloktan, bloğun kaçıncı okundan ve kaçıncı turdan geldiği; [box] o anda kutudaki
/// sayıdır. Ekran bunu çalışırken bloğu, tur rozetini ve kutuyu göstermek için kullanır.
typedef ProgramStep = ({Direction direction, int block, int inner, int round, int box});

abstract final class Places {
  /// Üst düzey bloğun [ProgramPlace.inner] değeri.
  static const topLevel = -1;

  static ProgramPlace top(int block) => (block: block, inner: topLevel);

  static ProgramPlace of(ProgramStep step) => (block: step.block, inner: step.inner);

  static bool isInner(ProgramPlace place) => place.inner != topLevel;
}
