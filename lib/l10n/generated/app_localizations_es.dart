// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Robi Programa';

  @override
  String get languageName => 'Español';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Programa';

  @override
  String get homeTagline => 'Juega • Aprende • Descubre';

  @override
  String get homeComingSoon => 'Muy pronto';

  @override
  String get homeLocked => 'Bloqueado';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels niveles';
  }

  @override
  String get homeChangeCharacter => 'Cambiar';

  @override
  String homeCharacterLabel(Object name) {
    return 'Tu personaje: $name. Toca para cambiarlo.';
  }

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonNextLevel => 'Siguiente nivel';

  @override
  String get commonBackToHome => 'Volver al inicio';

  @override
  String get commonBackToLevels => 'Volver a los niveles';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrellas',
      one: '1 estrella',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Empezar';

  @override
  String get commonHint => 'Pista';

  @override
  String get commonClear => 'Vaciar';

  @override
  String get commonDelete => 'Borrar';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Fácil',
      'medium': 'Medio',
      'hard': 'Difícil',
      'other': 'Experto',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Niveles básicos';

  @override
  String get playPreviousLevel => 'Nivel anterior';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, nivel $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Primero termina los niveles «$difficulty»';
  }

  @override
  String get playPreviewNote =>
      'Puedes probar gratis el primer nivel de cada dificultad. Los demás niveles se abren al comprarlos.';

  @override
  String get playLevelComplete => '¡Genial! Nivel completado.';

  @override
  String playLevel(Object level) {
    return 'Nivel $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Nivel $level, bloqueado';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Nivel $level, $stars';
  }

  @override
  String get playLocked => 'bloqueado';

  @override
  String get gamePathFinderTitle => 'Encuentra el camino del robot';

  @override
  String get gamePathFinderDescription =>
      'Lleva al robot a la meta con órdenes de dirección.';

  @override
  String get gamePathFinderTrophy => 'Maestro de robots';

  @override
  String get gamePathFinderTrophyDescription =>
      '¡Ahora el robot conoce todos los caminos!';

  @override
  String get gameCommandOrderTitle => 'Ordena los pasos';

  @override
  String get gameCommandOrderDescription =>
      'Pon los pasos en el orden correcto.';

  @override
  String get gameCommandOrderTrophy => 'Maestro de algoritmos';

  @override
  String get gameCommandOrderTrophyDescription =>
      '¡Eres el mejor ordenando pasos!';

  @override
  String get gameIfThenTitle => 'Si pasa esto, entonces';

  @override
  String get gameIfThenDescription =>
      'Elige la orden correcta para cada situación.';

  @override
  String get gameIfThenTrophy => 'Maestro de decisiones';

  @override
  String get gameIfThenTrophyDescription => '¡Siempre eliges bien!';

  @override
  String get gameRepeatTitle => 'Repítelo';

  @override
  String get gameRepeatDescription =>
      'Haz movimientos repetidos con un solo bloque.';

  @override
  String get gameRepeatTrophy => 'Maestro de bucles';

  @override
  String get gameRepeatTrophyDescription =>
      '¡Usas los bucles como un profesional!';

  @override
  String get gameBugHunterTitle => 'Cazador de errores';

  @override
  String get gameBugHunterDescription => 'Encuentra y arregla el código roto.';

  @override
  String get gameBugHunterTrophy => 'Maestro cazador de errores';

  @override
  String get gameBugHunterTrophyDescription =>
      '¡Encontraste hasta los errores más difíciles!';

  @override
  String get gameMyCommandTitle => 'Crea tu comando';

  @override
  String get gameMyCommandDescription =>
      'Haz tu propio comando con flechas y úsalo una y otra vez.';

  @override
  String get gameMyCommandTrophy => 'Arquitecto de comandos';

  @override
  String get gameMyCommandTrophyDescription =>
      '¡Resolviste los caminos más difíciles con tus propios comandos!';

  @override
  String get gameVariableBoxTitle => 'Caja de variables';

  @override
  String get gameVariableBoxDescription =>
      'Mete un número en la caja y el robot dará esos pasos.';

  @override
  String get gameVariableBoxTrophy => 'Maestro de las variables';

  @override
  String get gameVariableBoxTrophyDescription =>
      '¡Acortaste los caminos más largos con el número de la caja!';

  @override
  String get gamePatternPuzzleTitle => 'Puzzle de patrones';

  @override
  String get gamePatternPuzzleDescription =>
      'Descubre el patrón que se repite y completa las lámparas que faltan.';

  @override
  String get gamePatternPuzzleTrophy => 'Maestro de patrones';

  @override
  String get gamePatternPuzzleTrophyDescription =>
      '¡Resolviste todos los patrones y encendiste las lámparas con los colores correctos!';

  @override
  String get characterTitle => 'Elige tu personaje';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Hélice',
      'isil': 'Brillo',
      'kahraman': 'Héroe',
      'pembe': 'Rosita',
      'sovalye': 'Caballero',
      'piril': 'Chispa',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Mis logros';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¡Has ganado $count premios!',
      one: '¡Has ganado 1 premio!',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Insignias';

  @override
  String get achievementsBadgesSubtitle => 'Pequeños logros';

  @override
  String get achievementsBadgesEarned => 'Insignias que ganaste';

  @override
  String get achievementsBadgesLocked => 'Insignias por ganar';

  @override
  String get achievementsBadgesEmpty =>
      'Aún no tienes insignias. ¡Termina tu primer nivel!';

  @override
  String get achievementsTrophies => 'Trofeos';

  @override
  String get achievementsTrophiesSubtitle => 'Grandes metas';

  @override
  String get achievementsTrophiesEarned => 'Trofeos que ganaste';

  @override
  String get achievementsTrophiesLocked => 'Trofeos bloqueados';

  @override
  String get achievementsTrophiesEmpty =>
      'Aún no tienes trofeos. ¡Sigue adelante hacia las grandes metas!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'Mis logros: $earned/$total';
  }

  @override
  String get achievementEarned => '¡Conseguido!';

  @override
  String get achievementCondition => 'Cómo conseguirlo: ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, conseguido';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, bloqueado';
  }

  @override
  String get achievementNewBadge => '¡Nueva insignia!';

  @override
  String get achievementNewTrophy => '¡Has ganado un trofeo nuevo!';

  @override
  String get achievementGreat => '¡Genial!';

  @override
  String get achievementFirstGameTitle => 'Mi primer juego';

  @override
  String get achievementFirstGameDescription =>
      '¡Diste el primer paso de tu aventura de programación!';

  @override
  String get achievementFirstGameCondition =>
      'Completa tu primer nivel de un juego.';

  @override
  String get achievementQuickStartTitle => 'Inicio rápido';

  @override
  String get achievementQuickStartDescription =>
      '¡Los robots están orgullosos de ti!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Completa $goal niveles en un juego.';
  }

  @override
  String get achievementDeterminedTitle => 'Jugador decidido';

  @override
  String get achievementDeterminedDescription =>
      '¡Seguiste adelante y nunca te rendiste!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Completa $goal niveles en un juego.';
  }

  @override
  String get achievementMasterCoderTitle => 'Maestro programador';

  @override
  String get achievementMasterCoderDescription =>
      '¡Terminaste todos los niveles de un juego!';

  @override
  String get achievementMasterCoderCondition =>
      'Completa todos los niveles de un juego.';

  @override
  String get achievementAllGamesTitle => 'Explorador de juegos';

  @override
  String get achievementAllGamesDescription => '¡Probaste todos los juegos!';

  @override
  String get achievementAllGamesCondition =>
      'Termina al menos un nivel en cada juego.';

  @override
  String get achievementStarHunterTitle => 'Cazador de estrellas';

  @override
  String get achievementStarHunterDescription =>
      '¡Empezaste a coleccionar estrellas!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Consigue $goal estrellas en total.';
  }

  @override
  String get achievementStarMasterTitle => 'Maestro de estrellas';

  @override
  String get achievementStarMasterDescription =>
      '¡Tienes tantas estrellas como el cielo!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Consigue $goal estrellas en total.';
  }

  @override
  String get achievementPerfectTitle => 'Jugador perfecto';

  @override
  String get achievementPerfectDescription =>
      '¡Terminaste un nivel a la perfección!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Completa un nivel con $goal estrellas.';
  }

  @override
  String get achievementNoHintTitle => 'Héroe sin pistas';

  @override
  String get achievementNoHintDescription => '¡Lo resolviste todo tú solo!';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Completa $goal niveles sin usar ninguna pista.';
  }

  @override
  String get achievementBigSuccessTitle => 'Gran éxito';

  @override
  String get achievementBigSuccessDescription =>
      '¡Terminaste todos los juegos de principio a fin!';

  @override
  String get achievementBigSuccessCondition =>
      'Completa todos los niveles de todos los juegos.';

  @override
  String get achievementFirstAdventureTitle => 'Trofeo de la primera aventura';

  @override
  String get achievementFirstAdventureDescription =>
      '¡Diste el primer paso en todos los juegos!';

  @override
  String get achievementFirstAdventureCondition =>
      'Completa el primer nivel de cada juego.';

  @override
  String get achievementChampionTitle => 'Campeón de programación';

  @override
  String get achievementChampionDescription =>
      '¡Eres un auténtico campeón de la programación!';

  @override
  String get achievementChampionCondition =>
      'Termina todos los niveles de todos los juegos.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Termina «$game».';
  }

  @override
  String get parentalGateTitle => 'Permiso de los padres';

  @override
  String parentalGateIntro(Object action) {
    return 'Esta acción necesita el permiso de un adulto: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Comprar un paquete',
      'other': 'Acción',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Escribe la respuesta en números.';

  @override
  String get parentalGateCancel => 'Cancelar';

  @override
  String get parentalGateConfirm => 'Confirmar';

  @override
  String get parentalGateAnswer => 'Respuesta';

  @override
  String get parentalGateWrongAnswer =>
      'Respuesta incorrecta. Espera un momento y responde a la nueva pregunta.';

  @override
  String parentalGateQuestion(String first, String second) {
    return '¿Cuánto es $first por $second?';
  }

  @override
  String get storeTitle => 'Tienda';

  @override
  String get storeIntro =>
      'Las compras se hacen a través de Google Play y antes de cada compra se pide el permiso de un padre o una madre. Puedes canjear un código promocional de Google Play con el enlace «Canjear código» de la pantalla de pago o en la app Play Store; un paquete canjeado con un código también aparece aquí como comprado.';

  @override
  String get storePaidSection => 'Paquetes para comprar';

  @override
  String get storeFreeSection => 'Paquetes gratis';

  @override
  String get storeNoProducts => 'Ahora mismo no hay paquetes para comprar.';

  @override
  String get storeBundle => 'Lote';

  @override
  String get storeStarterBundleTitle => 'Pack de inicio';

  @override
  String get storeAdvancedBundleTitle => 'Pack avanzado';

  @override
  String get storeFourGameBundleTitle => 'Pack de cuatro';

  @override
  String get storeOwned => 'Comprado';

  @override
  String get storeUnlocks => 'Se desbloquea al comprarlo:';

  @override
  String get storePriceLoading => 'Obteniendo el precio de Google Play…';

  @override
  String get storePriceUnavailable =>
      'No se pudo obtener el precio de Google Play.';

  @override
  String get storeNotInStore =>
      'Este paquete no está en Google Play ahora mismo.';

  @override
  String get storeRetry => 'Reintentar';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Ya tienes parte del contenido de este paquete. Google Play no baja el precio por lo que ya tienes, así que este paquete no se vende para que no pagues dos veces por el mismo contenido. Paquetes que faltan: $missing';
  }

  @override
  String get storeRestore => 'Restaurar compras';

  @override
  String get storeRestoreHint =>
      'Vuelve a leer las compras de tu cuenta de Google Play; el progreso del juego no se borra.';

  @override
  String storeRestored(Object count) {
    return 'Las compras se volvieron a leer de Google Play. Productos comprados: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'No hay conexión a internet; los registros de compra de este dispositivo siguen siendo válidos.';

  @override
  String get storeRestoreUnavailable =>
      'No se pudo conectar con Google Play; los registros de compra de este dispositivo siguen siendo válidos.';

  @override
  String storeBuy(Object price) {
    return 'Comprar – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count niveles',
      one: '1 nivel',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased =>
      'Compra completada; el paquete está desbloqueado.';

  @override
  String get storePending =>
      'El pago está pendiente. El paquete se desbloqueará solo cuando se complete el pago.';

  @override
  String get storeCancelled => 'Compra cancelada.';

  @override
  String get storeAlreadyOwned =>
      'Ya tienes este paquete; no se ha vuelto a comprar.';

  @override
  String get storeBundlePartiallyOwned =>
      'Ya tienes parte del contenido de este paquete, así que no se inició la compra para que no pagues dos veces por el mismo contenido.';

  @override
  String get storeOffline =>
      'No hay conexión a internet. Revisa la conexión y vuelve a intentarlo.';

  @override
  String get storeUnavailable =>
      'No se pudo conectar con Google Play. Inténtalo de nuevo más tarde.';

  @override
  String get storeFailed => 'No se pudo completar la compra.';

  @override
  String get storeNotApproved =>
      'No se dio el permiso de los padres; la compra no se inició.';

  @override
  String get gameRobotRunning => 'El robot está en camino...';

  @override
  String get gameRobotReachedFlag => '¡Genial! ¡El robot llegó a la bandera!';

  @override
  String get gameMissingCoins =>
      'Llegaste a la bandera, pero no recogiste todas las monedas. Recoge primero las monedas.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Arriba',
      'down': 'Abajo',
      'left': 'Izquierda',
      'other': 'Derecha',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'una roca',
      'water': 'el agua',
      'other': 'el borde del mapa',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Elige las órdenes en orden para llevar al robot a la bandera.';

  @override
  String get pathFinderCoinIntro =>
      'Recoge primero todas las monedas y luego ve a la bandera.';

  @override
  String get pathFinderEmpty => 'Primero añade una orden de dirección.';

  @override
  String get pathFinderFull =>
      'Llegaste al límite de órdenes. Puedes borrar una orden y poner otra en su lugar.';

  @override
  String get pathFinderMissedGoal =>
      'El robot no llegó a la bandera. Prueba a añadir o cambiar órdenes.';

  @override
  String get pathFinderTooMany =>
      'Con estas órdenes no puedes terminar dentro del límite. Prueba a borrar los pasos que no necesitas.';

  @override
  String get pathFinderSolved =>
      '¡Tus órdenes son correctas! Toca el botón verde Empezar.';

  @override
  String get pathFinderEmptyStrip =>
      'Pulsa los botones de flecha y tus órdenes se pondrán en fila aquí.';

  @override
  String get pathFinderMoveLeft =>
      'Mover la orden seleccionada un paso a la izquierda';

  @override
  String get pathFinderMoveRight =>
      'Mover la orden seleccionada un paso a la derecha';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'El robot chocó con $obstacle. Prueba a cambiar la orden $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'La orden $number saca al robot del camino. La he seleccionado por ti; puedes borrarla o moverla.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Mira la casilla que brilla. Siguiente orden: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Añadir la orden «$direction»';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Orden $number: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Pon las tarjetas en el orden correcto para terminar la tarea. Toca una tarjeta o arrástrala a una casilla.';

  @override
  String get commandOrderExtrasIntro =>
      '¡Cuidado! Algunas tarjetas no son de esta tarea. Ordena solo las tarjetas que necesitas.';

  @override
  String get commandOrderFull =>
      'Todas las casillas están llenas. Toca una tarjeta para quitarla.';

  @override
  String get commandOrderNotFull => 'Primero llena todas las casillas.';

  @override
  String get commandOrderSuccess =>
      '¡Genial! Todos los pasos están en el orden correcto.';

  @override
  String get commandOrderSolved =>
      '¡El orden es correcto! Toca el botón verde Comprobar.';

  @override
  String get commandOrderPoolEmpty => 'Todas las tarjetas están colocadas';

  @override
  String get commandOrderCheck => 'Comprobar';

  @override
  String commandOrderWrongExtra(Object card) {
    return '«$card» no hace falta para esta tarea. Sácala de la casilla.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return 'Es demasiado pronto para «$card» en la casilla $number. Antes tiene que ir otro paso.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint La tarjeta que brilla, «$card», va en la casilla $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Casilla $number: $card. Toca para quitarla.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Casilla $number, vacía. Toca para poner una tarjeta aquí.';
  }

  @override
  String get ifThenIncomplete => 'Primero llena las casillas vacías.';

  @override
  String get ifThenSuccess =>
      '¡Genial! ¡El robot siguió sus reglas y llegó a la bandera!';

  @override
  String get ifThenSolved =>
      '¡Tus reglas son correctas! Toca el botón verde Empezar.';

  @override
  String get ifThenNoSlot =>
      'No hay ninguna casilla vacía para este bloque. Toca la casilla que quieras cambiar para vaciarla.';

  @override
  String get ifThenLockedSlot =>
      'Esta casilla venía preparada y no se puede cambiar. Pon el bloque en una casilla vacía.';

  @override
  String get ifThenWrongType =>
      'Este bloque no encaja ahí. Las cosas van en la casilla «Si» y los movimientos, junto a la flecha.';

  @override
  String get ifThenLane => 'El camino del robot';

  @override
  String get ifThenObjects => 'Cosas';

  @override
  String get ifThenActions => 'Movimientos';

  @override
  String get ifThenIf => 'Si';

  @override
  String get ifThenElseIf => 'Si no, si';

  @override
  String get ifThenElse => 'Si no';

  @override
  String get ifThenThen => 'está delante';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Camino vacío',
      'rock': 'Roca',
      'water': 'Agua',
      'door': 'Puerta',
      'other': 'Estrella',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Avanzar',
      'jump': 'Saltar',
      'bridge': 'Hacer puente',
      'open': 'Abrir puerta',
      'other': 'Recoger',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'un camino vacío',
      'rock': 'una roca',
      'water': 'agua',
      'door': 'una puerta',
      'other': 'una estrella',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'En un camino vacío no hace falta.',
      'rock': 'No se puede atravesar una roca.',
      'water': '¡El robot no sabe nadar!',
      'door': 'No se puede pasar con la puerta cerrada.',
      'other': 'La estrella se quedó en el suelo.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Si el camino está vacío, el robot puede avanzar.',
      'rock': 'Una roca se pasa saltando.',
      'water': 'Para cruzar el agua, hay que hacer un puente.',
      'door': 'Para pasar la puerta, primero hay que abrirla.',
      'other': 'Usa el bloque Recoger para tomar la estrella.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'La regla $number';
  }

  @override
  String get ifThenElseRule => 'La fila «Si no»';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Delante había $object. Se aplicó $rule y el robot hizo «$action». $problem Cambia las reglas y vuelve a intentarlo.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'En la casilla que brilla hay $object. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Casilla de condición',
      'other': 'Casilla de movimiento',
    });
    return '$_temp0: $value';
  }

  @override
  String get ifThenSlotEmpty => 'vacía';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, preparada';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Movimiento',
      'other': 'Cosa',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Lleva al robot a la bandera. Usa el bloque Repetir en lugar de añadir el mismo movimiento una y otra vez.';

  @override
  String get repeatCoinIntro =>
      'Recoge primero todas las monedas y luego ve a la bandera. El bloque Repetir lo hace más fácil.';

  @override
  String get repeatEmpty => 'Primero añade una flecha o un bloque Repetir.';

  @override
  String get repeatFull =>
      'Llegaste al límite de bloques. Si estás listo, toca el botón verde Empezar; para cambiar algo, selecciona un bloque y bórralo.';

  @override
  String get repeatInsideRepeat =>
      'Las flechas que añadas ahora irán dentro del bloque naranja. Cuando termines, toca el botón azul oscuro Salir del bloque.';

  @override
  String get repeatEmptyStrip =>
      'Añade una flecha o un bloque Repetir y tus bloques se pondrán en fila aquí.';

  @override
  String get repeatOutsideRepeat =>
      'Las flechas que añadas ahora irán fuera del bloque, al final.';

  @override
  String get repeatMovedOut =>
      'La flecha salió del bloque. Las flechas que añadas ahora también irán fuera, al final.';

  @override
  String get repeatEmptyRepeat =>
      'El bloque naranja está vacío. Lo he seleccionado; ahora añade una flecha dentro.';

  @override
  String get repeatMissedGoal =>
      'El robot no llegó a la bandera. Prueba a cambiar el número de repeticiones o las flechas.';

  @override
  String get repeatSolved =>
      '¡Tus bloques son correctos! Toca el botón verde Empezar.';

  @override
  String get repeatFullHint =>
      'Llegaste al límite de bloques. Prueba a cambiar un número de repeticiones, o borra un bloque y pon un bloque Repetir en su lugar.';

  @override
  String get repeatAddRepeat => 'Repetir';

  @override
  String get repeatLeaveRepeat => 'Salir del bloque ✓';

  @override
  String get repeatAddRepeatLabel => 'Añadir un bloque Repetir';

  @override
  String get repeatLeaveRepeatLabel =>
      'Salir del bloque; las siguientes flechas irán fuera';

  @override
  String get repeatDropHere => 'Añade flechas aquí';

  @override
  String get repeatEmptyBody => 'Vacío';

  @override
  String get repeatDecrease => 'Bajar el número de repeticiones';

  @override
  String get repeatIncrease => 'Subir el número de repeticiones';

  @override
  String get repeatDeleteLabel => 'Borrar el bloque seleccionado';

  @override
  String get repeatMoveOutLabel =>
      'Sacar la flecha seleccionada del bloque naranja';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times veces',
      one: '1 vez',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'repetir $times veces',
      one: 'repetir 1 vez',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Añadir la flecha «$direction»';
  }

  @override
  String repeatArrowName(Object number) {
    return 'La flecha $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'El bloque $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'La flecha $arrow dentro del bloque $block';
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
      other: 'repetir $times veces',
      one: 'repetir 1 vez',
    );
    return 'Bloque $number: $_temp0. Toca para añadir flechas dentro.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Prueba a cambiar el número de repeticiones del bloque $number o las flechas que tiene dentro.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place saca al robot del camino.';
  }

  @override
  String repeatExtraBlock(Object place) {
    return '$place sobra. Prueba a borrar esa pieza.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'El robot chocó con $obstacle. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'En la vuelta $round, el robot chocó con $obstacle. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice Te he marcado en rojo el lugar equivocado.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Mira la casilla que brilla; allí el robot debe ir hacia «$direction».';
  }

  @override
  String get repeatL1Intro =>
      'El robot tiene que ir 3 veces a la derecha, pero solo puedes usar 2 bloques. Añade un bloque Repetir y pon dentro la flecha a la derecha.';

  @override
  String get repeatL1Hint =>
      'El bloque Repetir hace la flecha de dentro tantas veces como digas. ¿Cuántas veces tiene que ir a la derecha?';

  @override
  String get repeatL2Intro =>
      'La bandera está allí arriba. Usa el bloque Repetir en lugar de añadir la misma flecha una y otra vez.';

  @override
  String get repeatL2Hint =>
      'El robot va siempre en la misma dirección. ¿Hacia dónde y cuántas veces?';

  @override
  String get repeatL3Hint =>
      'El robot va hacia abajo. Cuenta las casillas y elige el número de repeticiones.';

  @override
  String get repeatL4Hint =>
      'Esta vez hacia la izquierda. Puedes cambiar el número de repeticiones con los botones − y +.';

  @override
  String get repeatL5Intro =>
      '¡Recoge también las monedas del camino! Sigue habiendo solo 2 bloques.';

  @override
  String get repeatL5Hint =>
      'Las monedas están entre el robot y la bandera, en la misma fila. El robot solo va a la derecha.';

  @override
  String get repeatL6Intro =>
      'Baja como por una escalera: derecha, abajo, derecha, abajo... Puedes poner dos flechas dentro de un bloque Repetir.';

  @override
  String get repeatL6Hint =>
      'Un escalón: una vez a la derecha y una vez abajo. ¿Cuántos escalones hay?';

  @override
  String get repeatL7Hint =>
      'Dos veces a la derecha y una arriba. ¿Cuántas veces se repite este patrón?';

  @override
  String get repeatL8Hint =>
      'Primero dos a la derecha y luego una abajo. Repítelo.';

  @override
  String get repeatL9Intro =>
      'También puedes añadir una sola flecha después del bloque Repetir.';

  @override
  String get repeatL9Hint =>
      'Repite el patrón arriba-izquierda; puede que necesites un paso más al final.';

  @override
  String get repeatL10Hint =>
      'Cada escalón mide dos casillas de ancho y una de alto.';

  @override
  String get repeatL11Intro =>
      'Esta vez necesitas dos bloques Repetir: uno a la derecha y otro hacia abajo.';

  @override
  String get repeatL11Hint =>
      '¿Cuántas casillas a la derecha primero? ¿Y luego cuántas hacia abajo? Usa un bloque Repetir para cada una.';

  @override
  String get repeatL12Hint =>
      'Primero sube y luego ve a la derecha. Dos bloques Repetir, dos números distintos.';

  @override
  String get repeatL13Hint =>
      'Rodea las rocas: derecha, abajo, izquierda. Cuenta las casillas de cada dirección.';

  @override
  String get repeatL14Hint =>
      'El camino tiene tres partes: derecha, abajo y otra vez derecha.';

  @override
  String get repeatL15Hint =>
      'Las dos monedas están en las esquinas del camino. Haz cada tramo recto con un bloque Repetir.';

  @override
  String get repeatL16Intro =>
      '¡Solo 4 bloques! Recorre el camino largo con un patrón corto.';

  @override
  String get repeatL16Hint =>
      'Las monedas están en diagonal: fíjate en el patrón derecha-abajo.';

  @override
  String get repeatL17Hint =>
      'Cada escalón mide dos casillas de alto y dos de ancho.';

  @override
  String get repeatL18Hint =>
      'Dos a la derecha, dos abajo. Este patrón sigue hasta la bandera.';

  @override
  String get repeatL19Hint =>
      'Las monedas están en las esquinas de los escalones. Un escalón: dos a la derecha y una abajo.';

  @override
  String get repeatL20Intro =>
      'Un camino largo que serpentea. Usa bien los 10 bloques.';

  @override
  String get repeatL20Hint =>
      'El camino tiene cinco tramos rectos. Haz cada tramo con un bloque Repetir.';

  @override
  String get bugHunterIntro =>
      '¡Este código tiene un error! Primero toca Empezar y mira dónde se confunde el robot.';

  @override
  String get bugHunterSelected =>
      'Si seleccionaste una flecha, un botón de dirección la cambia. Puedes borrar el bloque seleccionado o añadir una flecha nueva delante.';

  @override
  String get bugHunterPickInsert =>
      '¿Qué flecha va delante? Toca un botón de dirección.';

  @override
  String get bugHunterInsertLabel =>
      'Añadir una flecha delante del bloque seleccionado';

  @override
  String get bugHunterReset => 'Empezar de nuevo';

  @override
  String get bugHunterL1Intro =>
      'El robot no llega a la bandera: ¡hay un error en el código! Toca Empezar y mira al robot. Luego toca la flecha equivocada y pulsa el botón de dirección correcto.';

  @override
  String get bugHunterL1Hint =>
      'La bandera está justo a la derecha. Todas las flechas deben ir a la derecha.';

  @override
  String get bugHunterL2Hint =>
      'El robot rodea la roca por debajo. La última flecha debe subirlo hasta la bandera.';

  @override
  String get bugHunterL3Intro =>
      'A este código le falta una flecha. ¿Dónde se paró el robot? Añade la flecha que falta.';

  @override
  String get bugHunterL3Hint =>
      'El robot se para antes de la bandera. Necesita un paso más.';

  @override
  String get bugHunterL4Intro =>
      'Este código tiene una flecha de más. Selecciona la flecha que sobra y bórrala.';

  @override
  String get bugHunterL4Hint =>
      'El robot da un paso más después de llegar a la bandera.';

  @override
  String get bugHunterL5Intro =>
      'Falta una flecha, pero no al final. Selecciona una flecha, toca el botón Añadir delante y luego toca un botón de dirección.';

  @override
  String get bugHunterL5Hint =>
      'Al pasar por debajo de la roca, el robot debe ir dos veces a la derecha.';

  @override
  String get bugHunterL6Hint =>
      'Después de recoger la moneda, la bandera está abajo.';

  @override
  String get bugHunterL7Hint =>
      'Para pasar junto al agua, ve tres veces a la derecha por la fila de abajo.';

  @override
  String get bugHunterL8Intro =>
      '¡Este código tiene dos errores! Cada vez que el robot se atasque, arregla uno.';

  @override
  String get bugHunterL8Hint =>
      'Pasa por encima de las rocas: primero a la derecha y luego abajo.';

  @override
  String get bugHunterL9Hint =>
      'Después de recoger las dos monedas, el robot debe pararse en la bandera.';

  @override
  String get bugHunterL10Hint =>
      'Sigue el camino que serpentea entre las rocas. Una flecha está mal y falta otra.';

  @override
  String get bugHunterL11Intro =>
      'Esta vez el error está dentro del bloque naranja Repetir. Selecciona la flecha de dentro y cámbiala.';

  @override
  String get bugHunterL11Hint =>
      'La flecha del bloque Repetir debe ir hacia la bandera.';

  @override
  String get bugHunterL12Intro =>
      'Las flechas de este código están bien, pero el número de repeticiones no. Cambia el número.';

  @override
  String get bugHunterL12Hint =>
      '¿Cuántos escalones hay? El número de repeticiones debe ser igual al número de escalones.';

  @override
  String get bugHunterL13Hint => 'Cada escalón: dos a la derecha y una arriba.';

  @override
  String get bugHunterL14Hint =>
      'Cada escalón: dos a la derecha y una abajo. Falta una flecha dentro del bloque.';

  @override
  String get bugHunterL15Hint =>
      'Después del bloque Repetir solo queda un paso.';

  @override
  String get bugHunterL16Intro =>
      '¡Cazador experto! Estos códigos tienen más de un error. Encuentra uno cada vez que lo pongas en marcha.';

  @override
  String get bugHunterL16Hint =>
      '¿Cuántas casillas a la derecha primero? ¿Y luego cuántas hacia abajo?';

  @override
  String get bugHunterL17Hint =>
      'Cada repetición va dos casillas a la derecha. ¿Cuántas repeticiones hacen falta para llegar a la bandera?';

  @override
  String get bugHunterL18Hint =>
      'Las rocas están encima de los escalones. En cada escalón, ve primero abajo y luego a la derecha.';

  @override
  String get bugHunterL19Hint =>
      'Entre el agua hay una escalera: una a la derecha y una abajo. ¿Cuántos escalones hay?';

  @override
  String get bugHunterL20Hint =>
      'Primero a la derecha y luego abajo. Cuenta las casillas de cada tramo recto.';

  @override
  String get myCommandIntro =>
      'Haz tu propio comando con flechas en la franja turquesa de arriba. Luego usa el bloque Comando en el programa principal de abajo; cada bloque Comando hace todas las flechas del comando.';

  @override
  String get myCommandCommandEmpty => 'Haz tu comando: añade una flecha aquí.';

  @override
  String get myCommandMainEmpty =>
      'Programa principal: añade un bloque Comando y flechas.';

  @override
  String get myCommandButton => 'Comando';

  @override
  String get myCommandButtonLabel =>
      'Añadir un bloque Comando al programa principal';

  @override
  String myCommandCallLabel(Object number) {
    return 'Bloque $number: comando';
  }

  @override
  String get myCommandEmptyCommand =>
      'Tu comando está vacío. Toca la franja turquesa de arriba y añade flechas.';

  @override
  String get myCommandEmptyMain =>
      'El programa principal está vacío. Añade el bloque Comando con el botón turquesa Comando.';

  @override
  String get myCommandEditCommand =>
      'Las flechas que añadas ahora entrarán en el comando.';

  @override
  String get myCommandEditMain =>
      'Los bloques que añadas ahora entrarán en el programa principal.';

  @override
  String get myCommandCallAdded =>
      'El bloque Comando se añadió al programa principal. Aquí el robot hará todas las flechas del comando.';

  @override
  String get myCommandUseHint =>
      'Tu comando está listo. Toca el botón turquesa Comando para usarlo en el programa principal.';

  @override
  String get myCommandFullHint =>
      'Llegaste al límite de bloques. Cambia el comando o sustituye las flechas del programa principal por un bloque Comando.';

  @override
  String get myCommandMissedGoal =>
      'El robot no llegó a la bandera. Prueba a cambiar las flechas del comando o el número de bloques Comando.';

  @override
  String myCommandOffPath(Object place) {
    return '$place en el comando saca al robot del camino.';
  }

  @override
  String myCommandFixCount(Object number) {
    return 'Prueba a cambiar el número de repeticiones del bloque $number del comando o las flechas que tiene dentro.';
  }

  @override
  String get myCommandLaterCall =>
      'Esta vez el comando saca al robot del camino; cambia el comando o las flechas del programa principal.';

  @override
  String get myCommandL1Intro =>
      '¡Crea tu propio comando! Pon dos flechas a la derecha en la franja turquesa de arriba. Luego añade tu comando al programa principal con el botón Comando.';

  @override
  String get myCommandL1Hint =>
      'El robot debe ir 6 veces a la derecha. Si tu comando son 2 flechas a la derecha, ¿cuántas veces debes usarlo?';

  @override
  String get myCommandL2Hint =>
      'Baja como por una escalera. Un escalón: una a la derecha, una abajo. Que ese sea tu comando.';

  @override
  String get myCommandL3Intro =>
      'En el programa principal también puedes añadir flechas junto al bloque Comando.';

  @override
  String get myCommandL3Hint =>
      'Entre las piedras hay una escalera: derecha, abajo. Al final falta un paso más.';

  @override
  String get myCommandL4Hint =>
      'Dos a la derecha, una arriba. ¿Cuántas veces se repite este patrón?';

  @override
  String get myCommandL5Hint =>
      'El robot sube hacia la izquierda: una arriba, una a la izquierda. El oro también está en este camino.';

  @override
  String get myCommandL6Hint =>
      'Cada escalón mide dos casillas de ancho y una de alto.';

  @override
  String get myCommandL7Hint =>
      'Dos a la derecha, dos abajo. El oro está a lo largo de este patrón.';

  @override
  String get myCommandL8Hint =>
      'Pasa por debajo de las piedras: primero abajo, luego dos a la derecha.';

  @override
  String get myCommandL9Hint =>
      'Que el comando vaya cuatro veces a la derecha. Entre los dos bloques Comando, el robot debe bajar.';

  @override
  String get myCommandL10Hint =>
      'Recoge el oro entre las piedras: abajo, dos a la derecha, arriba.';

  @override
  String get myCommandL11Intro =>
      '¡También puedes poner un bloque Repetir dentro de tu comando! Así, un comando corto recorre un camino largo.';

  @override
  String get myCommandL11Hint =>
      'Que el comando vaya tres veces a la derecha. Entre los comandos, el robot baja una vez y sube una vez.';

  @override
  String get myCommandL12Hint =>
      'Cada parte es dos a la derecha, una abajo. En un sitio se cuela un paso más hacia abajo.';

  @override
  String get myCommandL13Hint =>
      'Cada escalón es una arriba, dos a la derecha. No olvides el oro.';

  @override
  String get myCommandL14Hint =>
      'Cada parte es dos a la derecha, una arriba. Fíjate también en los pasos entre los comandos.';

  @override
  String get myCommandL15Hint =>
      'Cada parte es una abajo, dos a la derecha. Entre los comandos, el camino a veces sigue recto.';

  @override
  String get myCommandL16Hint =>
      'Comando: tres a la derecha, una abajo. Después del primer comando tienes que girar una vez a la izquierda.';

  @override
  String get myCommandL17Hint =>
      'Cada parte es una arriba, tres a la derecha. Entre los comandos, sube una vez más.';

  @override
  String get myCommandL18Hint =>
      'Dentro del comando puede haber dos bloques Repetir: dos abajo, dos a la derecha.';

  @override
  String get myCommandL19Hint =>
      'Comando: una a la derecha, dos arriba, una a la derecha. Encuentra las flechas del medio contando casillas.';

  @override
  String get myCommandL20Hint =>
      'El comando empieza con dos escalones: derecha, abajo. Después, un paso más a la derecha.';

  @override
  String get variableBoxIntro =>
      'Mete un número en la caja amarilla. Cada flecha mueve al robot tantas casillas como indique la caja. La caja empieza en 1.';

  @override
  String get variableBoxEmpty =>
      'Primero añade un bloque de caja o una flecha.';

  @override
  String get variableBoxEmptyStrip =>
      'Añade un bloque de caja y flechas y tus bloques se pondrán en fila aquí.';

  @override
  String get variableBoxMissedGoal =>
      'El robot no llegó a la bandera. Prueba a cambiar el número de la caja o las flechas.';

  @override
  String get variableBoxFullHint =>
      'Llegaste al límite de bloques. En vez de añadir las flechas una a una, prueba a meter un número más grande en la caja.';

  @override
  String variableBoxWalked(int box) {
    String _temp0 = intl.Intl.pluralLogic(
      box,
      locale: localeName,
      other: 'La caja tenía $box; cada flecha movió al robot $box casillas.',
      one: 'La caja tenía $box; cada flecha movió al robot $box casilla.',
    );
    return '$_temp0';
  }

  @override
  String variableBoxInnerName(Object block, Object number) {
    return 'El bloque de caja $number dentro del bloque $block';
  }

  @override
  String variableBoxSetChip(Object name, Object value) {
    return '$name: meter $value en la caja';
  }

  @override
  String variableBoxIncreaseChip(Object name) {
    return '$name: sumar 1 a la caja';
  }

  @override
  String variableBoxDecreaseChip(Object name) {
    return '$name: quitar 1 de la caja';
  }

  @override
  String get variableBoxDecrease => 'Bajar el número que se mete en la caja';

  @override
  String get variableBoxIncrease => 'Subir el número que se mete en la caja';

  @override
  String get variableBoxSetLabel =>
      'Añadir un bloque que mete un número en la caja';

  @override
  String get variableBoxIncreaseLabel =>
      'Añadir un bloque que suma 1 a la caja';

  @override
  String get variableBoxDecreaseLabel =>
      'Añadir un bloque que quita 1 de la caja';

  @override
  String variableBoxBadge(Object value) {
    return 'Ahora la caja tiene $value.';
  }

  @override
  String variableBoxArrowSteps(String label, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$label. Mueve al robot $count casillas.',
      one: '$label. Mueve al robot 1 casilla.',
    );
    return '$_temp0';
  }

  @override
  String variableBoxNextSetHint(Object levelHint, int value) {
    return '$levelHint Ahora mete $value en la caja: añade un bloque de caja con el botón que brilla y luego cambia su número a $value.';
  }

  @override
  String variableBoxNextIncreaseHint(Object levelHint) {
    return '$levelHint Ahora suma 1 a la caja: toca el botón +1 que brilla.';
  }

  @override
  String variableBoxNextDecreaseHint(Object levelHint) {
    return '$levelHint Ahora quita 1 de la caja: toca el botón −1 que brilla.';
  }

  @override
  String get variableBoxL1Intro =>
      'La bandera está 6 casillas más allá, pero solo puedes poner 2 bloques. Primero mete 6 en la caja y luego toca la flecha derecha.';

  @override
  String get variableBoxL1Hint =>
      'Con el bloque caja = mete 6 en la caja; luego una sola flecha derecha mueve al robot 6 casillas.';

  @override
  String get variableBoxL2Hint =>
      'El robot debe ir 3 a la derecha y 3 hacia abajo. Mete 3 en la caja; luego cada flecha mueve 3 casillas.';

  @override
  String get variableBoxL3Hint =>
      'Hay 4 casillas a la derecha y 4 hacia abajo. Mete 4 en la caja y bastan dos flechas.';

  @override
  String get variableBoxL4Hint =>
      'Primero 5 a la derecha y luego 2 hacia abajo. Mete 5 en la caja y toca la flecha derecha; después pon la caja en 2 y toca la flecha abajo.';

  @override
  String get variableBoxL5Intro =>
      'Bloque nuevo: +1 sube en uno el número de la caja.';

  @override
  String get variableBoxL5Hint =>
      '2 a la derecha y 3 hacia abajo. Mete 2 en la caja, flecha derecha; luego con +1 pon la caja en 3 y flecha abajo.';

  @override
  String get variableBoxL6Hint =>
      'El camino es siempre de 3 casillas: derecha, abajo, derecha, abajo. Mete 3 en la caja una sola vez; cada flecha siguiente avanza 3 casillas.';

  @override
  String get variableBoxL7Hint =>
      'La caja empieza en 1. En cada paso el camino crece una casilla: flecha, +1, flecha, +1, flecha.';

  @override
  String get variableBoxL8Intro =>
      'Bloque nuevo: −1 baja en uno el número de la caja.';

  @override
  String get variableBoxL8Hint =>
      'Los caminos son de 4, 3, 2 y 1 casillas. Mete 4 en la caja y después de cada flecha añade −1.';

  @override
  String get variableBoxL9Hint =>
      '5 hacia abajo, 2 a la derecha, 5 hacia arriba. Antes de cada dirección mete en la caja el número que toca.';

  @override
  String get variableBoxL10Hint =>
      'Todos los caminos miden 3 casillas. Mete 3 en la caja una sola vez y bastan cinco flechas.';

  @override
  String get variableBoxL11Intro =>
      '¡Repetir ha vuelto! El número de la caja sirve en cada vuelta de la repetición.';

  @override
  String get variableBoxL11Hint =>
      'Los escalones miden 2 casillas. Mete 2 en la caja y repite 3 veces la flecha derecha y la flecha abajo.';

  @override
  String get variableBoxL12Hint =>
      'Los escalones miden 3 casillas: primero abajo y luego a la derecha. Mete 3 en la caja y repite el patrón 2 veces.';

  @override
  String get variableBoxL13Hint =>
      'Mete 2 en la caja; repite 2 veces la flecha derecha y la flecha arriba, y al final una flecha derecha más.';

  @override
  String get variableBoxL14Hint =>
      'Primero ve 3 casillas a la derecha. Luego pon la caja en 2 y repite 2 veces el patrón abajo-derecha.';

  @override
  String get variableBoxL15Hint =>
      'Primero mete 2 en la caja y repite 2 veces el patrón derecha-abajo. El último tramo recto mide 3 casillas.';

  @override
  String get variableBoxL16Intro =>
      'Puedes poner +1 dentro de Repetir; así el camino crece una casilla en cada vuelta.';

  @override
  String get variableBoxL16Hint =>
      'Los escalones crecen: 1, 2 y 3 casillas. Repite 3 veces la flecha derecha, la flecha abajo y el bloque +1.';

  @override
  String get variableBoxL17Hint =>
      'Los escalones se encogen: 3, 2 y 1 casillas. Mete 3 en la caja y repite 3 veces la flecha derecha, la flecha abajo y el bloque −1.';

  @override
  String get variableBoxL18Hint =>
      'En cada vuelta hay flecha derecha, +1 y flecha abajo; después de 2 vueltas añade una última flecha derecha.';

  @override
  String get variableBoxL19Hint =>
      'Mete 4 en la caja. Repite 2 veces el patrón flecha derecha, −1 y flecha abajo.';

  @override
  String get variableBoxL20Hint =>
      'Cada flecha es una casilla más larga que la anterior. Repite 2 veces el patrón flecha derecha, +1, flecha abajo, +1.';

  @override
  String get patternColorRed => 'rojo';

  @override
  String get patternColorBlue => 'azul';

  @override
  String get patternColorYellow => 'amarillo';

  @override
  String get patternColorGreen => 'verde';

  @override
  String get patternShapeCircle => 'círculo';

  @override
  String get patternShapeSquare => 'cuadrado';

  @override
  String get patternShapeTriangle => 'triángulo';

  @override
  String patternLampLabel(String color, String shape) {
    return 'Lámpara $shape de color $color';
  }

  @override
  String get patternMissingSlot => 'Pieza que falta';

  @override
  String patternLightChip(String name, String color) {
    return '$name: encender una lámpara de color $color';
  }

  @override
  String patternInnerName(Object block, Object number) {
    return 'El bloque de lámpara $number dentro del bloque $block';
  }

  @override
  String patternLightLabel(String color) {
    return 'Añadir un bloque que enciende una lámpara de color $color';
  }

  @override
  String get patternEmptyStrip =>
      'Toca los botones de color para añadir bloques';

  @override
  String get patternIntroEasy =>
      'Las lámparas se encienden siguiendo un patrón. Elige abajo el color de la lámpara con el signo de interrogación.';

  @override
  String get patternIntroMedium =>
      'Esta vez faltan varias piezas. Mira los colores y las formas y completa las que faltan, una por una.';

  @override
  String get patternIntroHard =>
      'Estos patrones crecen o avanzan con números. Elige la pieza correcta entre las opciones de abajo.';

  @override
  String get patternIntroExpert =>
      '¡Enciende tú las lámparas! Añade bloques con los botones de color; si los colores se repiten, usa el bloque Repetir.';

  @override
  String get patternHintRepeat =>
      'Fíjate en la parte que se repite. ¿Con qué colores vuelve a empezar el patrón?';

  @override
  String get patternHintShape =>
      'Mira el color y también la forma. En la parte que se repite, los dos van en el mismo orden.';

  @override
  String get patternHintGrowing =>
      'El patrón crece cada vez. Cuenta las lámparas azules: en cada vuelta hay una más.';

  @override
  String get patternHintNumbers =>
      'Mira la diferencia entre los números. Cada vez se suma el mismo número.';

  @override
  String get patternHintGrowingNumbers =>
      'Mira la diferencia entre los números. La diferencia aumenta en uno cada vez: 1, 2, 3…';

  @override
  String get patternHintProgram =>
      'Busca el grupo de lámparas que se repite. Pon esos colores dentro del bloque Repetir y ajusta cuántas veces se repite.';

  @override
  String get patternHintProgramTail =>
      'Cuando termina el grupo que se repite, sobra una lámpara al final. Añádela fuera del bloque Repetir.';

  @override
  String get patternHintProgramTwo =>
      'En la tira hay dos patrones distintos. Usa un bloque Repetir para cada uno.';

  @override
  String get patternWrongLamp =>
      'Esta pieza no encaja en el patrón. Mira la parte que se repite e inténtalo de nuevo.';

  @override
  String get patternRightLamp =>
      '¡Correcto! Ahora completa el siguiente signo de interrogación.';

  @override
  String get patternSolved => '¡Genial! Completaste el patrón.';

  @override
  String get patternLampsDark =>
      'Algunas lámparas siguen apagadas. Añade más bloques de color o aumenta las repeticiones.';

  @override
  String get patternTooManyLights =>
      'Hay más bloques que lámparas. Borra un bloque o reduce las repeticiones.';

  @override
  String patternWrongColor(String color) {
    return 'Esta lámpara se encendió en $color, pero no encaja en el patrón. ¿Qué color debía ir aquí?';
  }

  @override
  String get patternProgramEmpty =>
      'Primero añade bloques con los botones de color.';

  @override
  String patternProgramHintWrong(String color) {
    return 'El bloque que elegí enciende la lámpara con otro color. Ahí debe encenderse una lámpara de color $color.';
  }

  @override
  String get patternInsideRepeat =>
      'Los colores que añadas ahora irán dentro del bloque naranja. Cuando termines, toca el botón azul oscuro Salir del bloque.';

  @override
  String get patternOutsideRepeat =>
      'Los colores que añadas ahora irán fuera del bloque, al final.';

  @override
  String get patternMovedOut =>
      'El color salió del bloque. Los colores que añadas ahora también irán fuera, al final.';

  @override
  String get patternEmptyRepeat =>
      'El bloque naranja está vacío. Lo he seleccionado; ahora añade un color dentro.';

  @override
  String get patternLeaveRepeatLabel =>
      'Salir del bloque; los siguientes colores irán fuera';

  @override
  String get patternDropHere => 'Añade colores aquí';

  @override
  String get ifThenL1Intro =>
      'Si hay una roca delante, ¿qué debe hacer el robot? Pon un movimiento en la casilla vacía.';

  @override
  String get ifThenL2Intro =>
      'El robot no sabe nadar. Si hay agua delante, ¿qué debe hacer?';

  @override
  String get ifThenL3Intro =>
      'Hay una puerta cerrada en el camino. ¿Qué debe hacer el robot cuando llegue a la puerta?';

  @override
  String get ifThenL4Intro =>
      '¡No pases junto a las estrellas sin recogerlas! Si hay una estrella delante, ¿qué debe hacer el robot?';

  @override
  String get ifThenL5Intro =>
      'Esta vez también eliges la condición. ¿Qué hay en el camino?';

  @override
  String get ifThenL6Intro =>
      'Si hay una roca, haz una cosa; si no, haz otra. Llena las dos casillas.';

  @override
  String get ifThenL7Intro => '¿Qué debe hacer si hay agua? ¿Y si no hay agua?';

  @override
  String get ifThenL8Intro =>
      '¡En este camino no hay casillas vacías! Si no hay una puerta, ¿qué hay delante?';

  @override
  String get ifThenL9Intro => 'Elige la condición y los dos movimientos.';

  @override
  String get ifThenL10Intro =>
      'En el camino hay rocas y agua. Basta con una regla y un «Si no».';

  @override
  String get ifThenL11Intro =>
      'También hay rocas y agua. Haz una regla para cada una.';

  @override
  String get ifThenL12Intro => 'Abre las puertas y recoge las estrellas.';

  @override
  String get ifThenL13Intro =>
      'Hay tres cosas distintas pero solo dos filas de reglas. Usa «Si no» para la tercera.';

  @override
  String get ifThenL14Intro =>
      'Agua, puertas y camino vacío. ¿Cuál dejarás para el «Si no»?';

  @override
  String get ifThenL15Intro =>
      'Cuidado: uno de los bloques no aparece en este camino.';

  @override
  String get ifThenL16Intro =>
      'El robot va hacia el castillo: hay rocas, fosos y puertas del castillo.';

  @override
  String get ifThenL17Intro =>
      'Camino del tesoro: recoge las estrellas y supera los obstáculos.';

  @override
  String get ifThenL18Intro =>
      'En este camino no hay casillas vacías. Cuatro cosas necesitan cuatro decisiones.';

  @override
  String get ifThenL19Intro =>
      '¡Un viaje largo! Agua, rocas, puertas y camino vacío.';

  @override
  String get ifThenL20Intro =>
      'Última tarea: recoge todas las estrellas y llega a la bandera.';

  @override
  String get pathFinderL1Intro =>
      'Lleva al robot a la bandera. Pulsa la flecha a la derecha y luego toca el botón verde Empezar.';

  @override
  String get pathFinderL2Intro =>
      'La bandera está encima del robot. ¿Qué flecha debes elegir?';

  @override
  String get pathFinderL3Intro =>
      'La bandera está a la izquierda, a dos casillas.';

  @override
  String get pathFinderL4Intro => 'El robot tiene que bajar. ¿Cuántas veces?';

  @override
  String get pathFinderL5Intro => 'Esta vez usarás dos direcciones distintas.';

  @override
  String get pathFinderL11Intro => 'Hay una roca en el camino. Rodéala.';

  @override
  String get pathFinderL12Intro =>
      'Las rocas están en fila como un muro. Rodéalas por debajo.';

  @override
  String get pathFinderL13Intro =>
      'El robot no puede entrar en el agua. Encuentra el camino seco.';

  @override
  String get pathFinderL15Intro =>
      'Hay más de un camino. ¿Encuentras el más corto?';

  @override
  String get commandOrderL1Title => 'Regar la flor';

  @override
  String get commandOrderL1Step1 => 'Llenar la regadera';

  @override
  String get commandOrderL1Step2 => 'Regar la flor';

  @override
  String get commandOrderL1Hint =>
      'Para regar la flor, primero tiene que haber agua en la regadera.';

  @override
  String get commandOrderL2Title => 'Lavarse los dientes';

  @override
  String get commandOrderL2Step1 => 'Poner pasta en el cepillo';

  @override
  String get commandOrderL2Step2 => 'Cepillarse los dientes';

  @override
  String get commandOrderL2Step3 => 'Enjuagarse la boca';

  @override
  String get commandOrderL2Hint =>
      'Antes de empezar a cepillarte, tiene que haber pasta en el cepillo.';

  @override
  String get commandOrderL3Title => 'Lavarse las manos';

  @override
  String get commandOrderL3Step1 => 'Enjabonarse las manos';

  @override
  String get commandOrderL3Step2 => 'Aclararse las manos';

  @override
  String get commandOrderL3Step3 => 'Secarse las manos';

  @override
  String get commandOrderL3Hint =>
      'No puedes secarte las manos antes de quitar la espuma.';

  @override
  String get commandOrderL4Title => 'Ponerse los zapatos';

  @override
  String get commandOrderL4Step1 => 'Ponerse los calcetines';

  @override
  String get commandOrderL4Step2 => 'Ponerse los zapatos';

  @override
  String get commandOrderL4Step3 => 'Atarse los cordones';

  @override
  String get commandOrderL4Hint =>
      '¿Qué debe llevar tu pie antes de entrar en el zapato?';

  @override
  String get commandOrderL5Title => 'Hacer un dibujo';

  @override
  String get commandOrderL5Step1 => 'Tomar una hoja de papel';

  @override
  String get commandOrderL5Step2 => 'Dibujar';

  @override
  String get commandOrderL5Step3 => 'Colorear el dibujo';

  @override
  String get commandOrderL5Hint =>
      'Para colorear, necesitas un dibujo ya hecho.';

  @override
  String get commandOrderL6Title => 'Preparar un sándwich';

  @override
  String get commandOrderL6Step1 => 'Poner el plato en la mesa';

  @override
  String get commandOrderL6Step2 => 'Poner el pan en el plato';

  @override
  String get commandOrderL6Step3 => 'Poner queso encima';

  @override
  String get commandOrderL6Step4 => 'Taparlo con pan';

  @override
  String get commandOrderL6Step5 => '¡Que aproveche!';

  @override
  String get commandOrderL6Hint =>
      'Necesitas un sitio para el pan. ¿Qué debe haber primero en la mesa?';

  @override
  String get commandOrderL7Title => 'Recoger los juguetes';

  @override
  String get commandOrderL7Step1 => 'Traer la caja';

  @override
  String get commandOrderL7Step2 => 'Meter los juguetes en la caja';

  @override
  String get commandOrderL7Step3 => 'Cerrar la tapa';

  @override
  String get commandOrderL7Step4 => 'Poner la caja en la estantería';

  @override
  String get commandOrderL7Hint =>
      '¿Qué haces si la caja de los juguetes no está a tu lado?';

  @override
  String get commandOrderL8Title => 'Plantar una semilla';

  @override
  String get commandOrderL8Step1 => 'Hacer un hoyo en la tierra';

  @override
  String get commandOrderL8Step2 => 'Poner la semilla en el hoyo';

  @override
  String get commandOrderL8Step3 => 'Taparla con tierra';

  @override
  String get commandOrderL8Step4 => 'Regar la semilla';

  @override
  String get commandOrderL8Step5 => 'Esperar al brote';

  @override
  String get commandOrderL8Hint =>
      'No puedes meter la semilla en la tierra sin un hoyo.';

  @override
  String get commandOrderL9Title => 'Prepararse para el colegio';

  @override
  String get commandOrderL9Step1 => 'Despertarse cuando suena el despertador';

  @override
  String get commandOrderL9Step2 => 'Ponerse la ropa del colegio';

  @override
  String get commandOrderL9Step3 => 'Ponerse la mochila';

  @override
  String get commandOrderL9Step4 => 'Subir al autobús escolar';

  @override
  String get commandOrderL9Hint =>
      'No puedes vestirte antes de despertarte. ¿Qué pasa primero por la mañana?';

  @override
  String get commandOrderL10Title => 'Enviar una carta';

  @override
  String get commandOrderL10Step1 => 'Escribir la carta';

  @override
  String get commandOrderL10Step2 => 'Meter la carta en el sobre';

  @override
  String get commandOrderL10Step3 => 'Cerrar el sobre';

  @override
  String get commandOrderL10Step4 => 'Echarla al buzón';

  @override
  String get commandOrderL10Hint =>
      'Tiene que haber una carta para meterla en el sobre.';

  @override
  String get commandOrderL11Title => 'Hacer un pastel';

  @override
  String get commandOrderL11Stage1 => 'Preparar la masa';

  @override
  String get commandOrderL11Stage2 => 'Hornear el pastel';

  @override
  String get commandOrderL11Step1 => 'Poner los ingredientes en la mesa';

  @override
  String get commandOrderL11Step2 => 'Mezclarlo todo en un bol';

  @override
  String get commandOrderL11Step3 => 'Echar la masa en el molde';

  @override
  String get commandOrderL11Step4 => 'Meter el molde en el horno';

  @override
  String get commandOrderL11Step5 => 'Esperar a que se haga';

  @override
  String get commandOrderL11Step6 => 'Cortar el pastel';

  @override
  String get commandOrderL11Hint =>
      'No puedes meter nada en el horno antes de que la masa esté lista.';

  @override
  String get commandOrderL12Title => 'Darse un baño';

  @override
  String get commandOrderL12Stage1 => 'Preparar el baño';

  @override
  String get commandOrderL12Stage2 => 'Lavarse';

  @override
  String get commandOrderL12Stage3 => 'Secarse';

  @override
  String get commandOrderL12Step1 => 'Llenar la bañera de agua';

  @override
  String get commandOrderL12Step2 => 'Meterse en la bañera';

  @override
  String get commandOrderL12Step3 => 'Lavarse el pelo con champú';

  @override
  String get commandOrderL12Step4 => 'Aclarar la espuma';

  @override
  String get commandOrderL12Step5 => 'Secarse con una toalla';

  @override
  String get commandOrderL12Hint =>
      'Si te metes en una bañera vacía, no puedes lavarte.';

  @override
  String get commandOrderL13Title => 'Montar en bici';

  @override
  String get commandOrderL13Stage1 => 'Prepararse';

  @override
  String get commandOrderL13Stage2 => 'En marcha';

  @override
  String get commandOrderL13Stage3 => 'Terminar';

  @override
  String get commandOrderL13Step1 => 'Ponerse el casco';

  @override
  String get commandOrderL13Step2 => 'Subirse a la bici';

  @override
  String get commandOrderL13Step3 => 'Pedalear';

  @override
  String get commandOrderL13Step4 => 'Frenar';

  @override
  String get commandOrderL13Step5 => 'Bajarse de la bici';

  @override
  String get commandOrderL13Hint =>
      'Lo primero es la seguridad. ¿Qué te pones antes de subirte a la bici?';

  @override
  String get commandOrderL14Title => 'Sacar un libro de la biblioteca';

  @override
  String get commandOrderL14Stage1 => 'En la biblioteca';

  @override
  String get commandOrderL14Stage2 => 'En casa';

  @override
  String get commandOrderL14Stage3 => 'Devolverlo';

  @override
  String get commandOrderL14Step1 => 'Ir a la biblioteca';

  @override
  String get commandOrderL14Step2 => 'Elegir un libro';

  @override
  String get commandOrderL14Step3 => 'Pedir prestado el libro';

  @override
  String get commandOrderL14Step4 => 'Llevar el libro a casa';

  @override
  String get commandOrderL14Step5 => 'Leer el libro';

  @override
  String get commandOrderL14Step6 => 'Devolver el libro';

  @override
  String get commandOrderL14Hint =>
      'Para elegir un libro, primero tienes que ir donde están los libros.';

  @override
  String get commandOrderL15Title => 'Montar una tienda de campaña';

  @override
  String get commandOrderL15Stage1 => 'Preparar el sitio';

  @override
  String get commandOrderL15Stage2 => 'Montar la tienda';

  @override
  String get commandOrderL15Stage3 => 'Preparar el interior';

  @override
  String get commandOrderL15Step1 => 'Buscar un sitio llano';

  @override
  String get commandOrderL15Step2 => 'Extender la tienda en el suelo';

  @override
  String get commandOrderL15Step3 => 'Meter las varillas';

  @override
  String get commandOrderL15Step4 => 'Levantar la tienda';

  @override
  String get commandOrderL15Step5 => 'Sujetarla con piquetas';

  @override
  String get commandOrderL15Step6 => 'Meter el saco de dormir';

  @override
  String get commandOrderL15Step7 => 'Encender la linterna';

  @override
  String get commandOrderL15Hint =>
      'Para extender la tienda, primero tienes que encontrar un buen sitio.';

  @override
  String get commandOrderL16Title => 'Hacer una pizza';

  @override
  String get commandOrderL16Stage1 => 'Masa';

  @override
  String get commandOrderL16Stage2 => 'Ingredientes';

  @override
  String get commandOrderL16Stage3 => 'Horno';

  @override
  String get commandOrderL16Step1 => 'Estirar la masa';

  @override
  String get commandOrderL16Step2 => 'Extender la salsa de tomate';

  @override
  String get commandOrderL16Step3 => 'Echar el queso';

  @override
  String get commandOrderL16Step4 => 'Meterla en el horno';

  @override
  String get commandOrderL16Step5 => 'Esperar a que se haga';

  @override
  String get commandOrderL16Step6 => 'Cortarla en trozos';

  @override
  String get commandOrderL16Extra1 => 'Encender la tele';

  @override
  String get commandOrderL16Hint =>
      'No todas las tarjetas son de esta tarea. ¿Necesitas la tele para hacer una pizza?';

  @override
  String get commandOrderL17Title => 'Lavar la ropa';

  @override
  String get commandOrderL17Stage1 => 'Preparar';

  @override
  String get commandOrderL17Stage2 => 'Lavar';

  @override
  String get commandOrderL17Stage3 => 'Secar';

  @override
  String get commandOrderL17Step1 => 'Juntar la ropa sucia';

  @override
  String get commandOrderL17Step2 => 'Meterla en la lavadora';

  @override
  String get commandOrderL17Step3 => 'Echar el detergente';

  @override
  String get commandOrderL17Step4 => 'Poner la lavadora';

  @override
  String get commandOrderL17Step5 => 'Tender la ropa';

  @override
  String get commandOrderL17Step6 => 'Doblarla cuando esté seca';

  @override
  String get commandOrderL17Extra1 => 'Jugar a la pelota';

  @override
  String get commandOrderL17Hint =>
      'Si la ropa sucia está por todas partes, ¿qué debes hacer primero?';

  @override
  String get commandOrderL18Title => 'Viajar en tren';

  @override
  String get commandOrderL18Stage1 => 'En la estación';

  @override
  String get commandOrderL18Stage2 => 'En el tren';

  @override
  String get commandOrderL18Stage3 => 'Llegada';

  @override
  String get commandOrderL18Step1 => 'Comprar un billete';

  @override
  String get commandOrderL18Step2 => 'Ir al andén';

  @override
  String get commandOrderL18Step3 => 'Esperar el tren';

  @override
  String get commandOrderL18Step4 => 'Subir al tren';

  @override
  String get commandOrderL18Step5 => 'Sentarse en tu asiento';

  @override
  String get commandOrderL18Step6 => 'Bajar en tu parada';

  @override
  String get commandOrderL18Extra1 => 'Subir al avión';

  @override
  String get commandOrderL18Hint => '¿Qué necesitas llevar para subir al tren?';

  @override
  String get commandOrderL19Title => 'Hacer crecer un arbolito';

  @override
  String get commandOrderL19Stage1 => 'Plantar';

  @override
  String get commandOrderL19Stage2 => 'Cuidar';

  @override
  String get commandOrderL19Stage3 => 'Crecer';

  @override
  String get commandOrderL19Step1 => 'Poner tierra en la maceta';

  @override
  String get commandOrderL19Step2 => 'Plantar la semilla';

  @override
  String get commandOrderL19Step3 => 'Regar la semilla';

  @override
  String get commandOrderL19Step4 => 'Poner la maceta al sol';

  @override
  String get commandOrderL19Step5 => 'Esperar al brote';

  @override
  String get commandOrderL19Step6 => 'Plantarlo en el jardín';

  @override
  String get commandOrderL19Extra1 => 'Abrir un paraguas';

  @override
  String get commandOrderL19Extra2 => 'Poner la maceta a oscuras';

  @override
  String get commandOrderL19Hint =>
      'Las plantas necesitan agua y luz del sol para crecer. ¿Qué tarjetas les harían daño?';

  @override
  String get commandOrderL20Title => 'Hacer galletas y compartirlas';

  @override
  String get commandOrderL20Stage1 => 'Preparar';

  @override
  String get commandOrderL20Stage2 => 'Hornear';

  @override
  String get commandOrderL20Stage3 => 'Compartir';

  @override
  String get commandOrderL20Step1 => 'Lavarse las manos';

  @override
  String get commandOrderL20Step2 => 'Mezclar los ingredientes';

  @override
  String get commandOrderL20Step3 => 'Dar forma a la masa';

  @override
  String get commandOrderL20Step4 => 'Hornearlas';

  @override
  String get commandOrderL20Step5 => 'Dejar que se enfríen';

  @override
  String get commandOrderL20Step6 => 'Ponerlas en una caja';

  @override
  String get commandOrderL20Step7 => 'Compartirlas con tus amigos';

  @override
  String get commandOrderL20Extra1 => 'Jugar con un coche de juguete';

  @override
  String get commandOrderL20Extra2 => 'Irse a dormir';

  @override
  String get commandOrderL20Hint =>
      'Antes de trabajar en la cocina, tienes que estar limpio.';
}
