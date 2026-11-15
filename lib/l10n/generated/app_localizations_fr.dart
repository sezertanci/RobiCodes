// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Robi Programme';

  @override
  String get languageName => 'Français';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Programme';

  @override
  String get homeTagline => 'Joue • Apprends • Découvre';

  @override
  String get homeComingSoon => 'Bientôt';

  @override
  String get homeLocked => 'Verrouillé';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels niveaux';
  }

  @override
  String get homeChangeCharacter => 'Changer';

  @override
  String homeCharacterLabel(Object name) {
    return 'Ton personnage : $name. Touche pour le changer.';
  }

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonNextLevel => 'Niveau suivant';

  @override
  String get commonBackToHome => 'Retour à l’accueil';

  @override
  String get commonBackToLevels => 'Retour aux niveaux';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étoiles',
      one: '1 étoile',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Démarrer';

  @override
  String get commonHint => 'Indice';

  @override
  String get commonClear => 'Vider';

  @override
  String get commonDelete => 'Effacer';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsSound => 'Son';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Facile',
      'medium': 'Moyen',
      'hard': 'Difficile',
      'other': 'Expert',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Niveaux de base';

  @override
  String get playPreviousLevel => 'Niveau précédent';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, niveau $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Termine d’abord les niveaux « $difficulty »';
  }

  @override
  String get playPreviewNote =>
      'Le premier niveau de chaque difficulté peut être essayé gratuitement. Les autres niveaux se débloquent après l’achat.';

  @override
  String get playLevelComplete => 'Bravo ! Niveau terminé.';

  @override
  String playLevel(Object level) {
    return 'Niveau $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Niveau $level, verrouillé';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Niveau $level, $stars';
  }

  @override
  String get playLocked => 'verrouillé';

  @override
  String get gamePathFinderTitle => 'Trouve le chemin du robot';

  @override
  String get gamePathFinderDescription =>
      'Guide le robot jusqu’au but avec des ordres de direction.';

  @override
  String get gamePathFinderTrophy => 'Maître des robots';

  @override
  String get gamePathFinderTrophyDescription =>
      'Le robot connaît maintenant tous les chemins !';

  @override
  String get gameCommandOrderTitle => 'Range les étapes';

  @override
  String get gameCommandOrderDescription =>
      'Mets les étapes dans le bon ordre.';

  @override
  String get gameCommandOrderTrophy => 'Maître des algorithmes';

  @override
  String get gameCommandOrderTrophyDescription =>
      'Tu es le meilleur pour ranger les étapes !';

  @override
  String get gameIfThenTitle => 'Si ceci, alors';

  @override
  String get gameIfThenDescription =>
      'Choisis le bon ordre pour chaque situation.';

  @override
  String get gameIfThenTrophy => 'Maître des décisions';

  @override
  String get gameIfThenTrophyDescription =>
      'Tu fais le bon choix à chaque fois !';

  @override
  String get gameRepeatTitle => 'Répète-le';

  @override
  String get gameRepeatDescription =>
      'Fais des mouvements répétés avec un seul bloc.';

  @override
  String get gameRepeatTrophy => 'Maître des boucles';

  @override
  String get gameRepeatTrophyDescription =>
      'Tu utilises les boucles comme un pro !';

  @override
  String get gameBugHunterTitle => 'Chasseur de bugs';

  @override
  String get gameBugHunterDescription => 'Trouve le code cassé et répare-le.';

  @override
  String get gameBugHunterTrophy => 'Maître chasseur de bugs';

  @override
  String get gameBugHunterTrophyDescription =>
      'Tu as trouvé même les bugs les plus difficiles !';

  @override
  String get characterTitle => 'Choisis ton personnage';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Hélice',
      'isil': 'Lueur',
      'kahraman': 'Héros',
      'pembe': 'Rosie',
      'sovalye': 'Chevalier',
      'piril': 'Étincelle',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Mes succès';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tu as gagné $count récompenses !',
      one: 'Tu as gagné 1 récompense !',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Badges';

  @override
  String get achievementsBadgesSubtitle => 'Petites victoires';

  @override
  String get achievementsBadgesEarned => 'Tes badges';

  @override
  String get achievementsBadgesLocked => 'Badges à gagner';

  @override
  String get achievementsBadgesEmpty =>
      'Pas encore de badge. Termine ton premier niveau !';

  @override
  String get achievementsTrophies => 'Trophées';

  @override
  String get achievementsTrophiesSubtitle => 'Grands objectifs';

  @override
  String get achievementsTrophiesEarned => 'Tes trophées';

  @override
  String get achievementsTrophiesLocked => 'Trophées verrouillés';

  @override
  String get achievementsTrophiesEmpty =>
      'Pas encore de trophée. Continue pour atteindre les grands objectifs !';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'Mes succès : $earned/$total';
  }

  @override
  String get achievementEarned => 'Gagné !';

  @override
  String get achievementCondition => 'Pour l’obtenir : ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, gagné';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, verrouillé';
  }

  @override
  String get achievementNewBadge => 'Nouveau badge !';

  @override
  String get achievementNewTrophy => 'Tu as gagné un nouveau trophée !';

  @override
  String get achievementGreat => 'Super !';

  @override
  String get achievementFirstGameTitle => 'Mon premier jeu';

  @override
  String get achievementFirstGameDescription =>
      'Tu as fait le premier pas de ton aventure de programmation !';

  @override
  String get achievementFirstGameCondition =>
      'Termine ton premier niveau dans un jeu.';

  @override
  String get achievementQuickStartTitle => 'Départ rapide';

  @override
  String get achievementQuickStartDescription =>
      'Les robots sont fiers de toi !';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Termine $goal niveaux dans un jeu.';
  }

  @override
  String get achievementDeterminedTitle => 'Joueur déterminé';

  @override
  String get achievementDeterminedDescription =>
      'Tu as continué sans jamais abandonner !';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Termine $goal niveaux dans un jeu.';
  }

  @override
  String get achievementMasterCoderTitle => 'Maître programmeur';

  @override
  String get achievementMasterCoderDescription =>
      'Tu as terminé tous les niveaux d’un jeu !';

  @override
  String get achievementMasterCoderCondition =>
      'Termine tous les niveaux d’un jeu.';

  @override
  String get achievementAllGamesTitle => 'Explorateur de jeux';

  @override
  String get achievementAllGamesDescription => 'Tu as essayé tous les jeux !';

  @override
  String get achievementAllGamesCondition =>
      'Termine au moins un niveau dans chaque jeu.';

  @override
  String get achievementStarHunterTitle => 'Chasseur d’étoiles';

  @override
  String get achievementStarHunterDescription =>
      'Tu as commencé à collectionner des étoiles !';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Gagne $goal étoiles au total.';
  }

  @override
  String get achievementStarMasterTitle => 'Maître des étoiles';

  @override
  String get achievementStarMasterDescription =>
      'Tu as autant d’étoiles que le ciel !';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Gagne $goal étoiles au total.';
  }

  @override
  String get achievementPerfectTitle => 'Joueur parfait';

  @override
  String get achievementPerfectDescription =>
      'Tu as terminé un niveau parfaitement !';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Termine un niveau avec $goal étoiles.';
  }

  @override
  String get achievementNoHintTitle => 'Héros sans indice';

  @override
  String get achievementNoHintDescription => 'Tu as tout résolu tout seul !';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Termine $goal niveaux sans utiliser d’indice.';
  }

  @override
  String get achievementBigSuccessTitle => 'Grand succès';

  @override
  String get achievementBigSuccessDescription =>
      'Tu as terminé tous les jeux du début à la fin !';

  @override
  String get achievementBigSuccessCondition =>
      'Termine tous les niveaux de tous les jeux.';

  @override
  String get achievementFirstAdventureTitle =>
      'Trophée de la première aventure';

  @override
  String get achievementFirstAdventureDescription =>
      'Tu as fait le premier pas dans tous les jeux !';

  @override
  String get achievementFirstAdventureCondition =>
      'Termine le premier niveau de chaque jeu.';

  @override
  String get achievementChampionTitle => 'Champion de la programmation';

  @override
  String get achievementChampionDescription =>
      'Tu es un vrai champion de la programmation !';

  @override
  String get achievementChampionCondition =>
      'Finis tous les niveaux de tous les jeux.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Termine « $game ».';
  }

  @override
  String get parentalGateTitle => 'Accord des parents';

  @override
  String parentalGateIntro(Object action) {
    return 'Cette action demande l’accord d’un adulte : $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Acheter un pack',
      'other': 'Action',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Écris la réponse en chiffres.';

  @override
  String get parentalGateCancel => 'Annuler';

  @override
  String get parentalGateConfirm => 'Confirmer';

  @override
  String get parentalGateAnswer => 'Réponse';

  @override
  String get parentalGateWrongAnswer =>
      'Mauvaise réponse. Attends un instant, puis réponds à la nouvelle question.';

  @override
  String parentalGateQuestion(String first, String second) {
    return 'Combien font $first fois $second ?';
  }

  @override
  String get parentalGateTrialLabel => 'Essayer le contrôle parental';

  @override
  String get parentalGateTrialHint =>
      'Affiché uniquement dans les versions de test. Aucun achat réel n’est effectué.';

  @override
  String get parentalGateTrialPassed =>
      'Contrôle réussi ; l’action d’essai a été exécutée.';

  @override
  String get parentalGateTrialBlocked =>
      'Contrôle échoué ; l’action n’a pas été exécutée.';

  @override
  String get storeTitle => 'Packs';

  @override
  String get storeIntro =>
      'Les achats se font via Google Play, et l’accord d’un parent est demandé avant chaque achat. Tu peux utiliser un code promo Google Play avec le lien « Utiliser un code » sur l’écran de paiement ou dans l’application Play Store ; un pack obtenu avec un code apparaît aussi ici comme acheté.';

  @override
  String get storePaidSection => 'Packs à acheter';

  @override
  String get storeFreeSection => 'Packs gratuits';

  @override
  String get storeNoProducts => 'Il n’y a aucun pack à acheter pour le moment.';

  @override
  String get storeBundle => 'Lot';

  @override
  String get storeOwned => 'Acheté';

  @override
  String get storeUnlocks => 'Débloqué à l’achat :';

  @override
  String get storePriceLoading => 'Récupération du prix sur Google Play…';

  @override
  String get storePriceUnavailable =>
      'Impossible de récupérer le prix sur Google Play.';

  @override
  String get storeNotInStore =>
      'Ce pack n’est pas sur Google Play pour le moment.';

  @override
  String get storeRetry => 'Réessayer';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Tu possèdes déjà une partie du contenu de ce pack. Google Play ne baisse pas le prix pour ce que tu possèdes déjà ; ce pack n’est donc pas vendu, pour que tu ne paies pas deux fois le même contenu. Packs manquants : $missing';
  }

  @override
  String get storeRestore => 'Restaurer les achats';

  @override
  String get storeRestoreHint =>
      'Relit les achats de ton compte Google Play ; la progression du jeu n’est pas effacée.';

  @override
  String storeRestored(Object count) {
    return 'Les achats ont été relus sur Google Play. Produits achetés : $count.';
  }

  @override
  String get storeRestoreOffline =>
      'Pas de connexion Internet ; les achats enregistrés sur cet appareil restent valables.';

  @override
  String get storeRestoreUnavailable =>
      'Impossible de se connecter à Google Play ; les achats enregistrés sur cet appareil restent valables.';

  @override
  String storeBuy(Object price) {
    return 'Acheter – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count niveaux',
      one: '1 niveau',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased => 'Achat terminé ; le pack est débloqué.';

  @override
  String get storePending =>
      'Le paiement est en attente. Le pack se débloquera tout seul une fois le paiement terminé.';

  @override
  String get storeCancelled => 'Achat annulé.';

  @override
  String get storeAlreadyOwned =>
      'Tu as déjà ce pack ; il n’a pas été racheté.';

  @override
  String get storeOffline =>
      'Pas de connexion Internet. Vérifie la connexion et réessaie.';

  @override
  String get storeUnavailable =>
      'Impossible de se connecter à Google Play. Réessaie plus tard.';

  @override
  String get storeFailed => 'L’achat n’a pas pu être terminé.';

  @override
  String get storeNotApproved =>
      'Les parents n’ont pas donné leur accord ; l’achat n’a pas commencé.';

  @override
  String get gameRobotRunning => 'Le robot est en route...';

  @override
  String get gameRobotReachedFlag => 'Bravo ! Le robot a atteint le drapeau !';

  @override
  String get gameMissingCoins =>
      'Tu as atteint le drapeau, mais tu n’as pas ramassé toutes les pièces. Ramasse d’abord les pièces.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Haut',
      'down': 'Bas',
      'left': 'Gauche',
      'other': 'Droite',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'un rocher',
      'water': 'l’eau',
      'other': 'le bord de la carte',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Choisis les ordres dans l’ordre pour amener le robot au drapeau.';

  @override
  String get pathFinderCoinIntro =>
      'Ramasse d’abord toutes les pièces, puis va au drapeau.';

  @override
  String get pathFinderEmpty => 'Ajoute d’abord un ordre de direction.';

  @override
  String get pathFinderFull =>
      'Tu as atteint la limite d’ordres. Tu peux effacer un ordre et en mettre un autre à sa place.';

  @override
  String get pathFinderMissedGoal =>
      'Le robot n’a pas atteint le drapeau. Essaie d’ajouter ou de changer des ordres.';

  @override
  String get pathFinderTooMany =>
      'Avec ces ordres, tu ne peux pas finir dans la limite. Essaie d’effacer les étapes inutiles.';

  @override
  String get pathFinderSolved =>
      'Tes ordres sont bons ! Touche le bouton vert Démarrer.';

  @override
  String get pathFinderEmptyStrip =>
      'Appuie sur les flèches et tes ordres s’aligneront ici.';

  @override
  String get pathFinderMoveLeft =>
      'Déplacer l’ordre choisi d’un pas vers la gauche';

  @override
  String get pathFinderMoveRight =>
      'Déplacer l’ordre choisi d’un pas vers la droite';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'Le robot a heurté $obstacle. Essaie de changer l’ordre $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'L’ordre $number fait sortir le robot du chemin. Je l’ai choisi pour toi ; tu peux l’effacer ou le déplacer.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Regarde la case qui brille. Ordre suivant : $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Ajouter l’ordre « $direction »';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Ordre $number : $direction';
  }

  @override
  String get commandOrderIntro =>
      'Mets les cartes dans le bon ordre pour finir la tâche. Touche une carte ou fais-la glisser dans une case.';

  @override
  String get commandOrderExtrasIntro =>
      'Attention ! Certaines cartes n’appartiennent pas à cette tâche. Range seulement les cartes utiles.';

  @override
  String get commandOrderFull =>
      'Toutes les cases sont pleines. Touche une carte pour la reprendre.';

  @override
  String get commandOrderNotFull => 'Remplis d’abord toutes les cases.';

  @override
  String get commandOrderSuccess =>
      'Bravo ! Toutes les étapes sont dans le bon ordre.';

  @override
  String get commandOrderSolved =>
      'L’ordre est bon ! Touche le bouton vert Vérifier.';

  @override
  String get commandOrderPoolEmpty => 'Toutes les cartes sont placées';

  @override
  String get commandOrderCheck => 'Vérifier';

  @override
  String commandOrderWrongExtra(Object card) {
    return '« $card » n’est pas utile pour cette tâche. Retire-la de la case.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return 'C’est trop tôt pour « $card » dans la case $number. Une autre étape doit venir avant.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint La carte qui brille, « $card », va dans la case $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Case $number : $card. Touche pour la reprendre.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Case $number, vide. Touche pour y mettre une carte.';
  }

  @override
  String get ifThenIncomplete => 'Remplis d’abord les cases vides.';

  @override
  String get ifThenSuccess =>
      'Bravo ! Le robot a suivi ses règles et a atteint le drapeau !';

  @override
  String get ifThenSolved =>
      'Tes règles sont bonnes ! Touche le bouton vert Démarrer.';

  @override
  String get ifThenNoSlot =>
      'Il n’y a pas de case vide pour ce bloc. Touche la case que tu veux changer pour la vider.';

  @override
  String get ifThenLockedSlot =>
      'Cette case était déjà remplie et ne peut pas être changée. Mets le bloc dans une case vide.';

  @override
  String get ifThenWrongType =>
      'Ce bloc ne va pas là. Les objets vont dans la case « Si », les mouvements à côté de la flèche.';

  @override
  String get ifThenLane => 'Le chemin du robot';

  @override
  String get ifThenObjects => 'Objets';

  @override
  String get ifThenActions => 'Mouvements';

  @override
  String get ifThenIf => 'Si';

  @override
  String get ifThenElseIf => 'Sinon si';

  @override
  String get ifThenElse => 'Sinon';

  @override
  String get ifThenThen => 'est devant';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Chemin vide',
      'rock': 'Rocher',
      'water': 'Eau',
      'door': 'Porte',
      'other': 'Étoile',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Avancer',
      'jump': 'Sauter',
      'bridge': 'Faire un pont',
      'open': 'Ouvrir la porte',
      'other': 'Ramasser',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'un chemin vide',
      'rock': 'un rocher',
      'water': 'de l’eau',
      'door': 'une porte',
      'other': 'une étoile',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Ce n’est pas utile sur un chemin vide.',
      'rock': 'On ne peut pas traverser un rocher.',
      'water': 'Le robot ne sait pas nager !',
      'door': 'On ne peut pas passer quand la porte est fermée.',
      'other': 'L’étoile est restée par terre.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Si le chemin est vide, le robot peut avancer.',
      'rock': 'On passe un rocher en sautant.',
      'water': 'Pour traverser l’eau, il faut faire un pont.',
      'door': 'Pour passer la porte, il faut d’abord l’ouvrir.',
      'other': 'Utilise le bloc Ramasser pour prendre l’étoile.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'La règle $number';
  }

  @override
  String get ifThenElseRule => 'La ligne « Sinon »';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Devant, il y avait $object. $rule s’est appliquée et le robot a fait « $action ». $problem Change les règles et réessaie.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'Sur la case qui brille, il y a $object. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Case condition',
      'other': 'Case mouvement',
    });
    return '$_temp0 : $value';
  }

  @override
  String get ifThenSlotEmpty => 'vide';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, déjà remplie';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Mouvement',
      'other': 'Objet',
    });
    return '$_temp0 : $label';
  }

  @override
  String get repeatIntro =>
      'Amène le robot au drapeau. Utilise le bloc Répéter au lieu d’ajouter le même mouvement encore et encore.';

  @override
  String get repeatCoinIntro =>
      'Ramasse d’abord toutes les pièces, puis va au drapeau. Le bloc Répéter rend ça plus facile.';

  @override
  String get repeatEmpty => 'Ajoute d’abord une flèche ou un bloc Répéter.';

  @override
  String get repeatFull =>
      'Tu as atteint la limite de blocs. Si tu es prêt, touche le bouton vert Démarrer ; pour changer quelque chose, choisis un bloc et efface-le.';

  @override
  String get repeatInsideRepeat =>
      'Les flèches que tu ajoutes maintenant iront dans le bloc orange. Quand tu as fini, touche le bouton bleu foncé Sortir du bloc.';

  @override
  String get repeatEmptyStrip =>
      'Ajoute une flèche ou un bloc Répéter et tes blocs s’aligneront ici.';

  @override
  String get repeatOutsideRepeat =>
      'Les flèches que tu ajoutes maintenant iront hors du bloc, à la fin.';

  @override
  String get repeatMovedOut =>
      'La flèche est sortie du bloc. Les flèches que tu ajoutes maintenant iront aussi dehors, à la fin.';

  @override
  String get repeatEmptyRepeat =>
      'Le bloc orange est vide. Je l’ai choisi ; ajoute maintenant une flèche dedans.';

  @override
  String get repeatMissedGoal =>
      'Le robot n’a pas atteint le drapeau. Essaie de changer le nombre de répétitions ou les flèches.';

  @override
  String get repeatSolved =>
      'Tes blocs sont bons ! Touche le bouton vert Démarrer.';

  @override
  String get repeatFullHint =>
      'Tu as atteint la limite de blocs. Essaie de changer un nombre de répétitions, ou efface un bloc et mets un bloc Répéter à sa place.';

  @override
  String get repeatAddRepeat => 'Répéter';

  @override
  String get repeatLeaveRepeat => 'Sortir du bloc ✓';

  @override
  String get repeatAddRepeatLabel => 'Ajouter un bloc Répéter';

  @override
  String get repeatLeaveRepeatLabel =>
      'Sortir du bloc ; les flèches suivantes iront dehors';

  @override
  String get repeatDropHere => 'Ajoute des flèches ici';

  @override
  String get repeatEmptyBody => 'Vide';

  @override
  String get repeatDecrease => 'Diminuer le nombre de répétitions';

  @override
  String get repeatIncrease => 'Augmenter le nombre de répétitions';

  @override
  String get repeatDeleteLabel => 'Effacer le bloc choisi';

  @override
  String get repeatMoveOutLabel => 'Sortir la flèche choisie du bloc orange';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times fois',
      one: '1 fois',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'répéter $times fois',
      one: 'répéter 1 fois',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Ajouter la flèche « $direction »';
  }

  @override
  String repeatArrowName(Object number) {
    return 'La flèche $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'Le bloc $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'La flèche $arrow du bloc $block';
  }

  @override
  String repeatMoveChip(Object name, Object direction) {
    return '$name : $direction';
  }

  @override
  String repeatBlockLabel(Object number, int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'répéter $times fois',
      one: 'répéter 1 fois',
    );
    return 'Bloc $number : $_temp0. Touche pour ajouter des flèches dedans.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Essaie de changer le nombre de répétitions du bloc $number ou les flèches qu’il contient.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place fait sortir le robot du chemin.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'Le robot a heurté $obstacle. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'Au tour $round, le robot a heurté $obstacle. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice J’ai marqué en rouge le mauvais endroit pour toi.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Regarde la case qui brille ; là, le robot doit aller vers « $direction ».';
  }

  @override
  String get repeatL1Intro =>
      'Le robot doit aller 3 fois à droite, mais tu ne peux utiliser que 2 blocs. Ajoute un bloc Répéter et mets la flèche droite dedans.';

  @override
  String get repeatL1Hint =>
      'Le bloc Répéter fait la flèche qu’il contient autant de fois que tu le dis. Combien de fois doit-il aller à droite ?';

  @override
  String get repeatL2Intro =>
      'Le drapeau est là-haut. Utilise le bloc Répéter au lieu d’ajouter la même flèche encore et encore.';

  @override
  String get repeatL2Hint =>
      'Le robot va toujours dans la même direction. Laquelle, et combien de fois ?';

  @override
  String get repeatL3Hint =>
      'Le robot descend. Compte les cases et règle le nombre de répétitions.';

  @override
  String get repeatL4Hint =>
      'Cette fois vers la gauche. Tu peux changer le nombre de répétitions avec les boutons − et +.';

  @override
  String get repeatL5Intro =>
      'Ramasse aussi les pièces sur le chemin ! Il n’y a toujours que 2 blocs.';

  @override
  String get repeatL5Hint =>
      'Les pièces sont entre le robot et le drapeau, sur la même ligne. Le robot va seulement à droite.';

  @override
  String get repeatL6Intro =>
      'Descends comme un escalier : droite, bas, droite, bas... Tu peux mettre deux flèches dans un bloc Répéter.';

  @override
  String get repeatL6Hint =>
      'Une marche : une fois à droite, une fois en bas. Combien y a-t-il de marches ?';

  @override
  String get repeatL7Hint =>
      'Deux fois à droite, une fois en haut. Combien de fois ce motif se répète-t-il ?';

  @override
  String get repeatL8Hint =>
      'D’abord deux à droite, puis une en bas. Répète ça.';

  @override
  String get repeatL9Intro =>
      'Tu peux aussi ajouter une seule flèche après le bloc Répéter.';

  @override
  String get repeatL9Hint =>
      'Répète le motif haut-gauche ; il te faudra peut-être un pas de plus à la fin.';

  @override
  String get repeatL10Hint =>
      'Chaque marche fait deux cases de large et une case de haut.';

  @override
  String get repeatL11Intro =>
      'Cette fois, il te faut deux blocs Répéter : un vers la droite, un vers le bas.';

  @override
  String get repeatL11Hint =>
      'Combien de cases à droite d’abord ? Puis combien vers le bas ? Utilise un bloc Répéter pour chacune.';

  @override
  String get repeatL12Hint =>
      'Monte d’abord, puis va à droite. Deux blocs Répéter, deux nombres différents.';

  @override
  String get repeatL13Hint =>
      'Contourne les rochers : droite, bas, gauche. Compte les cases pour chaque direction.';

  @override
  String get repeatL14Hint =>
      'Le chemin a trois parties : droite, bas, puis de nouveau droite.';

  @override
  String get repeatL15Hint =>
      'Les deux pièces sont aux coins du chemin. Fais chaque partie droite avec un bloc Répéter.';

  @override
  String get repeatL16Intro =>
      'Seulement 4 blocs ! Parcours le long chemin avec un motif court.';

  @override
  String get repeatL16Hint =>
      'Les pièces sont alignées en diagonale : regarde le motif droite-bas.';

  @override
  String get repeatL17Hint =>
      'Chaque marche fait deux cases de haut et deux cases de large.';

  @override
  String get repeatL18Hint =>
      'Deux à droite, deux en bas. Ce motif continue jusqu’au drapeau.';

  @override
  String get repeatL19Hint =>
      'Les pièces sont aux coins des marches. Une marche : deux à droite, une en bas.';

  @override
  String get repeatL20Intro =>
      'Un long chemin qui serpente. Utilise bien les 10 blocs.';

  @override
  String get repeatL20Hint =>
      'Le chemin est fait de cinq parties droites. Fais chaque partie avec un bloc Répéter.';

  @override
  String get bugHunterIntro =>
      'Il y a un bug dans ce code ! Touche d’abord Démarrer et regarde où le robot se trompe.';

  @override
  String get bugHunterSelected =>
      'Si tu as choisi une flèche, un bouton de direction la change. Tu peux effacer le bloc choisi ou ajouter une nouvelle flèche avant lui.';

  @override
  String get bugHunterPickInsert =>
      'Quelle flèche doit venir avant ? Touche un bouton de direction.';

  @override
  String get bugHunterInsertLabel => 'Ajouter une flèche avant le bloc choisi';

  @override
  String get bugHunterReset => 'Recommencer';

  @override
  String get bugHunterL1Intro =>
      'Le robot n’arrive pas au drapeau, il y a un bug dans le code ! Touche Démarrer et regarde le robot. Ensuite, touche la mauvaise flèche et appuie sur le bon bouton de direction.';

  @override
  String get bugHunterL1Hint =>
      'Le drapeau est tout droit à droite. Toutes les flèches doivent aller à droite.';

  @override
  String get bugHunterL2Hint =>
      'Le robot passe sous le rocher. La dernière flèche doit le faire monter jusqu’au drapeau.';

  @override
  String get bugHunterL3Intro =>
      'Il manque une flèche dans ce code. Où le robot s’est-il arrêté ? Ajoute la flèche qui manque.';

  @override
  String get bugHunterL3Hint =>
      'Le robot s’arrête avant le drapeau. Il lui faut encore un pas.';

  @override
  String get bugHunterL4Intro =>
      'Il y a une flèche en trop dans ce code. Choisis la flèche en trop et efface-la.';

  @override
  String get bugHunterL4Hint =>
      'Le robot fait encore un pas après avoir atteint le drapeau.';

  @override
  String get bugHunterL5Intro =>
      'Il manque une flèche, mais pas à la fin. Choisis une flèche, touche le bouton Ajouter avant, puis touche un bouton de direction.';

  @override
  String get bugHunterL5Hint =>
      'En passant sous le rocher, le robot doit aller deux fois à droite.';

  @override
  String get bugHunterL6Hint =>
      'Après avoir ramassé la pièce, le drapeau est en bas.';

  @override
  String get bugHunterL7Hint =>
      'Pour passer à côté de l’eau, va trois fois à droite sur la ligne du bas.';

  @override
  String get bugHunterL8Intro =>
      'Il y a deux bugs dans ce code ! Chaque fois que le robot est bloqué, répare un bug.';

  @override
  String get bugHunterL8Hint =>
      'Passe au-dessus des rochers : d’abord à droite, puis en bas.';

  @override
  String get bugHunterL9Hint =>
      'Après avoir ramassé les deux pièces, le robot doit s’arrêter sur le drapeau.';

  @override
  String get bugHunterL10Hint =>
      'Suis le chemin qui serpente entre les rochers. Une flèche est fausse et une autre manque.';

  @override
  String get bugHunterL11Intro =>
      'Cette fois, le bug est dans le bloc orange Répéter. Choisis la flèche à l’intérieur et change-la.';

  @override
  String get bugHunterL11Hint =>
      'La flèche du bloc Répéter doit aller vers le drapeau.';

  @override
  String get bugHunterL12Intro =>
      'Les flèches de ce code sont bonnes, mais le nombre de répétitions est faux. Change le nombre.';

  @override
  String get bugHunterL12Hint =>
      'Combien y a-t-il de marches ? Le nombre de répétitions doit être égal au nombre de marches.';

  @override
  String get bugHunterL13Hint => 'Chaque marche : deux à droite, une en haut.';

  @override
  String get bugHunterL14Hint =>
      'Chaque marche : deux à droite, une en bas. Il manque une flèche dans le bloc.';

  @override
  String get bugHunterL15Hint =>
      'Après le bloc Répéter, il ne reste qu’un seul pas.';

  @override
  String get bugHunterL16Intro =>
      'Chasseur expert ! Ces codes ont plus d’un bug. Trouves-en un à chaque fois que tu démarres.';

  @override
  String get bugHunterL16Hint =>
      'Combien de cases à droite d’abord ? Puis combien vers le bas ?';

  @override
  String get bugHunterL17Hint =>
      'Chaque répétition avance de deux cases à droite. Combien de répétitions faut-il pour atteindre le drapeau ?';

  @override
  String get bugHunterL18Hint =>
      'Les rochers sont au-dessus des marches. À chaque marche, va d’abord en bas, puis à droite.';

  @override
  String get bugHunterL19Hint =>
      'Il y a un escalier au milieu de l’eau : une fois à droite, une fois en bas. Combien y a-t-il de marches ?';

  @override
  String get bugHunterL20Hint =>
      'D’abord à droite, puis en bas. Compte les cases de chaque partie droite.';

  @override
  String get ifThenL1Intro =>
      'S’il y a un rocher devant, que doit faire le robot ? Mets un mouvement dans la case vide.';

  @override
  String get ifThenL2Intro =>
      'Le robot ne sait pas nager. S’il y a de l’eau devant, que doit-il faire ?';

  @override
  String get ifThenL3Intro =>
      'Il y a une porte fermée sur le chemin. Que doit faire le robot quand il arrive à la porte ?';

  @override
  String get ifThenL4Intro =>
      'Ne passe pas à côté des étoiles sans les ramasser ! S’il y a une étoile devant, que doit faire le robot ?';

  @override
  String get ifThenL5Intro =>
      'Cette fois, tu choisis aussi la condition. Qu’y a-t-il sur le chemin ?';

  @override
  String get ifThenL6Intro =>
      'S’il y a un rocher, fais une chose ; sinon, fais autre chose. Remplis les deux cases.';

  @override
  String get ifThenL7Intro =>
      'Que doit-il faire s’il y a de l’eau ? Et s’il n’y a pas d’eau ?';

  @override
  String get ifThenL8Intro =>
      'Il n’y a pas de case vide sur ce chemin ! S’il n’y a pas de porte, qu’y a-t-il devant ?';

  @override
  String get ifThenL9Intro => 'Choisis la condition et les deux mouvements.';

  @override
  String get ifThenL10Intro =>
      'Il y a des rochers et de l’eau sur le chemin. Une règle et un « Sinon » suffisent.';

  @override
  String get ifThenL11Intro =>
      'Il y a aussi des rochers et de l’eau. Fais une règle pour chacun.';

  @override
  String get ifThenL12Intro => 'Ouvre les portes et ramasse les étoiles.';

  @override
  String get ifThenL13Intro =>
      'Il y a trois choses différentes mais seulement deux lignes de règles. Utilise « Sinon » pour la troisième.';

  @override
  String get ifThenL14Intro =>
      'De l’eau, des portes et un chemin vide. Lequel laisseras-tu au « Sinon » ?';

  @override
  String get ifThenL15Intro =>
      'Attention : un des blocs n’est pas du tout sur ce chemin.';

  @override
  String get ifThenL16Intro =>
      'Le robot va vers le château : il y a des rochers, des douves et des portes de château.';

  @override
  String get ifThenL17Intro =>
      'Chemin du trésor : ramasse les étoiles et passe les obstacles.';

  @override
  String get ifThenL18Intro =>
      'Il n’y a pas de case vide sur ce chemin. Quatre choses demandent quatre décisions.';

  @override
  String get ifThenL19Intro =>
      'Un long voyage ! De l’eau, des rochers, des portes et un chemin vide.';

  @override
  String get ifThenL20Intro =>
      'Dernière tâche : ramasse toutes les étoiles et atteins le drapeau.';

  @override
  String get pathFinderL1Intro =>
      'Amène le robot au drapeau. Appuie sur la flèche droite, puis touche le bouton vert Démarrer.';

  @override
  String get pathFinderL2Intro =>
      'Le drapeau est au-dessus du robot. Quelle flèche dois-tu choisir ?';

  @override
  String get pathFinderL3Intro => 'Le drapeau est à gauche, à deux cases.';

  @override
  String get pathFinderL4Intro => 'Le robot doit descendre. Combien de fois ?';

  @override
  String get pathFinderL5Intro =>
      'Cette fois, tu vas utiliser deux directions différentes.';

  @override
  String get pathFinderL11Intro =>
      'Il y a un rocher sur le chemin. Contourne-le.';

  @override
  String get pathFinderL12Intro =>
      'Les rochers sont alignés comme un mur. Contourne-les par en dessous.';

  @override
  String get pathFinderL13Intro =>
      'Le robot ne peut pas aller dans l’eau. Trouve le chemin sec.';

  @override
  String get pathFinderL15Intro =>
      'Il y a plus d’un chemin. Trouveras-tu le plus court ?';

  @override
  String get commandOrderL1Title => 'Arroser la fleur';

  @override
  String get commandOrderL1Step1 => 'Remplir l’arrosoir';

  @override
  String get commandOrderL1Step2 => 'Arroser la fleur';

  @override
  String get commandOrderL1Hint =>
      'Pour arroser la fleur, il faut d’abord de l’eau dans l’arrosoir.';

  @override
  String get commandOrderL2Title => 'Se brosser les dents';

  @override
  String get commandOrderL2Step1 => 'Mettre du dentifrice sur la brosse';

  @override
  String get commandOrderL2Step2 => 'Se brosser les dents';

  @override
  String get commandOrderL2Step3 => 'Se rincer la bouche';

  @override
  String get commandOrderL2Hint =>
      'Avant de commencer à brosser, il faut du dentifrice sur la brosse.';

  @override
  String get commandOrderL3Title => 'Se laver les mains';

  @override
  String get commandOrderL3Step1 => 'Savonner ses mains';

  @override
  String get commandOrderL3Step2 => 'Rincer ses mains';

  @override
  String get commandOrderL3Step3 => 'Sécher ses mains';

  @override
  String get commandOrderL3Hint =>
      'Tu ne peux pas sécher tes mains avant que la mousse soit partie.';

  @override
  String get commandOrderL4Title => 'Mettre ses chaussures';

  @override
  String get commandOrderL4Step1 => 'Mettre ses chaussettes';

  @override
  String get commandOrderL4Step2 => 'Mettre ses chaussures';

  @override
  String get commandOrderL4Step3 => 'Faire ses lacets';

  @override
  String get commandOrderL4Hint =>
      'Que doit avoir ton pied avant d’entrer dans la chaussure ?';

  @override
  String get commandOrderL5Title => 'Faire un dessin';

  @override
  String get commandOrderL5Step1 => 'Prendre une feuille';

  @override
  String get commandOrderL5Step2 => 'Dessiner';

  @override
  String get commandOrderL5Step3 => 'Colorier le dessin';

  @override
  String get commandOrderL5Hint =>
      'Pour colorier, il te faut un dessin déjà fait.';

  @override
  String get commandOrderL6Title => 'Faire un sandwich';

  @override
  String get commandOrderL6Step1 => 'Mettre l’assiette sur la table';

  @override
  String get commandOrderL6Step2 => 'Mettre le pain dans l’assiette';

  @override
  String get commandOrderL6Step3 => 'Mettre du fromage dessus';

  @override
  String get commandOrderL6Step4 => 'Couvrir avec du pain';

  @override
  String get commandOrderL6Step5 => 'Bon appétit';

  @override
  String get commandOrderL6Hint =>
      'Il te faut un endroit pour poser le pain. Que doit-il y avoir d’abord sur la table ?';

  @override
  String get commandOrderL7Title => 'Ranger les jouets';

  @override
  String get commandOrderL7Step1 => 'Apporter la boîte';

  @override
  String get commandOrderL7Step2 => 'Mettre les jouets dans la boîte';

  @override
  String get commandOrderL7Step3 => 'Fermer le couvercle';

  @override
  String get commandOrderL7Step4 => 'Poser la boîte sur l’étagère';

  @override
  String get commandOrderL7Hint =>
      'Que fais-tu si la boîte à jouets n’est pas à côté de toi ?';

  @override
  String get commandOrderL8Title => 'Planter une graine';

  @override
  String get commandOrderL8Step1 => 'Creuser un trou dans la terre';

  @override
  String get commandOrderL8Step2 => 'Mettre la graine dans le trou';

  @override
  String get commandOrderL8Step3 => 'La couvrir de terre';

  @override
  String get commandOrderL8Step4 => 'Arroser la graine';

  @override
  String get commandOrderL8Step5 => 'Attendre la pousse';

  @override
  String get commandOrderL8Hint =>
      'Tu ne peux pas mettre la graine en terre sans trou.';

  @override
  String get commandOrderL9Title => 'Se préparer pour l’école';

  @override
  String get commandOrderL9Step1 => 'Se réveiller quand le réveil sonne';

  @override
  String get commandOrderL9Step2 => 'Mettre ses vêtements d’école';

  @override
  String get commandOrderL9Step3 => 'Mettre son sac à dos';

  @override
  String get commandOrderL9Step4 => 'Monter dans le bus scolaire';

  @override
  String get commandOrderL9Hint =>
      'Tu ne peux pas t’habiller avant de te réveiller. Que se passe-t-il d’abord le matin ?';

  @override
  String get commandOrderL10Title => 'Envoyer une lettre';

  @override
  String get commandOrderL10Step1 => 'Écrire la lettre';

  @override
  String get commandOrderL10Step2 => 'Mettre la lettre dans l’enveloppe';

  @override
  String get commandOrderL10Step3 => 'Fermer l’enveloppe';

  @override
  String get commandOrderL10Step4 => 'La mettre dans la boîte aux lettres';

  @override
  String get commandOrderL10Hint =>
      'Il faut une lettre à mettre dans l’enveloppe.';

  @override
  String get commandOrderL11Title => 'Faire un gâteau';

  @override
  String get commandOrderL11Stage1 => 'Préparer la pâte';

  @override
  String get commandOrderL11Stage2 => 'Cuire le gâteau';

  @override
  String get commandOrderL11Step1 => 'Mettre les ingrédients sur la table';

  @override
  String get commandOrderL11Step2 => 'Tout mélanger dans un bol';

  @override
  String get commandOrderL11Step3 => 'Verser la pâte dans le moule';

  @override
  String get commandOrderL11Step4 => 'Mettre le moule au four';

  @override
  String get commandOrderL11Step5 => 'Attendre qu’il cuise';

  @override
  String get commandOrderL11Step6 => 'Couper le gâteau';

  @override
  String get commandOrderL11Hint =>
      'Tu ne peux rien mettre au four avant que la pâte soit prête.';

  @override
  String get commandOrderL12Title => 'Prendre un bain';

  @override
  String get commandOrderL12Stage1 => 'Préparer le bain';

  @override
  String get commandOrderL12Stage2 => 'Se laver';

  @override
  String get commandOrderL12Stage3 => 'Se sécher';

  @override
  String get commandOrderL12Step1 => 'Remplir la baignoire d’eau';

  @override
  String get commandOrderL12Step2 => 'Entrer dans la baignoire';

  @override
  String get commandOrderL12Step3 => 'Se laver les cheveux';

  @override
  String get commandOrderL12Step4 => 'Rincer la mousse';

  @override
  String get commandOrderL12Step5 => 'Se sécher avec une serviette';

  @override
  String get commandOrderL12Hint =>
      'Si tu entres dans une baignoire vide, tu ne peux pas te laver.';

  @override
  String get commandOrderL13Title => 'Faire du vélo';

  @override
  String get commandOrderL13Stage1 => 'Se préparer';

  @override
  String get commandOrderL13Stage2 => 'Rouler';

  @override
  String get commandOrderL13Stage3 => 'Finir';

  @override
  String get commandOrderL13Step1 => 'Mettre son casque';

  @override
  String get commandOrderL13Step2 => 'Monter sur le vélo';

  @override
  String get commandOrderL13Step3 => 'Pédaler';

  @override
  String get commandOrderL13Step4 => 'Freiner';

  @override
  String get commandOrderL13Step5 => 'Descendre du vélo';

  @override
  String get commandOrderL13Hint =>
      'La sécurité d’abord. Que mets-tu avant de monter sur le vélo ?';

  @override
  String get commandOrderL14Title => 'Emprunter un livre';

  @override
  String get commandOrderL14Stage1 => 'À la bibliothèque';

  @override
  String get commandOrderL14Stage2 => 'À la maison';

  @override
  String get commandOrderL14Stage3 => 'Le rendre';

  @override
  String get commandOrderL14Step1 => 'Aller à la bibliothèque';

  @override
  String get commandOrderL14Step2 => 'Choisir un livre';

  @override
  String get commandOrderL14Step3 => 'Emprunter le livre';

  @override
  String get commandOrderL14Step4 => 'Rapporter le livre à la maison';

  @override
  String get commandOrderL14Step5 => 'Lire le livre';

  @override
  String get commandOrderL14Step6 => 'Rendre le livre';

  @override
  String get commandOrderL14Hint =>
      'Pour choisir un livre, tu dois d’abord aller là où sont les livres.';

  @override
  String get commandOrderL15Title => 'Monter une tente';

  @override
  String get commandOrderL15Stage1 => 'Préparer l’endroit';

  @override
  String get commandOrderL15Stage2 => 'Monter la tente';

  @override
  String get commandOrderL15Stage3 => 'Préparer l’intérieur';

  @override
  String get commandOrderL15Step1 => 'Trouver un endroit plat';

  @override
  String get commandOrderL15Step2 => 'Étaler la tente par terre';

  @override
  String get commandOrderL15Step3 => 'Mettre les arceaux';

  @override
  String get commandOrderL15Step4 => 'Lever la tente';

  @override
  String get commandOrderL15Step5 => 'La fixer avec des piquets';

  @override
  String get commandOrderL15Step6 => 'Mettre le sac de couchage dedans';

  @override
  String get commandOrderL15Step7 => 'Allumer sa lanterne';

  @override
  String get commandOrderL15Hint =>
      'Pour étaler la tente, tu dois d’abord trouver un bon endroit.';

  @override
  String get commandOrderL16Title => 'Faire une pizza';

  @override
  String get commandOrderL16Stage1 => 'La pâte';

  @override
  String get commandOrderL16Stage2 => 'La garniture';

  @override
  String get commandOrderL16Stage3 => 'La cuisson';

  @override
  String get commandOrderL16Step1 => 'Étaler la pâte';

  @override
  String get commandOrderL16Step2 => 'Étaler la sauce tomate';

  @override
  String get commandOrderL16Step3 => 'Ajouter du fromage';

  @override
  String get commandOrderL16Step4 => 'La mettre au four';

  @override
  String get commandOrderL16Step5 => 'Attendre qu’elle cuise';

  @override
  String get commandOrderL16Step6 => 'La couper en parts';

  @override
  String get commandOrderL16Extra1 => 'Allumer la télé';

  @override
  String get commandOrderL16Hint =>
      'Toutes les cartes n’appartiennent pas à cette tâche. As-tu besoin de la télé pour faire une pizza ?';

  @override
  String get commandOrderL17Title => 'Faire la lessive';

  @override
  String get commandOrderL17Stage1 => 'Préparer';

  @override
  String get commandOrderL17Stage2 => 'Laver';

  @override
  String get commandOrderL17Stage3 => 'Sécher';

  @override
  String get commandOrderL17Step1 => 'Ramasser le linge sale';

  @override
  String get commandOrderL17Step2 => 'Le mettre dans la machine';

  @override
  String get commandOrderL17Step3 => 'Ajouter la lessive';

  @override
  String get commandOrderL17Step4 => 'Lancer la machine';

  @override
  String get commandOrderL17Step5 => 'Étendre le linge';

  @override
  String get commandOrderL17Step6 => 'Le plier une fois sec';

  @override
  String get commandOrderL17Extra1 => 'Jouer au ballon';

  @override
  String get commandOrderL17Hint =>
      'Si le linge sale traîne partout, que dois-tu faire d’abord ?';

  @override
  String get commandOrderL18Title => 'Voyager en train';

  @override
  String get commandOrderL18Stage1 => 'À la gare';

  @override
  String get commandOrderL18Stage2 => 'Dans le train';

  @override
  String get commandOrderL18Stage3 => 'L’arrivée';

  @override
  String get commandOrderL18Step1 => 'Acheter un billet';

  @override
  String get commandOrderL18Step2 => 'Aller sur le quai';

  @override
  String get commandOrderL18Step3 => 'Attendre le train';

  @override
  String get commandOrderL18Step4 => 'Monter dans le train';

  @override
  String get commandOrderL18Step5 => 'S’asseoir à sa place';

  @override
  String get commandOrderL18Step6 => 'Descendre à son arrêt';

  @override
  String get commandOrderL18Extra1 => 'Monter dans l’avion';

  @override
  String get commandOrderL18Hint =>
      'De quoi as-tu besoin pour monter dans le train ?';

  @override
  String get commandOrderL19Title => 'Faire pousser un arbre';

  @override
  String get commandOrderL19Stage1 => 'Planter';

  @override
  String get commandOrderL19Stage2 => 'Prendre soin';

  @override
  String get commandOrderL19Stage3 => 'Grandir';

  @override
  String get commandOrderL19Step1 => 'Mettre de la terre dans le pot';

  @override
  String get commandOrderL19Step2 => 'Planter la graine';

  @override
  String get commandOrderL19Step3 => 'Arroser la graine';

  @override
  String get commandOrderL19Step4 => 'Mettre le pot au soleil';

  @override
  String get commandOrderL19Step5 => 'Attendre la pousse';

  @override
  String get commandOrderL19Step6 => 'Le planter dans le jardin';

  @override
  String get commandOrderL19Extra1 => 'Ouvrir un parapluie';

  @override
  String get commandOrderL19Extra2 => 'Mettre le pot dans le noir';

  @override
  String get commandOrderL19Hint =>
      'Les plantes ont besoin d’eau et de soleil pour grandir. Quelles cartes leur feraient du mal ?';

  @override
  String get commandOrderL20Title => 'Faire des biscuits et les partager';

  @override
  String get commandOrderL20Stage1 => 'Préparer';

  @override
  String get commandOrderL20Stage2 => 'Cuire';

  @override
  String get commandOrderL20Stage3 => 'Partager';

  @override
  String get commandOrderL20Step1 => 'Se laver les mains';

  @override
  String get commandOrderL20Step2 => 'Mélanger les ingrédients';

  @override
  String get commandOrderL20Step3 => 'Former la pâte';

  @override
  String get commandOrderL20Step4 => 'Les cuire au four';

  @override
  String get commandOrderL20Step5 => 'Les laisser refroidir';

  @override
  String get commandOrderL20Step6 => 'Les mettre dans une boîte';

  @override
  String get commandOrderL20Step7 => 'Les partager avec ses amis';

  @override
  String get commandOrderL20Extra1 => 'Conduire une petite voiture';

  @override
  String get commandOrderL20Extra2 => 'Aller dormir';

  @override
  String get commandOrderL20Hint =>
      'Avant de travailler dans la cuisine, il faut être propre.';
}
