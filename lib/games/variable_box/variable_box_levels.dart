import '../repeat/engine/repeat_level.dart';

/// Temel paketin 20 seviyesi. Her ok robotu kutudaki sayı kadar yürütür; kutu 1 ile başlar. Çözümlerde
/// "=3" kutuya 3 koyar, "+" ve "-" kutuyu bir artırır ya da azaltır. Her haritada blok sınırı kutu
/// kullanılmadan (yalnızca oklarla, 11–20'de oklar ve Tekrarla ile) aşılır. Gruplar: 1–5 Kolay, 6–10 Orta
/// (Tekrarla yok), 11–15 Zor (sabit kutuyla Tekrarla), 16–20 Uzman (Tekrarla'nın içinde kutu bloğu).
final variableBoxBaseLevels = <RepeatLevel>[
  // Kolay 1–5: kutuya sayı koyma, +1.
  RepeatLevel(
    map: ['S.....G'],
    solution: '=6 R',
    maxBlocks: 2,
    intro: (t) => t.variableBoxL1Intro,
    hint: (t) => t.variableBoxL1Hint,
  ),
  RepeatLevel(map: ['S...', '....', '....', '...G'], solution: '=3 R D', maxBlocks: 3, hint: (t) => t.variableBoxL2Hint),
  RepeatLevel(
    map: ['S....', '.....', '.....', '.....', '....G'],
    solution: '=4 R D',
    maxBlocks: 3,
    hint: (t) => t.variableBoxL3Hint,
  ),
  RepeatLevel(
    map: ['S.....', '......', '.....G'],
    solution: '=5 R =2 D',
    maxBlocks: 4,
    hint: (t) => t.variableBoxL4Hint,
  ),
  RepeatLevel(
    map: ['S..', '...', '...', '..G'],
    solution: '=2 R + D',
    maxBlocks: 4,
    intro: (t) => t.variableBoxL5Intro,
    hint: (t) => t.variableBoxL5Hint,
  ),
  // Orta 6–10: dar yollar, +1 ve −1.
  RepeatLevel(
    map: ['S...###', '###.###', '###.###', '###....', '######.', '######.', '######G'],
    solution: '=3 R D R D',
    maxBlocks: 5,
    hint: (t) => t.variableBoxL6Hint,
  ),
  RepeatLevel(map: ['S.###', '#.###', '#...G'], solution: 'R + D + R', maxBlocks: 5, hint: (t) => t.variableBoxL7Hint),
  RepeatLevel(
    map: ['S....##', '####.##', '####.##', '####...', '######G'],
    solution: '=4 R - D - R - D',
    maxBlocks: 8,
    intro: (t) => t.variableBoxL8Intro,
    hint: (t) => t.variableBoxL8Hint,
  ),
  RepeatLevel(
    map: ['S#G', '.#.', '.#.', '.#.', '.#.', '...'],
    solution: '=5 D =2 R =5 U',
    maxBlocks: 6,
    hint: (t) => t.variableBoxL9Hint,
  ),
  RepeatLevel(
    map: ['S...', '###.', '###.', '....', '.###', '.###', '...G'],
    solution: '=3 R D L D R',
    maxBlocks: 6,
    hint: (t) => t.variableBoxL10Hint,
  ),
  // Zor 11–15: kutuya bir sayı koyup Tekrarla.
  RepeatLevel(
    map: ['S..####', '##.####', '##...##', '####.##', '####...', '######.', '######G'],
    solution: '=2 3(RD)',
    maxBlocks: 4,
    intro: (t) => t.variableBoxL11Intro,
    hint: (t) => t.variableBoxL11Hint,
  ),
  RepeatLevel(
    map: ['S######', '.######', '.######', '....###', '###.###', '###.###', '###...G'],
    solution: '=3 2(DR)',
    maxBlocks: 4,
    hint: (t) => t.variableBoxL12Hint,
  ),
  RepeatLevel(
    map: ['####..G', '####.##', '##...##', '##.####', 'S..####'],
    solution: '=2 2(RU) R',
    maxBlocks: 5,
    hint: (t) => t.variableBoxL13Hint,
  ),
  RepeatLevel(
    map: ['S...####', '###.####', '###...##', '#####.##', '#####..G'],
    solution: '=3 R =2 2(DR)',
    maxBlocks: 6,
    hint: (t) => t.variableBoxL14Hint,
  ),
  RepeatLevel(
    map: ['S..#####', '##.#####', '##...###', '####.###', '####...G'],
    solution: '=2 2(RD) =3 R',
    maxBlocks: 6,
    hint: (t) => t.variableBoxL15Hint,
  ),
  // Uzman 16–20: Tekrarla'nın içinde +1 ya da −1; yol her turda uzar ya da kısalır.
  RepeatLevel(
    map: ['S.#####', '#...###', '###.###', '###....', '######.', '######.', '######G'],
    solution: '3(RD+)',
    maxBlocks: 4,
    intro: (t) => t.variableBoxL16Intro,
    hint: (t) => t.variableBoxL16Hint,
  ),
  RepeatLevel(
    map: ['S...###', '###.###', '###.###', '###...#', '#####.#', '#####..', '######G'],
    solution: '=3 3(RD-)',
    maxBlocks: 5,
    hint: (t) => t.variableBoxL17Hint,
  ),
  RepeatLevel(
    map: ['S.#####', '#.#####', '#...###', '###.###', '###.###', '###...G'],
    solution: '2(R+D) R',
    maxBlocks: 5,
    hint: (t) => t.variableBoxL18Hint,
  ),
  RepeatLevel(
    map: ['S....###', '####.###', '####.###', '####....', '#######.', '#######G'],
    solution: '=4 2(R-D)',
    maxBlocks: 5,
    hint: (t) => t.variableBoxL19Hint,
  ),
  RepeatLevel(
    map: ['S.###', '#.###', '#....', '####.', '####.', '####.', '####G'],
    solution: '2(R+D+)',
    maxBlocks: 5,
    hint: (t) => t.variableBoxL20Hint,
  ),
];
