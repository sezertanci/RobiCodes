import 'engine/command_order_engine.dart';

/// Oyunun ekranda görünen metinleri. Web sürümündeki mesajların aynısıdır.
abstract final class CommandOrderTexts {
  static const intro = 'Görevi bitirmek için kartları doğru sıraya diz. Bir karta dokun ya da onu bir kutuya sürükle.';
  static const extrasIntro = 'Dikkat! Bazı kartlar bu göreve ait değil. Yalnızca gereken kartları sıraya diz.';
  static const full = 'Bütün kutular dolu. Bir kartı geri almak için ona dokun.';
  static const notFull = 'Önce bütün kutuları doldur.';
  static const success = 'Harika! Bütün adımlar doğru sırada.';
  static const solved = 'Sıralama doğru! Yeşil Kontrol et tuşuna dokun.';
  static const poolEmpty = 'Bütün kartlar yerleşti';
  static const check = 'Kontrol et';
  static const hint = 'İpucu';
  static const clear = 'Temizle';

  static String wrong(OrderWrong result, String cardText) => switch (result.reason) {
    WrongReason.extra => '«$cardText» bu görev için gerekli değil. Onu kutudan çıkar.',
    WrongReason.tooEarly =>
      '${result.slot + 1}. kutudaki «$cardText» için henüz erken. Ondan önce yapılması gereken bir adım var.',
  };

  static String hintText(String levelHint, String cardText, int slot) =>
      '$levelHint Parlayan kart «$cardText» ${slot + 1}. kutuya gelmeli.';

  static String slotCard(int slot, String cardText) => '${slot + 1}. kutu: $cardText. Geri almak için dokun.';

  static String emptySlot(int slot) => '${slot + 1}. kutu, boş. Kartın buraya gelmesi için dokun.';
}
