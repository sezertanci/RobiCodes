import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/play_timings.dart';
import '../../features/play/robot_voice.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import '../../l10n/l10n.dart';
import 'engine/pattern_level.dart';
import 'engine/pattern_tile.dart';

/// "Desen Bulmacası" Kolay–Zor gruplarının oynanışı: eksik parçalar alttaki seçeneklerden seçilir. Seçilen
/// parça hemen denetlenir; doğruysa yerine oturur, yanlışsa bir süre kırmızı yanıp söner ve kaldırılır.
/// Ekrandan bağımsızdır; widget olmadan test edilebilir.
final class PatternPuzzleController extends ChangeNotifier with LevelLifecycle {
  PatternPuzzleController({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.celebrateDuration = PlayTimings.celebrate,
    this.wrongDuration = defaultWrongDuration,
  }) : _voice = RobotVoice(feedback: feedback, intro: level.intro),
       _selected = level.missing.first;

  /// Yanlış parçanın kaldırılmadan önce yanıp söndüğü süre.
  static const defaultWrongDuration = Duration(milliseconds: 900);

  final PatternPuzzleLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;
  final Duration celebrateDuration;
  final Duration wrongDuration;

  final RobotVoice _voice;
  final Set<int> _filled = {};
  int? _selected;
  int? _wrongSlot;
  PatternTile? _wrongTile;
  PatternTile? _highlighted;

  /// Her yanlış seçimde artar; yanıp sönme bitince yalnızca son yanlış parça kaldırılır.
  int _wrongCount = 0;
  bool _mistake = false;
  bool _hintUsed = false;
  bool _done = false;

  LocalizedText get message => _voice.message;
  RobotMood get mood => _voice.mood;

  /// Seçeneğin dolduracağı eksik parçanın sırası.
  int? get selected => _selected;

  /// Yanlış parçanın yanıp söndüğü yer.
  int? get wrongSlot => _wrongSlot;

  /// İpucunun parlattığı seçenek.
  PatternTile? get highlighted => _highlighted;
  bool get hintUsed => _hintUsed;
  bool get isDone => _done;

  bool isMissing(int index) => level.missing.contains(index);

  /// [index]te görünen parça: eksik ve henüz doldurulmamış yerde yanıp sönen yanlış parça ya da `null`.
  PatternTile? shownTile(int index) {
    if (!isMissing(index) || _filled.contains(index)) {
      return level.tiles[index];
    }
    return index == _wrongSlot ? _wrongTile : null;
  }

  /// Boş bir eksik parçaya dokunulunca seçenekler onu doldurur.
  void selectSlot(int index) {
    if (_done || !isMissing(index) || _filled.contains(index)) {
      return;
    }
    _selected = index;
    notifyListeners();
  }

  /// Seçeneği seçili yere koyar ve hemen denetler.
  Future<void> pick(PatternTile option) async {
    final slot = _selected;
    if (_done || slot == null) {
      return;
    }
    _highlighted = null;
    if (option == level.tiles[slot]) {
      await _fill(slot);
      return;
    }
    _mistake = true;
    _wrongSlot = slot;
    _wrongTile = option;
    final attempt = ++_wrongCount;
    _voice.say((t) => t.patternWrongLamp, RobotMood.sad);
    notifyListeners();
    await Future<void>.delayed(wrongDuration);
    if (!isDisposed && attempt == _wrongCount && _wrongSlot == slot) {
      _clearWrong();
      notifyListeners();
    }
  }

  /// İpucu doğru seçeneği parlatır ve deseni anlatan ipucunu söyler. İpucu kullanılınca en fazla 1 yıldız alınır.
  void showHint() {
    final slot = _selected;
    if (_done || slot == null) {
      return;
    }
    _hintUsed = true;
    _highlighted = level.tiles[slot];
    _voice.say(level.hint);
    notifyListeners();
  }

  Future<void> _fill(int slot) async {
    _filled.add(slot);
    _clearWrong();
    _selected = _nextEmpty();
    if (_selected != null) {
      _voice.say((t) => t.patternRightLamp, RobotMood.happy);
      notifyListeners();
      return;
    }
    _done = true;
    _voice.say((t) => t.patternSolved, RobotMood.happy);
    notifyListeners();
    final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: !_mistake);
    await completeAfter(celebrateDuration, onCompleted, stars);
  }

  int? _nextEmpty() {
    for (final index in level.missing) {
      if (!_filled.contains(index)) {
        return index;
      }
    }
    return null;
  }

  void _clearWrong() {
    _wrongSlot = null;
    _wrongTile = null;
  }
}
