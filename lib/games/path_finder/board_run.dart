import 'package:flutter/foundation.dart';

import 'engine/path_finder_board.dart';
import 'engine/path_finder_engine.dart';

/// Haritadaki yolculuğun durumu: robotun konumu, izi, toplanan altınlar, ipucu ve çarpma yönü.
/// "Robotun Yolunu Bul" ve "Tekrar Et" denetleyicileri yolculuğu bu sınıfla oynatır.
final class BoardRun {
  BoardRun(this.board) : _robot = board.start;

  final PathFinderBoard board;

  final Set<int> _collected = {};
  final Map<GridPoint, Direction> _trail = {};
  GridPoint _robot;

  /// İpucunun parlattığı kare ve yön.
  NextMoveHint? hint;

  /// Robotun en son çarptığı yön.
  Direction? bumpDirection;

  GridPoint get robot => _robot;
  Set<int> get collectedCoins => Set.unmodifiable(_collected);

  /// Robotun ayrıldığı kareler ve o karelerden çıktığı son yön.
  Map<GridPoint, Direction> get trail => Map.unmodifiable(_trail);

  /// Robotu başlangıç karesine döndürür; iz, toplanan altınlar ve ipucu silinir.
  void reset() {
    _robot = board.start;
    _collected.clear();
    _trail.clear();
    hint = null;
  }

  /// [result] adımlarını [stepDuration] arayla oynatır. [directions] her adımda robotun gittiği
  /// yöndür; [onStep] adım başlarken, [onMove] robot yeni kareye geçince (adım sesi için) çağrılır,
  /// [notify] ekranı günceller. Bekleme sırasında
  /// [isStopped] `true` olursa (ekran kapandıysa) oynatma durur ve `false` döner.
  Future<bool> play(
    RunResult result, {
    required List<Direction> directions,
    required Duration stepDuration,
    required ValueChanged<int> onStep,
    required VoidCallback onMove,
    required VoidCallback notify,
    required ValueGetter<bool> isStopped,
  }) async {
    for (final (index, step) in result.steps.indexed) {
      onStep(index);
      _trail[_robot] = directions[index];
      _robot = step.position;
      onMove();
      notify();
      await Future<void>.delayed(stepDuration);
      if (isStopped()) {
        return false;
      }
      if (step.coin case final coin?) {
        _collected.add(coin);
        notify();
      }
    }
    return true;
  }
}
