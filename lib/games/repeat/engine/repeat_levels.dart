import 'repeat_level.dart';

/// Temel paketin 20 seviyesi. Haritalar, çözümler, blok sınırları ve mesajlar web sürümüyle aynıdır
/// (`js/games/repeat/levels.js`). Gruplar: 1–5 Kolay, 6–10 Orta, 11–15 Zor, 16–20 Uzman.
final repeatBaseLevels = <RepeatLevel>[
  // Kolay 1–5: tek komutu 2–3 kez tekrarlama.
  RepeatLevel(
    map: ['....', 'S..G', '....'],
    solution: '3(R)',
    maxBlocks: 2,
    intro: (t) => t.repeatL1Intro,
    hint: (t) => t.repeatL1Hint,
  ),
  RepeatLevel(
    map: ['.G.', '...', '...', '.S.'],
    solution: '3(U)',
    maxBlocks: 2,
    intro: (t) => t.repeatL2Intro,
    hint: (t) => t.repeatL2Hint,
  ),
  RepeatLevel(map: ['..S..', '.....', '.....', '..G..'], solution: '3(D)', maxBlocks: 2, hint: (t) => t.repeatL3Hint),
  RepeatLevel(map: ['....', 'G..S', '....'], solution: '3(L)', maxBlocks: 2, hint: (t) => t.repeatL4Hint),
  RepeatLevel(
    map: ['S**G'],
    solution: '3(R)',
    maxBlocks: 2,
    intro: (t) => t.repeatL5Intro,
    hint: (t) => t.repeatL5Hint,
  ),
  // Orta 6–10: birden fazla komutu döngü içinde tekrarlama.
  RepeatLevel(
    map: ['S...', '....', '....', '...G'],
    solution: '3(RD)',
    maxBlocks: 4,
    intro: (t) => t.repeatL6Intro,
    hint: (t) => t.repeatL6Hint,
  ),
  RepeatLevel(map: ['....G', '.....', 'S....'], solution: '2(RRU)', maxBlocks: 5, hint: (t) => t.repeatL7Hint),
  RepeatLevel(map: ['S....', '.....', '....G'], solution: '2(RRD)', maxBlocks: 5, hint: (t) => t.repeatL8Hint),
  RepeatLevel(
    map: ['G...', '....', '....', '....', '...S'],
    solution: '3(UL) U',
    maxBlocks: 5,
    intro: (t) => t.repeatL9Intro,
    hint: (t) => t.repeatL9Hint,
  ),
  RepeatLevel(
    map: ['S......', '.......', '.......', '......G'],
    solution: '3(RRD)',
    maxBlocks: 5,
    hint: (t) => t.repeatL10Hint,
  ),
  // Zor 11–15: farklı tekrar sayıları ve ardışık döngüler.
  RepeatLevel(
    map: ['S....', '####.', '....G'],
    solution: '4(R) 2(D)',
    maxBlocks: 5,
    intro: (t) => t.repeatL11Intro,
    hint: (t) => t.repeatL11Hint,
  ),
  RepeatLevel(
    map: ['....G', '.####', '.####', 'S####'],
    solution: '3(U) 4(R)',
    maxBlocks: 5,
    hint: (t) => t.repeatL12Hint,
  ),
  RepeatLevel(map: ['S...', '###.', 'G...'], solution: '3(R) 2(D) 3(L)', maxBlocks: 7, hint: (t) => t.repeatL13Hint),
  RepeatLevel(
    map: ['S..##', '##.##', '##.##', '##..G'],
    solution: '2(R) 3(D) 2(R)',
    maxBlocks: 6,
    hint: (t) => t.repeatL14Hint,
  ),
  RepeatLevel(
    map: ['S.*###', '##.###', '##*..G'],
    solution: '2(R) 2(D) 3(R)',
    maxBlocks: 6,
    hint: (t) => t.repeatL15Hint,
  ),
  // Uzman 16–20: daha uzun desenleri daha az komutla tamamlama.
  RepeatLevel(
    map: ['S.....', '.*....', '......', '...*..', '.....G'],
    solution: '4(RD) R',
    maxBlocks: 4,
    intro: (t) => t.repeatL16Intro,
    hint: (t) => t.repeatL16Hint,
  ),
  RepeatLevel(
    map: ['......G', '.......', '....*..', '.......', '..*....', '.......', 'S......'],
    solution: '3(UURR)',
    maxBlocks: 5,
    hint: (t) => t.repeatL17Hint,
  ),
  RepeatLevel(
    map: ['S......', '.......', '..*....', '.......', '....*..', '.......', '......G'],
    solution: '3(RRDD)',
    maxBlocks: 5,
    hint: (t) => t.repeatL18Hint,
  ),
  RepeatLevel(
    map: ['S........', '..*......', '....*....', '......*..', '........G'],
    solution: '4(RRD)',
    maxBlocks: 4,
    hint: (t) => t.repeatL19Hint,
  ),
  RepeatLevel(
    map: ['S.*..', '####.', '..*..', '.####', '..*.G'],
    solution: '4(R) 2(D) 4(L) 2(D) 4(R)',
    maxBlocks: 10,
    intro: (t) => t.repeatL20Intro,
    hint: (t) => t.repeatL20Hint,
  ),
];
