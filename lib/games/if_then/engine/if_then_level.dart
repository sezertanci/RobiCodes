import '../../../l10n/l10n.dart';

/// Robotun yapabileceği hareketler. Sıra, paletteki sıradır.
enum LaneAction { forward, jump, bridge, open, collect }

/// Yoldaki bir karede bulunabilecek şey ve onun için tek doğru hareket. Sıra, paletteki sıradır.
enum LaneObject {
  empty(LaneAction.forward),
  rock(LaneAction.jump),
  water(LaneAction.bridge),
  door(LaneAction.open),
  star(LaneAction.collect);

  const LaneObject(this.correctAction);

  final LaneAction correctAction;
}

/// Seviyedeki bir "Eğer ... varsa → ..." satırı. Verilen kutu hazır ve kilitli gelir; `null` olanı
/// çocuk doldurur.
final class RuleSlot {
  const RuleSlot({this.condition, this.action});

  final LaneObject? condition;
  final LaneAction? action;
}

/// "Eğer Böyleyse" seviyesi.
final class IfThenLevel {
  const IfThenLevel({
    required this.lane,
    required this.rules,
    required this.intro,
    this.otherwise,
    this.extras = const [],
  });

  /// Robotun geçeceği kareler, soldan sağa. İşaretler: `.` boş yol, `#` taş, `~` su, `D` kapı,
  /// `*` yıldız. Robot başlangıç karesinden çıkar, son kareden sonra bayrağa varır.
  final String lane;

  final List<RuleSlot> rules;

  /// Hazır gelen "Değilse" hareketi; `null` ise çocuk seçer.
  final LaneAction? otherwise;

  /// Yolda olmayan ama blok olarak gösterilen nesneler (çeldirici).
  final List<LaneObject> extras;

  /// Robotun seviye başında söylediği cümle.
  final LocalizedText intro;
}
