import 'package:flutter/foundation.dart';

import '../../features/play/play_timings.dart';
import '../../features/play/widgets/robot_sprite.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import 'engine/if_then_engine.dart';
import 'engine/if_then_level.dart';
import 'if_then_texts.dart';

/// Kural satırındaki kutunun türü: koşul ("Eğer ... varsa") veya hareket ("→ ...").
enum SlotPart { condition, action }

/// Bir kutunun yeri. "Değilse" satırının hareket kutusu için [rule] [IfThenEngine.elseRule] olur.
typedef SlotRef = ({int rule, SlotPart part});

/// Bir seviyenin oynanış durumu: kutulardaki bloklar, seçili kutu, işaretler ve robotun yolculuğu.
/// Ekrandan bağımsızdır; bu yüzden widget olmadan test edilebilir.
final class IfThenController extends ChangeNotifier {
  IfThenController({
    required this.level,
    required this.onCompleted,
    this.stepDuration = defaultStepDuration,
    this.celebrateDuration = defaultCelebrateDuration,
  }) : lane = IfThenEngine.parseLane(level.lane),
       palette = IfThenEngine.paletteFor(level),
       _conditions = [for (final rule in level.rules) rule.condition],
       _actions = [for (final rule in level.rules) rule.action],
       _otherwise = level.otherwise,
       _message = level.intro;

  static const defaultStepDuration = Duration(milliseconds: 650);
  static const reducedStepDuration = PlayTimings.reducedStep;
  static const defaultCelebrateDuration = PlayTimings.celebrate;

  /// Robot başlangıç karesindeyken [robotCell] değeri.
  static const startCell = -1;

  final IfThenLevel level;
  final List<LaneObject> lane;
  final ({List<LaneObject> conditions, List<LaneAction> actions}) palette;
  final ValueChanged<int> onCompleted;
  final Duration stepDuration;
  final Duration celebrateDuration;

  final List<LaneObject?> _conditions;
  final List<LaneAction?> _actions;
  LaneAction? _otherwise;
  SlotRef? _target;
  String _message;
  RobotMood _mood = RobotMood.talk;
  int _robotCell = startCell;
  bool _jumpPending = false;
  int? _activeRule;
  int? _wrongCell;
  int? _wrongRule;
  int _wrongCount = 0;
  LaneHint? _hint;
  RobotReaction _reaction = RobotReaction.none;
  int _reactionCount = 0;
  int _runs = 0;
  bool _hintUsed = false;
  bool _running = false;
  bool _done = false;
  bool _disposed = false;

  String get message => _message;
  RobotMood get mood => _mood;
  SlotRef? get target => _target;

  /// Robotun durduğu kare: [startCell] başlangıç, `lane.length` bayrak. Robotun geçtiği kareler
  /// (köprü kurulan su, açılan kapı, toplanan yıldız) bu sıraya kadar olanlardır.
  int get robotCell => _robotCell;

  /// Robot yürürken o an çalışan kural.
  int? get activeRule => _activeRule;
  int? get wrongCell => _wrongCell;
  int? get wrongRule => _wrongRule;

  /// Her yanlış denemede artar; ekran yanlış kuralı her seferinde yeniden sallar.
  int get wrongCount => _wrongCount;
  LaneHint? get hint => _hint;
  RobotReaction get reaction => _reaction;
  int get reactionCount => _reactionCount;
  bool get hintUsed => _hintUsed;
  bool get isRunning => _running;
  bool get isDone => _done;
  bool get isEditable => !_running && !_done;

  /// Bir koşul kutusu çocuğa açıksa "Nesneler" grubu gösterilir.
  bool get needsConditions => level.rules.any((rule) => rule.condition == null);

  /// Ekrandaki sırayla bütün kutular: her kuralın koşulu ve hareketi, en sonda "Değilse".
  List<SlotRef> get slotRefs => [
    for (var rule = 0; rule < level.rules.length; rule++) ...[
      (rule: rule, part: SlotPart.condition),
      (rule: rule, part: SlotPart.action),
    ],
    (rule: IfThenEngine.elseRule, part: SlotPart.action),
  ];

  /// Kutudaki blok ([LaneObject] veya [LaneAction]); boşsa `null`.
  Enum? valueOf(SlotRef slot) => switch (slot) {
    (rule: IfThenEngine.elseRule, part: _) => _otherwise,
    (:final rule, part: SlotPart.condition) => _conditions[rule],
    (:final rule, part: SlotPart.action) => _actions[rule],
  };

  /// Hazır gelen kutular değiştirilemez.
  bool isLocked(SlotRef slot) => switch (slot) {
    (rule: IfThenEngine.elseRule, part: _) => level.otherwise != null,
    (:final rule, part: SlotPart.condition) => level.rules[rule].condition != null,
    (:final rule, part: SlotPart.action) => level.rules[rule].action != null,
  };

  bool get isComplete => slotRefs.every((slot) => valueOf(slot) != null);

  IfThenProgram get program => IfThenProgram(
    rules: [for (var i = 0; i < _conditions.length; i++) (condition: _conditions[i], action: _actions[i])],
    otherwise: _otherwise,
  );

  /// Paletteki bloğa dokunulunca blok seçili kutuya, uymuyorsa aynı türdeki ilk boş kutuya gider.
  void tapBlock(Enum block) {
    if (!isEditable) {
      return;
    }
    final target = _target;
    final slot = target != null && _accepts(target, block) ? target : _firstEmptyFor(block);
    if (slot == null) {
      _sayNow(IfThenTexts.noSlot);
      return;
    }
    _change(() => _set(slot, block));
  }

  /// Sürüklenen blok kutuya bırakılır; kutudaki eski blok varsa onun yerini alır.
  void dropBlock(Enum block, SlotRef slot) {
    if (!isEditable) {
      return;
    }
    if (isLocked(slot)) {
      _sayNow(IfThenTexts.lockedSlot);
    } else if (!_fits(slot, block)) {
      _sayNow(IfThenTexts.wrongType);
    } else {
      _change(() => _set(slot, block));
    }
  }

  /// Dolu kutuya dokunmak onu boşaltır; boş kutuya dokunmak onu hedef seçer veya seçimi kaldırır.
  void tapSlot(SlotRef slot) {
    if (!isEditable) {
      return;
    }
    if (isLocked(slot)) {
      _sayNow(IfThenTexts.lockedSlot);
    } else if (valueOf(slot) != null) {
      _change(() => _set(slot, null));
    } else {
      _target = _target == slot ? null : slot;
      notifyListeners();
    }
  }

  /// Çocuğun doldurduğu kutuları boşaltır.
  void clear() {
    if (!isEditable) {
      return;
    }
    for (final slot in slotRefs) {
      if (!isLocked(slot)) {
        _set(slot, null);
      }
    }
    _target = null;
    _resetScene();
    _sayNow(level.intro);
  }

  /// İlk sorunlu kareyi, orada çalışan kuralı ve gereken hareketi gösterir. İpucu bir kez
  /// kullanılınca seviyeden en fazla 1 yıldız alınır.
  void showHint() {
    if (!isEditable) {
      return;
    }
    _hintUsed = true;
    _resetScene();
    final hint = IfThenEngine.findHint(lane, program);
    _hint = hint;
    _sayNow(hint == null ? IfThenTexts.solved : IfThenTexts.hintText(hint.object));
  }

  /// Kuralları çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  Future<void> run() async {
    if (!isEditable) {
      return;
    }
    if (!isComplete) {
      _sayNow(IfThenTexts.incomplete);
      return;
    }
    _running = true;
    _runs++;
    _target = null;
    _resetScene();
    _sayNow(IfThenTexts.running);
    final result = IfThenEngine.run(lane, program);
    // Yanlış adımdan önceki adımların hepsi doğrudur; robot onları yürür.
    if (!await _walk(result.steps.take(result.failedIndex ?? result.steps.length))) {
      return;
    }
    if (result.failedIndex case final failed?) {
      _fail(result.steps[failed]);
    } else {
      await _succeed();
    }
  }

  /// Doğru adımları sırayla oynatır. Ekran kapanırsa `false` döner.
  ///
  /// Taşın üstüne inilmez: zıplama adımında robot taşın önünde bekler, bir sonraki hareketle taşın
  /// üstünden atlayıp taştan sonraki kareye (ya da bayrağa) iner.
  Future<bool> _walk(Iterable<LaneStep> steps) async {
    for (final step in steps) {
      _activeRule = step.rule;
      final jump = step.action == LaneAction.jump;
      if (jump) {
        _jumpPending = true;
      } else {
        _moveRobot(step.index);
      }
      notifyListeners();
      await Future<void>.delayed(jump ? stepDuration ~/ 2 : stepDuration);
      if (_disposed) {
        return false;
      }
    }
    return true;
  }

  /// Robotu [cell] karesine götürür; bekleyen bir zıplama varsa bu geçiş zıplayarak yapılır.
  void _moveRobot(int cell) {
    if (_jumpPending) {
      _react(RobotReaction.hop);
      _jumpPending = false;
    }
    _robotCell = cell;
  }

  void _fail(LaneStep step) {
    _activeRule = null;
    _jumpPending = false;
    _wrongCell = step.index;
    _wrongRule = step.rule;
    _wrongCount++;
    _react(RobotReaction.bump);
    _running = false;
    _sayNow(IfThenTexts.wrong(step), RobotMood.sad);
  }

  Future<void> _succeed() async {
    _activeRule = null;
    _moveRobot(lane.length);
    notifyListeners();
    await Future<void>.delayed(stepDuration);
    if (_disposed) {
      return;
    }
    _running = false;
    _done = true;
    _react(RobotReaction.celebrate);
    _sayNow(IfThenTexts.success, RobotMood.happy);
    final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: _runs == 1);
    await Future<void>.delayed(celebrateDuration);
    if (!_disposed) {
      onCompleted(stars);
    }
  }

  static bool _fits(SlotRef slot, Enum block) =>
      slot.part == SlotPart.condition ? block is LaneObject : block is LaneAction;

  bool _accepts(SlotRef slot, Enum block) => _fits(slot, block) && !isLocked(slot);

  SlotRef? _firstEmptyFor(Enum block) {
    for (final slot in slotRefs) {
      if (_accepts(slot, block) && valueOf(slot) == null) {
        return slot;
      }
    }
    return null;
  }

  void _set(SlotRef slot, Enum? block) {
    switch (slot) {
      case (rule: IfThenEngine.elseRule, part: _):
        _otherwise = block as LaneAction?;
      case (:final rule, part: SlotPart.condition):
        _conditions[rule] = block as LaneObject?;
      case (:final rule, part: SlotPart.action):
        _actions[rule] = block as LaneAction?;
    }
  }

  /// Kurallar değişince robot başa döner, işaretler silinir; işaret varsa açılış cümlesine dönülür.
  void _change(VoidCallback update) {
    update();
    _target = null;
    if (_hasMarks) {
      _say(level.intro);
    }
    _resetScene();
    notifyListeners();
  }

  bool get _hasMarks => _robotCell != startCell || _wrongCell != null || _hint != null;

  void _resetScene() {
    _robotCell = startCell;
    _jumpPending = false;
    _activeRule = null;
    _wrongCell = null;
    _wrongRule = null;
    _hint = null;
    _reaction = RobotReaction.none;
  }

  void _react(RobotReaction reaction) {
    _reaction = reaction;
    _reactionCount++;
  }

  void _say(String text, [RobotMood mood = RobotMood.talk]) {
    _message = text;
    _mood = mood;
  }

  void _sayNow(String text, [RobotMood mood = RobotMood.talk]) {
    _say(text, mood);
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
