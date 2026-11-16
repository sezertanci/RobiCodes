import '../../path_finder/engine/path_finder_board.dart';
import '../../path_finder/engine/path_finder_engine.dart';
import 'repeat_program.dart';

/// Programın çalıştırılma sonucu: harita sonucu ve her hareketin geldiği yer.
typedef RepeatRun = ({RunResult result, List<ProgramStep> trace});

/// Açılan bir bloğun hareketlerinin geldiği yer ve tur.
typedef _StepPlace = ({int block, int inner, int round});

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

/// Program önerilen çözümden ayrılıyor. Yalnızca ipucuna çözüm verilince (düzeltme kuralları) oluşur.
final class DifferenceHint extends RepeatHint {
  const DifferenceHint(this.difference);

  final SolutionDifference difference;
}

/// Bloklar zaten doğru.
final class RepeatSolvedHint extends RepeatHint {
  const RepeatSolvedHint();
}

/// "Tekrar Et" kuralları. Harita ve hareket kuralları "Robotun Yolunu Bul" motorundan gelir;
/// web sürümündeki `engine.js` ile aynı çalışır.
abstract final class RepeatEngine {
  static final _repeatToken = RegExp(r'^(\d+)\((.+)\)$');
  static final _innerToken = RegExp(r'=\d|[-+]|[UDLR]');

  /// Tekrar bloğunun sınırsız sayılabilmesi için ipucuna verilen komut sınırı.
  static const _unlimited = 1 << 30;

  /// Çözüm metninde komut bloğunun ([CallBlock]) kısaltması.
  static const callToken = 'C';

  /// Çözüm metninde kutu bloklarının kısaltmaları: "=3" kutuya 3 koyar, "+" ve "-" bir artırır ya da azaltır.
  static const setBoxToken = '=';
  static const incrementToken = '+';
  static const decrementToken = '-';

  /// "3(RD) U" ya da "=2 3(RD+)" gibi bir çözüm metnini bloklara çevirir; "C" komut bloğudur.
  static List<ProgramBlock> parseSolution(String text) => [
    for (final token in text.trim().split(RegExp(r'\s+')))
      if (token == callToken)
        const CallBlock()
      else if (_repeatToken.firstMatch(token) case final match?)
        RepeatBlock(int.parse(match[1]!), _parseInner(match[2]!))
      else
        ..._parseInner(token),
  ];

  static List<InnerBlock> _parseInner(String text) => [
    for (final match in _innerToken.allMatches(text))
      switch (match[0]!) {
        incrementToken => AddBoxBlock.increment,
        decrementToken => AddBoxBlock.decrement,
        final token when token.startsWith(setBoxToken) => SetBoxBlock(int.parse(token.substring(1))),
        final token => MoveBlock(Direction.parseSolution(token).single),
      },
  ];

  /// Blok sayısı: her ok, kutu bloğu ve tekrar bloğu bir sayılır; tekrar bloğunun içindekiler de sayılır.
  static int countBlocks(List<ProgramBlock> program) => program.fold(0, (sum, block) => sum + block.size);

  /// Programı tek tek hareketlere açar. Kutu [BoxRules.start] ile başlar; her ok kutudaki sayı kadar
  /// hareket olur. Komut bloğu [command] programının hareketlerine açılır; bu hareketler komut bloğunun
  /// yerinden gelmiş sayılır.
  static List<ProgramStep> expand(List<ProgramBlock> program, {List<ProgramBlock> command = const []}) {
    final steps = <ProgramStep>[];
    var box = BoxRules.start;
    for (final (index, block) in program.indexed) {
      switch (block) {
        case CallBlock():
          for (final step in expand(command)) {
            steps.add((direction: step.direction, block: index, inner: Places.topLevel, round: 0, box: step.box));
          }
        case RepeatBlock(:final times, :final body):
          for (var round = 0; round < times; round++) {
            for (final (inner, item) in body.indexed) {
              box = _expandInner(item, box, steps, (block: index, inner: inner, round: round));
            }
          }
        case final InnerBlock item:
          box = _expandInner(item, box, steps, (block: index, inner: Places.topLevel, round: 0));
      }
    }
    return steps;
  }

  /// Ok kutudaki sayı kadar hareket ekler; kutu bloğu kutuyu değiştirir. Kutunun yeni değerini döndürür.
  static int _expandInner(InnerBlock block, int box, List<ProgramStep> steps, _StepPlace at) {
    switch (block) {
      case MoveBlock(:final direction):
        steps.addAll([
          for (var i = 0; i < box; i++)
            (direction: direction, block: at.block, inner: at.inner, round: at.round, box: box),
        ]);
        return box;
      case SetBoxBlock(:final value):
        return BoxRules.clamp(value);
      case AddBoxBlock(:final amount):
        return BoxRules.clamp(box + amount);
      case LightBlock():
        steps.add((direction: LightBlock.direction, block: at.block, inner: at.inner, round: at.round, box: box));
        return box;
    }
  }

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
  /// [solution] verilirse (düzeltme kuralları) program önerilen çözümle de karşılaştırılır (bkz.
  /// [_solutionHint]); [openBlock] okların eklendiği açık tekrar bloğudur.
  static RepeatHint hint(
    PathFinderBoard board,
    List<ProgramBlock> program, {
    List<ProgramBlock> command = const [],
    List<ProgramBlock>? solution,
    int? openBlock,
  }) {
    if (findEmptyRepeat(program) case final block?) {
      return EmptyRepeatHint(block);
    }
    final trace = expand(program, command: command);
    final pathHint = PathFinderEngine.hint(board, _directions(trace), _unlimited);
    if (solution != null) {
      if (_solutionHint(board, program, pathHint, solution, openBlock) case final hint?) {
        return hint;
      }
    }
    return switch (pathHint) {
      FixCommandHint(:final index) => FixPlaceHint(trace[index], index),
      final NextMoveHint move => NextStepHint(move),
      SolvedHint() => const RepeatSolvedHint(),
      // Sınır olmadığı için yalnızca bayrağa yol yoksa olur; geçerli seviyelerde bu durum yoktur.
      TooManyCommandsHint() => throw StateError('Haritada bayrağa giden yol yok.'),
    };
  }

  /// Düzeltme kurallarına özgü ipucu; genel ipucu yeterliyse `null`.
  /// - Açık tekrar bloğu yazılırken bloğun okları çözümdeki okların başıysa sıradaki iç ok önerilir.
  /// - Robot çarpıyor ama programda fazla bir blok varsa çarptıran yer yerine fazla blok gösterilir.
  /// - Robot çarpmıyorsa programın çözümden ayrıldığı yer gösterilir; robot başka bir doğru yoldaysa
  ///   gösterilmez (bkz. [_offRoute]).
  static RepeatHint? _solutionHint(
    PathFinderBoard board,
    List<ProgramBlock> program,
    PathHint pathHint,
    List<ProgramBlock> solution,
    int? openBlock,
  ) {
    if (_nextInnerMove(board, program, solution, openBlock) case final move?) {
      return NextStepHint(move);
    }
    final difference = switch (pathHint) {
      FixCommandHint() => _extraBlock(program, solution),
      NextMoveHint() => _offRoute(board, program, solution),
      _ => null,
    };
    return difference == null ? null : DifferenceHint(difference);
  }

  /// Açık tekrar bloğunun okları çözümdeki aynı bloğun oklarının başıysa ve önceki bloklar çözüme uyuyorsa
  /// çözümdeki sıradaki iç ok; robotun gideceği kare bloğun ilk turuna göredir. Aksi halde `null`.
  static NextMoveHint? _nextInnerMove(
    PathFinderBoard board,
    List<ProgramBlock> program,
    List<ProgramBlock> solution,
    int? openBlock,
  ) {
    if (openBlock == null || openBlock >= solution.length) {
      return null;
    }
    final before = program.sublist(0, openBlock);
    if ((program[openBlock], solution[openBlock]) case (final RepeatBlock block, RepeatBlock(body: final want))
        when block.body.length < want.length &&
            _startsWith(want, block.body) &&
            _firstMismatch(before, solution) == null) {
      // Sıradaki iç blok kutu bloğuysa robotun gideceği kare yoktur; genel ipucu kullanılır.
      if (want[block.body.length] case MoveBlock(:final direction)) {
        final firstRound = [...before, block.copyWith(times: 1)];
        final position = PathFinderEngine.run(board, _directions(expand(firstRound))).position;
        return NextMoveHint(direction, direction.from(position));
      }
    }
    return null;
  }

  static bool _startsWith(List<InnerBlock> list, List<InnerBlock> prefix) =>
      prefix.indexed.every((entry) => list[entry.$1] == entry.$2);

  /// Programın çözümden ayrıldığı yer fazla bir bloksa o fark; değilse `null`.
  static SolutionDifference? _extraBlock(List<ProgramBlock> program, List<ProgramBlock> solution) {
    final difference = firstDifference(program, solution);
    return difference?.kind == DifferenceKind.extraBlock ? difference : null;
  }

  /// Robot çarpmadığında programın çözümden farkı. Fark üst düzeydeki bir oktaysa ve robot yolu çözümün
  /// hareket sayısını aşmadan bitirebiliyorsa robot başka bir doğru yoldadır; fark sayılmaz. Tekrar
  /// bloğundaki farklar (tekrar sayısı, iç ok) yol seçimi değil bozuk desendir; her zaman gösterilir.
  static SolutionDifference? _offRoute(PathFinderBoard board, List<ProgramBlock> program, List<ProgramBlock> solution) {
    final difference = firstDifference(program, solution);
    if (difference == null) {
      return null;
    }
    final place = difference.place;
    final isRouteChoice = !Places.isInner(place) && program[place.block] is MoveBlock;
    return isRouteChoice && _fitsSolution(board, program, solution) ? null : difference;
  }

  /// Robot programın sonundan bayrağa, çözümün hareket sayısını aşmadan ulaşabiliyor mu?
  static bool _fitsSolution(PathFinderBoard board, List<ProgramBlock> program, List<ProgramBlock> solution) =>
      PathFinderEngine.hint(board, _directions(expand(program)), expand(solution).length) is NextMoveHint;

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

  /// İki tekrar bloğunun ilk farklı iç bloğu. Program çözümdeki okların yalnızca başını içeriyorsa bloğun
  /// kendisi, oklar aynıysa tekrar sayısı gösterilir.
  static SolutionDifference _repeatDifference(int index, List<InnerBlock> body, List<InnerBlock> want) {
    for (final (inner, item) in body.indexed) {
      if (inner >= want.length || item != want[inner]) {
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
