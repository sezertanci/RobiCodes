import '../../l10n/l10n.dart';
import 'engine/command_order_engine.dart';

/// Oyunun parçalardan kurulan metinleri. Düz metinler doğrudan ARB dosyalarından okunur; burada
/// yalnızca kart adı ve kutu numarası gibi değerleri metne yerleştiren yardımcılar bulunur.
/// Robotun söyledikleri [LocalizedText] döndürür; ekran onları o anki dilde çözer.
abstract final class CommandOrderTexts {
  static LocalizedText wrong(OrderWrong result, OrderCard card) =>
      (t) => switch (result.reason) {
        WrongReason.extra => t.commandOrderWrongExtra(card.step.text(t)),
        WrongReason.tooEarly => t.commandOrderWrongTooEarly(result.slot + 1, card.step.text(t)),
      };

  static LocalizedText hint(LocalizedText levelHint, OrderCard card, int slot) =>
      (t) => t.commandOrderHint(levelHint(t), card.step.text(t), slot + 1);

  static String slotCard(AppLocalizations t, int slot, OrderCard card) =>
      t.commandOrderSlotCard(slot + 1, card.step.text(t));

  static String emptySlot(AppLocalizations t, int slot) => t.commandOrderEmptySlot(slot + 1);
}
