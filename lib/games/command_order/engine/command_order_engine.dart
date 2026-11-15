import 'command_order_level.dart';

/// Oyundaki bir kart. Kimlik, adımın doğru sırasıdır (0, 1, 2...); göreve ait olmayan kartlar
/// adımlardan sonra numaralanır.
final class OrderCard {
  const OrderCard({required this.id, required this.step, required this.extra});

  final int id;
  final CommandStep step;

  /// `true` ise kart bu göreve ait değildir.
  final bool extra;

  String get icon => step.icon;
}

/// Kontrolün sonucu.
sealed class OrderCheck {
  const OrderCheck();
}

final class OrderCorrect extends OrderCheck {
  const OrderCorrect();
}

/// Soldan ilk yanlış kutu ve nedeni.
final class OrderWrong extends OrderCheck {
  const OrderWrong(this.slot, this.reason);

  final int slot;
  final WrongReason reason;
}

enum WrongReason {
  /// Kart bu görevde kullanılmaz.
  extra,

  /// Kart olması gerekenden önceki bir kutuda; ondan önce yapılacak bir adım var.
  tooEarly,
}

/// İpucu: [slot] kutusuna [cardId] kartı gelmeli.
typedef OrderHint = ({int slot, int cardId});

/// Oyunun kuralları. Ekrandan bağımsızdır; web sürümündeki `engine.js` ile aynı mantıktadır.
abstract final class CommandOrderEngine {
  // Basit, tekrarlanabilir rastgele sayı üreteci: aynı tohum her zaman aynı karışık sırayı verir.
  static const _lcgMultiplier = 1103515245;
  static const _lcgIncrement = 12345;
  static const lcgModulus = 1 << 31;

  /// Karışık sıra çözülmüş ya da kaçınılan sıraya denk gelirse yeniden karıştırma sınırı.
  static const _maxShuffleAttempts = 20;

  /// Seviyedeki adımları ve göreve ait olmayan kartları tek bir kart listesine çevirir.
  static List<OrderCard> buildCards(CommandOrderLevel level) => [
    for (final (index, step) in level.steps.indexed) OrderCard(id: index, step: step, extra: false),
    for (final (index, step) in level.extras.indexed)
      OrderCard(id: level.steps.length + index, step: step, extra: true),
  ];

  /// Kartları karıştırır. Sonuç hiçbir zaman zaten doğru sıralı olmaz. [avoidIds] kaçınılacak
  /// sıradır (ör. bir önceki açılış); başka sıra bulunamazsa yine de gelebilir.
  static List<OrderCard> shuffleCards(List<OrderCard> cards, int seed, [List<int> avoidIds = const []]) {
    final random = _Lcg(seed);
    var result = _shuffleOnce(cards, random);
    for (
      var attempt = 1;
      attempt < _maxShuffleAttempts && (_isInOrder(result) || _hasOrder(result, avoidIds));
      attempt++
    ) {
      result = _shuffleOnce(cards, random);
    }
    if (_isInOrder(result)) {
      result.add(result.removeAt(0));
    }
    return result;
  }

  /// Kutulardaki sırayı denetler ve soldan ilk yanlış kutuyu bildirir. İlk yanlış kutudan
  /// öncekiler doğru olduğu için oradaki kart ya göreve ait değildir ya da erkene konmuştur.
  static OrderCheck checkOrder(List<int?> slots) {
    final slot = _firstMismatch(slots);
    if (slot < 0) {
      return const OrderCorrect();
    }
    final cardId = slots[slot];
    final reason = cardId != null && cardId >= slots.length ? WrongReason.extra : WrongReason.tooEarly;
    return OrderWrong(slot, reason);
  }

  /// İlk yanlış ya da boş kutuyu ve oraya gelmesi gereken kartı döndürür; sıra doğruysa `null`.
  static OrderHint? nextHint(List<int?> slots) {
    final slot = _firstMismatch(slots);
    return slot < 0 ? null : (slot: slot, cardId: slot);
  }

  static int _firstMismatch(List<int?> slots) {
    for (final (index, cardId) in slots.indexed) {
      if (cardId != index) {
        return index;
      }
    }
    return -1;
  }

  static bool _isInOrder(List<OrderCard> cards) => _hasOrder(cards, [for (var i = 0; i < cards.length; i++) i]);

  static bool _hasOrder(List<OrderCard> cards, List<int> ids) {
    if (cards.length != ids.length) {
      return false;
    }
    for (final (index, card) in cards.indexed) {
      if (card.id != ids[index]) {
        return false;
      }
    }
    return true;
  }

  static List<OrderCard> _shuffleOnce(List<OrderCard> cards, _Lcg random) {
    final result = [...cards];
    for (var index = result.length - 1; index > 0; index--) {
      final other = (random.next() * (index + 1)).floor();
      final swap = result[index];
      result[index] = result[other];
      result[other] = swap;
    }
    return result;
  }
}

final class _Lcg {
  _Lcg(this._value);

  int _value;

  /// 0 (dahil) ile 1 (hariç) arasında sayı.
  double next() {
    _value =
        (_value * CommandOrderEngine._lcgMultiplier + CommandOrderEngine._lcgIncrement) % CommandOrderEngine.lcgModulus;
    return _value / CommandOrderEngine.lcgModulus;
  }
}
