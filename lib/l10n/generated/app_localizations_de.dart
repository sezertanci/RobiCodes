// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Robi Programmiert';

  @override
  String get languageName => 'Deutsch';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Programmiert';

  @override
  String get homeTagline => 'Spielen • Lernen • Entdecken';

  @override
  String get homeComingSoon => 'Bald verfügbar';

  @override
  String get homeLocked => 'Gesperrt';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels Level';
  }

  @override
  String get homeChangeCharacter => 'Ändern';

  @override
  String homeCharacterLabel(Object name) {
    return 'Deine Figur: $name. Tippe, um sie zu ändern.';
  }

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonNextLevel => 'Nächstes Level';

  @override
  String get commonBackToHome => 'Zum Startbildschirm';

  @override
  String get commonBackToLevels => 'Zu den Leveln';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sterne',
      one: '1 Stern',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Start';

  @override
  String get commonHint => 'Tipp';

  @override
  String get commonClear => 'Leeren';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSound => 'Ton';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Leicht',
      'medium': 'Mittel',
      'hard': 'Schwer',
      'other': 'Experte',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Grundlevel';

  @override
  String get playPreviousLevel => 'Vorheriges Level';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, Level $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Schließe zuerst die Level „$difficulty“ ab';
  }

  @override
  String get playPreviewNote =>
      'Das erste Level jedes Schwierigkeitsgrads kannst du kostenlos ausprobieren. Die anderen Level werden nach dem Kauf freigeschaltet.';

  @override
  String get playLevelComplete => 'Super! Level geschafft.';

  @override
  String playLevel(Object level) {
    return 'Level $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Level $level, gesperrt';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Level $level, $stars';
  }

  @override
  String get playLocked => 'gesperrt';

  @override
  String get gamePathFinderTitle => 'Finde den Weg des Roboters';

  @override
  String get gamePathFinderDescription =>
      'Führe den Roboter mit Richtungsbefehlen zum Ziel.';

  @override
  String get gamePathFinderTrophy => 'Robotermeister';

  @override
  String get gamePathFinderTrophyDescription =>
      'Der Roboter kennt jetzt jeden Weg!';

  @override
  String get gameCommandOrderTitle => 'Ordne die Schritte';

  @override
  String get gameCommandOrderDescription =>
      'Bring die Schritte in die richtige Reihenfolge.';

  @override
  String get gameCommandOrderTrophy => 'Algorithmusmeister';

  @override
  String get gameCommandOrderTrophyDescription =>
      'Im Ordnen von Schritten bist du der Beste!';

  @override
  String get gameIfThenTitle => 'Wenn das, dann';

  @override
  String get gameIfThenDescription =>
      'Wähle für jede Situation den richtigen Befehl.';

  @override
  String get gameIfThenTrophy => 'Entscheidungsmeister';

  @override
  String get gameIfThenTrophyDescription =>
      'Du triffst jedes Mal die richtige Wahl!';

  @override
  String get gameRepeatTitle => 'Wiederhole es';

  @override
  String get gameRepeatDescription =>
      'Mach wiederholte Bewegungen mit einem einzigen Block.';

  @override
  String get gameRepeatTrophy => 'Schleifenmeister';

  @override
  String get gameRepeatTrophyDescription =>
      'Du benutzt Schleifen wie ein Profi!';

  @override
  String get gameBugHunterTitle => 'Fehlerjäger';

  @override
  String get gameBugHunterDescription =>
      'Finde den kaputten Code und repariere ihn.';

  @override
  String get gameBugHunterTrophy => 'Fehlerjäger-Meister';

  @override
  String get gameBugHunterTrophyDescription =>
      'Du hast sogar die kniffligsten Fehler gefunden!';

  @override
  String get gameMyCommandTitle => 'Eigener Befehl';

  @override
  String get gameMyCommandDescription =>
      'Baue mit Pfeilen deinen eigenen Befehl und nutze ihn immer wieder.';

  @override
  String get gameMyCommandTrophy => 'Befehlsarchitekt';

  @override
  String get gameMyCommandTrophyDescription =>
      'Du hast die schwierigsten Wege mit deinen eigenen Befehlen gelöst!';

  @override
  String get characterTitle => 'Wähle deine Figur';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Propeller',
      'isil': 'Leuchti',
      'kahraman': 'Held',
      'pembe': 'Rosa',
      'sovalye': 'Ritter',
      'piril': 'Glitzer',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Meine Erfolge';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Du hast $count Belohnungen bekommen!',
      one: 'Du hast 1 Belohnung bekommen!',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Abzeichen';

  @override
  String get achievementsBadgesSubtitle => 'Kleine Erfolge';

  @override
  String get achievementsBadgesEarned => 'Deine Abzeichen';

  @override
  String get achievementsBadgesLocked => 'Abzeichen, die du noch holen kannst';

  @override
  String get achievementsBadgesEmpty =>
      'Noch keine Abzeichen. Schaffe dein erstes Level!';

  @override
  String get achievementsTrophies => 'Pokale';

  @override
  String get achievementsTrophiesSubtitle => 'Große Ziele';

  @override
  String get achievementsTrophiesEarned => 'Deine Pokale';

  @override
  String get achievementsTrophiesLocked => 'Gesperrte Pokale';

  @override
  String get achievementsTrophiesEmpty =>
      'Noch keine Pokale. Mach weiter, um die großen Ziele zu erreichen!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'Meine Erfolge: $earned/$total';
  }

  @override
  String get achievementEarned => 'Geschafft!';

  @override
  String get achievementCondition => 'So bekommst du es: ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, geschafft';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, gesperrt';
  }

  @override
  String get achievementNewBadge => 'Neues Abzeichen!';

  @override
  String get achievementNewTrophy => 'Du hast einen neuen Pokal gewonnen!';

  @override
  String get achievementGreat => 'Super!';

  @override
  String get achievementFirstGameTitle => 'Mein erstes Spiel';

  @override
  String get achievementFirstGameDescription =>
      'Du hast den ersten Schritt deines Programmier-Abenteuers gemacht!';

  @override
  String get achievementFirstGameCondition =>
      'Schaffe dein erstes Level in einem Spiel.';

  @override
  String get achievementQuickStartTitle => 'Schneller Start';

  @override
  String get achievementQuickStartDescription =>
      'Die Roboter sind stolz auf dich!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Schaffe $goal Level in einem Spiel.';
  }

  @override
  String get achievementDeterminedTitle => 'Ausdauernder Spieler';

  @override
  String get achievementDeterminedDescription =>
      'Du hast weitergemacht und nie aufgegeben!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Schaffe $goal Level in einem Spiel.';
  }

  @override
  String get achievementMasterCoderTitle => 'Meisterprogrammierer';

  @override
  String get achievementMasterCoderDescription =>
      'Du hast alle Level eines Spiels geschafft!';

  @override
  String get achievementMasterCoderCondition =>
      'Schaffe alle Level eines Spiels.';

  @override
  String get achievementAllGamesTitle => 'Spiele-Entdecker';

  @override
  String get achievementAllGamesDescription =>
      'Du hast jedes Spiel ausprobiert!';

  @override
  String get achievementAllGamesCondition =>
      'Schaffe in jedem Spiel mindestens ein Level.';

  @override
  String get achievementStarHunterTitle => 'Sternenjäger';

  @override
  String get achievementStarHunterDescription =>
      'Du hast angefangen, Sterne zu sammeln!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Sammle insgesamt $goal Sterne.';
  }

  @override
  String get achievementStarMasterTitle => 'Sternenmeister';

  @override
  String get achievementStarMasterDescription =>
      'Du hast so viele Sterne wie der Himmel!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Sammle insgesamt $goal Sterne.';
  }

  @override
  String get achievementPerfectTitle => 'Perfekter Spieler';

  @override
  String get achievementPerfectDescription =>
      'Du hast ein Level perfekt geschafft!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Schaffe ein Level mit $goal Sternen.';
  }

  @override
  String get achievementNoHintTitle => 'Held ohne Tipps';

  @override
  String get achievementNoHintDescription => 'Du hast alles allein gelöst!';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Schaffe $goal Level, ohne einen Tipp zu benutzen.';
  }

  @override
  String get achievementBigSuccessTitle => 'Großer Erfolg';

  @override
  String get achievementBigSuccessDescription =>
      'Du hast jedes Spiel von Anfang bis Ende geschafft!';

  @override
  String get achievementBigSuccessCondition =>
      'Schaffe alle Level in jedem Spiel.';

  @override
  String get achievementFirstAdventureTitle => 'Pokal des ersten Abenteuers';

  @override
  String get achievementFirstAdventureDescription =>
      'Du hast in jedem Spiel den ersten Schritt gemacht!';

  @override
  String get achievementFirstAdventureCondition =>
      'Schaffe das erste Level in jedem Spiel.';

  @override
  String get achievementChampionTitle => 'Programmier-Champion';

  @override
  String get achievementChampionDescription =>
      'Du bist ein echter Programmier-Champion!';

  @override
  String get achievementChampionCondition =>
      'Schaffe alle Level in jedem Spiel.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Schaffe „$game“.';
  }

  @override
  String get parentalGateTitle => 'Zustimmung der Eltern';

  @override
  String parentalGateIntro(Object action) {
    return 'Für diese Aktion braucht es die Zustimmung eines Erwachsenen: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Ein Paket kaufen',
      'other': 'Aktion',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Schreibe die Antwort in Ziffern.';

  @override
  String get parentalGateCancel => 'Abbrechen';

  @override
  String get parentalGateConfirm => 'Bestätigen';

  @override
  String get parentalGateAnswer => 'Antwort';

  @override
  String get parentalGateWrongAnswer =>
      'Falsche Antwort. Bitte warte einen Moment und beantworte dann die neue Frage.';

  @override
  String parentalGateQuestion(String first, String second) {
    return 'Wie viel ist $first mal $second?';
  }

  @override
  String get parentalGateTrialLabel => 'Elternprüfung ausprobieren';

  @override
  String get parentalGateTrialHint =>
      'Wird nur in Testversionen angezeigt. Es wird nichts wirklich gekauft.';

  @override
  String get parentalGateTrialPassed =>
      'Prüfung bestanden; die Testaktion wurde ausgeführt.';

  @override
  String get parentalGateTrialBlocked =>
      'Prüfung nicht bestanden; die Aktion wurde nicht ausgeführt.';

  @override
  String get storeTitle => 'Pakete';

  @override
  String get storeIntro =>
      'Käufe erfolgen über Google Play, und vor jedem Kauf wird die Zustimmung der Eltern abgefragt. Einen Google-Play-Aktionscode kannst du über den Link „Code einlösen“ auf der Zahlungsseite oder in der Play Store-App einlösen; ein mit Code eingelöstes Paket erscheint auch hier als gekauft.';

  @override
  String get storePaidSection => 'Pakete zum Kaufen';

  @override
  String get storeFreeSection => 'Kostenlose Pakete';

  @override
  String get storeNoProducts => 'Im Moment gibt es keine Pakete zu kaufen.';

  @override
  String get storeBundle => 'Bündel';

  @override
  String get storeStarterBundleTitle => 'Starter-Set';

  @override
  String get storeOwned => 'Gekauft';

  @override
  String get storeUnlocks => 'Wird beim Kauf freigeschaltet:';

  @override
  String get storePriceLoading => 'Preis wird von Google Play abgerufen…';

  @override
  String get storePriceUnavailable =>
      'Der Preis konnte nicht von Google Play abgerufen werden.';

  @override
  String get storeNotInStore =>
      'Dieses Paket ist gerade nicht bei Google Play erhältlich.';

  @override
  String get storeRetry => 'Erneut versuchen';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Einen Teil des Inhalts dieses Pakets hast du schon. Google Play senkt den Preis für bereits gekaufte Inhalte nicht. Damit du nicht zweimal für denselben Inhalt bezahlst, wird dieses Paket nicht verkauft. Fehlende Pakete: $missing';
  }

  @override
  String get storeRestore => 'Käufe wiederherstellen';

  @override
  String get storeRestoreHint =>
      'Liest die Käufe in deinem Google-Play-Konto erneut ein; der Spielfortschritt wird nicht gelöscht.';

  @override
  String storeRestored(Object count) {
    return 'Die Käufe wurden erneut von Google Play gelesen. Gekaufte Produkte: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'Keine Internetverbindung; die Kaufdaten auf diesem Gerät bleiben gültig.';

  @override
  String get storeRestoreUnavailable =>
      'Keine Verbindung zu Google Play; die Kaufdaten auf diesem Gerät bleiben gültig.';

  @override
  String storeBuy(Object price) {
    return 'Kaufen – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Level',
      one: '1 Level',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased =>
      'Kauf abgeschlossen; das Paket ist freigeschaltet.';

  @override
  String get storePending =>
      'Die Zahlung steht noch aus. Das Paket wird automatisch freigeschaltet, sobald die Zahlung abgeschlossen ist.';

  @override
  String get storeCancelled => 'Kauf abgebrochen.';

  @override
  String get storeAlreadyOwned =>
      'Dieses Paket hast du schon; es wurde nicht noch einmal gekauft.';

  @override
  String get storeBundlePartiallyOwned =>
      'Du besitzt bereits einen Teil der Inhalte dieses Pakets. Damit du nicht zweimal für dieselben Inhalte bezahlst, wurde der Kauf nicht gestartet.';

  @override
  String get storeOffline =>
      'Keine Internetverbindung. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get storeUnavailable =>
      'Keine Verbindung zu Google Play. Bitte versuche es später erneut.';

  @override
  String get storeFailed => 'Der Kauf konnte nicht abgeschlossen werden.';

  @override
  String get storeNotApproved =>
      'Die Eltern haben nicht zugestimmt; der Kauf wurde nicht gestartet.';

  @override
  String get gameRobotRunning => 'Der Roboter ist unterwegs...';

  @override
  String get gameRobotReachedFlag =>
      'Super! Der Roboter hat die Flagge erreicht!';

  @override
  String get gameMissingCoins =>
      'Du hast die Flagge erreicht, aber nicht alle Münzen gesammelt. Sammle zuerst die Münzen.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Hoch',
      'down': 'Runter',
      'left': 'Links',
      'other': 'Rechts',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'einen Felsen',
      'water': 'Wasser',
      'other': 'den Rand der Karte',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Wähle die Befehle der Reihe nach, damit der Roboter zur Flagge kommt.';

  @override
  String get pathFinderCoinIntro =>
      'Sammle zuerst alle Münzen und geh dann zur Flagge.';

  @override
  String get pathFinderEmpty => 'Füge zuerst einen Richtungsbefehl hinzu.';

  @override
  String get pathFinderFull =>
      'Du hast die Befehlsgrenze erreicht. Du kannst einen Befehl löschen und einen anderen an seine Stelle setzen.';

  @override
  String get pathFinderMissedGoal =>
      'Der Roboter hat die Flagge nicht erreicht. Füge Befehle hinzu oder ändere sie.';

  @override
  String get pathFinderTooMany =>
      'Mit diesen Befehlen schaffst du es nicht innerhalb der Grenze. Lösche die Schritte, die du nicht brauchst.';

  @override
  String get pathFinderSolved =>
      'Deine Befehle sind richtig! Tippe auf den grünen Start-Knopf.';

  @override
  String get pathFinderEmptyStrip =>
      'Drücke die Pfeilknöpfe, dann reihen sich deine Befehle hier auf.';

  @override
  String get pathFinderMoveLeft =>
      'Ausgewählten Befehl einen Schritt nach links schieben';

  @override
  String get pathFinderMoveRight =>
      'Ausgewählten Befehl einen Schritt nach rechts schieben';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'Der Roboter ist auf $obstacle gestoßen. Ändere Befehl $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'Befehl $number bringt den Roboter vom Weg ab. Ich habe ihn für dich ausgewählt; du kannst ihn löschen oder verschieben.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Schau auf das leuchtende Feld. Nächster Befehl: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Befehl „$direction“ hinzufügen';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Befehl $number: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Bring die Karten in die richtige Reihenfolge, um die Aufgabe zu lösen. Tippe auf eine Karte oder zieh sie in ein Feld.';

  @override
  String get commandOrderExtrasIntro =>
      'Pass auf! Manche Karten gehören nicht zu dieser Aufgabe. Ordne nur die Karten, die du brauchst.';

  @override
  String get commandOrderFull =>
      'Alle Felder sind voll. Tippe auf eine Karte, um sie zurückzunehmen.';

  @override
  String get commandOrderNotFull => 'Fülle zuerst alle Felder.';

  @override
  String get commandOrderSuccess =>
      'Super! Alle Schritte sind in der richtigen Reihenfolge.';

  @override
  String get commandOrderSolved =>
      'Die Reihenfolge stimmt! Tippe auf den grünen Prüfen-Knopf.';

  @override
  String get commandOrderPoolEmpty => 'Alle Karten sind verteilt';

  @override
  String get commandOrderCheck => 'Prüfen';

  @override
  String commandOrderWrongExtra(Object card) {
    return '„$card“ wird für diese Aufgabe nicht gebraucht. Nimm die Karte aus dem Feld.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return 'Für „$card“ ist es in Feld $number noch zu früh. Davor muss ein anderer Schritt kommen.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint Die leuchtende Karte „$card“ gehört in Feld $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Feld $number: $card. Tippe, um die Karte zurückzunehmen.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Feld $number, leer. Tippe, um hier eine Karte abzulegen.';
  }

  @override
  String get ifThenIncomplete => 'Fülle zuerst die leeren Felder.';

  @override
  String get ifThenSuccess =>
      'Super! Der Roboter hat seine Regeln befolgt und die Flagge erreicht!';

  @override
  String get ifThenSolved =>
      'Deine Regeln sind richtig! Tippe auf den grünen Start-Knopf.';

  @override
  String get ifThenNoSlot =>
      'Für diesen Block gibt es kein leeres Feld. Tippe auf das Feld, das du ändern willst, um es zu leeren.';

  @override
  String get ifThenLockedSlot =>
      'Dieses Feld war schon vorgegeben und kann nicht geändert werden. Leg den Block in ein leeres Feld.';

  @override
  String get ifThenWrongType =>
      'Dieser Block passt dort nicht hin. Dinge kommen in das „Wenn“-Feld, Bewegungen neben den Pfeil.';

  @override
  String get ifThenLane => 'Der Weg des Roboters';

  @override
  String get ifThenObjects => 'Dinge';

  @override
  String get ifThenActions => 'Bewegungen';

  @override
  String get ifThenIf => 'Wenn';

  @override
  String get ifThenElseIf => 'Sonst wenn';

  @override
  String get ifThenElse => 'Sonst';

  @override
  String get ifThenThen => 'vorne ist';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Leerer Weg',
      'rock': 'Felsen',
      'water': 'Wasser',
      'door': 'Tür',
      'other': 'Stern',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Vorwärts gehen',
      'jump': 'Springen',
      'bridge': 'Brücke bauen',
      'open': 'Tür öffnen',
      'other': 'Einsammeln',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'ein leerer Weg',
      'rock': 'ein Felsen',
      'water': 'Wasser',
      'door': 'eine Tür',
      'other': 'ein Stern',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Auf einem leeren Weg ist das nicht nötig.',
      'rock': 'Durch einen Felsen kommst du nicht durch.',
      'water': 'Der Roboter kann nicht schwimmen!',
      'door': 'Durch eine geschlossene Tür kommst du nicht.',
      'other': 'Der Stern ist liegen geblieben.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Wenn der Weg leer ist, kann der Roboter vorwärts gehen.',
      'rock': 'Über einen Felsen kommst du, indem du springst.',
      'water': 'Um über Wasser zu kommen, musst du eine Brücke bauen.',
      'door': 'Um durch die Tür zu kommen, musst du sie zuerst öffnen.',
      'other': 'Nimm den Stern mit dem Block Einsammeln.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'Regel $number';
  }

  @override
  String get ifThenElseRule => 'Die „Sonst“-Zeile';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Vorne war $object. $rule wurde ausgeführt und der Roboter hat „$action“ gemacht. $problem Ändere die Regeln und versuche es noch einmal.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'Auf dem leuchtenden Feld ist $object. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Bedingungsfeld',
      'other': 'Bewegungsfeld',
    });
    return '$_temp0: $value';
  }

  @override
  String get ifThenSlotEmpty => 'leer';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, vorgegeben';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Bewegung',
      'other': 'Ding',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Bring den Roboter zur Flagge. Benutze den Wiederholen-Block, statt dieselbe Bewegung immer wieder hinzuzufügen.';

  @override
  String get repeatCoinIntro =>
      'Sammle zuerst alle Münzen und geh dann zur Flagge. Mit dem Wiederholen-Block geht es leichter.';

  @override
  String get repeatEmpty =>
      'Füge zuerst einen Pfeil oder einen Wiederholen-Block hinzu.';

  @override
  String get repeatFull =>
      'Du hast die Blockgrenze erreicht. Wenn du fertig bist, tippe auf den grünen Start-Knopf; um etwas zu ändern, wähle einen Block aus und lösche ihn.';

  @override
  String get repeatInsideRepeat =>
      'Die Pfeile, die du jetzt hinzufügst, kommen in den orangen Block. Wenn du fertig bist, tippe auf den dunkelblauen Knopf Block verlassen.';

  @override
  String get repeatEmptyStrip =>
      'Füge einen Pfeil oder einen Wiederholen-Block hinzu, dann reihen sich deine Blöcke hier auf.';

  @override
  String get repeatOutsideRepeat =>
      'Die Pfeile, die du jetzt hinzufügst, kommen außerhalb des Blocks ans Ende.';

  @override
  String get repeatMovedOut =>
      'Der Pfeil wurde aus dem Block geschoben. Die Pfeile, die du jetzt hinzufügst, kommen auch nach außen ans Ende.';

  @override
  String get repeatEmptyRepeat =>
      'Der orange Block ist leer. Ich habe ihn ausgewählt; füge jetzt einen Pfeil hinein.';

  @override
  String get repeatMissedGoal =>
      'Der Roboter hat die Flagge nicht erreicht. Ändere die Wiederholungszahl oder die Pfeile.';

  @override
  String get repeatSolved =>
      'Deine Blöcke sind richtig! Tippe auf den grünen Start-Knopf.';

  @override
  String get repeatFullHint =>
      'Du hast die Blockgrenze erreicht. Ändere eine Wiederholungszahl oder lösche einen Block und setze einen Wiederholen-Block an seine Stelle.';

  @override
  String get repeatAddRepeat => 'Wiederholen';

  @override
  String get repeatLeaveRepeat => 'Block verlassen ✓';

  @override
  String get repeatAddRepeatLabel => 'Wiederholen-Block hinzufügen';

  @override
  String get repeatLeaveRepeatLabel =>
      'Block verlassen; die nächsten Pfeile kommen nach außen';

  @override
  String get repeatDropHere => 'Pfeile hier hinzufügen';

  @override
  String get repeatEmptyBody => 'Leer';

  @override
  String get repeatDecrease => 'Wiederholungszahl verringern';

  @override
  String get repeatIncrease => 'Wiederholungszahl erhöhen';

  @override
  String get repeatDeleteLabel => 'Ausgewählten Block löschen';

  @override
  String get repeatMoveOutLabel =>
      'Ausgewählten Pfeil aus dem orangen Block schieben';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times-mal',
      one: 'einmal',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times-mal wiederholen',
      one: 'einmal wiederholen',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Pfeil „$direction“ hinzufügen';
  }

  @override
  String repeatArrowName(Object number) {
    return 'Pfeil $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'Block $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'Pfeil $arrow in Block $block';
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
      other: '$times-mal wiederholen',
      one: 'einmal wiederholen',
    );
    return 'Block $number: $_temp0. Tippe, um Pfeile hineinzulegen.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Ändere die Wiederholungszahl von Block $number oder die Pfeile darin.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place bringt den Roboter vom Weg ab.';
  }

  @override
  String repeatExtraBlock(Object place) {
    return '$place ist zu viel. Versuch, ihn zu löschen.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'Der Roboter ist auf $obstacle gestoßen. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'In Runde $round ist der Roboter gegen $obstacle gestoßen. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice Ich habe die falsche Stelle für dich rot markiert.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Schau auf das leuchtende Feld; dort muss der Roboter in Richtung „$direction“ gehen.';
  }

  @override
  String get repeatL1Intro =>
      'Der Roboter muss 3-mal nach rechts, aber du darfst nur 2 Blöcke benutzen. Füge einen Wiederholen-Block hinzu und leg den Rechtspfeil hinein.';

  @override
  String get repeatL1Hint =>
      'Der Wiederholen-Block macht den Pfeil darin so oft, wie du sagst. Wie oft soll er nach rechts?';

  @override
  String get repeatL2Intro =>
      'Die Flagge ist dort oben. Benutze den Wiederholen-Block, statt denselben Pfeil immer wieder hinzuzufügen.';

  @override
  String get repeatL2Hint =>
      'Der Roboter geht immer in dieselbe Richtung. In welche, und wie oft?';

  @override
  String get repeatL3Hint =>
      'Der Roboter geht nach unten. Zähl die Felder und stell die Wiederholungszahl ein.';

  @override
  String get repeatL4Hint =>
      'Diesmal nach links. Mit den Knöpfen − und + kannst du die Wiederholungszahl ändern.';

  @override
  String get repeatL5Intro =>
      'Sammle auch die Münzen auf dem Weg ein! Es gibt immer noch nur 2 Blöcke.';

  @override
  String get repeatL5Hint =>
      'Die Münzen liegen zwischen Roboter und Flagge in derselben Reihe. Der Roboter geht nur nach rechts.';

  @override
  String get repeatL6Intro =>
      'Geh wie auf einer Treppe nach unten: rechts, runter, rechts, runter... Du kannst zwei Pfeile in einen Wiederholen-Block legen.';

  @override
  String get repeatL6Hint =>
      'Eine Stufe: einmal rechts, einmal runter. Wie viele Stufen gibt es?';

  @override
  String get repeatL7Hint =>
      'Zweimal rechts, einmal hoch. Wie oft wiederholt sich dieses Muster?';

  @override
  String get repeatL8Hint =>
      'Erst zweimal rechts, dann einmal runter. Wiederhole das.';

  @override
  String get repeatL9Intro =>
      'Du kannst nach dem Wiederholen-Block auch einen einzelnen Pfeil hinzufügen.';

  @override
  String get repeatL9Hint =>
      'Wiederhole das Muster hoch-links; am Ende brauchst du vielleicht noch einen Schritt.';

  @override
  String get repeatL10Hint =>
      'Jede Stufe ist zwei Felder breit und ein Feld hoch.';

  @override
  String get repeatL11Intro =>
      'Diesmal brauchst du zwei Wiederholen-Blöcke: einen nach rechts, einen nach unten.';

  @override
  String get repeatL11Hint =>
      'Wie viele Felder zuerst nach rechts? Dann wie viele nach unten? Nimm für jede Richtung einen eigenen Wiederholen-Block.';

  @override
  String get repeatL12Hint =>
      'Geh zuerst nach oben, dann nach rechts. Zwei Wiederholen-Blöcke, zwei verschiedene Zahlen.';

  @override
  String get repeatL13Hint =>
      'Geh um die Felsen herum: rechts, runter, links. Zähl die Felder für jede Richtung.';

  @override
  String get repeatL14Hint =>
      'Der Weg hat drei Teile: rechts, runter und wieder rechts.';

  @override
  String get repeatL15Hint =>
      'Beide Münzen liegen an den Ecken des Wegs. Mach jedes gerade Stück mit einem Wiederholen-Block.';

  @override
  String get repeatL16Intro =>
      'Nur 4 Blöcke! Geh den langen Weg mit einem kurzen Muster.';

  @override
  String get repeatL16Hint =>
      'Die Münzen liegen schräg in einer Reihe: Schau dir das Muster rechts-runter an.';

  @override
  String get repeatL17Hint =>
      'Jede Stufe ist zwei Felder hoch und zwei Felder breit.';

  @override
  String get repeatL18Hint =>
      'Zweimal rechts, zweimal runter. Dieses Muster geht bis zur Flagge weiter.';

  @override
  String get repeatL19Hint =>
      'Die Münzen liegen an den Ecken der Stufen. Eine Stufe: zweimal rechts, einmal runter.';

  @override
  String get repeatL20Intro =>
      'Ein langer Weg, der sich wie eine Schlange windet. Nutze die 10 Blöcke klug.';

  @override
  String get repeatL20Hint =>
      'Der Weg besteht aus fünf geraden Stücken. Mach jedes Stück mit einem Wiederholen-Block.';

  @override
  String get bugHunterIntro =>
      'In diesem Code steckt ein Fehler! Tippe zuerst auf Start und schau, wo der Roboter durcheinanderkommt.';

  @override
  String get bugHunterSelected =>
      'Wenn du einen Pfeil ausgewählt hast, ändert ein Richtungsknopf ihn. Du kannst den ausgewählten Block löschen oder davor einen neuen Pfeil einfügen.';

  @override
  String get bugHunterPickInsert =>
      'Welcher Pfeil soll davor kommen? Tippe auf einen Richtungsknopf.';

  @override
  String get bugHunterInsertLabel =>
      'Pfeil vor dem ausgewählten Block einfügen';

  @override
  String get bugHunterReset => 'Von vorn';

  @override
  String get bugHunterL1Intro =>
      'Der Roboter kommt nicht zur Flagge, im Code steckt ein Fehler! Tippe auf Start und schau dem Roboter zu. Tippe dann auf den falschen Pfeil und drücke den richtigen Richtungsknopf.';

  @override
  String get bugHunterL1Hint =>
      'Die Flagge ist genau rechts. Alle Pfeile sollten nach rechts zeigen.';

  @override
  String get bugHunterL2Hint =>
      'Der Roboter geht unten um den Felsen herum. Der letzte Pfeil sollte ihn hoch zur Flagge bringen.';

  @override
  String get bugHunterL3Intro =>
      'In diesem Code fehlt ein Pfeil. Wo ist der Roboter stehen geblieben? Füge den fehlenden Pfeil hinzu.';

  @override
  String get bugHunterL3Hint =>
      'Der Roboter bleibt vor der Flagge stehen. Er braucht noch einen Schritt.';

  @override
  String get bugHunterL4Intro =>
      'In diesem Code ist ein Pfeil zu viel. Wähle den überzähligen Pfeil aus und lösche ihn.';

  @override
  String get bugHunterL4Hint =>
      'Der Roboter macht noch einen Schritt, nachdem er die Flagge erreicht hat.';

  @override
  String get bugHunterL5Intro =>
      'Ein Pfeil fehlt, aber nicht am Ende. Wähle einen Pfeil aus, tippe auf den Knopf „Davor einfügen“ und dann auf einen Richtungsknopf.';

  @override
  String get bugHunterL5Hint =>
      'Unter dem Felsen sollte der Roboter zweimal nach rechts gehen.';

  @override
  String get bugHunterL6Hint =>
      'Nachdem du die Münze eingesammelt hast, ist die Flagge unten.';

  @override
  String get bugHunterL7Hint =>
      'Um am Wasser vorbeizukommen, geh in der untersten Reihe dreimal nach rechts.';

  @override
  String get bugHunterL8Intro =>
      'In diesem Code stecken zwei Fehler! Immer wenn der Roboter hängen bleibt, behebst du einen Fehler.';

  @override
  String get bugHunterL8Hint =>
      'Geh oben über den Felsen: zuerst nach rechts, dann nach unten.';

  @override
  String get bugHunterL9Hint =>
      'Nachdem der Roboter beide Münzen eingesammelt hat, sollte er auf der Flagge stehen bleiben.';

  @override
  String get bugHunterL10Hint =>
      'Folge dem Weg, der sich zwischen den Felsen schlängelt. Ein Pfeil ist falsch und einer fehlt.';

  @override
  String get bugHunterL11Intro =>
      'Diesmal steckt der Fehler im orangen Wiederholen-Block. Wähle den Pfeil darin aus und ändere ihn.';

  @override
  String get bugHunterL11Hint =>
      'Der Pfeil im Wiederholen-Block sollte zur Flagge zeigen.';

  @override
  String get bugHunterL12Intro =>
      'Die Pfeile in diesem Code stimmen, aber die Wiederholungszahl ist falsch. Ändere die Zahl.';

  @override
  String get bugHunterL12Hint =>
      'Wie viele Stufen gibt es? Die Wiederholungszahl sollte genauso groß sein wie die Zahl der Stufen.';

  @override
  String get bugHunterL13Hint => 'Jede Stufe ist zweimal rechts, einmal hoch.';

  @override
  String get bugHunterL14Hint =>
      'Jede Stufe ist zweimal rechts, einmal runter. Im Block fehlt ein Pfeil.';

  @override
  String get bugHunterL15Hint =>
      'Nach dem Wiederholen-Block fehlt nur noch ein Schritt.';

  @override
  String get bugHunterL16Intro =>
      'Profi-Jäger! In diesen Codes steckt mehr als ein Fehler. Finde bei jedem Start einen davon.';

  @override
  String get bugHunterL16Hint =>
      'Wie viele Felder zuerst nach rechts? Dann wie viele nach unten?';

  @override
  String get bugHunterL17Hint =>
      'Jede Wiederholung geht zwei Felder nach rechts. Wie viele Wiederholungen braucht es bis zur Flagge?';

  @override
  String get bugHunterL18Hint =>
      'Die Felsen liegen über den Stufen. Geh auf jeder Stufe zuerst nach unten, dann nach rechts.';

  @override
  String get bugHunterL19Hint =>
      'Zwischen dem Wasser gibt es eine Treppe: einmal rechts, einmal runter. Wie viele Stufen gibt es?';

  @override
  String get bugHunterL20Hint =>
      'Zuerst nach rechts, dann nach unten. Zähl die Felder in jedem geraden Stück.';

  @override
  String get myCommandIntro =>
      'Baue im türkisen Streifen oben mit Pfeilen deinen eigenen Befehl. Nutze dann den Befehl-Block im Hauptprogramm unten; jeder Befehl-Block macht alle Pfeile des Befehls.';

  @override
  String get myCommandCommandEmpty =>
      'Baue deinen Befehl: Füge hier einen Pfeil hinzu.';

  @override
  String get myCommandMainEmpty =>
      'Hauptprogramm: Füge einen Befehl-Block und Pfeile hinzu.';

  @override
  String get myCommandButton => 'Befehl';

  @override
  String get myCommandButtonLabel =>
      'Befehl-Block zum Hauptprogramm hinzufügen';

  @override
  String myCommandCallLabel(Object number) {
    return 'Block $number: Befehl';
  }

  @override
  String get myCommandEmptyCommand =>
      'Dein Befehl ist leer. Tippe auf den türkisen Streifen oben und füge Pfeile hinzu.';

  @override
  String get myCommandEmptyMain =>
      'Das Hauptprogramm ist leer. Füge den Befehl-Block mit der türkisen Befehl-Taste hinzu.';

  @override
  String get myCommandEditCommand =>
      'Die Pfeile, die du jetzt hinzufügst, kommen in den Befehl.';

  @override
  String get myCommandEditMain =>
      'Die Blöcke, die du jetzt hinzufügst, kommen ins Hauptprogramm.';

  @override
  String get myCommandCallAdded =>
      'Der Befehl-Block wurde zum Hauptprogramm hinzugefügt. Hier macht der Roboter alle Pfeile des Befehls.';

  @override
  String get myCommandUseHint =>
      'Dein Befehl ist fertig. Tippe auf die türkise Befehl-Taste, um ihn im Hauptprogramm zu nutzen.';

  @override
  String get myCommandFullHint =>
      'Du hast das Blocklimit erreicht. Ändere den Befehl oder ersetze die Pfeile im Hauptprogramm durch einen Befehl-Block.';

  @override
  String get myCommandMissedGoal =>
      'Der Roboter hat die Flagge nicht erreicht. Ändere die Pfeile im Befehl oder die Anzahl der Befehl-Blöcke.';

  @override
  String myCommandOffPath(Object place) {
    return '$place im Befehl bringt den Roboter vom Weg ab.';
  }

  @override
  String myCommandFixCount(Object number) {
    return 'Ändere die Wiederholungszahl von Block $number im Befehl oder die Pfeile darin.';
  }

  @override
  String get myCommandLaterCall =>
      'Diesmal bringt der Befehl den Roboter vom Weg ab; ändere den Befehl oder die Pfeile im Hauptprogramm.';

  @override
  String get myCommandL1Intro =>
      'Baue deinen eigenen Befehl! Setze zwei Pfeile nach rechts in den türkisen Streifen oben. Füge deinen Befehl dann mit der Befehl-Taste zum Hauptprogramm hinzu.';

  @override
  String get myCommandL1Hint =>
      'Der Roboter muss 6-mal nach rechts gehen. Wenn dein Befehl aus 2 Pfeilen nach rechts besteht, wie oft musst du ihn nutzen?';

  @override
  String get myCommandL2Hint =>
      'Geh wie eine Treppe nach unten. Eine Stufe: einmal rechts, einmal runter. Das ist dein Befehl.';

  @override
  String get myCommandL3Intro =>
      'Im Hauptprogramm kannst du neben dem Befehl-Block auch Pfeile hinzufügen.';

  @override
  String get myCommandL3Hint =>
      'Zwischen den Steinen ist eine Treppe: rechts, runter. Am Ende fehlt noch ein Schritt.';

  @override
  String get myCommandL4Hint =>
      'Zweimal rechts, einmal hoch. Wie oft wiederholt sich dieses Muster?';

  @override
  String get myCommandL5Hint =>
      'Der Roboter klettert nach links: einmal hoch, einmal links. Das Gold liegt auch auf diesem Weg.';

  @override
  String get myCommandL6Hint =>
      'Jede Stufe ist zwei Felder breit und ein Feld hoch.';

  @override
  String get myCommandL7Hint =>
      'Zweimal rechts, zweimal runter. Das Gold liegt an diesem Muster.';

  @override
  String get myCommandL8Hint =>
      'Geh unter den Steinen durch: erst runter, dann zweimal rechts.';

  @override
  String get myCommandL9Hint =>
      'Der Befehl soll viermal nach rechts gehen. Zwischen den zwei Befehl-Blöcken muss der Roboter nach unten gehen.';

  @override
  String get myCommandL10Hint =>
      'Sammle das Gold zwischen den Steinen: runter, zweimal rechts, hoch.';

  @override
  String get myCommandL11Intro =>
      'Du kannst in deinen Befehl auch einen Wiederholen-Block setzen! So läuft ein kurzer Befehl einen langen Weg.';

  @override
  String get myCommandL11Hint =>
      'Der Befehl soll dreimal nach rechts gehen. Zwischen den Befehlen geht der Roboter einmal runter und einmal hoch.';

  @override
  String get myCommandL12Hint =>
      'Jedes Stück ist zweimal rechts, einmal runter. An einer Stelle kommt noch ein Schritt nach unten dazu.';

  @override
  String get myCommandL13Hint =>
      'Jede Stufe ist einmal hoch, zweimal rechts. Vergiss das Gold nicht.';

  @override
  String get myCommandL14Hint =>
      'Jedes Stück ist zweimal rechts, einmal hoch. Schau dir auch die Schritte zwischen den Befehlen an.';

  @override
  String get myCommandL15Hint =>
      'Jedes Stück ist einmal runter, zweimal rechts. Zwischen den Befehlen geht der Weg manchmal geradeaus.';

  @override
  String get myCommandL16Hint =>
      'Befehl: dreimal rechts, einmal runter. Nach dem ersten Befehl musst du einmal nach links gehen.';

  @override
  String get myCommandL17Hint =>
      'Jedes Stück ist einmal hoch, dreimal rechts. Zwischen den Befehlen musst du noch einmal hoch.';

  @override
  String get myCommandL18Hint =>
      'Im Befehl können zwei Wiederholen-Blöcke sein: zweimal runter, zweimal rechts.';

  @override
  String get myCommandL19Hint =>
      'Befehl: einmal rechts, zweimal hoch, einmal rechts. Finde die Pfeile dazwischen, indem du die Felder zählst.';

  @override
  String get myCommandL20Hint =>
      'Der Befehl beginnt mit zwei Stufen: rechts, runter. Danach kommt noch ein Schritt nach rechts.';

  @override
  String get ifThenL1Intro =>
      'Wenn vorne ein Felsen ist, was soll der Roboter tun? Leg eine Bewegung in das leere Feld.';

  @override
  String get ifThenL2Intro =>
      'Der Roboter kann nicht schwimmen. Wenn vorne Wasser ist, was soll er tun?';

  @override
  String get ifThenL3Intro =>
      'Auf dem Weg ist eine geschlossene Tür. Was soll der Roboter tun, wenn er zur Tür kommt?';

  @override
  String get ifThenL4Intro =>
      'Geh nicht an den Sternen vorbei, ohne sie einzusammeln! Wenn vorne ein Stern ist, was soll der Roboter tun?';

  @override
  String get ifThenL5Intro =>
      'Diesmal wählst du auch die Bedingung. Was ist auf dem Weg?';

  @override
  String get ifThenL6Intro =>
      'Wenn ein Felsen da ist, mach das eine; sonst etwas anderes. Fülle beide Felder.';

  @override
  String get ifThenL7Intro =>
      'Was soll er tun, wenn Wasser da ist? Und wenn kein Wasser da ist?';

  @override
  String get ifThenL8Intro =>
      'Auf diesem Weg gibt es keine leeren Felder! Wenn keine Tür da ist, was ist dann vorne?';

  @override
  String get ifThenL9Intro => 'Wähle die Bedingung und beide Bewegungen.';

  @override
  String get ifThenL10Intro =>
      'Auf dem Weg gibt es Felsen und Wasser. Eine Regel und ein „Sonst“ reichen.';

  @override
  String get ifThenL11Intro =>
      'Hier gibt es auch Felsen und Wasser. Mach für jedes eine Regel.';

  @override
  String get ifThenL12Intro => 'Öffne die Türen und sammle die Sterne ein.';

  @override
  String get ifThenL13Intro =>
      'Es gibt drei verschiedene Dinge, aber nur zwei Regelzeilen. Nimm „Sonst“ für das dritte.';

  @override
  String get ifThenL14Intro =>
      'Wasser, Türen und leerer Weg. Welches überlässt du dem „Sonst“?';

  @override
  String get ifThenL15Intro =>
      'Vorsicht: Einer der Blöcke kommt auf diesem Weg gar nicht vor.';

  @override
  String get ifThenL16Intro =>
      'Der Roboter ist auf dem Weg zur Burg: Es gibt Felsen, Burggräben und Burgtore.';

  @override
  String get ifThenL17Intro =>
      'Schatzweg: Sammle die Sterne ein und überwinde die Hindernisse.';

  @override
  String get ifThenL18Intro =>
      'Auf diesem Weg gibt es keine leeren Felder. Vier Dinge brauchen vier Entscheidungen.';

  @override
  String get ifThenL19Intro =>
      'Eine lange Reise! Wasser, Felsen, Türen und leerer Weg.';

  @override
  String get ifThenL20Intro =>
      'Letzte Aufgabe: Sammle alle Sterne ein und erreiche die Flagge.';

  @override
  String get pathFinderL1Intro =>
      'Bring den Roboter zur Flagge. Drücke den Rechtspfeil und tippe dann auf den grünen Start-Knopf.';

  @override
  String get pathFinderL2Intro =>
      'Die Flagge ist über dem Roboter. Welchen Pfeil solltest du wählen?';

  @override
  String get pathFinderL3Intro => 'Die Flagge ist links, zwei Felder entfernt.';

  @override
  String get pathFinderL4Intro => 'Der Roboter muss nach unten. Wie oft?';

  @override
  String get pathFinderL5Intro =>
      'Diesmal benutzt du zwei verschiedene Richtungen.';

  @override
  String get pathFinderL11Intro =>
      'Auf dem Weg liegt ein Felsen. Geh um ihn herum.';

  @override
  String get pathFinderL12Intro =>
      'Die Felsen stehen wie eine Mauer in einer Reihe. Geh unten herum.';

  @override
  String get pathFinderL13Intro =>
      'Der Roboter darf nicht ins Wasser. Finde den trockenen Weg.';

  @override
  String get pathFinderL15Intro =>
      'Es gibt mehr als einen Weg. Findest du den kürzesten?';

  @override
  String get commandOrderL1Title => 'Die Blume gießen';

  @override
  String get commandOrderL1Step1 => 'Die Gießkanne füllen';

  @override
  String get commandOrderL1Step2 => 'Die Blume gießen';

  @override
  String get commandOrderL1Hint =>
      'Um die Blume zu gießen, muss zuerst Wasser in der Kanne sein.';

  @override
  String get commandOrderL2Title => 'Zähne putzen';

  @override
  String get commandOrderL2Step1 => 'Zahnpasta auf die Bürste geben';

  @override
  String get commandOrderL2Step2 => 'Zähne putzen';

  @override
  String get commandOrderL2Step3 => 'Den Mund ausspülen';

  @override
  String get commandOrderL2Hint =>
      'Bevor du mit dem Putzen anfängst, muss Zahnpasta auf der Bürste sein.';

  @override
  String get commandOrderL3Title => 'Hände waschen';

  @override
  String get commandOrderL3Step1 => 'Die Hände einseifen';

  @override
  String get commandOrderL3Step2 => 'Die Hände abspülen';

  @override
  String get commandOrderL3Step3 => 'Die Hände abtrocknen';

  @override
  String get commandOrderL3Hint =>
      'Du kannst die Hände nicht abtrocknen, bevor der Schaum weg ist.';

  @override
  String get commandOrderL4Title => 'Schuhe anziehen';

  @override
  String get commandOrderL4Step1 => 'Socken anziehen';

  @override
  String get commandOrderL4Step2 => 'Schuhe anziehen';

  @override
  String get commandOrderL4Step3 => 'Schnürsenkel binden';

  @override
  String get commandOrderL4Hint =>
      'Was sollte an deinem Fuß sein, bevor er in den Schuh kommt?';

  @override
  String get commandOrderL5Title => 'Ein Bild malen';

  @override
  String get commandOrderL5Step1 => 'Ein Blatt Papier nehmen';

  @override
  String get commandOrderL5Step2 => 'Das Bild zeichnen';

  @override
  String get commandOrderL5Step3 => 'Das Bild ausmalen';

  @override
  String get commandOrderL5Hint =>
      'Zum Ausmalen brauchst du ein Bild, das schon gezeichnet ist.';

  @override
  String get commandOrderL6Title => 'Ein Sandwich machen';

  @override
  String get commandOrderL6Step1 => 'Den Teller auf den Tisch stellen';

  @override
  String get commandOrderL6Step2 => 'Das Brot auf den Teller legen';

  @override
  String get commandOrderL6Step3 => 'Käse darauflegen';

  @override
  String get commandOrderL6Step4 => 'Mit Brot zudecken';

  @override
  String get commandOrderL6Step5 => 'Guten Appetit';

  @override
  String get commandOrderL6Hint =>
      'Du brauchst einen Platz für das Brot. Was sollte zuerst auf dem Tisch sein?';

  @override
  String get commandOrderL7Title => 'Spielzeug aufräumen';

  @override
  String get commandOrderL7Step1 => 'Die Kiste holen';

  @override
  String get commandOrderL7Step2 => 'Das Spielzeug in die Kiste legen';

  @override
  String get commandOrderL7Step3 => 'Den Deckel schließen';

  @override
  String get commandOrderL7Step4 => 'Die Kiste ins Regal stellen';

  @override
  String get commandOrderL7Hint =>
      'Was machst du, wenn die Kiste für das Spielzeug nicht neben dir steht?';

  @override
  String get commandOrderL8Title => 'Einen Samen pflanzen';

  @override
  String get commandOrderL8Step1 => 'Ein Loch in die Erde graben';

  @override
  String get commandOrderL8Step2 => 'Den Samen ins Loch legen';

  @override
  String get commandOrderL8Step3 => 'Mit Erde bedecken';

  @override
  String get commandOrderL8Step4 => 'Den Samen gießen';

  @override
  String get commandOrderL8Step5 => 'Auf den Keimling warten';

  @override
  String get commandOrderL8Hint =>
      'Ohne ein Loch kannst du den Samen nicht in die Erde legen.';

  @override
  String get commandOrderL9Title => 'Für die Schule fertig machen';

  @override
  String get commandOrderL9Step1 => 'Aufwachen, wenn der Wecker klingelt';

  @override
  String get commandOrderL9Step2 => 'Die Schulkleidung anziehen';

  @override
  String get commandOrderL9Step3 => 'Den Rucksack aufsetzen';

  @override
  String get commandOrderL9Step4 => 'In den Schulbus steigen';

  @override
  String get commandOrderL9Hint =>
      'Du kannst dich nicht anziehen, bevor du aufwachst. Was passiert morgens zuerst?';

  @override
  String get commandOrderL10Title => 'Einen Brief verschicken';

  @override
  String get commandOrderL10Step1 => 'Den Brief schreiben';

  @override
  String get commandOrderL10Step2 => 'Den Brief in den Umschlag stecken';

  @override
  String get commandOrderL10Step3 => 'Den Umschlag zukleben';

  @override
  String get commandOrderL10Step4 => 'In den Briefkasten werfen';

  @override
  String get commandOrderL10Hint =>
      'Es muss einen Brief geben, den du in den Umschlag stecken kannst.';

  @override
  String get commandOrderL11Title => 'Einen Kuchen backen';

  @override
  String get commandOrderL11Stage1 => 'Den Teig machen';

  @override
  String get commandOrderL11Stage2 => 'Den Kuchen backen';

  @override
  String get commandOrderL11Step1 => 'Die Zutaten auf den Tisch stellen';

  @override
  String get commandOrderL11Step2 => 'Alles in einer Schüssel verrühren';

  @override
  String get commandOrderL11Step3 => 'Den Teig in die Form gießen';

  @override
  String get commandOrderL11Step4 => 'Die Form in den Ofen stellen';

  @override
  String get commandOrderL11Step5 => 'Warten, bis er gebacken ist';

  @override
  String get commandOrderL11Step6 => 'Den Kuchen anschneiden';

  @override
  String get commandOrderL11Hint =>
      'Du kannst nichts in den Ofen stellen, bevor der Teig fertig ist.';

  @override
  String get commandOrderL12Title => 'Baden';

  @override
  String get commandOrderL12Stage1 => 'Das Bad vorbereiten';

  @override
  String get commandOrderL12Stage2 => 'Waschen';

  @override
  String get commandOrderL12Stage3 => 'Abtrocknen';

  @override
  String get commandOrderL12Step1 => 'Die Wanne mit Wasser füllen';

  @override
  String get commandOrderL12Step2 => 'In die Wanne steigen';

  @override
  String get commandOrderL12Step3 => 'Die Haare einshampoonieren';

  @override
  String get commandOrderL12Step4 => 'Den Schaum abspülen';

  @override
  String get commandOrderL12Step5 => 'Mit einem Handtuch abtrocknen';

  @override
  String get commandOrderL12Hint =>
      'Wenn du in eine leere Wanne steigst, kannst du dich nicht waschen.';

  @override
  String get commandOrderL13Title => 'Fahrrad fahren';

  @override
  String get commandOrderL13Stage1 => 'Fertig machen';

  @override
  String get commandOrderL13Stage2 => 'Fahren';

  @override
  String get commandOrderL13Stage3 => 'Ankommen';

  @override
  String get commandOrderL13Step1 => 'Den Helm aufsetzen';

  @override
  String get commandOrderL13Step2 => 'Aufs Fahrrad steigen';

  @override
  String get commandOrderL13Step3 => 'In die Pedale treten';

  @override
  String get commandOrderL13Step4 => 'Bremsen';

  @override
  String get commandOrderL13Step5 => 'Vom Fahrrad steigen';

  @override
  String get commandOrderL13Hint =>
      'Sicherheit geht vor. Was setzt du auf, bevor du aufs Fahrrad steigst?';

  @override
  String get commandOrderL14Title => 'Ein Buch ausleihen';

  @override
  String get commandOrderL14Stage1 => 'In der Bücherei';

  @override
  String get commandOrderL14Stage2 => 'Zu Hause';

  @override
  String get commandOrderL14Stage3 => 'Zurückgeben';

  @override
  String get commandOrderL14Step1 => 'In die Bücherei gehen';

  @override
  String get commandOrderL14Step2 => 'Ein Buch aussuchen';

  @override
  String get commandOrderL14Step3 => 'Das Buch ausleihen';

  @override
  String get commandOrderL14Step4 => 'Das Buch nach Hause bringen';

  @override
  String get commandOrderL14Step5 => 'Das Buch lesen';

  @override
  String get commandOrderL14Step6 => 'Das Buch zurückbringen';

  @override
  String get commandOrderL14Hint =>
      'Um ein Buch auszusuchen, musst du zuerst dorthin gehen, wo die Bücher sind.';

  @override
  String get commandOrderL15Title => 'Ein Zelt aufbauen';

  @override
  String get commandOrderL15Stage1 => 'Den Platz vorbereiten';

  @override
  String get commandOrderL15Stage2 => 'Das Zelt aufbauen';

  @override
  String get commandOrderL15Stage3 => 'Das Zelt einrichten';

  @override
  String get commandOrderL15Step1 => 'Einen ebenen Platz finden';

  @override
  String get commandOrderL15Step2 => 'Das Zelt auf dem Boden ausbreiten';

  @override
  String get commandOrderL15Step3 => 'Die Stangen einstecken';

  @override
  String get commandOrderL15Step4 => 'Das Zelt aufstellen';

  @override
  String get commandOrderL15Step5 => 'Mit Heringen befestigen';

  @override
  String get commandOrderL15Step6 => 'Den Schlafsack hineinlegen';

  @override
  String get commandOrderL15Step7 => 'Die Laterne anmachen';

  @override
  String get commandOrderL15Hint =>
      'Um das Zelt auszubreiten, musst du zuerst einen guten Platz finden.';

  @override
  String get commandOrderL16Title => 'Eine Pizza machen';

  @override
  String get commandOrderL16Stage1 => 'Teig';

  @override
  String get commandOrderL16Stage2 => 'Belag';

  @override
  String get commandOrderL16Stage3 => 'Backen';

  @override
  String get commandOrderL16Step1 => 'Den Teig ausrollen';

  @override
  String get commandOrderL16Step2 => 'Tomatensoße verstreichen';

  @override
  String get commandOrderL16Step3 => 'Käse darüberstreuen';

  @override
  String get commandOrderL16Step4 => 'In den Ofen schieben';

  @override
  String get commandOrderL16Step5 => 'Warten, bis sie gebacken ist';

  @override
  String get commandOrderL16Step6 => 'In Stücke schneiden';

  @override
  String get commandOrderL16Extra1 => 'Den Fernseher einschalten';

  @override
  String get commandOrderL16Hint =>
      'Nicht jede Karte gehört zu dieser Aufgabe. Brauchst du den Fernseher, um eine Pizza zu machen?';

  @override
  String get commandOrderL17Title => 'Wäsche waschen';

  @override
  String get commandOrderL17Stage1 => 'Vorbereiten';

  @override
  String get commandOrderL17Stage2 => 'Waschen';

  @override
  String get commandOrderL17Stage3 => 'Trocknen';

  @override
  String get commandOrderL17Step1 => 'Die schmutzige Wäsche sammeln';

  @override
  String get commandOrderL17Step2 => 'In die Maschine stecken';

  @override
  String get commandOrderL17Step3 => 'Waschmittel einfüllen';

  @override
  String get commandOrderL17Step4 => 'Die Maschine starten';

  @override
  String get commandOrderL17Step5 => 'Die Wäsche aufhängen';

  @override
  String get commandOrderL17Step6 => 'Trocken zusammenlegen';

  @override
  String get commandOrderL17Extra1 => 'Ball spielen';

  @override
  String get commandOrderL17Hint =>
      'Wenn die schmutzige Wäsche überall herumliegt, was solltest du zuerst tun?';

  @override
  String get commandOrderL18Title => 'Mit dem Zug fahren';

  @override
  String get commandOrderL18Stage1 => 'Am Bahnhof';

  @override
  String get commandOrderL18Stage2 => 'Im Zug';

  @override
  String get commandOrderL18Stage3 => 'Ankunft';

  @override
  String get commandOrderL18Step1 => 'Eine Fahrkarte kaufen';

  @override
  String get commandOrderL18Step2 => 'Zum Bahnsteig gehen';

  @override
  String get commandOrderL18Step3 => 'Auf den Zug warten';

  @override
  String get commandOrderL18Step4 => 'In den Zug steigen';

  @override
  String get commandOrderL18Step5 => 'Sich auf den Platz setzen';

  @override
  String get commandOrderL18Step6 => 'Am Ziel aussteigen';

  @override
  String get commandOrderL18Extra1 => 'Ins Flugzeug steigen';

  @override
  String get commandOrderL18Hint =>
      'Was brauchst du, um in den Zug zu steigen?';

  @override
  String get commandOrderL19Title => 'Einen Baum großziehen';

  @override
  String get commandOrderL19Stage1 => 'Pflanzen';

  @override
  String get commandOrderL19Stage2 => 'Pflegen';

  @override
  String get commandOrderL19Stage3 => 'Wachsen';

  @override
  String get commandOrderL19Step1 => 'Erde in den Topf füllen';

  @override
  String get commandOrderL19Step2 => 'Den Samen pflanzen';

  @override
  String get commandOrderL19Step3 => 'Den Samen gießen';

  @override
  String get commandOrderL19Step4 => 'Den Topf in die Sonne stellen';

  @override
  String get commandOrderL19Step5 => 'Auf den Keimling warten';

  @override
  String get commandOrderL19Step6 => 'Im Garten einpflanzen';

  @override
  String get commandOrderL19Extra1 => 'Einen Regenschirm aufspannen';

  @override
  String get commandOrderL19Extra2 => 'Den Topf ins Dunkle stellen';

  @override
  String get commandOrderL19Hint =>
      'Pflanzen brauchen Wasser und Sonnenlicht zum Wachsen. Welche Karten würden ihnen schaden?';

  @override
  String get commandOrderL20Title => 'Kekse backen und teilen';

  @override
  String get commandOrderL20Stage1 => 'Vorbereiten';

  @override
  String get commandOrderL20Stage2 => 'Backen';

  @override
  String get commandOrderL20Stage3 => 'Teilen';

  @override
  String get commandOrderL20Step1 => 'Die Hände waschen';

  @override
  String get commandOrderL20Step2 => 'Die Zutaten verrühren';

  @override
  String get commandOrderL20Step3 => 'Den Teig formen';

  @override
  String get commandOrderL20Step4 => 'Im Ofen backen';

  @override
  String get commandOrderL20Step5 => 'Abkühlen lassen';

  @override
  String get commandOrderL20Step6 => 'In eine Dose legen';

  @override
  String get commandOrderL20Step7 => 'Mit Freunden teilen';

  @override
  String get commandOrderL20Extra1 => 'Mit einem Spielzeugauto fahren';

  @override
  String get commandOrderL20Extra2 => 'Schlafen gehen';

  @override
  String get commandOrderL20Hint =>
      'Bevor du in der Küche arbeitest, musst du sauber sein.';
}
