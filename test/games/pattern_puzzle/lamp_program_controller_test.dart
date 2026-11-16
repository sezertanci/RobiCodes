import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/path_finder/engine/lamp.dart';
import 'package:robi_codes/games/pattern_puzzle/engine/pattern_level.dart';
import 'package:robi_codes/games/pattern_puzzle/lamp_program_controller.dart';
import 'package:robi_codes/games/repeat/engine/repeat_program.dart';
import 'package:robi_codes/games/repeat/repeat_texts.dart';

import '../../support/test_l10n.dart';

const _red = LightBlock(LampColor.red);
const _blue = LightBlock(LampColor.blue);

/// Kırmızı-mavi dört lamba; çözüm 2 kez (kırmızı, mavi), sınır 3 blok.
final _level = PatternProgramLevel(
  lamps: 'R B R B',
  solution: const [
    RepeatBlock(2, [_red, _blue]),
  ],
  maxBlocks: 3,
  intro: (t) => t.patternIntroExpert,
  hint: (t) => t.patternHintProgram,
);

LampProgramController _controller(List<int> stars) => LampProgramController(
  level: _level,
  onCompleted: stars.add,
  stepDuration: Duration.zero,
  celebrateDuration: Duration.zero,
);

/// Tekrarla bloğu açıp içine kırmızı ve mavi ekler; tekrar sayısı varsayılan değerdedir.
LampProgramController _withRepeat(List<int> stars) {
  final controller = _controller(stars)..pressRepeatButton();
  controller
    ..addLight(LampColor.red)
    ..addLight(LampColor.blue);
  return controller;
}

void main() {
  test('constructor_Default_AllLampsDarkAndSaysIntro', () {
    final controller = _controller([]);

    expect(controller.lamps.values.map((lamp) => lamp.lit), everyElement(isFalse));
    expect(controller.message(texts), texts.patternIntroExpert);
  });

  test('addLight_OpenRepeat_PutsLightBlockInside', () {
    final controller = _withRepeat([]);

    expect(controller.program, [
      const RepeatBlock(RepeatBlock.defaultTimes, [_red, _blue]),
    ]);
  });

  test('pressRepeatButton_OpenAndLeave_TalksAboutColors', () {
    final controller = _controller([])..pressRepeatButton();

    expect(controller.message(texts), texts.patternInsideRepeat);
    controller.pressRepeatButton();
    expect(controller.message(texts), texts.patternOutsideRepeat);
  });

  test('run_EmptyRepeat_SaysAddColorInside', () async {
    final controller = _controller([])..pressRepeatButton();

    await controller.run();

    expect(controller.message(texts), texts.patternEmptyRepeat);
  });

  test('run_Solution_CompletesWithThreeStars', () async {
    final stars = <int>[];
    final controller = _withRepeat(stars);

    await controller.run();

    expect(stars, [3]);
  });

  test('run_WrongColor_MarksWrongLampAndSaysItsColor', () async {
    final stars = <int>[];
    final controller = _controller(stars)
      ..addLight(LampColor.red)
      ..addLight(LampColor.red);

    await controller.run();

    final wrong = controller.lamps[PatternProgramLevel.lampAt(1)]!;
    expect(stars, isEmpty);
    expect(wrong.wrong, isTrue);
    expect(wrong.color, LampColor.red);
    expect(controller.message(texts), texts.patternWrongColor(RepeatTexts.lampColor(texts, LampColor.red)));
  });

  test('run_TooFewLights_SaysLampsDark', () async {
    final stars = <int>[];
    final controller = _controller(stars)..addLight(LampColor.red);

    await controller.run();

    expect(stars, isEmpty);
    expect(controller.message(texts), texts.patternLampsDark);
  });

  test('run_EmptyProgram_SaysProgramEmpty', () async {
    final controller = _controller([]);

    await controller.run();

    expect(controller.message(texts), texts.patternProgramEmpty);
  });

  test('showHint_WrongColorBlock_SelectsItAndSaysWantedColor', () {
    final controller = _controller([])
      ..addLight(LampColor.red)
      ..addLight(LampColor.red);

    controller.showHint();

    expect(controller.selected, (block: 1, inner: Places.topLevel));
    expect(controller.message(texts), texts.patternProgramHintWrong(RepeatTexts.lampColor(texts, LampColor.blue)));
  });

  test('showHint_TooFewLights_SaysLevelHint', () {
    final controller = _controller([])..addLight(LampColor.red);

    controller.showHint();

    expect(controller.message(texts), texts.patternHintProgram);
  });
}
