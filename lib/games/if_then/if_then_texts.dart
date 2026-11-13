import 'engine/if_then_engine.dart';
import 'engine/if_then_level.dart';

/// Oyunun ekranda görünen metinleri. Web sürümündeki mesajların aynısıdır.
abstract final class IfThenTexts {
  static const incomplete = 'Önce boş kutuları doldur.';
  static const running = 'Robot yola çıktı...';
  static const success = 'Harika! Robot kurallarını izleyip bayrağa ulaştı!';
  static const solved = 'Kuralların doğru! Yeşil Başlat tuşuna dokun.';
  static const noSlot = 'Bu blok için boş kutu yok. Değiştirmek istediğin kutuya dokunup onu boşalt.';
  static const lockedSlot = 'Bu kutu hazır geldi, değiştirilemez. Bloğu boş bir kutuya koy.';
  static const wrongType = 'Bu blok oraya uymaz. Nesneler "Eğer" kutusuna, hareketler ok işaretinin yanına gider.';

  static const run = 'Başlat';
  static const hint = 'İpucu';
  static const clear = 'Temizle';
  static const lane = 'Robotun yolu';
  static const objects = 'Nesneler';
  static const actions = 'Hareketler';
  static const ifWord = 'Eğer';
  static const elseIfWord = 'Değilse eğer';
  static const elseWord = 'Değilse';
  static const thenWord = 'varsa';

  static String objectLabel(LaneObject object) => switch (object) {
    LaneObject.empty => 'Boş yol',
    LaneObject.rock => 'Taş',
    LaneObject.water => 'Su',
    LaneObject.door => 'Kapı',
    LaneObject.star => 'Yıldız',
  };

  static String actionLabel(LaneAction action) => switch (action) {
    LaneAction.forward => 'İleri Git',
    LaneAction.jump => 'Zıpla',
    LaneAction.bridge => 'Köprü Kur',
    LaneAction.open => 'Kapıyı Aç',
    LaneAction.collect => 'Topla',
  };

  static String _name(LaneObject object) => switch (object) {
    LaneObject.empty => 'boş yol',
    LaneObject.rock => 'taş',
    LaneObject.water => 'su',
    LaneObject.door => 'kapı',
    LaneObject.star => 'yıldız',
  };

  static String _problem(LaneObject object) => switch (object) {
    LaneObject.empty => 'Boş yolda buna gerek yok.',
    LaneObject.rock => 'Taşın içinden geçilemez.',
    LaneObject.water => 'Robot yüzemez!',
    LaneObject.door => 'Kapı kapalıyken geçilemez.',
    LaneObject.star => 'Yıldız yerde kaldı.',
  };

  static String _advice(LaneObject object) => switch (object) {
    LaneObject.empty => 'Yol boşsa robot ileri gidebilir.',
    LaneObject.rock => 'Taşın üstünden zıplayarak geçilir.',
    LaneObject.water => 'Suyun üstünden geçmek için köprü kurmak gerekir.',
    LaneObject.door => 'Kapıdan geçmek için önce kapıyı açmalısın.',
    LaneObject.star => 'Yıldızı almak için Topla bloğunu kullan.',
  };

  static String _ruleName(int rule) => rule == IfThenEngine.elseRule ? '"Değilse" satırı' : '${rule + 1}. kural';

  /// Yanlış harekette robotun söylediği cümle. Program tam olduğu için hareket her zaman doludur.
  static String wrong(LaneStep step) =>
      'Önünde ${_name(step.object)} vardı. ${_ruleName(step.rule)} çalıştı ve robot '
      '"${actionLabel(step.action!)}" yaptı. ${_problem(step.object)} Kuralları değiştirip yeniden dene.';

  static String hintText(LaneObject object) => 'Parlayan karede ${_name(object)} var. ${_advice(object)}';

  /// Bloğun adı: nesne veya hareket.
  static String label(Enum block) => block is LaneAction ? actionLabel(block) : objectLabel(block as LaneObject);

  /// Kutunun ekran okuyucu etiketi.
  static String slot({required bool condition, required Enum? value, required bool locked}) =>
      '${condition ? 'Koşul' : 'Hareket'} kutusu: ${value == null ? 'boş' : label(value)}${locked ? ', hazır' : ''}';

  /// Paletteki bloğun ekran okuyucu etiketi.
  static String paletteBlock(Enum block) => '${block is LaneAction ? 'Hareket' : 'Nesne'}: ${label(block)}';
}
