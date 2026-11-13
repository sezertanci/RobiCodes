import 'dart:collection';

import 'path_finder_board.dart';

/// Programın sonucu.
enum RunOutcome {
  success,

  /// Taşa, suya veya harita kenarına çarptı.
  blocked,

  /// Komutlar bitti, robot bayrağa ulaşmadı.
  missedGoal,

  /// Bayrağa ulaştı ama altınların hepsini toplamadı.
  missingCoins,
}

/// Robotun bir komuttan sonraki konumu. [coin], o adımda alınan altının sırasıdır (yoksa `null`).
typedef RunStep = ({GridPoint position, int? coin});

/// Komutların çalıştırılmasının sonucu. Ekran, [steps] listesini sırayla canlandırır.
final class RunResult {
  const RunResult({
    required this.outcome,
    required this.steps,
    required this.position,
    required this.collected,
    this.failedIndex,
    this.obstacle,
  });

  final RunOutcome outcome;
  final List<RunStep> steps;

  /// Robotun son konumu. Engele çarptıysa çarpmadan önceki kare.
  final GridPoint position;

  /// Toplanan altınların sırası.
  final Set<int> collected;

  /// Engele çarptıran komutun sırası (0'dan başlar).
  final int? failedIndex;

  /// Çarpılan engel.
  final Obstacle? obstacle;
}

/// İpucu türleri. İpucu cevabın tamamını vermez; yalnızca bir sonraki adımı söyler.
sealed class PathHint {
  const PathHint();
}

/// Sıradaki doğru komut ve robotun gideceği kare.
final class NextMoveHint extends PathHint {
  const NextMoveHint(this.direction, this.target);

  final Direction direction;
  final GridPoint target;
}

/// Robotu engele çarptıran komut.
final class FixCommandHint extends PathHint {
  const FixCommandHint(this.index);

  final int index;
}

/// Mevcut komutlarla sınır içinde bitirilemez.
final class TooManyCommandsHint extends PathHint {
  const TooManyCommandsHint();
}

/// Komutlar zaten doğru.
final class SolvedHint extends PathHint {
  const SolvedHint();
}

/// "Robotun Yolunu Bul" kuralları. Ekrandan bağımsızdır; web sürümündeki `engine.js` ile aynı çalışır.
abstract final class PathFinderEngine {
  /// Komutları sırayla çalıştırır. Engele çarpınca durur.
  static RunResult run(PathFinderBoard board, List<Direction> commands) {
    var position = board.start;
    final collected = <int>{};
    final steps = <RunStep>[];
    for (final (index, command) in commands.indexed) {
      final next = command.from(position);
      final obstacle = board.obstacleAt(next);
      if (obstacle != null) {
        return RunResult(
          outcome: RunOutcome.blocked,
          steps: steps,
          position: position,
          collected: collected,
          failedIndex: index,
          obstacle: obstacle,
        );
      }
      position = next;
      final coin = board.coinIndexAt(position);
      if (coin != null) {
        collected.add(coin);
      }
      steps.add((position: position, coin: coin));
    }
    return RunResult(
      outcome: _finalOutcome(board, position, collected),
      steps: steps,
      position: position,
      collected: collected,
    );
  }

  static RunOutcome _finalOutcome(PathFinderBoard board, GridPoint position, Set<int> collected) {
    if (position != board.goal) {
      return RunOutcome.missedGoal;
    }
    return collected.length == board.coins.length ? RunOutcome.success : RunOutcome.missingCoins;
  }

  /// [from] karesinden, bütün altınları toplayıp bayrağa varan en kısa yol. Yol yoksa `null`.
  /// Durum = konum + toplanan altınlar (bit maskesi); genişlik öncelikli arama yapılır.
  static List<Direction>? shortestPath(PathFinderBoard board, GridPoint from, Set<int> collected) {
    final allCoins = (1 << board.coins.length) - 1;
    final startMask = collected.fold(0, (mask, index) => mask | (1 << index));
    final queue = Queue<_SearchState>()..add(_SearchState(from, startMask, const []));
    final seen = {(from, startMask)};
    while (queue.isNotEmpty) {
      final state = queue.removeFirst();
      if (state.mask == allCoins && state.position == board.goal) {
        return state.path;
      }
      for (final direction in Direction.values) {
        final next = state.advance(board, direction);
        if (next != null && seen.add((next.position, next.mask))) {
          queue.add(next);
        }
      }
    }
    return null;
  }

  /// En kısa çözümün komut sayısı. 3 yıldız için komut sayısı bunu aşmamalıdır.
  static int optimalLength(PathFinderBoard board) => shortestPath(board, board.start, const {})?.length ?? 0;

  /// Yanlış bir komut varsa önce onu, yoksa bir sonraki doğru adımı gösterir.
  static PathHint hint(PathFinderBoard board, List<Direction> commands, int maxCommands) {
    final result = run(board, commands);
    if (result.outcome == RunOutcome.blocked) {
      return FixCommandHint(result.failedIndex!);
    }
    if (result.outcome == RunOutcome.success) {
      return const SolvedHint();
    }
    final rest = shortestPath(board, result.position, result.collected);
    if (rest == null || rest.isEmpty || commands.length + rest.length > maxCommands) {
      return const TooManyCommandsHint();
    }
    return NextMoveHint(rest.first, rest.first.from(result.position));
  }
}

final class _SearchState {
  const _SearchState(this.position, this.mask, this.path);

  final GridPoint position;
  final int mask;
  final List<Direction> path;

  _SearchState? advance(PathFinderBoard board, Direction direction) {
    final next = direction.from(position);
    if (!board.isWalkable(next)) {
      return null;
    }
    final coin = board.coinIndexAt(next);
    return _SearchState(next, coin == null ? mask : mask | (1 << coin), [...path, direction]);
  }
}
