import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/games/path_finder/engine/lamp.dart';
import 'package:robi_codes/games/pattern_puzzle/engine/pattern_level.dart';
import 'package:robi_codes/games/pattern_puzzle/engine/pattern_tile.dart';
import 'package:robi_codes/games/pattern_puzzle/pattern_puzzle_controller.dart';

import '../../support/test_l10n.dart';

const _red = LampTile(LampColor.red);
const _blue = LampTile(LampColor.blue);

/// İki eksik parçalı desen: 2. ve 4. parça (mavi).
final _level = PatternPuzzleLevel(
  pattern: 'R [B] R [B]',
  intro: (t) => t.patternIntroEasy,
  hint: (t) => t.patternHintRepeat,
);

PatternPuzzleController _controller(List<int> stars) => PatternPuzzleController(
  level: _level,
  onCompleted: stars.add,
  celebrateDuration: Duration.zero,
  wrongDuration: Duration.zero,
);

void main() {
  test('constructor_Default_SelectsFirstMissingAndSaysIntro', () {
    final controller = _controller([]);

    expect(controller.selected, 1);
    expect(controller.shownTile(1), isNull);
    expect(controller.shownTile(0), _red);
    expect(controller.message(texts), texts.patternIntroEasy);
  });

  test('pick_RightOption_FillsSlotAndSelectsNextMissing', () async {
    final controller = _controller([]);

    await controller.pick(_blue);

    expect(controller.shownTile(1), _blue);
    expect(controller.selected, 3);
    expect(controller.message(texts), texts.patternRightLamp);
  });

  test('pick_AllRightWithoutMistake_CompletesWithThreeStars', () async {
    final stars = <int>[];
    final controller = _controller(stars);

    await controller.pick(_blue);
    await controller.pick(_blue);

    expect(controller.isDone, isTrue);
    expect(controller.message(texts), texts.patternSolved);
    expect(stars, [3]);
  });

  test('pick_WrongOption_ShowsWrongTileThenRemovesIt', () async {
    final controller = _controller([]);

    final picking = controller.pick(_red);

    expect(controller.wrongSlot, 1);
    expect(controller.shownTile(1), _red);
    expect(controller.mood, RobotMood.sad);
    await picking;
    expect(controller.wrongSlot, isNull);
    expect(controller.shownTile(1), isNull);
    expect(controller.selected, 1);
  });

  test('pick_MistakeBeforeSolving_CompletesWithTwoStars', () async {
    final stars = <int>[];
    final controller = _controller(stars);

    await controller.pick(_red);
    await controller.pick(_blue);
    await controller.pick(_blue);

    expect(stars, [2]);
  });

  test('showHint_SlotSelected_HighlightsRightOptionUntilPick', () async {
    final controller = _controller([]);

    controller.showHint();

    expect(controller.highlighted, _blue);
    expect(controller.message(texts), texts.patternHintRepeat);
    await controller.pick(_blue);
    expect(controller.highlighted, isNull);
  });

  test('showHint_ThenSolved_GivesOneStar', () async {
    final stars = <int>[];
    final controller = _controller(stars);

    controller.showHint();
    await controller.pick(_blue);
    await controller.pick(_blue);

    expect(controller.hintUsed, isTrue);
    expect(stars, [1]);
  });

  test('selectSlot_FilledOrNotMissing_IsIgnored', () async {
    final controller = _controller([]);
    await controller.pick(_blue);

    controller
      ..selectSlot(0)
      ..selectSlot(1);

    expect(controller.selected, 3);
  });
}
