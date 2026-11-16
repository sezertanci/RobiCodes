// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Robi Codes';

  @override
  String get languageName => 'English';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Codes';

  @override
  String get homeTagline => 'Play • Learn • Explore';

  @override
  String get homeComingSoon => 'Coming soon';

  @override
  String get homeLocked => 'Locked';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels levels';
  }

  @override
  String get homeChangeCharacter => 'Change';

  @override
  String homeCharacterLabel(Object name) {
    return 'Your character: $name. Tap to change.';
  }

  @override
  String get commonClose => 'Close';

  @override
  String get commonNextLevel => 'Next level';

  @override
  String get commonBackToHome => 'Back to home';

  @override
  String get commonBackToLevels => 'Back to levels';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stars',
      one: '1 star',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Start';

  @override
  String get commonHint => 'Hint';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonDelete => 'Delete';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsLanguage => 'Language';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Easy',
      'medium': 'Medium',
      'hard': 'Hard',
      'other': 'Expert',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Basic Levels';

  @override
  String get playPreviousLevel => 'Previous level';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, level $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Finish the $difficulty levels first';
  }

  @override
  String get playPreviewNote =>
      'The first level of each difficulty can be tried for free. The other levels open after purchase.';

  @override
  String get playLevelComplete => 'Great! Level complete.';

  @override
  String playLevel(Object level) {
    return 'Level $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Level $level, locked';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Level $level, $stars';
  }

  @override
  String get playLocked => 'locked';

  @override
  String get gamePathFinderTitle => 'Find the Robot\'s Path';

  @override
  String get gamePathFinderDescription =>
      'Guide the robot to the goal with direction commands.';

  @override
  String get gamePathFinderTrophy => 'Robot Master';

  @override
  String get gamePathFinderTrophyDescription =>
      'The robot knows every path now!';

  @override
  String get gameCommandOrderTitle => 'Order the Steps';

  @override
  String get gameCommandOrderDescription => 'Put the steps in the right order.';

  @override
  String get gameCommandOrderTrophy => 'Algorithm Master';

  @override
  String get gameCommandOrderTrophyDescription =>
      'You are the best at ordering steps!';

  @override
  String get gameIfThenTitle => 'If This, Then';

  @override
  String get gameIfThenDescription =>
      'Pick the right command for each situation.';

  @override
  String get gameIfThenTrophy => 'Decision Master';

  @override
  String get gameIfThenTrophyDescription =>
      'You make the right choice every time!';

  @override
  String get gameRepeatTitle => 'Repeat It';

  @override
  String get gameRepeatDescription => 'Do repeated moves with a single block.';

  @override
  String get gameRepeatTrophy => 'Loop Master';

  @override
  String get gameRepeatTrophyDescription => 'You use loops like a pro!';

  @override
  String get gameBugHunterTitle => 'Bug Hunter';

  @override
  String get gameBugHunterDescription => 'Find and fix the broken code.';

  @override
  String get gameBugHunterTrophy => 'Master Bug Hunter';

  @override
  String get gameBugHunterTrophyDescription =>
      'You found even the trickiest bugs!';

  @override
  String get gameMyCommandTitle => 'Make Your Own Command';

  @override
  String get gameMyCommandDescription =>
      'Make your own command with arrows and use it again and again.';

  @override
  String get gameMyCommandTrophy => 'Command Architect';

  @override
  String get gameMyCommandTrophyDescription =>
      'You solved the trickiest paths with your own commands!';

  @override
  String get gameVariableBoxTitle => 'Variable Box';

  @override
  String get gameVariableBoxDescription =>
      'Put a number in the box and the robot takes that many steps.';

  @override
  String get gameVariableBoxTrophy => 'Variable Master';

  @override
  String get gameVariableBoxTrophyDescription =>
      'You made the longest paths shorter with the number in the box!';

  @override
  String get characterTitle => 'Choose your character';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Propeller',
      'isil': 'Glow',
      'kahraman': 'Hero',
      'pembe': 'Pinky',
      'sovalye': 'Knight',
      'piril': 'Sparkle',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'My Achievements';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You earned $count rewards!',
      one: 'You earned 1 reward!',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Badges';

  @override
  String get achievementsBadgesSubtitle => 'Small wins';

  @override
  String get achievementsBadgesEarned => 'Badges you earned';

  @override
  String get achievementsBadgesLocked => 'Badges to earn';

  @override
  String get achievementsBadgesEmpty =>
      'No badges yet. Finish your first level!';

  @override
  String get achievementsTrophies => 'Trophies';

  @override
  String get achievementsTrophiesSubtitle => 'Big goals';

  @override
  String get achievementsTrophiesEarned => 'Trophies you earned';

  @override
  String get achievementsTrophiesLocked => 'Locked trophies';

  @override
  String get achievementsTrophiesEmpty =>
      'No trophies yet. Keep going for the big goals!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'My Achievements: $earned/$total';
  }

  @override
  String get achievementEarned => 'Earned!';

  @override
  String get achievementCondition => 'How to earn: ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, earned';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, locked';
  }

  @override
  String get achievementNewBadge => 'New badge!';

  @override
  String get achievementNewTrophy => 'You won a new trophy!';

  @override
  String get achievementGreat => 'Great!';

  @override
  String get achievementFirstGameTitle => 'My First Game';

  @override
  String get achievementFirstGameDescription =>
      'You took the first step of your coding adventure!';

  @override
  String get achievementFirstGameCondition => 'Complete your first game level.';

  @override
  String get achievementQuickStartTitle => 'Quick Start';

  @override
  String get achievementQuickStartDescription => 'The robots are proud of you!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Complete $goal levels in one game.';
  }

  @override
  String get achievementDeterminedTitle => 'Determined Player';

  @override
  String get achievementDeterminedDescription =>
      'You kept going and never gave up!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Complete $goal levels in one game.';
  }

  @override
  String get achievementMasterCoderTitle => 'Master Coder';

  @override
  String get achievementMasterCoderDescription =>
      'You finished every level of a game!';

  @override
  String get achievementMasterCoderCondition =>
      'Complete every level of a game.';

  @override
  String get achievementAllGamesTitle => 'Game Explorer';

  @override
  String get achievementAllGamesDescription => 'You tried every game!';

  @override
  String get achievementAllGamesCondition =>
      'Finish at least one level in every game.';

  @override
  String get achievementStarHunterTitle => 'Star Hunter';

  @override
  String get achievementStarHunterDescription =>
      'You started collecting stars!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Earn $goal stars in total.';
  }

  @override
  String get achievementStarMasterTitle => 'Star Master';

  @override
  String get achievementStarMasterDescription =>
      'You have as many stars as the sky!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Earn $goal stars in total.';
  }

  @override
  String get achievementPerfectTitle => 'Perfect Player';

  @override
  String get achievementPerfectDescription => 'You finished a level perfectly!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Complete a level with $goal stars.';
  }

  @override
  String get achievementNoHintTitle => 'No-Hint Hero';

  @override
  String get achievementNoHintDescription => 'You solved it all by yourself!';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Complete $goal levels without using a hint.';
  }

  @override
  String get achievementBigSuccessTitle => 'Big Success';

  @override
  String get achievementBigSuccessDescription =>
      'You finished every game from start to end!';

  @override
  String get achievementBigSuccessCondition =>
      'Complete all levels of every game.';

  @override
  String get achievementFirstAdventureTitle => 'First Adventure Trophy';

  @override
  String get achievementFirstAdventureDescription =>
      'You took the first step in every game!';

  @override
  String get achievementFirstAdventureCondition =>
      'Complete the first level in every game.';

  @override
  String get achievementChampionTitle => 'Coding Champion';

  @override
  String get achievementChampionDescription =>
      'You are a true coding champion!';

  @override
  String get achievementChampionCondition => 'Finish all levels of every game.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Finish $game.';
  }

  @override
  String get parentalGateTitle => 'Parental approval';

  @override
  String parentalGateIntro(Object action) {
    return 'This action needs an adult’s approval: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Buying a pack',
      'other': 'Action',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Write the answer in digits.';

  @override
  String get parentalGateCancel => 'Cancel';

  @override
  String get parentalGateConfirm => 'Confirm';

  @override
  String get parentalGateAnswer => 'Answer';

  @override
  String get parentalGateWrongAnswer =>
      'Wrong answer. Please wait a moment, then answer the new question.';

  @override
  String parentalGateQuestion(String first, String second) {
    return 'What is $first times $second?';
  }

  @override
  String get storeTitle => 'Packs';

  @override
  String get storeIntro =>
      'Purchases are made through Google Play, and a parent’s approval is asked before each purchase. You can redeem a Google Play promo code from the \"Redeem code\" link on the payment screen or in the Play Store app; a pack redeemed with a code also appears here as owned.';

  @override
  String get storePaidSection => 'Packs to buy';

  @override
  String get storeFreeSection => 'Free packs';

  @override
  String get storeNoProducts => 'There are no packs to buy right now.';

  @override
  String get storeBundle => 'Bundle';

  @override
  String get storeStarterBundleTitle => 'Starter Set';

  @override
  String get storeOwned => 'Owned';

  @override
  String get storeUnlocks => 'Unlocked when purchased:';

  @override
  String get storePriceLoading => 'Getting the price from Google Play…';

  @override
  String get storePriceUnavailable =>
      'Could not get the price from Google Play.';

  @override
  String get storeNotInStore => 'This pack is not on Google Play right now.';

  @override
  String get storeRetry => 'Try again';

  @override
  String storePartiallyOwned(Object missing) {
    return 'You already own some of the content in this pack. Google Play does not lower the price for what you own, so this pack is not sold to keep you from paying twice for the same content. Missing packs: $missing';
  }

  @override
  String get storeRestore => 'Restore purchases';

  @override
  String get storeRestoreHint =>
      'Reads the purchases on your Google Play account again; game progress is not deleted.';

  @override
  String storeRestored(Object count) {
    return 'Purchases were read again from Google Play. Owned products: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'No internet connection; the purchase records on this device stay valid.';

  @override
  String get storeRestoreUnavailable =>
      'Could not connect to Google Play; the purchase records on this device stay valid.';

  @override
  String storeBuy(Object price) {
    return 'Buy – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count levels',
      one: '1 level',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased => 'Purchase complete; the pack is unlocked.';

  @override
  String get storePending =>
      'Payment is pending. The pack unlocks by itself when the payment completes.';

  @override
  String get storeCancelled => 'Purchase cancelled.';

  @override
  String get storeAlreadyOwned =>
      'You already own this pack; it was not bought again.';

  @override
  String get storeBundlePartiallyOwned =>
      'You already own some of the content in this bundle, so the purchase was not started to avoid paying twice for the same content.';

  @override
  String get storeOffline =>
      'No internet connection. Check the connection and try again.';

  @override
  String get storeUnavailable =>
      'Could not connect to Google Play. Please try again later.';

  @override
  String get storeFailed => 'The purchase could not be completed.';

  @override
  String get storeNotApproved =>
      'Parental approval was not given; the purchase did not start.';

  @override
  String get gameRobotRunning => 'The robot is on its way...';

  @override
  String get gameRobotReachedFlag => 'Great! The robot reached the flag!';

  @override
  String get gameMissingCoins =>
      'You reached the flag but didn\'t collect all the coins. Collect the coins first.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Up',
      'down': 'Down',
      'left': 'Left',
      'other': 'Right',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'a rock',
      'water': 'water',
      'other': 'the edge of the map',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Choose commands in order to get the robot to the flag.';

  @override
  String get pathFinderCoinIntro =>
      'Collect all the coins first, then go to the flag.';

  @override
  String get pathFinderEmpty => 'Add a direction command first.';

  @override
  String get pathFinderFull =>
      'You\'ve reached the command limit. You can delete a command and put another one in its place.';

  @override
  String get pathFinderMissedGoal =>
      'The robot didn\'t reach the flag. Try adding or changing commands.';

  @override
  String get pathFinderTooMany =>
      'You can\'t finish within the limit with these commands. Try deleting the steps you don\'t need.';

  @override
  String get pathFinderSolved =>
      'Your commands are right! Tap the green Start button.';

  @override
  String get pathFinderEmptyStrip =>
      'Press the arrow buttons and your commands will line up here.';

  @override
  String get pathFinderMoveLeft => 'Move the selected command one step left';

  @override
  String get pathFinderMoveRight => 'Move the selected command one step right';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'The robot hit $obstacle. Try changing command $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'Command $number takes the robot off the path. I selected it for you; you can delete it or move it.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Look at the glowing square. Next command: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Add $direction command';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Command $number: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Put the cards in the right order to finish the task. Tap a card or drag it into a box.';

  @override
  String get commandOrderExtrasIntro =>
      'Watch out! Some cards don\'t belong to this task. Only put the cards you need in order.';

  @override
  String get commandOrderFull =>
      'All the boxes are full. Tap a card to take it back.';

  @override
  String get commandOrderNotFull => 'Fill all the boxes first.';

  @override
  String get commandOrderSuccess =>
      'Great! All the steps are in the right order.';

  @override
  String get commandOrderSolved =>
      'The order is right! Tap the green Check button.';

  @override
  String get commandOrderPoolEmpty => 'All the cards are placed';

  @override
  String get commandOrderCheck => 'Check';

  @override
  String commandOrderWrongExtra(Object card) {
    return '\"$card\" is not needed for this task. Take it out of the box.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return 'It is too early for \"$card\" in box $number. Another step must come before it.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint The glowing card \"$card\" belongs in box $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Box $number: $card. Tap to take it back.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Box $number, empty. Tap to put a card here.';
  }

  @override
  String get ifThenIncomplete => 'Fill the empty boxes first.';

  @override
  String get ifThenSuccess =>
      'Great! The robot followed its rules and reached the flag!';

  @override
  String get ifThenSolved =>
      'Your rules are right! Tap the green Start button.';

  @override
  String get ifThenNoSlot =>
      'There is no empty box for this block. Tap the box you want to change to empty it.';

  @override
  String get ifThenLockedSlot =>
      'This box came ready and cannot be changed. Put the block in an empty box.';

  @override
  String get ifThenWrongType =>
      'This block doesn\'t fit there. Objects go in the \"If\" box, moves go next to the arrow.';

  @override
  String get ifThenLane => 'The robot\'s path';

  @override
  String get ifThenObjects => 'Objects';

  @override
  String get ifThenActions => 'Moves';

  @override
  String get ifThenIf => 'If';

  @override
  String get ifThenElseIf => 'Else if';

  @override
  String get ifThenElse => 'Else';

  @override
  String get ifThenThen => 'is ahead';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Empty path',
      'rock': 'Rock',
      'water': 'Water',
      'door': 'Door',
      'other': 'Star',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Go Forward',
      'jump': 'Jump',
      'bridge': 'Build Bridge',
      'open': 'Open Door',
      'other': 'Collect',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'an empty path',
      'rock': 'a rock',
      'water': 'water',
      'door': 'a door',
      'other': 'a star',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'There\'s no need for that on an empty path.',
      'rock': 'You can\'t go through a rock.',
      'water': 'The robot can\'t swim!',
      'door': 'You can\'t pass while the door is closed.',
      'other': 'The star was left on the ground.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'If the path is empty, the robot can go forward.',
      'rock': 'You get over a rock by jumping.',
      'water': 'To cross water, you need to build a bridge.',
      'door': 'To pass the door, you must open it first.',
      'other': 'Use the Collect block to take the star.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'Rule $number';
  }

  @override
  String get ifThenElseRule => 'The \"Else\" row';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'There was $object ahead. $rule ran and the robot did \"$action\". $problem Change the rules and try again.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'There is $object on the glowing square. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Condition',
      'other': 'Move',
    });
    return '$_temp0 box: $value';
  }

  @override
  String get ifThenSlotEmpty => 'empty';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, ready';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Move',
      'other': 'Object',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Take the robot to the flag. Use the Repeat block instead of adding the same move again and again.';

  @override
  String get repeatCoinIntro =>
      'Collect all the coins first, then go to the flag. The Repeat block makes it easier.';

  @override
  String get repeatEmpty => 'Add an arrow or a Repeat block first.';

  @override
  String get repeatFull =>
      'You\'ve reached the block limit. If you\'re ready, tap the green Start button; to change something, select a block and delete it.';

  @override
  String get repeatInsideRepeat =>
      'The arrows you add now will go inside the orange block. When you\'re done, tap the navy Leave block button.';

  @override
  String get repeatEmptyStrip =>
      'Add an arrow or a Repeat block and your blocks will line up here.';

  @override
  String get repeatOutsideRepeat =>
      'The arrows you add now will go outside the block, at the end.';

  @override
  String get repeatMovedOut =>
      'The arrow moved out of the block. The arrows you add now will also go outside, at the end.';

  @override
  String get repeatEmptyRepeat =>
      'The orange block is empty. I selected it; now add an arrow inside.';

  @override
  String get repeatMissedGoal =>
      'The robot didn\'t reach the flag. Try changing the repeat count or the arrows.';

  @override
  String get repeatSolved =>
      'Your blocks are right! Tap the green Start button.';

  @override
  String get repeatFullHint =>
      'You\'ve reached the block limit. Try changing a repeat count, or delete a block and put a Repeat block in its place.';

  @override
  String get repeatAddRepeat => 'Repeat';

  @override
  String get repeatLeaveRepeat => 'Leave block ✓';

  @override
  String get repeatAddRepeatLabel => 'Add a Repeat block';

  @override
  String get repeatLeaveRepeatLabel =>
      'Leave the block; the next arrows go outside';

  @override
  String get repeatDropHere => 'Add arrows here';

  @override
  String get repeatEmptyBody => 'Empty';

  @override
  String get repeatDecrease => 'Decrease the repeat count';

  @override
  String get repeatIncrease => 'Increase the repeat count';

  @override
  String get repeatDeleteLabel => 'Delete the selected block';

  @override
  String get repeatMoveOutLabel =>
      'Move the selected arrow out of the orange block';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times times',
      one: 'once',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'repeat $times times',
      one: 'repeat once',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Add $direction arrow';
  }

  @override
  String repeatArrowName(Object number) {
    return 'Arrow $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'Block $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'Arrow $arrow inside block $block';
  }

  @override
  String repeatMoveChip(Object name, Object direction) {
    return '$name: $direction';
  }

  @override
  String repeatBlockLabel(Object number, int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'repeat $times times',
      one: 'repeat once',
    );
    return 'Block $number: $_temp0. Tap to add arrows inside.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Try changing the repeat count of block $number or the arrows inside it.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place takes the robot off the path.';
  }

  @override
  String repeatExtraBlock(Object place) {
    return '$place is extra. Try deleting it.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'The robot hit $obstacle. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'In round $round, the robot hit $obstacle. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice I marked the wrong spot in red for you.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Look at the glowing square; the robot must go $direction there.';
  }

  @override
  String get repeatL1Intro =>
      'The robot must go right 3 times, but you can only use 2 blocks. Add a Repeat block and put the right arrow inside.';

  @override
  String get repeatL1Hint =>
      'The Repeat block does the arrow inside it as many times as you say. How many times should it go right?';

  @override
  String get repeatL2Intro =>
      'The flag is up there. Use the Repeat block instead of adding the same arrow again and again.';

  @override
  String get repeatL2Hint =>
      'The robot keeps going the same way. Which way, and how many times?';

  @override
  String get repeatL3Hint =>
      'The robot is going down. Count the squares and set the repeat count.';

  @override
  String get repeatL4Hint =>
      'This time to the left. You can change the repeat count with the − and + buttons.';

  @override
  String get repeatL5Intro =>
      'Collect the coins on the path too! There are still only 2 blocks.';

  @override
  String get repeatL5Hint =>
      'The coins are between the robot and the flag, in the same row. The robot only goes right.';

  @override
  String get repeatL6Intro =>
      'Go down like stairs: right, down, right, down... You can put two arrows inside a Repeat block.';

  @override
  String get repeatL6Hint =>
      'One step: one right, one down. How many steps are there?';

  @override
  String get repeatL7Hint =>
      'Right twice, up once. How many times does this pattern repeat?';

  @override
  String get repeatL8Hint => 'First two right, then one down. Repeat that.';

  @override
  String get repeatL9Intro =>
      'You can also add a single arrow after the Repeat block.';

  @override
  String get repeatL9Hint =>
      'Repeat the up-left pattern; you may need one more step at the end.';

  @override
  String get repeatL10Hint =>
      'Each step is two squares wide and one square high.';

  @override
  String get repeatL11Intro =>
      'This time you need two Repeat blocks: one to the right, one down.';

  @override
  String get repeatL11Hint =>
      'How many squares to the right first? Then how many down? Use a separate Repeat block for each.';

  @override
  String get repeatL12Hint =>
      'Go up first, then go right. Two Repeat blocks, two different numbers.';

  @override
  String get repeatL13Hint =>
      'Go around the rocks: right, down, left. Count the squares for each direction.';

  @override
  String get repeatL14Hint =>
      'The path has three parts: right, down, and right again.';

  @override
  String get repeatL15Hint =>
      'Both coins are at the corners of the path. Do each straight part with a Repeat block.';

  @override
  String get repeatL16Intro =>
      'Only 4 blocks! Walk the long path with a short pattern.';

  @override
  String get repeatL16Hint =>
      'The coins are lined up diagonally: look at the right-down pattern.';

  @override
  String get repeatL17Hint =>
      'Each step is two squares high and two squares wide.';

  @override
  String get repeatL18Hint =>
      'Two right, two down. This pattern continues all the way to the flag.';

  @override
  String get repeatL19Hint =>
      'The coins are at the corners of the steps. One step: two right, one down.';

  @override
  String get repeatL20Intro =>
      'A long path that winds like a snake. Use the 10 blocks wisely.';

  @override
  String get repeatL20Hint =>
      'The path is made of five straight parts. Do each part with a Repeat block.';

  @override
  String get bugHunterIntro =>
      'There\'s a bug in this code! First tap Start and watch where the robot gets confused.';

  @override
  String get bugHunterSelected =>
      'If you selected an arrow, a direction button changes it. You can delete the selected block or add a new arrow before it.';

  @override
  String get bugHunterPickInsert =>
      'Which arrow should go before it? Tap a direction button.';

  @override
  String get bugHunterInsertLabel => 'Add an arrow before the selected block';

  @override
  String get bugHunterReset => 'Start over';

  @override
  String get bugHunterL1Intro =>
      'The robot can\'t reach the flag, there\'s a bug in the code! Tap Start and watch the robot. Then tap the wrong arrow and press the right direction button.';

  @override
  String get bugHunterL1Hint =>
      'The flag is straight to the right. All arrows should point right.';

  @override
  String get bugHunterL2Hint =>
      'The robot goes around below the rock. The last arrow should take it up to the flag.';

  @override
  String get bugHunterL3Intro =>
      'An arrow is missing in this code. Where did the robot stop? Add the missing arrow.';

  @override
  String get bugHunterL3Hint =>
      'The robot stops before the flag. It needs one more step.';

  @override
  String get bugHunterL4Intro =>
      'There\'s an extra arrow in this code. Select the extra arrow and delete it.';

  @override
  String get bugHunterL4Hint =>
      'The robot takes one more step after reaching the flag.';

  @override
  String get bugHunterL5Intro =>
      'An arrow is missing, but not at the end. Select an arrow, tap the Add before button, then tap a direction button.';

  @override
  String get bugHunterL5Hint =>
      'While passing below the rock, the robot should go right twice.';

  @override
  String get bugHunterL6Hint => 'After picking up the coin, the flag is below.';

  @override
  String get bugHunterL7Hint =>
      'To get past the water, go right three times along the bottom row.';

  @override
  String get bugHunterL8Intro =>
      'There are two bugs in this code! Each time the robot gets stuck, fix one bug.';

  @override
  String get bugHunterL8Hint => 'Go above the rocks: first right, then down.';

  @override
  String get bugHunterL9Hint =>
      'After picking up both coins, the robot should stop on the flag.';

  @override
  String get bugHunterL10Hint =>
      'Follow the path that winds between the rocks. One arrow is wrong and one is missing.';

  @override
  String get bugHunterL11Intro =>
      'This time the bug is inside the orange Repeat block. Select the arrow inside and change it.';

  @override
  String get bugHunterL11Hint =>
      'The arrow in the Repeat block should point toward the flag.';

  @override
  String get bugHunterL12Intro =>
      'The arrows in this code are right, but the repeat count is wrong. Change the number.';

  @override
  String get bugHunterL12Hint =>
      'How many steps are there? The repeat count should match the number of steps.';

  @override
  String get bugHunterL13Hint => 'Each step is two right, one up.';

  @override
  String get bugHunterL14Hint =>
      'Each step is two right, one down. An arrow is missing inside the block.';

  @override
  String get bugHunterL15Hint =>
      'Only one step is left after the Repeat block.';

  @override
  String get bugHunterL16Intro =>
      'Expert hunter! These codes have more than one bug. Find one each time you run.';

  @override
  String get bugHunterL16Hint =>
      'How many squares to the right first? Then how many down?';

  @override
  String get bugHunterL17Hint =>
      'Each repeat goes two squares right. How many repeats does it take to reach the flag?';

  @override
  String get bugHunterL18Hint =>
      'The rocks are above the steps. On each step, go down first, then right.';

  @override
  String get bugHunterL19Hint =>
      'There\'s a staircase between the water: one right, one down. How many steps are there?';

  @override
  String get bugHunterL20Hint =>
      'First right, then down. Count the squares in each straight part.';

  @override
  String get myCommandIntro =>
      'Make your own command with arrows in the turquoise strip at the top. Then use the Command block in the main program below; every Command block does all the arrows in the command.';

  @override
  String get myCommandCommandEmpty => 'Make your command: add an arrow here.';

  @override
  String get myCommandMainEmpty =>
      'Main program: add a Command block and arrows.';

  @override
  String get myCommandButton => 'Command';

  @override
  String get myCommandButtonLabel => 'Add a Command block to the main program';

  @override
  String myCommandCallLabel(Object number) {
    return 'Block $number: command';
  }

  @override
  String get myCommandEmptyCommand =>
      'Your command is empty. Tap the turquoise strip at the top and add arrows to it.';

  @override
  String get myCommandEmptyMain =>
      'The main program is empty. Add the Command block with the turquoise Command button.';

  @override
  String get myCommandEditCommand =>
      'The arrows you add now will go into the command.';

  @override
  String get myCommandEditMain =>
      'The blocks you add now will go into the main program.';

  @override
  String get myCommandCallAdded =>
      'The Command block was added to the main program. Here the robot will do all the arrows in the command.';

  @override
  String get myCommandUseHint =>
      'Your command is ready. Tap the turquoise Command button to use it in the main program.';

  @override
  String get myCommandFullHint =>
      'You have reached the block limit. Change the command, or replace the arrows in the main program with a Command block.';

  @override
  String get myCommandMissedGoal =>
      'The robot did not reach the flag. Try changing the arrows in the command or the number of Command blocks.';

  @override
  String myCommandOffPath(Object place) {
    return '$place in the command takes the robot off the path.';
  }

  @override
  String myCommandFixCount(Object number) {
    return 'Try changing the repeat count of block $number in the command or the arrows inside it.';
  }

  @override
  String get myCommandLaterCall =>
      'This time the command takes the robot off the path; change the command or the arrows in the main program.';

  @override
  String get myCommandL1Intro =>
      'Make your own command! Put two right arrows in the turquoise strip at the top. Then add your command to the main program with the Command button.';

  @override
  String get myCommandL1Hint =>
      'The robot must go right 6 times. If your command is 2 right arrows, how many times must you use it?';

  @override
  String get myCommandL2Hint =>
      'Go down like a staircase. One step: one right, one down. Make that your command.';

  @override
  String get myCommandL3Intro =>
      'In the main program you can add arrows next to the Command block, too.';

  @override
  String get myCommandL3Hint =>
      'There is a staircase between the rocks: right, down. One more step is needed at the end.';

  @override
  String get myCommandL4Hint =>
      'Two right, one up. How many times does this pattern repeat?';

  @override
  String get myCommandL5Hint =>
      'The robot is climbing to the left: one up, one left. The gold is on this path, too.';

  @override
  String get myCommandL6Hint =>
      'Each step is two squares wide and one square tall.';

  @override
  String get myCommandL7Hint =>
      'Two right, two down. The gold is along this pattern.';

  @override
  String get myCommandL8Hint =>
      'Go past the rocks: first down, then two right.';

  @override
  String get myCommandL9Hint =>
      'Let the command go right four times. Between the two Command blocks, the robot must go down.';

  @override
  String get myCommandL10Hint =>
      'Collect the gold between the rocks: down, two right, up.';

  @override
  String get myCommandL11Intro =>
      'You can put a Repeat block inside your command, too! That way a short command walks a long path.';

  @override
  String get myCommandL11Hint =>
      'Let the command go right three times. Between the commands, the robot goes down once and up once.';

  @override
  String get myCommandL12Hint =>
      'Each part is two right, one down. In one place, an extra step down comes in between.';

  @override
  String get myCommandL13Hint =>
      'Each step is one up, two right. Don\'t forget the gold.';

  @override
  String get myCommandL14Hint =>
      'Each part is two right, one up. Also look at the steps between the commands.';

  @override
  String get myCommandL15Hint =>
      'Each part is one down, two right. Between the commands, the path sometimes goes straight.';

  @override
  String get myCommandL16Hint =>
      'Command: three right, one down. After the first command you need to turn left once.';

  @override
  String get myCommandL17Hint =>
      'Each part is one up, three right. Between the commands, go up one more time.';

  @override
  String get myCommandL18Hint =>
      'You can have two Repeat blocks inside the command: two down, two right.';

  @override
  String get myCommandL19Hint =>
      'Command: one right, two up, one right. Find the arrows in between by counting squares.';

  @override
  String get myCommandL20Hint =>
      'The command starts with two steps: right, down. Then one more step right.';

  @override
  String get variableBoxIntro =>
      'Put a number in the yellow box. Each arrow moves the robot as many squares as the number in the box. The box starts at 1.';

  @override
  String get variableBoxEmpty => 'Add a box block or an arrow first.';

  @override
  String get variableBoxEmptyStrip =>
      'Add a box block and arrows and your blocks will line up here.';

  @override
  String get variableBoxMissedGoal =>
      'The robot didn\'t reach the flag. Try changing the number in the box or the arrows.';

  @override
  String get variableBoxFullHint =>
      'You\'ve reached the block limit. Instead of adding arrows one by one, try putting a bigger number in the box.';

  @override
  String variableBoxWalked(int box) {
    String _temp0 = intl.Intl.pluralLogic(
      box,
      locale: localeName,
      other: 'The box had $box; each arrow moved the robot $box squares.',
      one: 'The box had $box; each arrow moved the robot $box square.',
    );
    return '$_temp0';
  }

  @override
  String variableBoxInnerName(Object block, Object number) {
    return 'Box block $number inside block $block';
  }

  @override
  String variableBoxSetChip(Object name, Object value) {
    return '$name: put $value in the box';
  }

  @override
  String variableBoxIncreaseChip(Object name) {
    return '$name: add 1 to the box';
  }

  @override
  String variableBoxDecreaseChip(Object name) {
    return '$name: take 1 out of the box';
  }

  @override
  String get variableBoxDecrease => 'Decrease the number to put in the box';

  @override
  String get variableBoxIncrease => 'Increase the number to put in the box';

  @override
  String get variableBoxSetLabel => 'Add a block that puts a number in the box';

  @override
  String get variableBoxIncreaseLabel => 'Add a block that adds 1 to the box';

  @override
  String get variableBoxDecreaseLabel =>
      'Add a block that takes 1 out of the box';

  @override
  String variableBoxBadge(Object value) {
    return 'The box now has $value.';
  }

  @override
  String get variableBoxL1Intro =>
      'The flag is 6 squares away, but you can only use 2 blocks. First put 6 in the box, then tap the right arrow.';

  @override
  String get variableBoxL1Hint =>
      'Put 6 in the box with the box = block; then a single right arrow moves the robot 6 squares.';

  @override
  String get variableBoxL2Hint =>
      'The robot must go 3 right and 3 down. Put 3 in the box; then each arrow moves 3 squares.';

  @override
  String get variableBoxL3Hint =>
      'It\'s 4 squares right and 4 squares down. Put 4 in the box, then two arrows are enough.';

  @override
  String get variableBoxL4Hint =>
      'First 5 squares right, then 2 down. Put 5 in the box, right arrow; then make the box 2, down arrow.';

  @override
  String get variableBoxL5Intro =>
      'New block: +1 makes the number in the box one bigger.';

  @override
  String get variableBoxL5Hint =>
      '2 right, 3 down. Put 2 in the box, right arrow, then use +1 to make the box 3 and add the down arrow.';

  @override
  String get variableBoxL6Hint =>
      'Every path is 3 squares: right, down, right, down. Put 3 in the box once; every arrow after that goes 3 squares.';

  @override
  String get variableBoxL7Hint =>
      'The box starts at 1. The path gets one square longer each step: arrow, +1, arrow, +1, arrow.';

  @override
  String get variableBoxL8Intro =>
      'New block: −1 makes the number in the box one smaller.';

  @override
  String get variableBoxL8Hint =>
      'The paths are 4, 3, 2, 1 squares. Put 4 in the box, then add −1 after each arrow.';

  @override
  String get variableBoxL9Hint =>
      'Down 5, right 2, up 5 squares. Before each direction, put that number in the box.';

  @override
  String get variableBoxL10Hint =>
      'All the paths are 3 squares long. Put 3 in the box once, then five arrows are enough.';

  @override
  String get variableBoxL11Intro =>
      'Repeat is back! The number in the box works in every round of the repeat too.';

  @override
  String get variableBoxL11Hint =>
      'The steps are 2 squares. Put 2 in the box, then repeat the right and down arrows 3 times.';

  @override
  String get variableBoxL12Hint =>
      'The steps are 3 squares: first down, then right. Put 3 in the box and repeat the pattern 2 times.';

  @override
  String get variableBoxL13Hint =>
      'Put 2 in the box; repeat the right and up arrows 2 times, then add one more right arrow at the end.';

  @override
  String get variableBoxL14Hint =>
      'First go 3 squares right. Then make the box 2 and repeat the down-right pattern 2 times.';

  @override
  String get variableBoxL15Hint =>
      'First put 2 in the box and repeat the right-down pattern 2 times. The last straight path is 3 squares.';

  @override
  String get variableBoxL16Intro =>
      'You can put +1 inside a Repeat; then the path gets one square longer in every round.';

  @override
  String get variableBoxL16Hint =>
      'The steps grow: 1, 2, 3 squares. Repeat the right arrow, down arrow and +1 block 3 times.';

  @override
  String get variableBoxL17Hint =>
      'The steps shrink: 3, 2, 1 squares. Put 3 in the box; repeat the right, down and −1 blocks 3 times.';

  @override
  String get variableBoxL18Hint =>
      'Each round has a right arrow, +1 and a down arrow; after 2 rounds, add one last right arrow.';

  @override
  String get variableBoxL19Hint =>
      'Put 4 in the box. Repeat the right arrow, −1 and down arrow pattern 2 times.';

  @override
  String get variableBoxL20Hint =>
      'Each arrow is one square longer than the one before. Repeat the right arrow, +1, down arrow, +1 pattern 2 times.';

  @override
  String get ifThenL1Intro =>
      'If there\'s a rock ahead, what should the robot do? Put a move in the empty box.';

  @override
  String get ifThenL2Intro =>
      'The robot can\'t swim. If there\'s water ahead, what should it do?';

  @override
  String get ifThenL3Intro =>
      'There\'s a closed door on the path. What should the robot do when it reaches the door?';

  @override
  String get ifThenL4Intro =>
      'Don\'t pass the stars without collecting them! If there\'s a star ahead, what should the robot do?';

  @override
  String get ifThenL5Intro =>
      'This time you choose the condition too. What\'s on the path?';

  @override
  String get ifThenL6Intro =>
      'If there\'s a rock, do one thing; if not, do something else. Fill both boxes.';

  @override
  String get ifThenL7Intro =>
      'What should it do if there\'s water? What if there\'s no water?';

  @override
  String get ifThenL8Intro =>
      'There are no empty squares on this path! If there\'s no door, what is ahead?';

  @override
  String get ifThenL9Intro => 'Choose the condition and both moves.';

  @override
  String get ifThenL10Intro =>
      'There are rocks and water on the path. One rule and one \"Else\" are enough.';

  @override
  String get ifThenL11Intro =>
      'There are rocks and water too. Make a rule for each one.';

  @override
  String get ifThenL12Intro => 'Open the doors and collect the stars.';

  @override
  String get ifThenL13Intro =>
      'There are three different things but only two rule rows. Use \"Else\" for the third.';

  @override
  String get ifThenL14Intro =>
      'Water, doors and empty path. Which one will you leave to \"Else\"?';

  @override
  String get ifThenL15Intro =>
      'Careful: one of the blocks isn\'t on this path at all.';

  @override
  String get ifThenL16Intro =>
      'The robot is heading to the castle: there are rocks, moats and castle doors.';

  @override
  String get ifThenL17Intro =>
      'Treasure path: collect the stars and get past the obstacles.';

  @override
  String get ifThenL18Intro =>
      'There are no empty squares on this path. Four things need four decisions.';

  @override
  String get ifThenL19Intro =>
      'A long journey! Water, rocks, doors and empty path.';

  @override
  String get ifThenL20Intro =>
      'Last task: collect all the stars and reach the flag.';

  @override
  String get pathFinderL1Intro =>
      'Take the robot to the flag. Press the right arrow, then tap the green Start button.';

  @override
  String get pathFinderL2Intro =>
      'The flag is above the robot. Which arrow should you choose?';

  @override
  String get pathFinderL3Intro => 'The flag is to the left, two squares away.';

  @override
  String get pathFinderL4Intro => 'The robot must go down. How many times?';

  @override
  String get pathFinderL5Intro =>
      'This time you\'ll use two different directions.';

  @override
  String get pathFinderL11Intro => 'There\'s a rock on the path. Go around it.';

  @override
  String get pathFinderL12Intro =>
      'The rocks are lined up like a wall. Go around underneath.';

  @override
  String get pathFinderL13Intro =>
      'The robot can\'t go into water. Find the dry path.';

  @override
  String get pathFinderL15Intro =>
      'There\'s more than one path. Can you find the shortest one?';

  @override
  String get commandOrderL1Title => 'Water the flower';

  @override
  String get commandOrderL1Step1 => 'Fill the watering can';

  @override
  String get commandOrderL1Step2 => 'Water the flower';

  @override
  String get commandOrderL1Hint =>
      'To water the flower, there must be water in the can first.';

  @override
  String get commandOrderL2Title => 'Brush your teeth';

  @override
  String get commandOrderL2Step1 => 'Put toothpaste on the brush';

  @override
  String get commandOrderL2Step2 => 'Brush your teeth';

  @override
  String get commandOrderL2Step3 => 'Rinse your mouth';

  @override
  String get commandOrderL2Hint =>
      'Before you start brushing, there must be toothpaste on the brush.';

  @override
  String get commandOrderL3Title => 'Wash your hands';

  @override
  String get commandOrderL3Step1 => 'Soap your hands';

  @override
  String get commandOrderL3Step2 => 'Rinse your hands';

  @override
  String get commandOrderL3Step3 => 'Dry your hands';

  @override
  String get commandOrderL3Hint =>
      'You can\'t dry your hands before the bubbles are gone.';

  @override
  String get commandOrderL4Title => 'Put on your shoes';

  @override
  String get commandOrderL4Step1 => 'Put on your socks';

  @override
  String get commandOrderL4Step2 => 'Put on your shoes';

  @override
  String get commandOrderL4Step3 => 'Tie your laces';

  @override
  String get commandOrderL4Hint =>
      'What should be on your foot before it goes into the shoe?';

  @override
  String get commandOrderL5Title => 'Make a picture';

  @override
  String get commandOrderL5Step1 => 'Take a sheet of paper';

  @override
  String get commandOrderL5Step2 => 'Draw your picture';

  @override
  String get commandOrderL5Step3 => 'Color your picture';

  @override
  String get commandOrderL5Hint =>
      'To color, you need a picture that is already drawn.';

  @override
  String get commandOrderL6Title => 'Make a sandwich';

  @override
  String get commandOrderL6Step1 => 'Put the plate on the table';

  @override
  String get commandOrderL6Step2 => 'Put the bread on the plate';

  @override
  String get commandOrderL6Step3 => 'Put cheese on top';

  @override
  String get commandOrderL6Step4 => 'Cover it with bread';

  @override
  String get commandOrderL6Step5 => 'Enjoy your meal';

  @override
  String get commandOrderL6Hint =>
      'You need a place to put the bread. What should be on the table first?';

  @override
  String get commandOrderL7Title => 'Tidy up the toys';

  @override
  String get commandOrderL7Step1 => 'Bring the box';

  @override
  String get commandOrderL7Step2 => 'Put the toys in the box';

  @override
  String get commandOrderL7Step3 => 'Close the lid';

  @override
  String get commandOrderL7Step4 => 'Put the box on the shelf';

  @override
  String get commandOrderL7Hint =>
      'What do you do if the box for the toys isn\'t next to you?';

  @override
  String get commandOrderL8Title => 'Plant a seed';

  @override
  String get commandOrderL8Step1 => 'Dig a hole in the soil';

  @override
  String get commandOrderL8Step2 => 'Put the seed in the hole';

  @override
  String get commandOrderL8Step3 => 'Cover it with soil';

  @override
  String get commandOrderL8Step4 => 'Water the seed';

  @override
  String get commandOrderL8Step5 => 'Wait for the sprout';

  @override
  String get commandOrderL8Hint =>
      'You can\'t put the seed in the ground without a hole for it.';

  @override
  String get commandOrderL9Title => 'Get ready for school';

  @override
  String get commandOrderL9Step1 => 'Wake up when the alarm rings';

  @override
  String get commandOrderL9Step2 => 'Put on your school clothes';

  @override
  String get commandOrderL9Step3 => 'Put on your backpack';

  @override
  String get commandOrderL9Step4 => 'Get on the school bus';

  @override
  String get commandOrderL9Hint =>
      'You can\'t get dressed before you wake up. What happens first in the morning?';

  @override
  String get commandOrderL10Title => 'Send a letter';

  @override
  String get commandOrderL10Step1 => 'Write the letter';

  @override
  String get commandOrderL10Step2 => 'Put the letter in the envelope';

  @override
  String get commandOrderL10Step3 => 'Seal the envelope';

  @override
  String get commandOrderL10Step4 => 'Drop it in the mailbox';

  @override
  String get commandOrderL10Hint =>
      'There must be a letter to put in the envelope.';

  @override
  String get commandOrderL11Title => 'Bake a cake';

  @override
  String get commandOrderL11Stage1 => 'Make the batter';

  @override
  String get commandOrderL11Stage2 => 'Bake the cake';

  @override
  String get commandOrderL11Step1 => 'Put the ingredients on the table';

  @override
  String get commandOrderL11Step2 => 'Mix them all in a bowl';

  @override
  String get commandOrderL11Step3 => 'Pour the batter into the pan';

  @override
  String get commandOrderL11Step4 => 'Put the pan in the oven';

  @override
  String get commandOrderL11Step5 => 'Wait for it to bake';

  @override
  String get commandOrderL11Step6 => 'Slice the cake';

  @override
  String get commandOrderL11Hint =>
      'You can\'t put anything in the oven before the batter is ready.';

  @override
  String get commandOrderL12Title => 'Take a bath';

  @override
  String get commandOrderL12Stage1 => 'Get ready for the bath';

  @override
  String get commandOrderL12Stage2 => 'Wash';

  @override
  String get commandOrderL12Stage3 => 'Dry off';

  @override
  String get commandOrderL12Step1 => 'Fill the tub with water';

  @override
  String get commandOrderL12Step2 => 'Get in the tub';

  @override
  String get commandOrderL12Step3 => 'Shampoo your hair';

  @override
  String get commandOrderL12Step4 => 'Rinse off the bubbles';

  @override
  String get commandOrderL12Step5 => 'Dry off with a towel';

  @override
  String get commandOrderL12Hint =>
      'If you get into an empty tub, you can\'t wash.';

  @override
  String get commandOrderL13Title => 'Ride a bike';

  @override
  String get commandOrderL13Stage1 => 'Get ready';

  @override
  String get commandOrderL13Stage2 => 'Ride';

  @override
  String get commandOrderL13Stage3 => 'Finish';

  @override
  String get commandOrderL13Step1 => 'Put on your helmet';

  @override
  String get commandOrderL13Step2 => 'Get on the bike';

  @override
  String get commandOrderL13Step3 => 'Pedal';

  @override
  String get commandOrderL13Step4 => 'Use the brakes';

  @override
  String get commandOrderL13Step5 => 'Get off the bike';

  @override
  String get commandOrderL13Hint =>
      'Safety comes first. What do you put on before you get on the bike?';

  @override
  String get commandOrderL14Title => 'Borrow a library book';

  @override
  String get commandOrderL14Stage1 => 'At the library';

  @override
  String get commandOrderL14Stage2 => 'At home';

  @override
  String get commandOrderL14Stage3 => 'Give it back';

  @override
  String get commandOrderL14Step1 => 'Go to the library';

  @override
  String get commandOrderL14Step2 => 'Choose a book';

  @override
  String get commandOrderL14Step3 => 'Borrow the book';

  @override
  String get commandOrderL14Step4 => 'Bring the book home';

  @override
  String get commandOrderL14Step5 => 'Read the book';

  @override
  String get commandOrderL14Step6 => 'Take the book back';

  @override
  String get commandOrderL14Hint =>
      'To choose a book, you must first go where the books are.';

  @override
  String get commandOrderL15Title => 'Set up a tent';

  @override
  String get commandOrderL15Stage1 => 'Prepare the spot';

  @override
  String get commandOrderL15Stage2 => 'Set up the tent';

  @override
  String get commandOrderL15Stage3 => 'Get the inside ready';

  @override
  String get commandOrderL15Step1 => 'Find a flat spot';

  @override
  String get commandOrderL15Step2 => 'Spread the tent on the ground';

  @override
  String get commandOrderL15Step3 => 'Put in the poles';

  @override
  String get commandOrderL15Step4 => 'Raise the tent';

  @override
  String get commandOrderL15Step5 => 'Fix it with pegs';

  @override
  String get commandOrderL15Step6 => 'Put the sleeping bag inside';

  @override
  String get commandOrderL15Step7 => 'Turn on your lantern';

  @override
  String get commandOrderL15Hint =>
      'To spread the tent, you must first find a good spot.';

  @override
  String get commandOrderL16Title => 'Make a pizza';

  @override
  String get commandOrderL16Stage1 => 'Dough';

  @override
  String get commandOrderL16Stage2 => 'Toppings';

  @override
  String get commandOrderL16Stage3 => 'Baking';

  @override
  String get commandOrderL16Step1 => 'Roll out the dough';

  @override
  String get commandOrderL16Step2 => 'Spread tomato sauce';

  @override
  String get commandOrderL16Step3 => 'Sprinkle cheese';

  @override
  String get commandOrderL16Step4 => 'Put it in the oven';

  @override
  String get commandOrderL16Step5 => 'Wait for it to bake';

  @override
  String get commandOrderL16Step6 => 'Slice it';

  @override
  String get commandOrderL16Extra1 => 'Turn on the TV';

  @override
  String get commandOrderL16Hint =>
      'Not every card belongs to this task. Do you need the TV to make a pizza?';

  @override
  String get commandOrderL17Title => 'Do the laundry';

  @override
  String get commandOrderL17Stage1 => 'Getting ready';

  @override
  String get commandOrderL17Stage2 => 'Washing';

  @override
  String get commandOrderL17Stage3 => 'Drying';

  @override
  String get commandOrderL17Step1 => 'Gather the dirty clothes';

  @override
  String get commandOrderL17Step2 => 'Put them in the machine';

  @override
  String get commandOrderL17Step3 => 'Add the detergent';

  @override
  String get commandOrderL17Step4 => 'Start the machine';

  @override
  String get commandOrderL17Step5 => 'Hang up the clothes';

  @override
  String get commandOrderL17Step6 => 'Fold them when dry';

  @override
  String get commandOrderL17Extra1 => 'Play ball';

  @override
  String get commandOrderL17Hint =>
      'If the dirty clothes are scattered around, what should you do first?';

  @override
  String get commandOrderL18Title => 'Travel by train';

  @override
  String get commandOrderL18Stage1 => 'At the station';

  @override
  String get commandOrderL18Stage2 => 'On the train';

  @override
  String get commandOrderL18Stage3 => 'Arrival';

  @override
  String get commandOrderL18Step1 => 'Buy a ticket';

  @override
  String get commandOrderL18Step2 => 'Go to the platform';

  @override
  String get commandOrderL18Step3 => 'Wait for the train';

  @override
  String get commandOrderL18Step4 => 'Get on the train';

  @override
  String get commandOrderL18Step5 => 'Sit in your seat';

  @override
  String get commandOrderL18Step6 => 'Get off at your stop';

  @override
  String get commandOrderL18Extra1 => 'Board the plane';

  @override
  String get commandOrderL18Hint =>
      'What do you need with you to get on the train?';

  @override
  String get commandOrderL19Title => 'Grow a sapling';

  @override
  String get commandOrderL19Stage1 => 'Plant';

  @override
  String get commandOrderL19Stage2 => 'Take care';

  @override
  String get commandOrderL19Stage3 => 'Grow';

  @override
  String get commandOrderL19Step1 => 'Put soil in the pot';

  @override
  String get commandOrderL19Step2 => 'Plant the seed';

  @override
  String get commandOrderL19Step3 => 'Water the seed';

  @override
  String get commandOrderL19Step4 => 'Put the pot in the sun';

  @override
  String get commandOrderL19Step5 => 'Wait for the sprout';

  @override
  String get commandOrderL19Step6 => 'Plant it in the garden';

  @override
  String get commandOrderL19Extra1 => 'Open an umbrella';

  @override
  String get commandOrderL19Extra2 => 'Put the pot in the dark';

  @override
  String get commandOrderL19Hint =>
      'Plants need water and sunlight to grow. Which cards would hurt them?';

  @override
  String get commandOrderL20Title => 'Bake and share cookies';

  @override
  String get commandOrderL20Stage1 => 'Prepare';

  @override
  String get commandOrderL20Stage2 => 'Bake';

  @override
  String get commandOrderL20Stage3 => 'Share';

  @override
  String get commandOrderL20Step1 => 'Wash your hands';

  @override
  String get commandOrderL20Step2 => 'Mix the ingredients';

  @override
  String get commandOrderL20Step3 => 'Shape the dough';

  @override
  String get commandOrderL20Step4 => 'Bake them in the oven';

  @override
  String get commandOrderL20Step5 => 'Let them cool';

  @override
  String get commandOrderL20Step6 => 'Put them in a box';

  @override
  String get commandOrderL20Step7 => 'Share them with your friends';

  @override
  String get commandOrderL20Extra1 => 'Drive a toy car';

  @override
  String get commandOrderL20Extra2 => 'Go to sleep';

  @override
  String get commandOrderL20Hint =>
      'Before working in the kitchen, you need to get clean.';
}
