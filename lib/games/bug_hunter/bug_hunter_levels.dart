import 'bug_hunter_level.dart';

/// Temel paketin 20 seviyesi. Gruplar: 1–5 Kolay, 6–10 Orta (yalnızca oklar), 11–15 Zor, 16–20 Uzman
/// (hata tekrar bloğunda). Hata türleri: yanlış ok, eksik ok, fazla ok, yanlış tekrar sayısı; Orta ve
/// Uzman gruplarında bazı kodlarda birden çok hata vardır.
final bugHunterBaseLevels = <BugHunterLevel>[
  // Kolay 1–5: tek hata.
  BugHunterLevel(
    map: ['....', 'S..G', '....'],
    bugged: 'RUR',
    solution: 'RRR',
    maxBlocks: 4,
    intro: (t) => t.bugHunterL1Intro,
    hint: (t) => t.bugHunterL1Hint,
  ),
  BugHunterLevel(
    map: ['S.#G', '....'],
    bugged: 'RDRRD',
    solution: 'RDRRU',
    maxBlocks: 6,
    hint: (t) => t.bugHunterL2Hint,
  ),
  BugHunterLevel(
    map: ['S..', '...', '..G'],
    bugged: 'RRD',
    solution: 'RRDD',
    maxBlocks: 5,
    intro: (t) => t.bugHunterL3Intro,
    hint: (t) => t.bugHunterL3Hint,
  ),
  BugHunterLevel(
    map: ['G...', '....', '...S'],
    bugged: 'UULLLL',
    solution: 'UULLL',
    maxBlocks: 6,
    intro: (t) => t.bugHunterL4Intro,
    hint: (t) => t.bugHunterL4Hint,
  ),
  BugHunterLevel(
    map: ['S#G', '...'],
    bugged: 'DRU',
    solution: 'DRRU',
    maxBlocks: 5,
    intro: (t) => t.bugHunterL5Intro,
    hint: (t) => t.bugHunterL5Hint,
  ),
  // Orta 6–10: daha uzun yollar, altınlar ve birden çok hata.
  BugHunterLevel(map: ['S.*.', '...G'], bugged: 'RRRU', solution: 'RRRD', maxBlocks: 5, hint: (t) => t.bugHunterL6Hint),
  BugHunterLevel(
    map: ['S.~G', '..~.', '....'],
    bugged: 'DDRRUU',
    solution: 'DDRRRUU',
    maxBlocks: 8,
    hint: (t) => t.bugHunterL7Hint,
  ),
  BugHunterLevel(
    map: ['S...', '.##.', '...G'],
    bugged: 'RRDDR',
    solution: 'RRRDD',
    maxBlocks: 6,
    intro: (t) => t.bugHunterL8Intro,
    hint: (t) => t.bugHunterL8Hint,
  ),
  BugHunterLevel(
    map: ['S*.', '...', '.*G'],
    bugged: 'RDDRD',
    solution: 'RDDR',
    maxBlocks: 5,
    hint: (t) => t.bugHunterL9Hint,
  ),
  BugHunterLevel(
    map: ['S.#.', '...#', '#...', '...G'],
    bugged: 'RRDRD',
    solution: 'RDDRRD',
    maxBlocks: 7,
    hint: (t) => t.bugHunterL10Hint,
  ),
  // Zor 11–15: hata tekrar bloğunda ya da hemen yanında.
  BugHunterLevel(
    map: ['.....', 'S...G', '.....'],
    bugged: '4(U)',
    solution: '4(R)',
    maxBlocks: 3,
    intro: (t) => t.bugHunterL11Intro,
    hint: (t) => t.bugHunterL11Hint,
  ),
  BugHunterLevel(
    map: ['S...', '....', '....', '...G'],
    bugged: '2(RD)',
    solution: '3(RD)',
    maxBlocks: 4,
    intro: (t) => t.bugHunterL12Intro,
    hint: (t) => t.bugHunterL12Hint,
  ),
  BugHunterLevel(
    map: ['....G', '.....', 'S....'],
    bugged: '2(RUU)',
    solution: '2(RRU)',
    maxBlocks: 5,
    hint: (t) => t.bugHunterL13Hint,
  ),
  BugHunterLevel(
    map: ['S....', '.....', '....G'],
    bugged: '2(RD)',
    solution: '2(RRD)',
    maxBlocks: 5,
    hint: (t) => t.bugHunterL14Hint,
  ),
  BugHunterLevel(
    map: ['S..', '...', '...', '..G'],
    bugged: '2(RD) D D',
    solution: '2(RD) D',
    maxBlocks: 5,
    hint: (t) => t.bugHunterL15Hint,
  ),
  // Uzman 16–20: tekrar bloklarında birden çok hata.
  BugHunterLevel(
    map: ['S.....', '......', '.....G'],
    bugged: '4(R) D U',
    solution: '5(R) D D',
    maxBlocks: 5,
    intro: (t) => t.bugHunterL16Intro,
    hint: (t) => t.bugHunterL16Hint,
  ),
  BugHunterLevel(
    map: ['S*.*.*G', '.......'],
    bugged: '2(RR) R',
    solution: '3(RR)',
    maxBlocks: 5,
    hint: (t) => t.bugHunterL17Hint,
  ),
  BugHunterLevel(
    map: ['S#..', '..#.', '...#', '...G'],
    bugged: '3(RD)',
    solution: '3(DR)',
    maxBlocks: 4,
    hint: (t) => t.bugHunterL18Hint,
  ),
  BugHunterLevel(
    map: ['S.~..', '...~.', '~...~', '.~...', '..~.G'],
    bugged: '3(R)',
    solution: '4(RD)',
    maxBlocks: 4,
    hint: (t) => t.bugHunterL19Hint,
  ),
  BugHunterLevel(
    map: ['S*.*.', '####.', '....*', '....G'],
    bugged: '3(R) 2(D) R',
    solution: '4(R) 3(D)',
    maxBlocks: 6,
    hint: (t) => t.bugHunterL20Hint,
  ),
];
