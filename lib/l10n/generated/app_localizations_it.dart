// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Robi Programma';

  @override
  String get languageName => 'Italiano';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Programma';

  @override
  String get homeTagline => 'Gioca • Impara • Scopri';

  @override
  String get homeComingSoon => 'Presto in arrivo';

  @override
  String get homeLocked => 'Bloccato';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels livelli';
  }

  @override
  String get homeChangeCharacter => 'Cambia';

  @override
  String homeCharacterLabel(Object name) {
    return 'Il tuo personaggio: $name. Tocca per cambiarlo.';
  }

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonNextLevel => 'Livello successivo';

  @override
  String get commonBackToHome => 'Torna all’inizio';

  @override
  String get commonBackToLevels => 'Torna ai livelli';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stelle',
      one: '1 stella',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Via';

  @override
  String get commonHint => 'Aiuto';

  @override
  String get commonClear => 'Svuota';

  @override
  String get commonDelete => 'Cancella';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSound => 'Suono';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Facile',
      'medium': 'Medio',
      'hard': 'Difficile',
      'other': 'Esperto',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Livelli base';

  @override
  String get playPreviousLevel => 'Livello precedente';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, livello $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Prima finisci i livelli «$difficulty»';
  }

  @override
  String get playPreviewNote =>
      'Il primo livello di ogni difficoltà si può provare gratis. Gli altri livelli si sbloccano con l’acquisto.';

  @override
  String get playLevelComplete => 'Bravo! Livello completato.';

  @override
  String playLevel(Object level) {
    return 'Livello $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Livello $level, bloccato';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Livello $level, $stars';
  }

  @override
  String get playLocked => 'bloccato';

  @override
  String get gamePathFinderTitle => 'Trova la strada del robot';

  @override
  String get gamePathFinderDescription =>
      'Guida il robot fino al traguardo con i comandi di direzione.';

  @override
  String get gamePathFinderTrophy => 'Maestro dei robot';

  @override
  String get gamePathFinderTrophyDescription =>
      'Ora il robot conosce tutte le strade!';

  @override
  String get gameCommandOrderTitle => 'Metti in ordine i passi';

  @override
  String get gameCommandOrderDescription => 'Metti i passi nell’ordine giusto.';

  @override
  String get gameCommandOrderTrophy => 'Maestro degli algoritmi';

  @override
  String get gameCommandOrderTrophyDescription =>
      'Sei bravissimo a mettere in ordine i passi!';

  @override
  String get gameIfThenTitle => 'Se succede questo, allora';

  @override
  String get gameIfThenDescription =>
      'Scegli il comando giusto per ogni situazione.';

  @override
  String get gameIfThenTrophy => 'Maestro delle decisioni';

  @override
  String get gameIfThenTrophyDescription => 'Fai sempre la scelta giusta!';

  @override
  String get gameRepeatTitle => 'Ripetilo';

  @override
  String get gameRepeatDescription =>
      'Fai le mosse ripetute con un solo blocco.';

  @override
  String get gameRepeatTrophy => 'Maestro dei cicli';

  @override
  String get gameRepeatTrophyDescription => 'Usi i cicli come un campione!';

  @override
  String get gameBugHunterTitle => 'Caccia all’errore';

  @override
  String get gameBugHunterDescription =>
      'Trova e correggi il codice sbagliato.';

  @override
  String get gameBugHunterTrophy => 'Maestro cacciatore di errori';

  @override
  String get gameBugHunterTrophyDescription =>
      'Hai trovato anche gli errori più difficili!';

  @override
  String get gameMyCommandTitle => 'Crea il tuo comando';

  @override
  String get gameMyCommandDescription =>
      'Costruisci il tuo comando con le frecce e usalo tante volte.';

  @override
  String get gameMyCommandTrophy => 'Architetto dei Comandi';

  @override
  String get gameMyCommandTrophyDescription =>
      'Hai risolto i percorsi più difficili con i tuoi comandi!';

  @override
  String get gameVariableBoxTitle => 'Scatola variabile';

  @override
  String get gameVariableBoxDescription =>
      'Metti un numero nella scatola e il robot farà tutti quei passi.';

  @override
  String get gameVariableBoxTrophy => 'Maestro delle variabili';

  @override
  String get gameVariableBoxTrophyDescription =>
      'Con il numero nella scatola hai accorciato i percorsi più lunghi!';

  @override
  String get gamePatternPuzzleTitle => 'Puzzle di sequenze';

  @override
  String get gamePatternPuzzleDescription =>
      'Trova la sequenza che si ripete e completa le lampade mancanti.';

  @override
  String get gamePatternPuzzleTrophy => 'Maestro delle sequenze';

  @override
  String get gamePatternPuzzleTrophyDescription =>
      'Hai risolto tutte le sequenze e acceso le lampade con i colori giusti!';

  @override
  String get characterTitle => 'Scegli il tuo personaggio';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Elica',
      'isil': 'Luce',
      'kahraman': 'Eroe',
      'pembe': 'Rosina',
      'sovalye': 'Cavaliere',
      'piril': 'Scintilla',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'I miei successi';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hai vinto $count premi!',
      one: 'Hai vinto 1 premio!',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Medaglie';

  @override
  String get achievementsBadgesSubtitle => 'Piccole vittorie';

  @override
  String get achievementsBadgesEarned => 'Le tue medaglie';

  @override
  String get achievementsBadgesLocked => 'Medaglie da vincere';

  @override
  String get achievementsBadgesEmpty =>
      'Ancora nessuna medaglia. Finisci il tuo primo livello!';

  @override
  String get achievementsTrophies => 'Trofei';

  @override
  String get achievementsTrophiesSubtitle => 'Grandi traguardi';

  @override
  String get achievementsTrophiesEarned => 'I tuoi trofei';

  @override
  String get achievementsTrophiesLocked => 'Trofei bloccati';

  @override
  String get achievementsTrophiesEmpty =>
      'Ancora nessun trofeo. Continua così per i grandi traguardi!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'I miei successi: $earned/$total';
  }

  @override
  String get achievementEarned => 'Vinto!';

  @override
  String get achievementCondition => 'Come vincerlo: ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, vinto';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, bloccato';
  }

  @override
  String get achievementNewBadge => 'Nuova medaglia!';

  @override
  String get achievementNewTrophy => 'Hai vinto un nuovo trofeo!';

  @override
  String get achievementGreat => 'Fantastico!';

  @override
  String get achievementFirstGameTitle => 'Il mio primo gioco';

  @override
  String get achievementFirstGameDescription =>
      'Hai fatto il primo passo della tua avventura nella programmazione!';

  @override
  String get achievementFirstGameCondition =>
      'Completa il tuo primo livello in un gioco.';

  @override
  String get achievementQuickStartTitle => 'Partenza veloce';

  @override
  String get achievementQuickStartDescription => 'I robot sono fieri di te!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Completa $goal livelli in un gioco.';
  }

  @override
  String get achievementDeterminedTitle => 'Giocatore tenace';

  @override
  String get achievementDeterminedDescription =>
      'Sei andato avanti senza mai arrenderti!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Completa $goal livelli in un gioco.';
  }

  @override
  String get achievementMasterCoderTitle => 'Maestro programmatore';

  @override
  String get achievementMasterCoderDescription =>
      'Hai finito tutti i livelli di un gioco!';

  @override
  String get achievementMasterCoderCondition =>
      'Completa tutti i livelli di un gioco.';

  @override
  String get achievementAllGamesTitle => 'Esploratore di giochi';

  @override
  String get achievementAllGamesDescription => 'Hai provato tutti i giochi!';

  @override
  String get achievementAllGamesCondition =>
      'Finisci almeno un livello in ogni gioco.';

  @override
  String get achievementStarHunterTitle => 'Cacciatore di stelle';

  @override
  String get achievementStarHunterDescription =>
      'Hai iniziato a raccogliere le stelle!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Vinci $goal stelle in tutto.';
  }

  @override
  String get achievementStarMasterTitle => 'Maestro delle stelle';

  @override
  String get achievementStarMasterDescription =>
      'Hai tante stelle quante il cielo!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Vinci $goal stelle in tutto.';
  }

  @override
  String get achievementPerfectTitle => 'Giocatore perfetto';

  @override
  String get achievementPerfectDescription =>
      'Hai finito un livello alla perfezione!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Completa un livello con $goal stelle.';
  }

  @override
  String get achievementNoHintTitle => 'Eroe senza aiuti';

  @override
  String get achievementNoHintDescription => 'Hai risolto tutto da solo!';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Completa $goal livelli senza usare l’aiuto.';
  }

  @override
  String get achievementBigSuccessTitle => 'Grande successo';

  @override
  String get achievementBigSuccessDescription =>
      'Hai finito tutti i giochi dall’inizio alla fine!';

  @override
  String get achievementBigSuccessCondition =>
      'Completa tutti i livelli di tutti i giochi.';

  @override
  String get achievementFirstAdventureTitle => 'Trofeo della prima avventura';

  @override
  String get achievementFirstAdventureDescription =>
      'Hai fatto il primo passo in tutti i giochi!';

  @override
  String get achievementFirstAdventureCondition =>
      'Completa il primo livello di ogni gioco.';

  @override
  String get achievementChampionTitle => 'Campione di programmazione';

  @override
  String get achievementChampionDescription =>
      'Sei un vero campione di programmazione!';

  @override
  String get achievementChampionCondition =>
      'Finisci tutti i livelli di tutti i giochi.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Finisci «$game».';
  }

  @override
  String get parentalGateTitle => 'Permesso dei genitori';

  @override
  String parentalGateIntro(Object action) {
    return 'Per questa azione serve il permesso di un adulto: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Acquisto di un pacchetto',
      'other': 'Azione',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Scrivi la risposta in cifre.';

  @override
  String get parentalGateCancel => 'Annulla';

  @override
  String get parentalGateConfirm => 'Conferma';

  @override
  String get parentalGateAnswer => 'Risposta';

  @override
  String get parentalGateWrongAnswer =>
      'Risposta sbagliata. Aspetta un momento, poi rispondi alla nuova domanda.';

  @override
  String parentalGateQuestion(String first, String second) {
    return 'Quanto fa $first per $second?';
  }

  @override
  String get storeTitle => 'Pacchetti';

  @override
  String get storeIntro =>
      'Gli acquisti si fanno tramite Google Play e prima di ogni acquisto viene chiesto il permesso di un genitore. Puoi usare un codice promozionale di Google Play con il link «Utilizza codice» nella schermata di pagamento o nell’app Play Store; anche un pacchetto ottenuto con un codice compare qui come acquistato.';

  @override
  String get storePaidSection => 'Pacchetti da acquistare';

  @override
  String get storeFreeSection => 'Pacchetti gratuiti';

  @override
  String get storeNoProducts =>
      'Al momento non ci sono pacchetti da acquistare.';

  @override
  String get storeBundle => 'Offerta multipla';

  @override
  String get storeStarterBundleTitle => 'Pacchetto iniziale';

  @override
  String get storeOwned => 'Acquistato';

  @override
  String get storeUnlocks => 'Si sblocca con l’acquisto:';

  @override
  String get storePriceLoading => 'Recupero del prezzo da Google Play…';

  @override
  String get storePriceUnavailable =>
      'Impossibile recuperare il prezzo da Google Play.';

  @override
  String get storeNotInStore =>
      'Al momento questo pacchetto non è su Google Play.';

  @override
  String get storeRetry => 'Riprova';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Hai già una parte dei contenuti di questo pacchetto. Google Play non abbassa il prezzo per quello che hai già, quindi questo pacchetto non viene venduto, così non paghi due volte gli stessi contenuti. Pacchetti mancanti: $missing';
  }

  @override
  String get storeRestore => 'Ripristina acquisti';

  @override
  String get storeRestoreHint =>
      'Rilegge gli acquisti del tuo account Google Play; i progressi nel gioco non vengono cancellati.';

  @override
  String storeRestored(Object count) {
    return 'Gli acquisti sono stati riletti da Google Play. Prodotti acquistati: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'Nessuna connessione a Internet; gli acquisti salvati su questo dispositivo restano validi.';

  @override
  String get storeRestoreUnavailable =>
      'Impossibile collegarsi a Google Play; gli acquisti salvati su questo dispositivo restano validi.';

  @override
  String storeBuy(Object price) {
    return 'Acquista – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count livelli',
      one: '1 livello',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased => 'Acquisto completato; il pacchetto è sbloccato.';

  @override
  String get storePending =>
      'Il pagamento è in attesa. Il pacchetto si sbloccherà da solo quando il pagamento sarà completato.';

  @override
  String get storeCancelled => 'Acquisto annullato.';

  @override
  String get storeAlreadyOwned =>
      'Hai già questo pacchetto; non è stato acquistato di nuovo.';

  @override
  String get storeBundlePartiallyOwned =>
      'Possiedi già parte dei contenuti di questo pacchetto, quindi l\'acquisto non è stato avviato per evitare di pagare due volte gli stessi contenuti.';

  @override
  String get storeOffline =>
      'Nessuna connessione a Internet. Controlla la connessione e riprova.';

  @override
  String get storeUnavailable =>
      'Impossibile collegarsi a Google Play. Riprova più tardi.';

  @override
  String get storeFailed => 'Non è stato possibile completare l’acquisto.';

  @override
  String get storeNotApproved =>
      'Il genitore non ha dato il permesso; l’acquisto non è iniziato.';

  @override
  String get gameRobotRunning => 'Il robot è in cammino...';

  @override
  String get gameRobotReachedFlag =>
      'Bravo! Il robot è arrivato alla bandiera!';

  @override
  String get gameMissingCoins =>
      'Sei arrivato alla bandiera, ma non hai raccolto tutte le monete. Prima raccogli le monete.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Su',
      'down': 'Giù',
      'left': 'Sinistra',
      'other': 'Destra',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'contro una roccia',
      'water': 'nell’acqua',
      'other': 'contro il bordo della mappa',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Scegli i comandi in ordine per portare il robot alla bandiera.';

  @override
  String get pathFinderCoinIntro =>
      'Prima raccogli tutte le monete, poi vai alla bandiera.';

  @override
  String get pathFinderEmpty => 'Prima aggiungi un comando di direzione.';

  @override
  String get pathFinderFull =>
      'Hai raggiunto il limite di comandi. Puoi cancellare un comando e metterne un altro al suo posto.';

  @override
  String get pathFinderMissedGoal =>
      'Il robot non è arrivato alla bandiera. Prova ad aggiungere o cambiare i comandi.';

  @override
  String get pathFinderTooMany =>
      'Con questi comandi non puoi finire entro il limite. Prova a cancellare i passi che non servono.';

  @override
  String get pathFinderSolved =>
      'I tuoi comandi sono giusti! Tocca il pulsante verde Via.';

  @override
  String get pathFinderEmptyStrip =>
      'Premi le frecce e i tuoi comandi si metteranno in fila qui.';

  @override
  String get pathFinderMoveLeft =>
      'Sposta il comando scelto di un passo a sinistra';

  @override
  String get pathFinderMoveRight =>
      'Sposta il comando scelto di un passo a destra';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'Il robot è finito $obstacle. Prova a cambiare il comando $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'Il comando $number porta il robot fuori dalla strada. L’ho scelto io per te; puoi cancellarlo o spostarlo.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Guarda la casella che brilla. Prossimo comando: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Aggiungi il comando «$direction»';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Comando $number: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Metti le carte nell’ordine giusto per finire il compito. Tocca una carta o trascinala in una casella.';

  @override
  String get commandOrderExtrasIntro =>
      'Attenzione! Alcune carte non fanno parte di questo compito. Metti in ordine solo le carte che servono.';

  @override
  String get commandOrderFull =>
      'Tutte le caselle sono piene. Tocca una carta per riprenderla.';

  @override
  String get commandOrderNotFull => 'Prima riempi tutte le caselle.';

  @override
  String get commandOrderSuccess =>
      'Bravo! Tutti i passi sono nell’ordine giusto.';

  @override
  String get commandOrderSolved =>
      'L’ordine è giusto! Tocca il pulsante verde Controlla.';

  @override
  String get commandOrderPoolEmpty => 'Tutte le carte sono al loro posto';

  @override
  String get commandOrderCheck => 'Controlla';

  @override
  String commandOrderWrongExtra(Object card) {
    return '«$card» non serve per questo compito. Toglila dalla casella.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return 'Nella casella $number è troppo presto per «$card». Prima deve venire un altro passo.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint La carta che brilla, «$card», va nella casella $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Casella $number: $card. Tocca per riprenderla.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Casella $number, vuota. Tocca per metterci una carta.';
  }

  @override
  String get ifThenIncomplete => 'Prima riempi le caselle vuote.';

  @override
  String get ifThenSuccess =>
      'Bravo! Il robot ha seguito le sue regole ed è arrivato alla bandiera!';

  @override
  String get ifThenSolved =>
      'Le tue regole sono giuste! Tocca il pulsante verde Via.';

  @override
  String get ifThenNoSlot =>
      'Non c’è una casella vuota per questo blocco. Tocca la casella che vuoi cambiare per svuotarla.';

  @override
  String get ifThenLockedSlot =>
      'Questa casella era già pronta e non si può cambiare. Metti il blocco in una casella vuota.';

  @override
  String get ifThenWrongType =>
      'Questo blocco non va lì. Gli oggetti vanno nella casella «Se», le mosse vanno accanto alla freccia.';

  @override
  String get ifThenLane => 'La strada del robot';

  @override
  String get ifThenObjects => 'Oggetti';

  @override
  String get ifThenActions => 'Mosse';

  @override
  String get ifThenIf => 'Se';

  @override
  String get ifThenElseIf => 'Altrimenti se';

  @override
  String get ifThenElse => 'Altrimenti';

  @override
  String get ifThenThen => 'è davanti';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Strada libera',
      'rock': 'Roccia',
      'water': 'Acqua',
      'door': 'Porta',
      'other': 'Stella',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Vai avanti',
      'jump': 'Salta',
      'bridge': 'Costruisci un ponte',
      'open': 'Apri la porta',
      'other': 'Raccogli',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'una strada libera',
      'rock': 'una roccia',
      'water': 'dell’acqua',
      'door': 'una porta',
      'other': 'una stella',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Su una strada libera non serve.',
      'rock': 'Non si può passare attraverso una roccia.',
      'water': 'Il robot non sa nuotare!',
      'door': 'Non si può passare quando la porta è chiusa.',
      'other': 'La stella è rimasta per terra.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Se la strada è libera, il robot può andare avanti.',
      'rock': 'Una roccia si supera saltando.',
      'water': 'Per attraversare l’acqua, devi costruire un ponte.',
      'door': 'Per passare dalla porta, prima devi aprirla.',
      'other': 'Usa il blocco Raccogli per prendere la stella.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'La regola $number';
  }

  @override
  String get ifThenElseRule => 'La riga «Altrimenti»';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Davanti c’era $object. $rule si è attivata e il robot ha fatto «$action». $problem Cambia le regole e riprova.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'Sulla casella che brilla c’è $object. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Casella condizione',
      'other': 'Casella mossa',
    });
    return '$_temp0: $value';
  }

  @override
  String get ifThenSlotEmpty => 'vuota';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, già pronta';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Mossa',
      'other': 'Oggetto',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Porta il robot alla bandiera. Usa il blocco Ripeti invece di aggiungere la stessa mossa tante volte.';

  @override
  String get repeatCoinIntro =>
      'Prima raccogli tutte le monete, poi vai alla bandiera. Il blocco Ripeti rende tutto più facile.';

  @override
  String get repeatEmpty => 'Prima aggiungi una freccia o un blocco Ripeti.';

  @override
  String get repeatFull =>
      'Hai raggiunto il limite di blocchi. Se hai finito, tocca il pulsante verde Via; per cambiare qualcosa, scegli un blocco e cancellalo.';

  @override
  String get repeatInsideRepeat =>
      'Le frecce che aggiungi adesso andranno dentro il blocco arancione. Quando hai finito, tocca il pulsante blu Esci dal blocco.';

  @override
  String get repeatEmptyStrip =>
      'Aggiungi una freccia o un blocco Ripeti e i tuoi blocchi si metteranno in fila qui.';

  @override
  String get repeatOutsideRepeat =>
      'Le frecce che aggiungi adesso andranno fuori dal blocco, alla fine.';

  @override
  String get repeatMovedOut =>
      'La freccia è uscita dal blocco. Anche le frecce che aggiungi adesso andranno fuori, alla fine.';

  @override
  String get repeatEmptyRepeat =>
      'Il blocco arancione è vuoto. L’ho scelto io; ora aggiungi una freccia dentro.';

  @override
  String get repeatMissedGoal =>
      'Il robot non è arrivato alla bandiera. Prova a cambiare il numero di ripetizioni o le frecce.';

  @override
  String get repeatSolved =>
      'I tuoi blocchi sono giusti! Tocca il pulsante verde Via.';

  @override
  String get repeatFullHint =>
      'Hai raggiunto il limite di blocchi. Prova a cambiare un numero di ripetizioni, oppure cancella un blocco e metti un blocco Ripeti al suo posto.';

  @override
  String get repeatAddRepeat => 'Ripeti';

  @override
  String get repeatLeaveRepeat => 'Esci dal blocco ✓';

  @override
  String get repeatAddRepeatLabel => 'Aggiungi un blocco Ripeti';

  @override
  String get repeatLeaveRepeatLabel =>
      'Esci dal blocco; le prossime frecce andranno fuori';

  @override
  String get repeatDropHere => 'Aggiungi qui le frecce';

  @override
  String get repeatEmptyBody => 'Vuoto';

  @override
  String get repeatDecrease => 'Diminuisci il numero di ripetizioni';

  @override
  String get repeatIncrease => 'Aumenta il numero di ripetizioni';

  @override
  String get repeatDeleteLabel => 'Cancella il blocco scelto';

  @override
  String get repeatMoveOutLabel =>
      'Porta la freccia scelta fuori dal blocco arancione';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times volte',
      one: 'una volta',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'ripeti $times volte',
      one: 'ripeti una volta',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Aggiungi la freccia «$direction»';
  }

  @override
  String repeatArrowName(Object number) {
    return 'La freccia $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'Il blocco $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'La freccia $arrow nel blocco $block';
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
      other: 'ripeti $times volte',
      one: 'ripeti una volta',
    );
    return 'Blocco $number: $_temp0. Tocca per aggiungere frecce dentro.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Prova a cambiare il numero di ripetizioni del blocco $number o le frecce che ci sono dentro.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place porta il robot fuori dalla strada.';
  }

  @override
  String repeatExtraBlock(Object place) {
    return '$place è di troppo. Prova a cancellare quel pezzo.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'Il robot è finito $obstacle. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'Al giro $round, il robot è finito $obstacle. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice Ho segnato in rosso il punto sbagliato per te.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Guarda la casella che brilla; lì il robot deve andare verso «$direction».';
  }

  @override
  String get repeatL1Intro =>
      'Il robot deve andare a destra 3 volte, ma puoi usare solo 2 blocchi. Aggiungi un blocco Ripeti e metti dentro la freccia a destra.';

  @override
  String get repeatL1Hint =>
      'Il blocco Ripeti fa la freccia che ha dentro tante volte quante dici tu. Quante volte deve andare a destra?';

  @override
  String get repeatL2Intro =>
      'La bandiera è lassù. Usa il blocco Ripeti invece di aggiungere la stessa freccia tante volte.';

  @override
  String get repeatL2Hint =>
      'Il robot va sempre nella stessa direzione. Quale, e quante volte?';

  @override
  String get repeatL3Hint =>
      'Il robot va giù. Conta le caselle e scegli il numero di ripetizioni.';

  @override
  String get repeatL4Hint =>
      'Questa volta a sinistra. Puoi cambiare il numero di ripetizioni con i pulsanti − e +.';

  @override
  String get repeatL5Intro =>
      'Raccogli anche le monete sulla strada! I blocchi sono sempre solo 2.';

  @override
  String get repeatL5Hint =>
      'Le monete sono tra il robot e la bandiera, sulla stessa riga. Il robot va solo a destra.';

  @override
  String get repeatL6Intro =>
      'Scendi come su una scala: destra, giù, destra, giù... Puoi mettere due frecce dentro un blocco Ripeti.';

  @override
  String get repeatL6Hint =>
      'Un gradino: una volta a destra, una volta giù. Quanti gradini ci sono?';

  @override
  String get repeatL7Hint =>
      'Due volte a destra, una volta su. Quante volte si ripete questo schema?';

  @override
  String get repeatL8Hint => 'Prima due a destra, poi una giù. Ripeti questo.';

  @override
  String get repeatL9Intro =>
      'Puoi anche aggiungere una sola freccia dopo il blocco Ripeti.';

  @override
  String get repeatL9Hint =>
      'Ripeti lo schema su-sinistra; forse alla fine ti serve un passo in più.';

  @override
  String get repeatL10Hint =>
      'Ogni gradino è largo due caselle e alto una casella.';

  @override
  String get repeatL11Intro =>
      'Questa volta ti servono due blocchi Ripeti: uno verso destra, uno verso il basso.';

  @override
  String get repeatL11Hint =>
      'Prima quante caselle a destra? Poi quante giù? Usa un blocco Ripeti diverso per ognuna.';

  @override
  String get repeatL12Hint =>
      'Prima vai su, poi vai a destra. Due blocchi Ripeti, due numeri diversi.';

  @override
  String get repeatL13Hint =>
      'Gira intorno alle rocce: destra, giù, sinistra. Conta le caselle per ogni direzione.';

  @override
  String get repeatL14Hint =>
      'La strada ha tre parti: destra, giù e di nuovo destra.';

  @override
  String get repeatL15Hint =>
      'Le due monete sono agli angoli della strada. Fai ogni tratto dritto con un blocco Ripeti.';

  @override
  String get repeatL16Intro =>
      'Solo 4 blocchi! Percorri la strada lunga con uno schema corto.';

  @override
  String get repeatL16Hint =>
      'Le monete sono in fila in diagonale: guarda lo schema destra-giù.';

  @override
  String get repeatL17Hint =>
      'Ogni gradino è alto due caselle e largo due caselle.';

  @override
  String get repeatL18Hint =>
      'Due a destra, due giù. Questo schema continua fino alla bandiera.';

  @override
  String get repeatL19Hint =>
      'Le monete sono agli angoli dei gradini. Un gradino: due a destra, una giù.';

  @override
  String get repeatL20Intro =>
      'Una strada lunga che fa le curve come un serpente. Usa bene i 10 blocchi.';

  @override
  String get repeatL20Hint =>
      'La strada è fatta di cinque tratti dritti. Fai ogni tratto con un blocco Ripeti.';

  @override
  String get bugHunterIntro =>
      'In questo codice c’è un errore! Prima tocca Via e guarda dove il robot si confonde.';

  @override
  String get bugHunterSelected =>
      'Se hai scelto una freccia, un pulsante di direzione la cambia. Puoi cancellare il blocco scelto o aggiungere una nuova freccia prima di lui.';

  @override
  String get bugHunterPickInsert =>
      'Quale freccia va prima? Tocca un pulsante di direzione.';

  @override
  String get bugHunterInsertLabel =>
      'Aggiungi una freccia prima del blocco scelto';

  @override
  String get bugHunterReset => 'Ricomincia';

  @override
  String get bugHunterL1Intro =>
      'Il robot non arriva alla bandiera: c’è un errore nel codice! Tocca Via e guarda il robot. Poi tocca la freccia sbagliata e premi il pulsante di direzione giusto.';

  @override
  String get bugHunterL1Hint =>
      'La bandiera è dritta a destra. Tutte le frecce devono andare a destra.';

  @override
  String get bugHunterL2Hint =>
      'Il robot passa sotto la roccia. L’ultima freccia deve portarlo su fino alla bandiera.';

  @override
  String get bugHunterL3Intro =>
      'In questo codice manca una freccia. Dove si è fermato il robot? Aggiungi la freccia che manca.';

  @override
  String get bugHunterL3Hint =>
      'Il robot si ferma prima della bandiera. Gli serve ancora un passo.';

  @override
  String get bugHunterL4Intro =>
      'In questo codice c’è una freccia in più. Scegli la freccia in più e cancellala.';

  @override
  String get bugHunterL4Hint =>
      'Il robot fa ancora un passo dopo essere arrivato alla bandiera.';

  @override
  String get bugHunterL5Intro =>
      'Manca una freccia, ma non alla fine. Scegli una freccia, tocca il pulsante Aggiungi prima, poi tocca un pulsante di direzione.';

  @override
  String get bugHunterL5Hint =>
      'Mentre passa sotto la roccia, il robot deve andare a destra due volte.';

  @override
  String get bugHunterL6Hint =>
      'Dopo aver raccolto la moneta, la bandiera è giù.';

  @override
  String get bugHunterL7Hint =>
      'Per passare accanto all’acqua, vai a destra tre volte lungo la riga in basso.';

  @override
  String get bugHunterL8Intro =>
      'In questo codice ci sono due errori! Ogni volta che il robot si blocca, correggi un errore.';

  @override
  String get bugHunterL8Hint =>
      'Passa sopra le rocce: prima a destra, poi giù.';

  @override
  String get bugHunterL9Hint =>
      'Dopo aver raccolto tutte e due le monete, il robot deve fermarsi sulla bandiera.';

  @override
  String get bugHunterL10Hint =>
      'Segui la strada che fa le curve tra le rocce. Una freccia è sbagliata e una manca.';

  @override
  String get bugHunterL11Intro =>
      'Questa volta l’errore è dentro il blocco arancione Ripeti. Scegli la freccia che c’è dentro e cambiala.';

  @override
  String get bugHunterL11Hint =>
      'La freccia nel blocco Ripeti deve andare verso la bandiera.';

  @override
  String get bugHunterL12Intro =>
      'Le frecce di questo codice sono giuste, ma il numero di ripetizioni è sbagliato. Cambia il numero.';

  @override
  String get bugHunterL12Hint =>
      'Quanti gradini ci sono? Il numero di ripetizioni deve essere uguale al numero di gradini.';

  @override
  String get bugHunterL13Hint => 'Ogni gradino è due a destra, una su.';

  @override
  String get bugHunterL14Hint =>
      'Ogni gradino è due a destra, una giù. Dentro il blocco manca una freccia.';

  @override
  String get bugHunterL15Hint => 'Dopo il blocco Ripeti manca solo un passo.';

  @override
  String get bugHunterL16Intro =>
      'Cacciatore esperto! In questi codici c’è più di un errore. Trovane uno ogni volta che tocchi Via.';

  @override
  String get bugHunterL16Hint =>
      'Prima quante caselle a destra? Poi quante giù?';

  @override
  String get bugHunterL17Hint =>
      'Ogni ripetizione va due caselle a destra. Quante ripetizioni servono per arrivare alla bandiera?';

  @override
  String get bugHunterL18Hint =>
      'Le rocce sono sopra i gradini. A ogni gradino, prima vai giù, poi a destra.';

  @override
  String get bugHunterL19Hint =>
      'Tra l’acqua c’è una scala: una a destra, una giù. Quanti gradini ci sono?';

  @override
  String get bugHunterL20Hint =>
      'Prima a destra, poi giù. Conta le caselle di ogni tratto dritto.';

  @override
  String get myCommandIntro =>
      'Nella striscia turchese in alto, costruisci il tuo comando con le frecce. Poi, nel programma principale in basso, usa il blocco Comando; ogni blocco Comando fa tutte le frecce del comando.';

  @override
  String get myCommandCommandEmpty =>
      'Costruisci il tuo comando: aggiungi frecce qui.';

  @override
  String get myCommandMainEmpty =>
      'Programma principale: aggiungi il blocco Comando e le frecce.';

  @override
  String get myCommandButton => 'Comando';

  @override
  String get myCommandButtonLabel =>
      'Aggiungi il blocco Comando al programma principale';

  @override
  String myCommandCallLabel(Object number) {
    return 'Blocco $number: comando';
  }

  @override
  String get myCommandEmptyCommand =>
      'Il tuo comando è vuoto. Tocca la striscia turchese in alto e aggiungi delle frecce.';

  @override
  String get myCommandEmptyMain =>
      'Il programma principale è vuoto. Aggiungi il blocco Comando con il pulsante turchese Comando.';

  @override
  String get myCommandEditCommand =>
      'Le frecce che aggiungi adesso andranno nel comando.';

  @override
  String get myCommandEditMain =>
      'I blocchi che aggiungi adesso andranno nel programma principale.';

  @override
  String get myCommandCallAdded =>
      'Il blocco Comando è stato aggiunto al programma principale. Qui il robot farà tutte le frecce del comando.';

  @override
  String get myCommandUseHint =>
      'Il tuo comando è pronto. Tocca il pulsante turchese Comando per usarlo nel programma principale.';

  @override
  String get myCommandFullHint =>
      'Hai raggiunto il limite di blocchi. Cambia il comando oppure sostituisci delle frecce del programma principale con un blocco Comando.';

  @override
  String get myCommandMissedGoal =>
      'Il robot non è arrivato alla bandiera. Prova a cambiare le frecce del comando o il numero di blocchi Comando.';

  @override
  String myCommandOffPath(Object place) {
    return '$place nel comando porta il robot fuori dalla strada.';
  }

  @override
  String myCommandFixCount(Object number) {
    return 'Prova a cambiare il numero di ripetizioni del blocco $number del comando o le frecce che ci sono dentro.';
  }

  @override
  String get myCommandLaterCall =>
      'Questa volta il comando porta il robot fuori dalla strada; cambia il comando o le frecce del programma principale.';

  @override
  String get myCommandL1Intro =>
      'Crea il tuo comando! Metti due frecce a destra nella striscia turchese in alto. Poi aggiungi il tuo comando al programma principale con il pulsante Comando.';

  @override
  String get myCommandL1Hint =>
      'Il robot deve andare 6 volte a destra. Se il tuo comando ha 2 frecce a destra, quante volte devi usarlo?';

  @override
  String get myCommandL2Hint =>
      'Scendi come su una scala. Un gradino: una a destra, una in basso. Sia questo il tuo comando.';

  @override
  String get myCommandL3Intro =>
      'Nel programma principale puoi aggiungere anche delle frecce accanto al blocco Comando.';

  @override
  String get myCommandL3Hint =>
      'Tra le pietre c’è una scala: destra, giù. Alla fine serve ancora un passo.';

  @override
  String get myCommandL4Hint =>
      'Due a destra, una in su. Quante volte si ripete questo schema?';

  @override
  String get myCommandL5Hint =>
      'Il robot sale verso sinistra: una in su, una a sinistra. Anche le monete sono su questo percorso.';

  @override
  String get myCommandL6Hint => 'Ogni gradino è largo due caselle e alto una.';

  @override
  String get myCommandL7Hint =>
      'Due a destra, due in giù. Le monete sono su questo schema.';

  @override
  String get myCommandL8Hint =>
      'Passa sotto le pietre: prima in giù, poi due a destra.';

  @override
  String get myCommandL9Hint =>
      'Fai andare il comando quattro volte a destra. Tra i due blocchi Comando il robot deve scendere.';

  @override
  String get myCommandL10Hint =>
      'Prendi le monete tra le pietre: giù, due a destra, su.';

  @override
  String get myCommandL11Intro =>
      'Puoi mettere anche un blocco Ripeti dentro il comando! Così un comando corto fa un percorso lungo.';

  @override
  String get myCommandL11Hint =>
      'Fai andare il comando tre volte a destra. Tra i comandi il robot va una volta giù e una volta su.';

  @override
  String get myCommandL12Hint =>
      'Ogni pezzo è due a destra, una in giù. In un punto c’è un altro passo in giù.';

  @override
  String get myCommandL13Hint =>
      'Ogni gradino è una in su, due a destra. Non dimenticare la moneta.';

  @override
  String get myCommandL14Hint =>
      'Ogni pezzo è due a destra, una in su. Guarda anche i passi tra i comandi.';

  @override
  String get myCommandL15Hint =>
      'Ogni pezzo è una in giù, due a destra. Tra i comandi a volte il percorso va dritto.';

  @override
  String get myCommandL16Hint =>
      'Comando: tre a destra, una in giù. Dopo il primo comando devi girare una volta a sinistra.';

  @override
  String get myCommandL17Hint =>
      'Ogni pezzo è una in su, tre a destra. Tra i comandi sali ancora una volta.';

  @override
  String get myCommandL18Hint =>
      'Dentro il comando possono esserci due blocchi Ripeti: due in giù, due a destra.';

  @override
  String get myCommandL19Hint =>
      'Comando: una a destra, due in su, una a destra. Trova le frecce in mezzo contando le caselle.';

  @override
  String get myCommandL20Hint =>
      'Nel comando ci sono prima due gradini: destra, giù. Poi ancora un passo a destra.';

  @override
  String get variableBoxIntro =>
      'Metti un numero nella scatola gialla. Ogni freccia fa camminare il robot di tante caselle quante ne indica la scatola. La scatola parte da 1.';

  @override
  String get variableBoxEmpty =>
      'Prima aggiungi un blocco scatola o una freccia.';

  @override
  String get variableBoxEmptyStrip =>
      'Aggiungi un blocco scatola e delle frecce e i tuoi blocchi si metteranno in fila qui.';

  @override
  String get variableBoxMissedGoal =>
      'Il robot non è arrivato alla bandiera. Prova a cambiare il numero nella scatola o le frecce.';

  @override
  String get variableBoxFullHint =>
      'Hai raggiunto il limite di blocchi. Invece di aggiungere le frecce una per una, prova a mettere un numero più grande nella scatola.';

  @override
  String variableBoxWalked(int box) {
    String _temp0 = intl.Intl.pluralLogic(
      box,
      locale: localeName,
      other:
          'Nella scatola c’era $box: ogni freccia ha fatto camminare il robot di $box caselle.',
      one:
          'Nella scatola c’era $box: ogni freccia ha fatto camminare il robot di $box casella.',
    );
    return '$_temp0';
  }

  @override
  String variableBoxInnerName(Object block, Object number) {
    return 'Il blocco scatola $number nel blocco $block';
  }

  @override
  String variableBoxSetChip(Object name, Object value) {
    return '$name: metti $value nella scatola';
  }

  @override
  String variableBoxIncreaseChip(Object name) {
    return '$name: aggiungi 1 alla scatola';
  }

  @override
  String variableBoxDecreaseChip(Object name) {
    return '$name: togli 1 dalla scatola';
  }

  @override
  String get variableBoxDecrease =>
      'Diminuisci il numero da mettere nella scatola';

  @override
  String get variableBoxIncrease =>
      'Aumenta il numero da mettere nella scatola';

  @override
  String get variableBoxSetLabel =>
      'Aggiungi un blocco che mette un numero nella scatola';

  @override
  String get variableBoxIncreaseLabel =>
      'Aggiungi un blocco che aggiunge 1 alla scatola';

  @override
  String get variableBoxDecreaseLabel =>
      'Aggiungi un blocco che toglie 1 dalla scatola';

  @override
  String variableBoxBadge(Object value) {
    return 'Adesso nella scatola c’è $value.';
  }

  @override
  String variableBoxArrowSteps(String label, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label. Fa camminare il robot di $count caselle.',
      one: '$label. Fa camminare il robot di 1 casella.',
    );
    return '$_temp0';
  }

  @override
  String get variableBoxL1Intro =>
      'La bandiera è 6 caselle più in là, ma puoi usare solo 2 blocchi. Prima metti 6 nella scatola, poi tocca la freccia a destra.';

  @override
  String get variableBoxL1Hint =>
      'Con il blocco scatola = metti 6 nella scatola; poi una sola freccia a destra fa camminare il robot di 6 caselle.';

  @override
  String get variableBoxL2Hint =>
      'Il robot deve andare 3 a destra e 3 in basso. Metti 3 nella scatola; poi ogni freccia fa 3 caselle.';

  @override
  String get variableBoxL3Hint =>
      'Ci sono 4 caselle a destra e 4 in basso. Metti 4 nella scatola, poi bastano due frecce.';

  @override
  String get variableBoxL4Hint =>
      'Prima 5 caselle a destra, poi 2 in basso. Metti 5 nella scatola e usa la freccia a destra; poi metti 2 nella scatola e usa la freccia in basso.';

  @override
  String get variableBoxL5Intro =>
      'Nuovo blocco: +1 aumenta di uno il numero nella scatola.';

  @override
  String get variableBoxL5Hint =>
      '2 caselle a destra, 3 in basso. Metti 2 nella scatola, freccia a destra, poi con +1 porta la scatola a 3 e usa la freccia in basso.';

  @override
  String get variableBoxL6Hint =>
      'Il percorso è sempre di 3 caselle: destra, basso, destra, basso. Metti 3 nella scatola una volta sola; ogni freccia dopo farà 3 caselle.';

  @override
  String get variableBoxL7Hint =>
      'La scatola parte da 1. A ogni passo il percorso si allunga di una casella: freccia, +1, freccia, +1, freccia.';

  @override
  String get variableBoxL8Intro =>
      'Nuovo blocco: −1 diminuisce di uno il numero nella scatola.';

  @override
  String get variableBoxL8Hint =>
      'I percorsi sono di 4, 3, 2, 1 caselle. Metti 4 nella scatola, poi aggiungi −1 dopo ogni freccia.';

  @override
  String get variableBoxL9Hint =>
      '5 caselle in basso, 2 a destra, 5 in alto. Prima di ogni direzione metti nella scatola il numero giusto.';

  @override
  String get variableBoxL10Hint =>
      'Tutti i percorsi sono lunghi 3 caselle. Metti 3 nella scatola una volta sola, poi bastano cinque frecce.';

  @override
  String get variableBoxL11Intro =>
      'Il blocco Ripeti è tornato! Il numero nella scatola vale anche a ogni giro della ripetizione.';

  @override
  String get variableBoxL11Hint =>
      'I gradini sono di 2 caselle. Metti 2 nella scatola, poi ripeti 3 volte la freccia a destra e quella in basso.';

  @override
  String get variableBoxL12Hint =>
      'I gradini sono di 3 caselle: prima in basso, poi a destra. Metti 3 nella scatola e ripeti lo schema 2 volte.';

  @override
  String get variableBoxL13Hint =>
      'Metti 2 nella scatola; ripeti 2 volte la freccia a destra e quella in alto, alla fine aggiungi un’altra freccia a destra.';

  @override
  String get variableBoxL14Hint =>
      'Prima vai 3 caselle a destra. Poi porta la scatola a 2 e ripeti 2 volte lo schema in basso e a destra.';

  @override
  String get variableBoxL15Hint =>
      'Prima metti 2 nella scatola e ripeti 2 volte lo schema a destra e in basso. L’ultimo tratto dritto è di 3 caselle.';

  @override
  String get variableBoxL16Intro =>
      'Dentro il blocco Ripeti puoi mettere +1: così a ogni giro il percorso si allunga di una casella.';

  @override
  String get variableBoxL16Hint =>
      'I gradini crescono: 1, 2, 3 caselle. Ripeti 3 volte la freccia a destra, la freccia in basso e il blocco +1.';

  @override
  String get variableBoxL17Hint =>
      'I gradini si accorciano: 3, 2, 1 caselle. Metti 3 nella scatola; ripeti 3 volte la freccia a destra, quella in basso e il blocco −1.';

  @override
  String get variableBoxL18Hint =>
      'A ogni giro ci sono la freccia a destra, +1 e la freccia in basso; dopo 2 giri aggiungi un’ultima freccia a destra.';

  @override
  String get variableBoxL19Hint =>
      'Metti 4 nella scatola. Ripeti 2 volte lo schema freccia a destra, −1 e freccia in basso.';

  @override
  String get variableBoxL20Hint =>
      'Ogni freccia è più lunga di una casella rispetto alla precedente. Ripeti 2 volte lo schema freccia a destra, +1, freccia in basso, +1.';

  @override
  String get patternColorRed => 'rosso';

  @override
  String get patternColorBlue => 'blu';

  @override
  String get patternColorYellow => 'giallo';

  @override
  String get patternColorGreen => 'verde';

  @override
  String get patternShapeCircle => 'cerchio';

  @override
  String get patternShapeSquare => 'quadrato';

  @override
  String get patternShapeTriangle => 'triangolo';

  @override
  String patternLampLabel(String color, String shape) {
    return 'Lampada $shape di colore $color';
  }

  @override
  String get patternMissingSlot => 'Pezzo mancante';

  @override
  String patternLightChip(String name, String color) {
    return '$name: accendi una lampada di colore $color';
  }

  @override
  String patternInnerName(Object block, Object number) {
    return 'Il blocco lampada $number nel blocco $block';
  }

  @override
  String patternLightLabel(String color) {
    return 'Aggiungi un blocco che accende una lampada di colore $color';
  }

  @override
  String get patternEmptyStrip =>
      'Tocca i pulsanti dei colori per aggiungere blocchi';

  @override
  String get patternIntroEasy =>
      'Le lampade si accendono seguendo una sequenza. Scegli qui sotto il colore della lampada con il punto interrogativo.';

  @override
  String get patternIntroMedium =>
      'Stavolta mancano più pezzi. Guarda i colori e le forme, poi completa i pezzi mancanti uno alla volta.';

  @override
  String get patternIntroHard =>
      'Queste sequenze crescono o avanzano con i numeri. Scegli il pezzo giusto tra le opzioni qui sotto.';

  @override
  String get patternIntroExpert =>
      'Le lampade le accendi tu! Aggiungi blocchi con i pulsanti dei colori; se i colori si ripetono, usa il blocco Ripeti.';

  @override
  String get patternHintRepeat =>
      'Guarda la parte che si ripete. Con quali colori ricomincia la sequenza?';

  @override
  String get patternHintShape =>
      'Guarda sia il colore sia la forma. Nella parte che si ripete tornano entrambi nello stesso ordine.';

  @override
  String get patternHintGrowing =>
      'La sequenza cresce ogni volta. Conta le lampade blu: a ogni giro ce n’è una in più.';

  @override
  String get patternHintNumbers =>
      'Guarda la differenza tra i numeri. Ogni volta si aggiunge lo stesso numero.';

  @override
  String get patternHintGrowingNumbers =>
      'Guarda la differenza tra i numeri. La differenza aumenta di uno ogni volta: 1, 2, 3…';

  @override
  String get patternHintProgram =>
      'Trova il gruppo di lampade che si ripete. Metti quei colori dentro il blocco Ripeti e imposta il numero di ripetizioni.';

  @override
  String get patternHintProgramTail =>
      'Quando il gruppo che si ripete finisce, in fondo resta una lampada. Aggiungila fuori dal blocco Ripeti.';

  @override
  String get patternHintProgramTwo =>
      'Nella striscia ci sono due sequenze diverse. Usa un blocco Ripeti per ognuna.';

  @override
  String get patternWrongLamp =>
      'Questo pezzo non va con la sequenza. Guarda la parte che si ripete e riprova.';

  @override
  String get patternRightLamp =>
      'Giusto! Ora completa il prossimo punto interrogativo.';

  @override
  String get patternSolved => 'Bravissimo! La sequenza è completa.';

  @override
  String get patternLampsDark =>
      'Alcune lampade sono ancora spente. Aggiungi più blocchi colore oppure aumenta il numero di ripetizioni.';

  @override
  String get patternTooManyLights =>
      'Ci sono più blocchi che lampade. Elimina un blocco oppure diminuisci il numero di ripetizioni.';

  @override
  String patternWrongColor(String color) {
    return 'Questa lampada si è accesa di colore $color, ma non va con la sequenza. Che colore doveva essere qui?';
  }

  @override
  String get patternProgramEmpty =>
      'Prima aggiungi dei blocchi con i pulsanti dei colori.';

  @override
  String patternProgramHintWrong(String color) {
    return 'Il blocco che ho scelto accende la lampada del colore sbagliato. Lì la lampada deve essere di colore $color.';
  }

  @override
  String get patternInsideRepeat =>
      'I colori che aggiungi adesso andranno dentro il blocco arancione. Quando hai finito, tocca il pulsante blu Esci dal blocco.';

  @override
  String get patternOutsideRepeat =>
      'I colori che aggiungi adesso andranno fuori dal blocco, alla fine.';

  @override
  String get patternMovedOut =>
      'Il colore è uscito dal blocco. Anche i colori che aggiungi adesso andranno fuori, alla fine.';

  @override
  String get patternEmptyRepeat =>
      'Il blocco arancione è vuoto. L’ho scelto io; ora aggiungi un colore dentro.';

  @override
  String get patternLeaveRepeatLabel =>
      'Esci dal blocco; i prossimi colori andranno fuori';

  @override
  String get patternDropHere => 'Aggiungi qui i colori';

  @override
  String get ifThenL1Intro =>
      'Se davanti c’è una roccia, che cosa deve fare il robot? Metti una mossa nella casella vuota.';

  @override
  String get ifThenL2Intro =>
      'Il robot non sa nuotare. Se davanti c’è dell’acqua, che cosa deve fare?';

  @override
  String get ifThenL3Intro =>
      'Sulla strada c’è una porta chiusa. Che cosa deve fare il robot quando arriva alla porta?';

  @override
  String get ifThenL4Intro =>
      'Non passare accanto alle stelle senza raccoglierle! Se davanti c’è una stella, che cosa deve fare il robot?';

  @override
  String get ifThenL5Intro =>
      'Questa volta scegli anche la condizione. Che cosa c’è sulla strada?';

  @override
  String get ifThenL6Intro =>
      'Se c’è una roccia, fai una cosa; se no, fai un’altra cosa. Riempi tutte e due le caselle.';

  @override
  String get ifThenL7Intro =>
      'Che cosa deve fare se c’è dell’acqua? E se non c’è acqua?';

  @override
  String get ifThenL8Intro =>
      'Su questa strada non ci sono caselle libere! Se non c’è una porta, che cosa c’è davanti?';

  @override
  String get ifThenL9Intro => 'Scegli la condizione e tutte e due le mosse.';

  @override
  String get ifThenL10Intro =>
      'Sulla strada ci sono rocce e acqua. Bastano una regola e un «Altrimenti».';

  @override
  String get ifThenL11Intro =>
      'Ci sono di nuovo rocce e acqua. Fai una regola per ognuna.';

  @override
  String get ifThenL12Intro => 'Apri le porte e raccogli le stelle.';

  @override
  String get ifThenL13Intro =>
      'Ci sono tre cose diverse ma solo due righe per le regole. Usa «Altrimenti» per la terza.';

  @override
  String get ifThenL14Intro =>
      'Acqua, porte e strada libera. Quale lascerai ad «Altrimenti»?';

  @override
  String get ifThenL15Intro =>
      'Attenzione: uno dei blocchi non è proprio su questa strada.';

  @override
  String get ifThenL16Intro =>
      'Il robot va verso il castello: ci sono rocce, fossati e porte del castello.';

  @override
  String get ifThenL17Intro =>
      'La strada del tesoro: raccogli le stelle e supera gli ostacoli.';

  @override
  String get ifThenL18Intro =>
      'Su questa strada non ci sono caselle libere. Quattro cose vogliono quattro decisioni.';

  @override
  String get ifThenL19Intro =>
      'Un lungo viaggio! Acqua, rocce, porte e strada libera.';

  @override
  String get ifThenL20Intro =>
      'Ultimo compito: raccogli tutte le stelle e arriva alla bandiera.';

  @override
  String get pathFinderL1Intro =>
      'Porta il robot alla bandiera. Premi la freccia a destra, poi tocca il pulsante verde Via.';

  @override
  String get pathFinderL2Intro =>
      'La bandiera è sopra il robot. Quale freccia devi scegliere?';

  @override
  String get pathFinderL3Intro =>
      'La bandiera è a sinistra, a due caselle di distanza.';

  @override
  String get pathFinderL4Intro => 'Il robot deve andare giù. Quante volte?';

  @override
  String get pathFinderL5Intro => 'Questa volta userai due direzioni diverse.';

  @override
  String get pathFinderL11Intro =>
      'Sulla strada c’è una roccia. Girale intorno.';

  @override
  String get pathFinderL12Intro =>
      'Le rocce sono in fila come un muro. Passa sotto, girandoci intorno.';

  @override
  String get pathFinderL13Intro =>
      'Il robot non può andare nell’acqua. Trova la strada asciutta.';

  @override
  String get pathFinderL15Intro =>
      'C’è più di una strada. Riesci a trovare la più corta?';

  @override
  String get commandOrderL1Title => 'Annaffia il fiore';

  @override
  String get commandOrderL1Step1 => 'Riempi l’annaffiatoio';

  @override
  String get commandOrderL1Step2 => 'Annaffia il fiore';

  @override
  String get commandOrderL1Hint =>
      'Per annaffiare il fiore, prima ci deve essere l’acqua nell’annaffiatoio.';

  @override
  String get commandOrderL2Title => 'Lavati i denti';

  @override
  String get commandOrderL2Step1 => 'Metti il dentifricio sullo spazzolino';

  @override
  String get commandOrderL2Step2 => 'Lavati i denti';

  @override
  String get commandOrderL2Step3 => 'Sciacquati la bocca';

  @override
  String get commandOrderL2Hint =>
      'Prima di iniziare a lavarti i denti, ci deve essere il dentifricio sullo spazzolino.';

  @override
  String get commandOrderL3Title => 'Lavati le mani';

  @override
  String get commandOrderL3Step1 => 'Insapona le mani';

  @override
  String get commandOrderL3Step2 => 'Sciacqua le mani';

  @override
  String get commandOrderL3Step3 => 'Asciuga le mani';

  @override
  String get commandOrderL3Hint =>
      'Non puoi asciugarti le mani prima che la schiuma sia andata via.';

  @override
  String get commandOrderL4Title => 'Mettiti le scarpe';

  @override
  String get commandOrderL4Step1 => 'Mettiti i calzini';

  @override
  String get commandOrderL4Step2 => 'Mettiti le scarpe';

  @override
  String get commandOrderL4Step3 => 'Allaccia le stringhe';

  @override
  String get commandOrderL4Hint =>
      'Che cosa deve avere il piede prima di entrare nella scarpa?';

  @override
  String get commandOrderL5Title => 'Fai un disegno';

  @override
  String get commandOrderL5Step1 => 'Prendi un foglio';

  @override
  String get commandOrderL5Step2 => 'Disegna';

  @override
  String get commandOrderL5Step3 => 'Colora il disegno';

  @override
  String get commandOrderL5Hint =>
      'Per colorare, ti serve un disegno già fatto.';

  @override
  String get commandOrderL6Title => 'Prepara un panino';

  @override
  String get commandOrderL6Step1 => 'Metti il piatto sul tavolo';

  @override
  String get commandOrderL6Step2 => 'Metti il pane nel piatto';

  @override
  String get commandOrderL6Step3 => 'Metti sopra il formaggio';

  @override
  String get commandOrderL6Step4 => 'Coprilo con il pane';

  @override
  String get commandOrderL6Step5 => 'Buon appetito';

  @override
  String get commandOrderL6Hint =>
      'Ti serve un posto dove mettere il pane. Che cosa deve esserci prima sul tavolo?';

  @override
  String get commandOrderL7Title => 'Metti a posto i giocattoli';

  @override
  String get commandOrderL7Step1 => 'Prendi la scatola';

  @override
  String get commandOrderL7Step2 => 'Metti i giocattoli nella scatola';

  @override
  String get commandOrderL7Step3 => 'Chiudi il coperchio';

  @override
  String get commandOrderL7Step4 => 'Metti la scatola sullo scaffale';

  @override
  String get commandOrderL7Hint =>
      'Che cosa fai se la scatola dei giocattoli non è vicino a te?';

  @override
  String get commandOrderL8Title => 'Pianta un seme';

  @override
  String get commandOrderL8Step1 => 'Scava una buca nella terra';

  @override
  String get commandOrderL8Step2 => 'Metti il seme nella buca';

  @override
  String get commandOrderL8Step3 => 'Coprilo con la terra';

  @override
  String get commandOrderL8Step4 => 'Annaffia il seme';

  @override
  String get commandOrderL8Step5 => 'Aspetta il germoglio';

  @override
  String get commandOrderL8Hint =>
      'Non puoi mettere il seme nella terra senza una buca.';

  @override
  String get commandOrderL9Title => 'Preparati per la scuola';

  @override
  String get commandOrderL9Step1 => 'Svegliati quando suona la sveglia';

  @override
  String get commandOrderL9Step2 => 'Mettiti i vestiti per la scuola';

  @override
  String get commandOrderL9Step3 => 'Mettiti lo zaino';

  @override
  String get commandOrderL9Step4 => 'Sali sullo scuolabus';

  @override
  String get commandOrderL9Hint =>
      'Non puoi vestirti prima di svegliarti. Che cosa succede per prima cosa la mattina?';

  @override
  String get commandOrderL10Title => 'Spedisci una lettera';

  @override
  String get commandOrderL10Step1 => 'Scrivi la lettera';

  @override
  String get commandOrderL10Step2 => 'Metti la lettera nella busta';

  @override
  String get commandOrderL10Step3 => 'Chiudi la busta';

  @override
  String get commandOrderL10Step4 => 'Imbucala nella cassetta delle lettere';

  @override
  String get commandOrderL10Hint =>
      'Ci deve essere una lettera da mettere nella busta.';

  @override
  String get commandOrderL11Title => 'Fai una torta';

  @override
  String get commandOrderL11Stage1 => 'Prepara l’impasto';

  @override
  String get commandOrderL11Stage2 => 'Cuoci la torta';

  @override
  String get commandOrderL11Step1 => 'Metti gli ingredienti sul tavolo';

  @override
  String get commandOrderL11Step2 => 'Mescola tutto in una ciotola';

  @override
  String get commandOrderL11Step3 => 'Versa l’impasto nella teglia';

  @override
  String get commandOrderL11Step4 => 'Metti la teglia nel forno';

  @override
  String get commandOrderL11Step5 => 'Aspetta che si cuocia';

  @override
  String get commandOrderL11Step6 => 'Taglia la torta a fette';

  @override
  String get commandOrderL11Hint =>
      'Non puoi mettere niente nel forno prima che l’impasto sia pronto.';

  @override
  String get commandOrderL12Title => 'Fai il bagno';

  @override
  String get commandOrderL12Stage1 => 'Prepara il bagno';

  @override
  String get commandOrderL12Stage2 => 'Lavati';

  @override
  String get commandOrderL12Stage3 => 'Asciugati';

  @override
  String get commandOrderL12Step1 => 'Riempi la vasca d’acqua';

  @override
  String get commandOrderL12Step2 => 'Entra nella vasca';

  @override
  String get commandOrderL12Step3 => 'Lavati i capelli con lo shampoo';

  @override
  String get commandOrderL12Step4 => 'Sciacqua via la schiuma';

  @override
  String get commandOrderL12Step5 => 'Asciugati con l’asciugamano';

  @override
  String get commandOrderL12Hint =>
      'Se entri in una vasca vuota, non ti puoi lavare.';

  @override
  String get commandOrderL13Title => 'Vai in bicicletta';

  @override
  String get commandOrderL13Stage1 => 'Preparati';

  @override
  String get commandOrderL13Stage2 => 'In sella';

  @override
  String get commandOrderL13Stage3 => 'Arrivo';

  @override
  String get commandOrderL13Step1 => 'Mettiti il casco';

  @override
  String get commandOrderL13Step2 => 'Sali sulla bicicletta';

  @override
  String get commandOrderL13Step3 => 'Pedala';

  @override
  String get commandOrderL13Step4 => 'Usa i freni';

  @override
  String get commandOrderL13Step5 => 'Scendi dalla bicicletta';

  @override
  String get commandOrderL13Hint =>
      'Prima di tutto la sicurezza. Che cosa ti metti prima di salire sulla bicicletta?';

  @override
  String get commandOrderL14Title => 'Prendi un libro in prestito';

  @override
  String get commandOrderL14Stage1 => 'In biblioteca';

  @override
  String get commandOrderL14Stage2 => 'A casa';

  @override
  String get commandOrderL14Stage3 => 'Restituiscilo';

  @override
  String get commandOrderL14Step1 => 'Vai in biblioteca';

  @override
  String get commandOrderL14Step2 => 'Scegli un libro';

  @override
  String get commandOrderL14Step3 => 'Prendi il libro in prestito';

  @override
  String get commandOrderL14Step4 => 'Porta il libro a casa';

  @override
  String get commandOrderL14Step5 => 'Leggi il libro';

  @override
  String get commandOrderL14Step6 => 'Riporta il libro';

  @override
  String get commandOrderL14Hint =>
      'Per scegliere un libro, prima devi andare dove sono i libri.';

  @override
  String get commandOrderL15Title => 'Pianta una tenda';

  @override
  String get commandOrderL15Stage1 => 'Prepara il posto';

  @override
  String get commandOrderL15Stage2 => 'Monta la tenda';

  @override
  String get commandOrderL15Stage3 => 'Prepara l’interno';

  @override
  String get commandOrderL15Step1 => 'Trova un posto piano';

  @override
  String get commandOrderL15Step2 => 'Stendi la tenda per terra';

  @override
  String get commandOrderL15Step3 => 'Infila i paletti';

  @override
  String get commandOrderL15Step4 => 'Alza la tenda';

  @override
  String get commandOrderL15Step5 => 'Fissala con i picchetti';

  @override
  String get commandOrderL15Step6 => 'Metti dentro il sacco a pelo';

  @override
  String get commandOrderL15Step7 => 'Accendi la tua lanterna';

  @override
  String get commandOrderL15Hint =>
      'Per stendere la tenda, prima devi trovare un buon posto.';

  @override
  String get commandOrderL16Title => 'Fai una pizza';

  @override
  String get commandOrderL16Stage1 => 'L’impasto';

  @override
  String get commandOrderL16Stage2 => 'Il condimento';

  @override
  String get commandOrderL16Stage3 => 'La cottura';

  @override
  String get commandOrderL16Step1 => 'Stendi l’impasto';

  @override
  String get commandOrderL16Step2 => 'Spalma il pomodoro';

  @override
  String get commandOrderL16Step3 => 'Metti la mozzarella';

  @override
  String get commandOrderL16Step4 => 'Mettila nel forno';

  @override
  String get commandOrderL16Step5 => 'Aspetta che si cuocia';

  @override
  String get commandOrderL16Step6 => 'Tagliala a fette';

  @override
  String get commandOrderL16Extra1 => 'Accendi la TV';

  @override
  String get commandOrderL16Hint =>
      'Non tutte le carte fanno parte di questo compito. Ti serve la TV per fare una pizza?';

  @override
  String get commandOrderL17Title => 'Fai il bucato';

  @override
  String get commandOrderL17Stage1 => 'Preparazione';

  @override
  String get commandOrderL17Stage2 => 'Lavaggio';

  @override
  String get commandOrderL17Stage3 => 'Asciugatura';

  @override
  String get commandOrderL17Step1 => 'Raccogli i vestiti sporchi';

  @override
  String get commandOrderL17Step2 => 'Mettili nella lavatrice';

  @override
  String get commandOrderL17Step3 => 'Aggiungi il detersivo';

  @override
  String get commandOrderL17Step4 => 'Accendi la lavatrice';

  @override
  String get commandOrderL17Step5 => 'Stendi i vestiti';

  @override
  String get commandOrderL17Step6 => 'Piegali quando sono asciutti';

  @override
  String get commandOrderL17Extra1 => 'Gioca a palla';

  @override
  String get commandOrderL17Hint =>
      'Se i vestiti sporchi sono sparsi in giro, che cosa devi fare prima?';

  @override
  String get commandOrderL18Title => 'Viaggia in treno';

  @override
  String get commandOrderL18Stage1 => 'In stazione';

  @override
  String get commandOrderL18Stage2 => 'Sul treno';

  @override
  String get commandOrderL18Stage3 => 'L’arrivo';

  @override
  String get commandOrderL18Step1 => 'Compra il biglietto';

  @override
  String get commandOrderL18Step2 => 'Vai al binario';

  @override
  String get commandOrderL18Step3 => 'Aspetta il treno';

  @override
  String get commandOrderL18Step4 => 'Sali sul treno';

  @override
  String get commandOrderL18Step5 => 'Siediti al tuo posto';

  @override
  String get commandOrderL18Step6 => 'Scendi alla tua fermata';

  @override
  String get commandOrderL18Extra1 => 'Sali sull’aereo';

  @override
  String get commandOrderL18Hint => 'Che cosa ti serve per salire sul treno?';

  @override
  String get commandOrderL19Title => 'Fai crescere un alberello';

  @override
  String get commandOrderL19Stage1 => 'La semina';

  @override
  String get commandOrderL19Stage2 => 'Le cure';

  @override
  String get commandOrderL19Stage3 => 'La crescita';

  @override
  String get commandOrderL19Step1 => 'Metti la terra nel vaso';

  @override
  String get commandOrderL19Step2 => 'Pianta il seme';

  @override
  String get commandOrderL19Step3 => 'Annaffia il seme';

  @override
  String get commandOrderL19Step4 => 'Metti il vaso al sole';

  @override
  String get commandOrderL19Step5 => 'Aspetta il germoglio';

  @override
  String get commandOrderL19Step6 => 'Piantalo in giardino';

  @override
  String get commandOrderL19Extra1 => 'Apri un ombrello';

  @override
  String get commandOrderL19Extra2 => 'Metti il vaso al buio';

  @override
  String get commandOrderL19Hint =>
      'Per crescere, le piante hanno bisogno di acqua e di sole. Quali carte farebbero loro male?';

  @override
  String get commandOrderL20Title => 'Prepara i biscotti e condividili';

  @override
  String get commandOrderL20Stage1 => 'Preparazione';

  @override
  String get commandOrderL20Stage2 => 'Cottura';

  @override
  String get commandOrderL20Stage3 => 'Da condividere';

  @override
  String get commandOrderL20Step1 => 'Lavati le mani';

  @override
  String get commandOrderL20Step2 => 'Mescola gli ingredienti';

  @override
  String get commandOrderL20Step3 => 'Dai forma all’impasto';

  @override
  String get commandOrderL20Step4 => 'Cuocili nel forno';

  @override
  String get commandOrderL20Step5 => 'Lasciali raffreddare';

  @override
  String get commandOrderL20Step6 => 'Mettili in una scatola';

  @override
  String get commandOrderL20Step7 => 'Condividili con i tuoi amici';

  @override
  String get commandOrderL20Extra1 => 'Guida una macchinina';

  @override
  String get commandOrderL20Extra2 => 'Vai a dormire';

  @override
  String get commandOrderL20Hint =>
      'Prima di lavorare in cucina, le mani devono essere pulite.';
}
