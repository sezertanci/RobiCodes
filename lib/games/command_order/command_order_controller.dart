import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/play_timings.dart';
import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import '../../l10n/l10n.dart';
import 'command_order_texts.dart';
import 'engine/command_order_engine.dart';
import 'engine/command_order_level.dart';

/// Kutudaki işaretin türü: yanlış kart (kırmızı) veya ipucu (sarı).
enum SlotMarkKind { wrong, hint }

/// Bir kutunun işareti. İpucunda parlayan kart da [cardId] ile gösterilir.
typedef SlotMark = ({int slot, int? cardId, SlotMarkKind kind});

/// Bir seviyenin oynanış durumu: kutulardaki kartlar, seçili kutu, işaretler ve sonuç.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class CommandOrderController extends ChangeNotifier with LevelLifecycle {
  CommandOrderController({
    required this.level,
    required List<OrderCard> cards,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.celebrateDuration = defaultCelebrateDuration,
  }) : cards = List.unmodifiable(cards),
       _slots = List<int?>.filled(level.steps.length, null),
       _voice = RobotVoice(feedback: feedback, intro: _introOf(level));

  static const defaultCelebrateDuration = PlayTimings.celebrate;

  final CommandOrderLevel level;

  /// Kartlar, ekranda gösterilen karışık sırayla.
  final List<OrderCard> cards;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;
  final Duration celebrateDuration;

  final List<int?> _slots;
  final RobotVoice _voice;
  int? _target;
  SlotMark? _mark;
  int _wrongCount = 0;
  bool _hintUsed = false;
  int _failedChecks = 0;
  bool _done = false;

  /// Her kutudaki kartın kimliği; boş kutu `null`.
  List<int?> get slots => List.unmodifiable(_slots);
  int? get target => _target;
  SlotMark? get mark => _mark;
  LocalizedText get message => _voice.message;
  RobotMood get mood => _voice.mood;

  /// Her yanlış kontrolde artar; ekran yanlış kartı her seferinde yeniden sallar.
  int get wrongCount => _wrongCount;
  bool get hintUsed => _hintUsed;
  bool get isDone => _done;
  bool get isFull => !_slots.contains(null);

  /// Henüz bir kutuya konmamış kartlar, karışık sırayla.
  List<OrderCard> get poolCards => [
    for (final card in cards)
      if (!_slots.contains(card.id)) card,
  ];

  OrderCard cardOf(int cardId) => cards.firstWhere((card) => card.id == cardId);

  /// Kartın karışık sıradaki yeri; ekran kart rengini buna göre seçer.
  int positionOf(int cardId) => cards.indexWhere((card) => card.id == cardId);

  /// Havuzdaki kartı seçili kutuya, seçili kutu yoksa ilk boş kutuya koyar.
  void tapPoolCard(int cardId) {
    if (_done) {
      return;
    }
    final slot = _target ?? _slots.indexOf(null);
    if (slot < 0) {
      _voice.say((t) => t.commandOrderFull);
      notifyListeners();
      return;
    }
    _change(() {
      _slots[slot] = cardId;
      _target = null;
    });
  }

  /// Kutudaki kartı havuza geri gönderir.
  void returnToPool(int slot) {
    if (_done || _slots[slot] == null) {
      return;
    }
    _change(() => _slots[slot] = null);
  }

  /// Boş kutuyu hedef olarak seçer; seçili kutuya dokunulursa seçim kalkar.
  void toggleTarget(int slot) {
    if (_done) {
      return;
    }
    _target = _target == slot ? null : slot;
    notifyListeners();
  }

  /// Sürüklenen kartı [toSlot] kutusuna bırakır. Kart bir kutudan geldiyse ([fromSlot]) iki kutu
  /// yer değiştirir; havuzdan geldiyse kutudaki eski kart havuza döner.
  void dropOnSlot(int cardId, int? fromSlot, int toSlot) {
    if (_done || toSlot == fromSlot) {
      return;
    }
    _change(() {
      if (fromSlot != null) {
        _slots[fromSlot] = _slots[toSlot];
      }
      _slots[toSlot] = cardId;
      _target = null;
    });
  }

  /// Bütün kutuları boşaltır.
  void clear() {
    if (_done) {
      return;
    }
    _voice.say(_introOf(level));
    _change(() {
      _slots.fillRange(0, _slots.length, null);
      _target = null;
    });
  }

  /// Sırayı denetler. Doğruysa kutlamadan sonra yıldızları bildirir.
  Future<void> check() async {
    if (_done) {
      return;
    }
    if (!isFull) {
      _voice.say((t) => t.commandOrderNotFull);
      notifyListeners();
      return;
    }
    switch (CommandOrderEngine.checkOrder(_slots)) {
      case OrderCorrect():
        await _finish();
      case final OrderWrong wrong:
        _failedChecks++;
        _wrongCount++;
        _mark = (slot: wrong.slot, cardId: null, kind: SlotMarkKind.wrong);
        _voice.say(CommandOrderTexts.wrong(wrong, cardOf(_slots[wrong.slot]!)), RobotMood.sad);
        notifyListeners();
    }
  }

  /// İpucu ister: ilk yanlış ya da boş kutu seçilir ve oraya gelecek kart parlar.
  /// İpucu bir kez kullanılınca seviyeden en fazla 1 yıldız alınır.
  void showHint() {
    if (_done) {
      return;
    }
    _hintUsed = true;
    final hint = CommandOrderEngine.nextHint(_slots);
    if (hint == null) {
      _voice.say((t) => t.commandOrderSolved);
    } else {
      _mark = (slot: hint.slot, cardId: hint.cardId, kind: SlotMarkKind.hint);
      // Kutu seçili kalır; parlayan karta dokununca kart oraya gider, kutudaki yanlış kart havuza döner.
      _target = hint.slot;
      _voice.say(CommandOrderTexts.hint(level.hint, cardOf(hint.cardId), hint.slot));
    }
    notifyListeners();
  }

  Future<void> _finish() async {
    _done = true;
    _target = null;
    _mark = null;
    _voice.say((t) => t.commandOrderSuccess, RobotMood.happy);
    notifyListeners();
    final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: _failedChecks == 0);
    await completeAfter(celebrateDuration, onCompleted, stars);
  }

  /// Sıra değişince eski yanlış veya ipucu işareti ve ona ait mesaj silinir.
  void _change(VoidCallback update) {
    update();
    if (_mark != null) {
      _voice.say(_introOf(level));
    }
    _mark = null;
    notifyListeners();
  }

  static LocalizedText _introOf(CommandOrderLevel level) =>
      (t) => level.extras.isEmpty ? t.commandOrderIntro : t.commandOrderExtrasIntro;
}
