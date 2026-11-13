import 'path_finder_level.dart';

/// "Robotun Yolunu Bul" temel paketinin 20 seviyesi. Web sürümündeki
/// `js/games/path-finder/levels.js` dosyasından aynı sırayla aktarıldı.
/// Gruplar katalogda tanımlıdır: 1–5 Kolay, 6–10 Orta, 11–15 Zor, 16–20 Uzman.
const pathFinderBaseLevels = <PathFinderLevel>[
  // Kolay
  PathFinderLevel(
    map: ['....', 'SG..', '....'],
    solution: 'R',
    intro: 'Robotu bayrağa götür. Sağa okuna bas, sonra yeşil Başlat tuşuna dokun.',
  ),
  PathFinderLevel(
    map: ['..G.', '..S.', '....'],
    solution: 'U',
    intro: 'Bayrak robotun yukarısında. Hangi oku seçmelisin?',
  ),
  PathFinderLevel(map: ['.....', 'G.S..', '.....'], solution: 'LL', intro: 'Bayrak solda ve iki kare uzakta.'),
  PathFinderLevel(map: ['.S..', '....', '.G..'], solution: 'DD', intro: 'Robot aşağı inmeli. Kaç kez?'),
  PathFinderLevel(map: ['...G', '.S..', '....'], solution: 'URR', intro: 'Bu kez iki farklı yön kullanacaksın.'),
  // Orta
  PathFinderLevel(map: ['S....', '.....', '...G.'], solution: 'DDRRR'),
  PathFinderLevel(map: ['.....', '..G..', '.....', 'S....'], solution: 'UURR'),
  PathFinderLevel(map: ['G....', '.....', '....S'], solution: 'UULLLL'),
  PathFinderLevel(map: ['..S..', '.....', 'G....', '.....'], solution: 'DDLL'),
  PathFinderLevel(map: ['....G', 'S....', '.....'], solution: 'URRRR'),
  // Zor
  PathFinderLevel(
    map: ['S.#.G', '.....', '.....'],
    solution: 'DRRRUR',
    intro: 'Yolda taş var. Taşın etrafından dolaş.',
  ),
  PathFinderLevel(
    map: ['S.#G.', '..#..', '.....'],
    solution: 'DDRRRUU',
    intro: 'Taşlar duvar gibi dizilmiş. Altından dolaş.',
  ),
  PathFinderLevel(map: ['S~~~G', '.....', '~~.~~'], solution: 'DRRRRU', intro: 'Robot suya giremez. Kuru yolu bul.'),
  PathFinderLevel(map: ['..#..', 'S.#.G', '..#..', '.....'], solution: 'DDRRRRUU'),
  PathFinderLevel(
    map: ['S.#...', '..#.#.', '....#G', '......'],
    solution: 'DDDRRRRRU',
    intro: 'Birden çok yol var. En kısasını bulabilir misin?',
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
