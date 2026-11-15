import '../../path_finder/engine/path_finder_board.dart';
import '../../path_finder/engine/path_finder_engine.dart';
import 'repeat_program.dart';

/// Programın çalıştırılma sonucu: harita sonucu ve her hareketin geldiği yer.
typedef RepeatRun = ({RunResult result, List<ProgramStep> trace});

/// Programın önerilen çözümden nasıl ayrıldığı.
enum DifferenceKind {
  /// O yerdeki blok ya da ok yanlış.
  wrongBlock,

  /// Tekrar bloğunun okları doğru, tekrar sayısı yanlış.
  wrongCount,

  /// O yerdeki blok ya da ok fazla; silinince program çözüme uyar.
  extraBlock,
}

/// Programın önerilen çözümden ayrıldığı yer ve ayrılış biçimi.
typedef SolutionDifference = ({ProgramPlace place, DifferenceKind kind});

/// İpucu türleri.
sealed class RepeatHint {
  const RepeatHint();
}

/// İçi boş tekrar bloğu.
final class EmptyRepeatHint extends RepeatHint {
  const EmptyRepeatHint(this.block);

  final int block;
}

/// Robotu yoldan çıkaran hareketin yeri ve turu. [index] hareketin açılmış programdaki sırasıdır.
final class FixPlaceHint extends RepeatHint {
  const FixPlaceHint(this.step, this.index);

  final ProgramStep step;
  final int index;
}

/// Sıradaki doğru hareket ve robotun gideceği kare.
final class NextStepHint extends RepeatHint {
  const NextStepHint(this.move);

  final NextMoveHint move;
}

/// Bloklar zaten doğru.
final class RepeatSolvedHint extends RepeatHint {
  const RepeatSolvedHint();
}

/// "Tekrar Et" kuralları. Harita ve hareket kuralları "Robotun Yolunu Bul" motorundan gelir;
/// web sürümündeki `engine.js` ile aynı çalışır.
abstract final class RepeatEngine {
  static final _repeatToken = RegExp(r'^(\d+)\(([UDLR]+)\)$');

  /// Tekrar bloğunun sınırsız sayılabilmesi için ipucuna verilen komut sınırı.
  static const _unlimited = 1 << 30;

  /// Çözüm metninde komut bloğunun ([CallBlock]) kısaltması.
  static const callToken = 'C';

  /// "3(RD) U" gibi bir çözüm metnini bloklara çevirir; "C" komut bloğudur.
  static List<ProgramBlock> parseSolution(String text) => [
    for (final token in text.trim().split(RegExp(r'\s+')))
      if (token == callToken)
        const CallBlock()
      else if (_repeatToken.firstMatch(token) case final match?)
        RepeatBlock(int.parse(match[1]!), Direction.parseSolution(match[2]!))
      else
        ...Direction.parseSolution(token).map(MoveBlock.new),
  ];

  /// Blok sayısı: her ok ve her tekrar bloğu bir sayılır; tekrar bloğunun içindekiler de sayılır.
  static int countBlocks(List<ProgramBlock> program) => program.fold(0, (sum, block) => sum + block.size);

  /// Programı tek tek hareketlere açar. Komut bloğu [command] programının hareketlerine açılır; bu
  /// hareketler komut bloğunun yerinden gelmiş sayılır.
  static List<ProgramStep> expand(List<ProgramBlock> program, {List<ProgramBlock> command = const []}) => [
    for (final (index, block) in program.indexed)
      ...switch (block) {
        MoveBlock(:final direction) => [(direction: direction, block: index, inner: Places.topLevel, round: 0)],
        CallBlock() => [
          for (final step in expand(command))
            (direction: step.direction, block: index, inner: Places.topLevel, round: 0),
        ],
        RepeatBlock(:final times, :final body) => [
          for (var round = 0; round < times; round++)
            for (final (inner, direction) in body.indexed)
              (direction: direction, block: index, inner: inner, round: round),
        ],
      },
  ];

  static RepeatRun run(PathFinderBoard board, List<ProgramBlock> program, {List<ProgramBlock> command = const []}) {
    final trace = expand(program, command: command);
    return (result: PathFinderEngine.run(board, _directions(trace)), trace: trace);
  }

  /// İçi boş ilk tekrar bloğunun sırası; yoksa `null`. Boş blok varken program çalıştırılmaz.
  static int? findEmptyRepeat(List<ProgramBlock> program) {
    final index = program.indexWhere((block) => block is RepeatBlock && block.body.isEmpty);
    return index < 0 ? null : index;
  }

  /// İpucu: önce boş tekrar bloğu, sonra robotu yoldan çıkaran hareket, yoksa sıradaki doğru hareket.
  static RepeatHint hint(PathFinderBoard board, List<ProgramBlock> program, {List<ProgramBlock> command = const []}) {
    if (findEmptyRepeat(program) case final block?) {
      return EmptyRepeatHint(block);
    }
    final trace = expand(program, command: command);
    return switch (PathFinderEngine.hint(board, _directions(trace), _unlimited)) {
      FixCommandHint(:final index) => FixPlaceHint(trace[index], index),
      final NextMoveHint move => NextStepHint(move),
      SolvedHint() => const RepeatSolvedHint(),
      // Sınır olmadığı için yalnızca bayrağa yol yoksa olur; geçerli seviyelerde bu durum yoktur.
      TooManyCommandsHint() => throw StateError('Haritada bayrağa giden yol yok.'),
    };
  }

  /// Programın [solution]dan ayrıldığı ilk yer; program çözümün başıysa `null`. Aynı yerdeki iki tekrar
  /// bloğunun okları aynıysa yanlış olan tekrar sayısıdır. O yer silinince program çözüme uyuyorsa fazladır.
  static SolutionDifference? firstDifference(List<ProgramBlock> program, List<ProgramBlock> solution) {
    final difference = _firstMismatch(program, solution);
    if (difference == null || difference.kind == DifferenceKind.wrongCount) {
      return difference;
    }
    final place = difference.place;
    return _isExtra(program, solution, place) ? (place: place, kind: DifferenceKind.extraBlock) : difference;
  }

  static SolutionDifference? _firstMismatch(List<ProgramBlock> program, List<ProgramBlock> solution) {
    for (final (index, block) in program.indexed) {
      final expected = index < solution.length ? solution[index] : null;
      if (block == expected) {
        continue;
      }
      if ((block, expected) case (RepeatBlock(:final body), RepeatBlock(body: final want))) {
        return _repeatDifference(index, body, want);
      }
      return (place: Places.top(index), kind: DifferenceKind.wrongBlock);
    }
    return null;
  }

  /// İki tekrar bloğunun ilk farklı oku. Program çözümdeki okların yalnızca başını içeriyorsa bloğun
  /// kendisi, oklar aynıysa tekrar sayısı gösterilir.
  static SolutionDifference _repeatDifference(int index, List<Direction> body, List<Direction> want) {
    for (final (inner, direction) in body.indexed) {
      if (inner >= want.length || direction != want[inner]) {
        return (place: (block: index, inner: inner), kind: DifferenceKind.wrongBlock);
      }
    }
    final kind = body.length == want.length ? DifferenceKind.wrongCount : DifferenceKind.wrongBlock;
    return (place: Places.top(index), kind: kind);
  }

  /// [place] silinince program çözümün başı oluyorsa o yer fazladır. O yer çözümdeki blokla değiştirilince
  /// de uyuyorsa (ör. "RUR" ile "RRR") blok fazla değil yanlıştır; değiştirmek daha doğru öneridir.
  static bool _isExtra(List<ProgramBlock> program, List<ProgramBlock> solution, ProgramPlace place) {
    if (_firstMismatch(_without(program, place), solution) != null) {
      return false;
    }
    return !_has(solution, place) || _firstMismatch(_replaced(program, place, solution), solution) != null;
  }

  static List<ProgramBlock> _without(List<ProgramBlock> program, ProgramPlace place) => [
    for (final (index, block) in program.indexed)
      if (index != place.block)
        block
      else if ((block, Places.isInner(place)) case (final RepeatBlock repeat, true))
        repeat.copyWith(body: [...repeat.body]..removeAt(place.inner)),
  ];

  /// [place]ı çözümün aynı yerdeki bloğuyla ya da okuyla değiştirir; çözümde o yer bulunmalıdır.
  static List<ProgramBlock> _replaced(List<ProgramBlock> program, ProgramPlace place, List<ProgramBlock> solution) => [
    for (final (index, block) in program.indexed)
      if (index != place.block)
        block
      else
        switch ((block, solution[index])) {
          (final RepeatBlock repeat, RepeatBlock(body: final want)) when Places.isInner(place) => repeat.copyWith(
            body: [...repeat.body]..[place.inner] = want[place.inner],
          ),
          (_, final expected) => expected,
        },
  ];

  static bool _has(List<ProgramBlock> program, ProgramPlace place) {
    if (place.block >= program.length) {
      return false;
    }
    return switch (program[place.block]) {
      RepeatBlock(:final body) when Places.isInner(place) => place.inner < body.length,
      _ => !Places.isInner(place),
    };
  }

  static List<Direction> _directions(List<ProgramStep> trace) => [for (final step in trace) step.direction];
}
