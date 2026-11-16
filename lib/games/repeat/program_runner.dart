import 'package:flutter/foundation.dart';

import '../../features/play/game_feedback.dart';
import '../../features/play/level_lifecycle.dart';
import '../../features/play/widgets/robot_sprite.dart';
import '../../features/play/widgets/speech_bubble.dart';
import '../../features/progress/star_rule.dart';
import '../../l10n/l10n.dart';
import '../path_finder/board_scene.dart';
import '../path_finder/engine/path_finder_engine.dart';
import 'engine/repeat_engine.dart';
import 'engine/repeat_program.dart';

/// Blok programı yazılan oyunların ("Tekrar Et", "Kendi Komutunu Oluştur") ortak oynanışı: programı
/// çalıştırıp robotu yürütme, sonucu söyleme, ipucu ve Tekrarla düğmesinin blok sınırı kuralı.
/// Denetleyici yalnızca oyuna özgü adımları (çalıştırmadan önceki denetim, hareketin şeritteki yeri,
/// çarpınca gösterilen yer) verir.
mixin ProgramRunner on LevelLifecycle, BoardRunScene {
  /// Tekrarla bloğu ile içindeki bir ok en az iki blok yer kaplar.
  static const repeatWithMove = 2;

  bool _running = false;
  bool _hintUsed = false;

  ValueChanged<int> get onCompleted;
  GameFeedback get feedback;
  Duration get celebrateDuration;
  int get blockCount;
  int get maxBlocks;

  /// 3 yıldız için en fazla blok sayısı.
  int get targetBlocks;
  bool get allowsRepeat;
  bool get isInsideRepeat;

  /// Robot bayrağa ulaşmadığında söylenen metin.
  @protected
  LocalizedText get missedGoalText;

  bool get isRunning => _running;
  bool get hintUsed => _hintUsed;
  LocalizedText get message => voice.message;
  RobotMood get mood => voice.mood;

  /// Tekrarla düğmesi blok açıkken bloktan çıkarır; kapalıyken ancak blok ve içine bir ok sığıyorsa ekler.
  bool get canUseRepeatButton =>
      allowsRepeat && !_running && (isInsideRepeat || blockCount + repeatWithMove <= maxBlocks);

  /// Çalıştırmadan önce eksikleri söyler; program çalıştırılabilirse `true` döner.
  @protected
  bool readyToRun();

  /// Çalışma başlarken açık blokları ve seçimleri kapatır.
  @protected
  void prepareRun();

  /// Programı çalıştırır; robot sonucun izinden yürütülür.
  @protected
  RepeatRun startRun();

  /// Robot [index]. hareketi yaparken şeritlerde o hareketin yerini gösterir.
  @protected
  void showStep(int index);

  /// Çalışma bitince şeritlerdeki etkin hareketi kaldırır.
  @protected
  void clearActiveStep();

  /// Robot [index]. harekette ([step]) çarptı; yanlış yeri işaretleyip nedenini söyler.
  @protected
  void showBlocked(RunResult result, ProgramStep step, int index);

  /// Robotun başa döndüğünde silinen işaretler.
  @protected
  void clearRunMarks();

  /// İpucunu kullanılmış sayar ve eski ipucunu siler. İpucu bir kez kullanılınca seviyeden en fazla
  /// 1 yıldız alınır.
  @protected
  void useHint() {
    _hintUsed = true;
    boardRun.hint = null;
  }

  /// Programı çalıştırır ve robotu adım adım yürütür. Başarıda kutlamadan sonra yıldızları bildirir.
  Future<void> run() async {
    if (_running) {
      return;
    }
    if (!readyToRun()) {
      notifyListeners();
      return;
    }
    _running = true;
    prepareRun();
    resetBoard();
    voice.say((t) => t.gameRobotRunning);
    notifyListeners();
    final run = startRun();
    final played = await boardRun.play(
      run.result,
      directions: [for (final step in run.trace) step.direction],
      stepDuration: stepDuration,
      onStep: showStep,
      onMove: feedback.step,
      notify: notifyListeners,
      isStopped: () => isDisposed,
    );
    if (played) {
      await _finish(run);
    }
  }

  Future<void> _finish(RepeatRun run) async {
    clearActiveStep();
    final result = run.result;
    switch (result.outcome) {
      case RunOutcome.success:
        voice.say((t) => t.gameRobotReachedFlag, RobotMood.happy);
        voice.react(RobotReaction.celebrate);
        notifyListeners();
        final stars = StarRule.calculate(hintUsed: _hintUsed, targetMet: blockCount <= targetBlocks);
        await completeAfter(celebrateDuration, onCompleted, stars);
        return;
      case RunOutcome.blocked:
        final index = result.failedIndex!;
        boardRun.bumpDirection = run.trace[index].direction;
        voice.react(RobotReaction.bump);
        showBlocked(result, run.trace[index], index);
      case RunOutcome.missedGoal || RunOutcome.missingCoins:
        voice.react(RobotReaction.shake);
        final missingCoins = result.outcome == RunOutcome.missingCoins;
        voice.say(missingCoins ? (t) => t.gameMissingCoins : missedGoalText, RobotMood.sad);
    }
    _running = false;
    notifyListeners();
  }

  /// Robot başa döner; ipucu ve işaretler silinir.
  @protected
  void resetBoard() {
    boardRun.reset();
    clearRunMarks();
    voice.calm();
  }
}
