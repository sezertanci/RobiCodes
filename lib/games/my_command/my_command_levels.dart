import 'my_command_level.dart';

/// Temel paketin 20 seviyesi. Her haritada blok sınırı, komut kullanılmadan (yalnızca oklarla veya
/// 11–20'de yalnızca Tekrarla ile) aşılır; çözüm için komut tanımlamak gerekir. Gruplar: 1–5 Kolay,
/// 6–10 Orta (yalnızca oklar), 11–15 Zor, 16–20 Uzman (komutun içinde Tekrarla).
final myCommandBaseLevels = <MyCommandLevel>[
  // Kolay 1–5: kısa komutu art arda kullanma.
  MyCommandLevel(
    map: ['S.....G'],
    command: 'RR',
    main: 'C C C',
    maxBlocks: 5,
    intro: (t) => t.myCommandL1Intro,
    hint: (t) => t.myCommandL1Hint,
  ),
  MyCommandLevel(
    map: ['S...', '....', '....', '...G'],
    command: 'RD',
    main: 'C C C',
    maxBlocks: 5,
    hint: (t) => t.myCommandL2Hint,
  ),
  MyCommandLevel(
    map: ['S.#..', '#..#.', '.#..#', '..#.G'],
    command: 'RD',
    main: 'C C C R',
    maxBlocks: 6,
    intro: (t) => t.myCommandL3Intro,
    hint: (t) => t.myCommandL3Hint,
  ),
  MyCommandLevel(
    map: ['....G', '.....', 'S....'],
    command: 'RRU',
    main: 'C C',
    maxBlocks: 5,
    hint: (t) => t.myCommandL4Hint,
  ),
  MyCommandLevel(
    map: ['G...', '.*..', '..*.', '...S'],
    command: 'UL',
    main: 'C C C',
    maxBlocks: 5,
    hint: (t) => t.myCommandL5Hint,
  ),
  // Orta 6–10: daha uzun komutlar, komut arasına ok.
  MyCommandLevel(
    map: ['S......', '.......', '.......', '......G'],
    command: 'RRD',
    main: 'C C C',
    maxBlocks: 6,
    hint: (t) => t.myCommandL6Hint,
  ),
  MyCommandLevel(
    map: ['S......', '.......', '..*....', '.......', '....*..', '.......', '......G'],
    command: 'RRDD',
    main: 'C C C',
    maxBlocks: 7,
    hint: (t) => t.myCommandL7Hint,
  ),
  MyCommandLevel(
    map: ['S##....', '.......', '.......', '......G'],
    command: 'DRR',
    main: 'C C C',
    maxBlocks: 6,
    hint: (t) => t.myCommandL8Hint,
  ),
  MyCommandLevel(
    map: ['S....####', '####....G'],
    command: 'RRRR',
    main: 'C D C',
    maxBlocks: 7,
    hint: (t) => t.myCommandL9Hint,
  ),
  MyCommandLevel(
    map: ['S#*#*#G', '.......'],
    command: 'DRRU',
    main: 'C C C',
    maxBlocks: 7,
    hint: (t) => t.myCommandL10Hint,
  ),
  // Zor 11–15: komutun içinde tekrar bloğu.
  MyCommandLevel(
    map: ['S...##...G', '###....###'],
    command: '3(R)',
    main: 'C D C U C',
    maxBlocks: 7,
    intro: (t) => t.myCommandL11Intro,
    hint: (t) => t.myCommandL11Hint,
  ),
  MyCommandLevel(
    map: ['S..####', '##.####', '##...##', '####...', '######G'],
    command: '2(R) D',
    main: 'C D C C',
    maxBlocks: 7,
    hint: (t) => t.myCommandL12Hint,
  ),
  MyCommandLevel(
    map: ['####..G', '####.##', '##.*.##', '...####', 'S######'],
    command: 'U 2(R)',
    main: 'C C U C',
    maxBlocks: 7,
    hint: (t) => t.myCommandL13Hint,
  ),
  MyCommandLevel(
    map: ['#######G', '#####...', '#####.##', '##....##', 'S..#####'],
    command: '2(R) U',
    main: 'C R C U C',
    maxBlocks: 8,
    hint: (t) => t.myCommandL14Hint,
  ),
  MyCommandLevel(
    map: ['S#######', '...#####', '##.#####', '##....##', '#####..G'],
    command: 'D 2(R)',
    main: 'C D C R C',
    maxBlocks: 8,
    hint: (t) => t.myCommandL15Hint,
  ),
  // Uzman 16–20: daha uzun tekrarlar, komutta iki tekrar bloğu.
  MyCommandLevel(
    map: ['S...#####', '##..#####', '##..*.###', '#####....', '########G'],
    command: '3(R) D',
    main: 'C L D C C',
    maxBlocks: 8,
    hint: (t) => t.myCommandL16Hint,
  ),
  MyCommandLevel(
    map: ['######...G', '######.###', '###....###', '###.######', '....######', 'S#########'],
    command: 'U 3(R)',
    main: 'C U C U C',
    maxBlocks: 8,
    hint: (t) => t.myCommandL17Hint,
  ),
  MyCommandLevel(
    map: ['S#######', '.#..####', '....####', '###...##', '#####.##', '#####..G'],
    command: '2(D) 2(R)',
    main: 'C U R C C',
    maxBlocks: 9,
    hint: (t) => t.myCommandL18Hint,
  ),
  MyCommandLevel(
    map: ['######.G', '######.#', '####.*.#', '#....###', '#.#..###', 'S.######'],
    command: 'R 2(U) R',
    main: 'C R D C C',
    maxBlocks: 9,
    hint: (t) => t.myCommandL19Hint,
  ),
  MyCommandLevel(
    map: ['S.#..#####', '#.....####', '##..#...##', '#######..#', '########.G'],
    command: '2(RD) R',
    main: 'C U U C C',
    maxBlocks: 9,
    hint: (t) => t.myCommandL20Hint,
  ),
];
