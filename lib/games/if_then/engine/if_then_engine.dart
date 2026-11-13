import 'if_then_level.dart';

/// Çocuğun kurduğu kurallardan biri. Kutular boşsa alanlar `null` olur.
typedef Rule = ({LaneObject? condition, LaneAction? action});

/// Çocuğun kurduğu program: sırayla denenen kurallar ve hiçbiri uymazsa yapılacak hareket.
final class IfThenProgram {
  const IfThenProgram({required this.rules, required this.otherwise});

  final List<Rule> rules;
  final LaneAction? otherwise;
}

/// Yoldaki bir karede verilen karar. [rule] kuralın sırasıdır; "Değilse" için [IfThenEngine.elseRule].
typedef LaneStep = ({int index, LaneObject object, LaneAction? action, int rule});

/// Programın çalıştırılma sonucu. Program doğruysa [failedIndex] `null` olur.
final class LaneRun {
  const LaneRun(this.steps, this.failedIndex);

  final List<LaneStep> steps;
  final int? failedIndex;

  bool get succeeded => failedIndex == null;
}

/// İlk sorunlu kare, oradaki nesne, gereken hareket ve o karede çalışan kural.
typedef LaneHint = ({int index, LaneObject object, LaneAction action, int rule});

/// "Eğer Böyleyse" oyununun kuralları. Robot düz bir yolda ilerler; her karede önündekine bakar ve
/// kurallardan ilk uyanını uygular, hiçbiri uymazsa "Değilse" hareketini yapar. Flutter'dan bağımsızdır.
abstract final class IfThenEngine {
  /// "Değilse" satırının kural sırası.
  static const elseRule = -1;

  static const _symbols = {
    '.': LaneObject.empty,
    '#': LaneObject.rock,
    '~': LaneObject.water,
    'D': LaneObject.door,
    '*': LaneObject.star,
  };

  static List<LaneObject> parseLane(String lane) => [
    for (final symbol in lane.split('')) _symbols[symbol] ?? (throw ArgumentError('Bilinmeyen yol işareti: $symbol')),
  ];

  /// Seviyede seçilebilecek bloklar: yoldaki ve çeldirici nesneler (boş yol hariç), onların doğru
  /// hareketleri ve her zaman İleri Git. İkisi de enum sırasıyla döner.
  static ({List<LaneObject> conditions, List<LaneAction> actions}) paletteFor(IfThenLevel level) {
    final objects = {...parseLane(level.lane), ...level.extras}..remove(LaneObject.empty);
    final conditions = [
      for (final object in LaneObject.values)
        if (objects.contains(object)) object,
    ];
    final needed = {for (final object in conditions) object.correctAction};
    final actions = [
      for (final action in LaneAction.values)
        if (action == LaneAction.forward || needed.contains(action)) action,
    ];
    return (conditions: conditions, actions: actions);
  }

  /// Önündeki nesneye göre çalışan kural ve yapılacak hareket.
  static ({LaneAction? action, int rule}) decide(IfThenProgram program, LaneObject object) {
    final rule = program.rules.indexWhere((candidate) => candidate.condition == object);
    return rule >= 0 ? (action: program.rules[rule].action, rule: rule) : (action: program.otherwise, rule: elseRule);
  }

  /// Programı yolun başından sonuna çalıştırır; ilk yanlış harekette durur.
  static LaneRun run(List<LaneObject> lane, IfThenProgram program) {
    final steps = <LaneStep>[];
    for (var index = 0; index < lane.length; index++) {
      final object = lane[index];
      final (:action, :rule) = decide(program, object);
      steps.add((index: index, object: object, action: action, rule: rule));
      if (action != object.correctAction) {
        return LaneRun(steps, index);
      }
    }
    return LaneRun(steps, null);
  }

  /// İlk sorunlu kareyi ve orada gereken hareketi döndürür; program doğruysa `null`.
  static LaneHint? findHint(List<LaneObject> lane, IfThenProgram program) {
    final result = run(lane, program);
    final failed = result.failedIndex;
    if (failed == null) {
      return null;
    }
    final step = result.steps[failed];
    return (index: step.index, object: step.object, action: step.object.correctAction, rule: step.rule);
  }
}
