import '../../path_finder/engine/lamp.dart';
import '../../repeat/engine/repeat_program.dart';
import 'pattern_level.dart';

const _red = LightBlock(LampColor.red);
const _blue = LightBlock(LampColor.blue);
const _yellow = LightBlock(LampColor.yellow);
const _green = LightBlock(LampColor.green);

/// Temel paketin 20 seviyesi (desen kısaltması için bkz. [PatternNotation]). Gruplar: 1–5 Kolay (iki renkte tek
/// eksik lamba), 6–10 Orta (birden çok eksik lamba; renk ve biçim birlikte), 11–15 Zor (büyüyen desenler ve sayı
/// dizileri; sayılar 3–4 seçenekten seçilir), 16–20 Uzman (lambaları "renk yak" blokları ve Tekrarla ile yakma).
final patternPuzzleBaseLevels = <PatternLevel>[
  // Kolay 1–5: kırmızı ve mavi, tek eksik lamba.
  PatternPuzzleLevel(pattern: 'R B R B R [B]', intro: (t) => t.patternIntroEasy, hint: (t) => t.patternHintRepeat),
  PatternPuzzleLevel(
    pattern: 'R R B R R B R [R] B',
    intro: (t) => t.patternIntroEasy,
    hint: (t) => t.patternHintRepeat,
  ),
  PatternPuzzleLevel(
    pattern: 'B R R B R R [B] R R',
    intro: (t) => t.patternIntroEasy,
    hint: (t) => t.patternHintRepeat,
  ),
  PatternPuzzleLevel(pattern: 'R R B B R R B [B]', intro: (t) => t.patternIntroEasy, hint: (t) => t.patternHintRepeat),
  PatternPuzzleLevel(
    pattern: '[R] B B R B B R B B',
    intro: (t) => t.patternIntroEasy,
    hint: (t) => t.patternHintRepeat,
  ),
  // Orta 6–10: üç-dört renk ve biçimler, birden çok eksik lamba.
  PatternPuzzleLevel(
    pattern: 'R B Y R B Y [R] [B] Y',
    intro: (t) => t.patternIntroMedium,
    hint: (t) => t.patternHintRepeat,
  ),
  PatternPuzzleLevel(
    pattern: 'Rc Bs Rc Bs [Rc] [Bs]',
    intro: (t) => t.patternIntroMedium,
    hint: (t) => t.patternHintShape,
  ),
  PatternPuzzleLevel(
    pattern: 'G Y Y G Y Y G [Y] [Y]',
    intro: (t) => t.patternIntroMedium,
    hint: (t) => t.patternHintRepeat,
  ),
  PatternPuzzleLevel(
    pattern: 'Rc Rs Bc Bs Rc Rs [Bc] [Bs]',
    intro: (t) => t.patternIntroMedium,
    hint: (t) => t.patternHintShape,
  ),
  PatternPuzzleLevel(
    pattern: 'Rt Bs Yc Gt Rt [Bs] Yc [Gt]',
    intro: (t) => t.patternIntroMedium,
    hint: (t) => t.patternHintShape,
  ),
  // Zor 11–15: sayı dizileri ve büyüyen desen.
  PatternPuzzleLevel(
    pattern: '2 4 6 8 [10]',
    options: '9 10 12',
    intro: (t) => t.patternIntroHard,
    hint: (t) => t.patternHintNumbers,
  ),
  PatternPuzzleLevel(
    pattern: '1 3 5 7 [9]',
    options: '8 9 10',
    intro: (t) => t.patternIntroHard,
    hint: (t) => t.patternHintNumbers,
  ),
  PatternPuzzleLevel(
    pattern: 'R B R B B R B B B [R]',
    intro: (t) => t.patternIntroHard,
    hint: (t) => t.patternHintGrowing,
  ),
  PatternPuzzleLevel(
    pattern: '5 10 15 [20] 25',
    options: '16 20 30',
    intro: (t) => t.patternIntroHard,
    hint: (t) => t.patternHintNumbers,
  ),
  PatternPuzzleLevel(
    pattern: '1 2 4 7 [11]',
    options: '9 10 11 12',
    intro: (t) => t.patternIntroHard,
    hint: (t) => t.patternHintGrowingNumbers,
  ),
  // Uzman 16–20: blok sınırı Tekrarla'yı gerektirir.
  PatternProgramLevel(
    lamps: 'R B R B R B',
    solution: const [
      RepeatBlock(3, [_red, _blue]),
    ],
    maxBlocks: 4,
    intro: (t) => t.patternIntroExpert,
    hint: (t) => t.patternHintProgram,
  ),
  PatternProgramLevel(
    lamps: 'R R B R R B R R B',
    solution: const [
      RepeatBlock(3, [_red, _red, _blue]),
    ],
    maxBlocks: 5,
    intro: (t) => t.patternIntroExpert,
    hint: (t) => t.patternHintProgram,
  ),
  PatternProgramLevel(
    lamps: 'Y G B Y G B Y G B',
    solution: const [
      RepeatBlock(3, [_yellow, _green, _blue]),
    ],
    maxBlocks: 5,
    intro: (t) => t.patternIntroExpert,
    hint: (t) => t.patternHintProgram,
  ),
  PatternProgramLevel(
    lamps: 'R B B R B B G',
    solution: const [
      RepeatBlock(2, [_red, _blue, _blue]),
      _green,
    ],
    maxBlocks: 6,
    intro: (t) => t.patternIntroExpert,
    hint: (t) => t.patternHintProgramTail,
  ),
  PatternProgramLevel(
    lamps: 'R Y R Y B G B G',
    solution: const [
      RepeatBlock(2, [_red, _yellow]),
      RepeatBlock(2, [_blue, _green]),
    ],
    maxBlocks: 7,
    intro: (t) => t.patternIntroExpert,
    hint: (t) => t.patternHintProgramTwo,
  ),
];
