import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/my_command/my_command_levels.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_board.dart';
import 'package:robi_codes/games/path_finder/engine/path_finder_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_engine.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';

/// Tekrarla bloğunun ilk göründüğü seviyenin sırası (11. seviye).
const _firstRepeatLevel = 10;

/// Robotun konumu ve topladığı altınlar (bit maskesi).
typedef _State = ({GridPoint position, int coins});

/// Komut kullanmadan, yalnızca oklar ve Tekrarla bloklarıyla bayrağa varmak için gereken en az blok.
/// [limit] blokta varılamıyorsa `null`. Her blok robotu bir durumdan ötekine götürdüğü için durumlar
/// üzerinde blok sayısına göre katman katman arama yapılır.
int? _fewestBlocksWithoutCommand(PathFinderBoard board, int limit) {
  final start = (position: board.start, coins: 0);
  final best = <_State, int>{start: 0};
  final allCoins = (1 << board.coins.length) - 1;
  for (var cost = 0; cost <= limit; cost++) {
    final layer = [
      for (final MapEntry(key: state, value: used) in best.entries)
        if (used == cost) state,
    ];
    for (final state in layer) {
      if (state.position == board.goal && state.coins == allCoins) {
        return cost;
      }
      for (final (block, next) in _blocksFrom(board, state, limit - cost)) {
        final total = cost + block.size;
        if (total < (best[next] ?? limit + 1)) {
          best[next] = total;
        }
      }
    }
  }
  return null;
}

/// [state]ten başlayıp robotu çarptırmayan, en fazla [room] blok kaplayan bütün bloklar ve sonuçları.
Iterable<(ProgramBlock, _State)> _blocksFrom(PathFinderBoard board, _State state, int room) sync* {
  for (final direction in Direction.values) {
    if (_walk(board, state, [direction]) case final next?) {
      yield (MoveBlock(direction), next);
    }
  }
  yield* _repeatsFrom(board, state, const [], room);
}

/// [body] ile başlayan tekrar bloklarını ok ok büyütür; ilk turu çarpan gövdeler budanır.
Iterable<(ProgramBlock, _State)> _repeatsFrom(
  PathFinderBoard board,
  _State state,
  List<Direction> body,
  int room,
) sync* {
  if (body.length + 1 >= room) {
    return;
  }
  for (final direction in Direction.values) {
    final longer = [...body, direction];
    if (_walk(board, state, longer) == null) {
      continue;
    }
    for (var times = RepeatBlock.minTimes; times <= RepeatBlock.maxTimes; times++) {
      if (_walk(board, state, [for (var i = 0; i < times; i++) ...longer]) case final next?) {
        yield (RepeatBlock(times, longer), next);
      }
    }
    yield* _repeatsFrom(board, state, longer, room);
  }
}

/// Robotu [moves] ile yürütür; çarparsa `null`.
_State? _walk(PathFinderBoard board, _State state, List<Direction> moves) {
  var (:position, :coins) = state;
  for (final move in moves) {
    position = move.from(position);
    if (!board.isWalkable(position)) {
      return null;
    }
    final coin = board.coinIndexAt(position);
    coins |= coin == null ? 0 : 1 << coin;
  }
  return (position: position, coins: coins);
}

void main() {
  test('myCommandBaseLevels_Length_IsTwenty', () {
    expect(myCommandBaseLevels, hasLength(20));
  });

  for (final (index, level) in myCommandBaseLevels.indexed) {
    final number = index + 1;

    test('solution_Level${number}_SucceedsWithExactlyBlockLimit', () {
      // Act
      final run = RepeatEngine.run(level.board, level.mainBlocks, command: level.commandBlocks);

      // Assert
      expect(run.result.outcome, RunOutcome.success);
      expect(level.targetBlocks, level.maxBlocks);
    });

    test('arrowsOnly_Level${number}_ExceedBlockLimit', () {
      expect(PathFinderEngine.optimalLength(level.board), greaterThan(level.maxBlocks));
    });
  }

  for (final (index, level) in myCommandBaseLevels.indexed.skip(_firstRepeatLevel)) {
    test('repeatWithoutCommand_Level${index + 1}_ExceedBlockLimit', () {
      expect(_fewestBlocksWithoutCommand(level.board, level.maxBlocks), isNull);
    });
  }

  test('allowsRepeat_OnlyLastTwoGroups_IsTrue', () {
    expect(myCommandBaseLevels.take(10).map((level) => level.allowsRepeat), everyElement(isFalse));
    expect(myCommandBaseLevels.skip(10).map((level) => level.allowsRepeat), everyElement(isTrue));
  });
}
