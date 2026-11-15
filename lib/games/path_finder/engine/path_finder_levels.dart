import 'path_finder_level.dart';

/// "Robotun Yolunu Bul" temel paketinin 20 seviyesi. Web sürümündeki
/// `js/games/path-finder/levels.js` dosyasından aynı sırayla aktarıldı.
/// Gruplar katalogda tanımlıdır: 1–5 Kolay, 6–10 Orta, 11–15 Zor, 16–20 Uzman.
final pathFinderBaseLevels = <PathFinderLevel>[
  // Kolay
  PathFinderLevel(map: ['....', 'SG..', '....'], solution: 'R', intro: (t) => t.pathFinderL1Intro),
  PathFinderLevel(map: ['..G.', '..S.', '....'], solution: 'U', intro: (t) => t.pathFinderL2Intro),
  PathFinderLevel(map: ['.....', 'G.S..', '.....'], solution: 'LL', intro: (t) => t.pathFinderL3Intro),
  PathFinderLevel(map: ['.S..', '....', '.G..'], solution: 'DD', intro: (t) => t.pathFinderL4Intro),
  PathFinderLevel(map: ['...G', '.S..', '....'], solution: 'URR', intro: (t) => t.pathFinderL5Intro),
  // Orta
  PathFinderLevel(map: ['S....', '.....', '...G.'], solution: 'DDRRR'),
  PathFinderLevel(map: ['.....', '..G..', '.....', 'S....'], solution: 'UURR'),
  PathFinderLevel(map: ['G....', '.....', '....S'], solution: 'UULLLL'),
  PathFinderLevel(map: ['..S..', '.....', 'G....', '.....'], solution: 'DDLL'),
  PathFinderLevel(map: ['....G', 'S....', '.....'], solution: 'URRRR'),
  // Zor
  PathFinderLevel(map: ['S.#.G', '.....', '.....'], solution: 'DRRRUR', intro: (t) => t.pathFinderL11Intro),
  PathFinderLevel(map: ['S.#G.', '..#..', '.....'], solution: 'DDRRRUU', intro: (t) => t.pathFinderL12Intro),
  PathFinderLevel(map: ['S~~~G', '.....', '~~.~~'], solution: 'DRRRRU', intro: (t) => t.pathFinderL13Intro),
  PathFinderLevel(map: ['..#..', 'S.#.G', '..#..', '.....'], solution: 'DDRRRRUU'),
  PathFinderLevel(
    map: ['S.#...', '..#.#.', '....#G', '......'],
    solution: 'DDDRRRRRU',
    intro: (t) => t.pathFinderL15Intro,
  ),
  // Uzman
  PathFinderLevel(map: ['S.....G', '...*...', '.......'], solution: 'DRRRURRR', maxCommands: 10),
  PathFinderLevel(map: ['.......', 'S.#*#..', '..#.#..', '......G'], solution: 'URRRDDDRRR', maxCommands: 12),
  PathFinderLevel(map: ['*.....*', '..#~#..', 'S.....G'], solution: 'UURRRRRRDD', maxCommands: 12),
  PathFinderLevel(
    map: ['S..#...', '.#.#.#.', '...*...', '~#.#.#.', '......G'],
    solution: 'DDRRRRDDRR',
    maxCommands: 12,
  ),
  PathFinderLevel(map: ['*..#..*', '.#...#.', 'S#.#.#.', '...#..G'], solution: 'UURRDRRURRDDD', maxCommands: 15),
];
