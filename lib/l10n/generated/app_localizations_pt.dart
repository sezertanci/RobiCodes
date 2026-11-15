// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Robi Programa';

  @override
  String get languageName => 'Português';

  @override
  String get homeLogoTop => 'Robi';

  @override
  String get homeLogoBottom => 'Programa';

  @override
  String get homeTagline => 'Brinque • Aprenda • Descubra';

  @override
  String get homeComingSoon => 'Em breve';

  @override
  String homeLevels(Object completed, Object levels) {
    return '$completed/$levels fases';
  }

  @override
  String get homeChangeCharacter => 'Trocar';

  @override
  String homeCharacterLabel(Object name) {
    return 'Seu personagem: $name. Toque para trocar.';
  }

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonNextLevel => 'Próxima fase';

  @override
  String get commonBackToHome => 'Voltar ao início';

  @override
  String get commonBackToLevels => 'Voltar às fases';

  @override
  String commonStars(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrelas',
      one: '1 estrela',
    );
    return '$_temp0';
  }

  @override
  String get commonRun => 'Começar';

  @override
  String get commonHint => 'Dica';

  @override
  String get commonClear => 'Limpar';

  @override
  String get commonDelete => 'Apagar';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsSound => 'Som';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String difficulty(String difficulty) {
    String _temp0 = intl.Intl.selectLogic(difficulty, {
      'easy': 'Fácil',
      'medium': 'Médio',
      'hard': 'Difícil',
      'other': 'Especialista',
    });
    return '$_temp0';
  }

  @override
  String get basePackTitle => 'Fases básicas';

  @override
  String get playPreviousLevel => 'Fase anterior';

  @override
  String playLevelLabel(Object difficulty, Object level) {
    return '$difficulty, fase $level';
  }

  @override
  String playFinishGroupFirst(Object difficulty) {
    return 'Primeiro termine as fases “$difficulty”';
  }

  @override
  String get playLevelComplete => 'Muito bem! Fase concluída.';

  @override
  String playLevel(Object level) {
    return 'Fase $level';
  }

  @override
  String playLevelLocked(Object level) {
    return 'Fase $level, bloqueada';
  }

  @override
  String playLevelStars(Object level, Object stars) {
    return 'Fase $level, $stars';
  }

  @override
  String get playLocked => 'bloqueada';

  @override
  String get gamePathFinderTitle => 'Ache o caminho do robô';

  @override
  String get gamePathFinderDescription =>
      'Leve o robô até o objetivo com comandos de direção.';

  @override
  String get gamePathFinderTrophy => 'Mestre dos Robôs';

  @override
  String get gamePathFinderTrophyDescription =>
      'Agora o robô conhece todos os caminhos!';

  @override
  String get gameCommandOrderTitle => 'Ponha os passos em ordem';

  @override
  String get gameCommandOrderDescription => 'Coloque os passos na ordem certa.';

  @override
  String get gameCommandOrderTrophy => 'Mestre dos Algoritmos';

  @override
  String get gameCommandOrderTrophyDescription =>
      'Ninguém ordena os passos melhor que você!';

  @override
  String get gameIfThenTitle => 'Se isso, então';

  @override
  String get gameIfThenDescription =>
      'Escolha o comando certo para cada situação.';

  @override
  String get gameIfThenTrophy => 'Mestre das Decisões';

  @override
  String get gameIfThenTrophyDescription => 'Você sempre faz a escolha certa!';

  @override
  String get gameRepeatTitle => 'Repita';

  @override
  String get gameRepeatDescription =>
      'Faça movimentos repetidos com um bloco só.';

  @override
  String get gameRepeatTrophy => 'Mestre das Repetições';

  @override
  String get gameRepeatTrophyDescription =>
      'Você usa repetições como um profissional!';

  @override
  String get characterTitle => 'Escolha seu personagem';

  @override
  String characterName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'robi': 'Robi',
      'fiyo': 'Fiyo',
      'pervane': 'Hélice',
      'isil': 'Brilho',
      'kahraman': 'Herói',
      'pembe': 'Rosinha',
      'sovalye': 'Cavaleiro',
      'piril': 'Faísca',
      'other': 'Robi',
    });
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Minhas conquistas';

  @override
  String achievementsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Você ganhou $count prêmios!',
      one: 'Você ganhou 1 prêmio!',
    );
    return '$_temp0';
  }

  @override
  String get achievementsBadges => 'Medalhas';

  @override
  String get achievementsBadgesSubtitle => 'Pequenas vitórias';

  @override
  String get achievementsBadgesEarned => 'Medalhas que você ganhou';

  @override
  String get achievementsBadgesLocked => 'Medalhas para ganhar';

  @override
  String get achievementsBadgesEmpty =>
      'Ainda não tem medalhas. Termine sua primeira fase!';

  @override
  String get achievementsTrophies => 'Troféus';

  @override
  String get achievementsTrophiesSubtitle => 'Grandes objetivos';

  @override
  String get achievementsTrophiesEarned => 'Troféus que você ganhou';

  @override
  String get achievementsTrophiesLocked => 'Troféus bloqueados';

  @override
  String get achievementsTrophiesEmpty =>
      'Ainda não tem troféus. Continue em busca dos grandes objetivos!';

  @override
  String achievementsButtonLabel(Object earned, Object total) {
    return 'Minhas conquistas: $earned/$total';
  }

  @override
  String get achievementEarned => 'Conquistado!';

  @override
  String get achievementCondition => 'Como ganhar: ';

  @override
  String achievementCardEarned(Object title) {
    return '$title, conquistado';
  }

  @override
  String achievementCardLocked(Object title) {
    return '$title, bloqueado';
  }

  @override
  String get achievementNewBadge => 'Medalha nova!';

  @override
  String get achievementNewTrophy => 'Você ganhou um troféu novo!';

  @override
  String get achievementGreat => 'Muito bem!';

  @override
  String get achievementFirstGameTitle => 'Meu primeiro jogo';

  @override
  String get achievementFirstGameDescription =>
      'Você deu o primeiro passo na sua aventura de programação!';

  @override
  String get achievementFirstGameCondition =>
      'Complete sua primeira fase de um jogo.';

  @override
  String get achievementQuickStartTitle => 'Começo rápido';

  @override
  String get achievementQuickStartDescription =>
      'Os robôs estão orgulhosos de você!';

  @override
  String achievementQuickStartCondition(Object goal) {
    return 'Complete $goal fases em um jogo.';
  }

  @override
  String get achievementDeterminedTitle => 'Jogador persistente';

  @override
  String get achievementDeterminedDescription =>
      'Você continuou e nunca desistiu!';

  @override
  String achievementDeterminedCondition(Object goal) {
    return 'Complete $goal fases em um jogo.';
  }

  @override
  String get achievementMasterCoderTitle => 'Mestre da programação';

  @override
  String get achievementMasterCoderDescription =>
      'Você terminou todas as fases de um jogo!';

  @override
  String get achievementMasterCoderCondition =>
      'Complete todas as fases de um jogo.';

  @override
  String get achievementAllGamesTitle => 'Explorador de jogos';

  @override
  String get achievementAllGamesDescription =>
      'Você experimentou todos os jogos!';

  @override
  String get achievementAllGamesCondition =>
      'Termine pelo menos uma fase em cada jogo.';

  @override
  String get achievementStarHunterTitle => 'Caçador de estrelas';

  @override
  String get achievementStarHunterDescription =>
      'Você começou a juntar estrelas!';

  @override
  String achievementStarHunterCondition(Object goal) {
    return 'Ganhe $goal estrelas no total.';
  }

  @override
  String get achievementStarMasterTitle => 'Mestre das estrelas';

  @override
  String get achievementStarMasterDescription =>
      'Você tem tantas estrelas quanto o céu!';

  @override
  String achievementStarMasterCondition(Object goal) {
    return 'Ganhe $goal estrelas no total.';
  }

  @override
  String get achievementPerfectTitle => 'Jogada perfeita';

  @override
  String get achievementPerfectDescription =>
      'Você terminou uma fase de forma perfeita!';

  @override
  String achievementPerfectCondition(Object goal) {
    return 'Complete uma fase com $goal estrelas.';
  }

  @override
  String get achievementNoHintTitle => 'Herói sem dicas';

  @override
  String get achievementNoHintDescription => 'Você resolveu tudo sem ajuda!';

  @override
  String achievementNoHintCondition(Object goal) {
    return 'Complete $goal fases sem usar nenhuma dica.';
  }

  @override
  String get achievementBigSuccessTitle => 'Grande sucesso';

  @override
  String get achievementBigSuccessDescription =>
      'Você terminou todos os jogos do começo ao fim!';

  @override
  String get achievementBigSuccessCondition =>
      'Complete todas as fases de todos os jogos.';

  @override
  String get achievementFirstAdventureTitle => 'Troféu da primeira aventura';

  @override
  String get achievementFirstAdventureDescription =>
      'Você deu o primeiro passo em todos os jogos!';

  @override
  String get achievementFirstAdventureCondition =>
      'Complete a primeira fase de cada jogo.';

  @override
  String get achievementChampionTitle => 'Campeão da programação';

  @override
  String get achievementChampionDescription =>
      'Você é um verdadeiro campeão da programação!';

  @override
  String get achievementChampionCondition =>
      'Termine todas as fases de todos os jogos.';

  @override
  String achievementGameTrophyCondition(Object game) {
    return 'Termine “$game”.';
  }

  @override
  String get parentalGateTitle => 'Permissão dos pais';

  @override
  String parentalGateIntro(Object action) {
    return 'Esta ação precisa da permissão de um adulto: $action.';
  }

  @override
  String parentalGateAction(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'purchase': 'Comprar um pacote',
      'other': 'Ação',
    });
    return '$_temp0';
  }

  @override
  String get parentalGateAnswerHint => 'Escreva a resposta em números.';

  @override
  String get parentalGateCancel => 'Cancelar';

  @override
  String get parentalGateConfirm => 'Confirmar';

  @override
  String get parentalGateAnswer => 'Resposta';

  @override
  String get parentalGateWrongAnswer =>
      'Resposta errada. Espere um pouco e depois responda à nova pergunta.';

  @override
  String parentalGateQuestion(String first, String second) {
    return 'Quanto é $first vezes $second?';
  }

  @override
  String get parentalGateTrialLabel => 'Testar a verificação dos pais';

  @override
  String get parentalGateTrialHint =>
      'Aparece só em versões de teste. Nenhuma compra de verdade é feita.';

  @override
  String get parentalGateTrialPassed =>
      'Verificação aprovada; a ação de teste foi executada.';

  @override
  String get parentalGateTrialBlocked =>
      'Verificação não aprovada; a ação não foi executada.';

  @override
  String get storeTitle => 'Pacotes';

  @override
  String get storeIntro =>
      'As compras são feitas pelo Google Play, e a permissão de um responsável é pedida antes de cada compra. Você pode resgatar um código promocional do Google Play pelo link “Resgatar código” na tela de pagamento ou no app Play Store; um pacote resgatado com código também aparece aqui como comprado.';

  @override
  String get storePaidSection => 'Pacotes para comprar';

  @override
  String get storeFreeSection => 'Pacotes grátis';

  @override
  String get storeNoProducts => 'No momento não há pacotes para comprar.';

  @override
  String get storeBundle => 'Combo';

  @override
  String get storeOwned => 'Comprado';

  @override
  String get storeUnlocks => 'Desbloqueado com a compra:';

  @override
  String get storePriceLoading => 'Buscando o preço no Google Play…';

  @override
  String get storePriceUnavailable =>
      'Não foi possível obter o preço do Google Play.';

  @override
  String get storeNotInStore =>
      'Este pacote não está no Google Play no momento.';

  @override
  String get storeRetry => 'Tentar de novo';

  @override
  String storePartiallyOwned(Object missing) {
    return 'Você já tem parte do conteúdo deste pacote. O Google Play não diminui o preço pelo que você já tem, então este pacote não é vendido para você não pagar duas vezes pelo mesmo conteúdo. Pacotes que faltam: $missing';
  }

  @override
  String get storeRestore => 'Restaurar compras';

  @override
  String get storeRestoreHint =>
      'Lê de novo as compras da sua conta do Google Play; o progresso do jogo não é apagado.';

  @override
  String storeRestored(Object count) {
    return 'As compras foram lidas de novo no Google Play. Produtos comprados: $count.';
  }

  @override
  String get storeRestoreOffline =>
      'Sem conexão com a internet; os registros de compra deste dispositivo continuam válidos.';

  @override
  String get storeRestoreUnavailable =>
      'Não foi possível conectar ao Google Play; os registros de compra deste dispositivo continuam válidos.';

  @override
  String storeBuy(Object price) {
    return 'Comprar – $price';
  }

  @override
  String storeLevels(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fases',
      one: '1 fase',
    );
    return '$_temp0';
  }

  @override
  String storePackLine(Object game, Object pack, Object levels) {
    return '$game – $pack ($levels)';
  }

  @override
  String get storePurchased => 'Compra concluída; o pacote foi desbloqueado.';

  @override
  String get storePending =>
      'O pagamento está pendente. O pacote será desbloqueado sozinho quando o pagamento for concluído.';

  @override
  String get storeCancelled => 'Compra cancelada.';

  @override
  String get storeAlreadyOwned =>
      'Você já tem este pacote; ele não foi comprado de novo.';

  @override
  String get storeOffline =>
      'Sem conexão com a internet. Verifique a conexão e tente de novo.';

  @override
  String get storeUnavailable =>
      'Não foi possível conectar ao Google Play. Tente de novo mais tarde.';

  @override
  String get storeFailed => 'Não foi possível concluir a compra.';

  @override
  String get storeNotApproved =>
      'A permissão dos pais não foi dada; a compra não começou.';

  @override
  String get gameRobotRunning => 'O robô está a caminho...';

  @override
  String get gameRobotReachedFlag => 'Muito bem! O robô chegou à bandeira!';

  @override
  String get gameMissingCoins =>
      'Você chegou à bandeira, mas não pegou todas as moedas. Pegue as moedas primeiro.';

  @override
  String gameDirection(String direction) {
    String _temp0 = intl.Intl.selectLogic(direction, {
      'up': 'Cima',
      'down': 'Baixo',
      'left': 'Esquerda',
      'other': 'Direita',
    });
    return '$_temp0';
  }

  @override
  String gameObstacle(String obstacle) {
    String _temp0 = intl.Intl.selectLogic(obstacle, {
      'rock': 'uma pedra',
      'water': 'a água',
      'other': 'a borda do mapa',
    });
    return '$_temp0';
  }

  @override
  String get pathFinderIntro =>
      'Escolha os comandos em ordem para levar o robô até a bandeira.';

  @override
  String get pathFinderCoinIntro =>
      'Primeiro pegue todas as moedas, depois vá até a bandeira.';

  @override
  String get pathFinderEmpty => 'Primeiro adicione um comando de direção.';

  @override
  String get pathFinderFull =>
      'Você chegou ao limite de comandos. Você pode apagar um comando e colocar outro no lugar.';

  @override
  String get pathFinderMissedGoal =>
      'O robô não chegou à bandeira. Tente adicionar ou trocar comandos.';

  @override
  String get pathFinderTooMany =>
      'Com estes comandos não dá para terminar dentro do limite. Tente apagar os passos que você não precisa.';

  @override
  String get pathFinderSolved =>
      'Seus comandos estão certos! Toque no botão verde Começar.';

  @override
  String get pathFinderEmptyStrip =>
      'Aperte os botões de seta e seus comandos vão aparecer em fila aqui.';

  @override
  String get pathFinderMoveLeft =>
      'Mover o comando escolhido um passo para a esquerda';

  @override
  String get pathFinderMoveRight =>
      'Mover o comando escolhido um passo para a direita';

  @override
  String pathFinderBlocked(Object obstacle, Object number) {
    return 'O robô deu de cara com $obstacle. Tente trocar o comando $number.';
  }

  @override
  String pathFinderFixCommand(Object number) {
    return 'O comando $number tira o robô do caminho. Eu já o escolhi para você; você pode apagá-lo ou mudá-lo de lugar.';
  }

  @override
  String pathFinderNextMove(Object direction) {
    return 'Olhe o quadrado que brilha. Próximo comando: $direction.';
  }

  @override
  String pathFinderAddCommand(Object direction) {
    return 'Adicionar o comando “$direction”';
  }

  @override
  String pathFinderCommandChip(Object number, Object direction) {
    return 'Comando $number: $direction';
  }

  @override
  String get commandOrderIntro =>
      'Coloque os cartões na ordem certa para terminar a tarefa. Toque em um cartão ou arraste-o para uma caixa.';

  @override
  String get commandOrderExtrasIntro =>
      'Atenção! Alguns cartões não fazem parte desta tarefa. Coloque em ordem só os cartões de que você precisa.';

  @override
  String get commandOrderFull =>
      'Todas as caixas estão cheias. Toque em um cartão para tirá-lo.';

  @override
  String get commandOrderNotFull => 'Primeiro preencha todas as caixas.';

  @override
  String get commandOrderSuccess =>
      'Muito bem! Todos os passos estão na ordem certa.';

  @override
  String get commandOrderSolved =>
      'A ordem está certa! Toque no botão verde Verificar.';

  @override
  String get commandOrderPoolEmpty => 'Todos os cartões estão no lugar';

  @override
  String get commandOrderCheck => 'Verificar';

  @override
  String commandOrderWrongExtra(Object card) {
    return '“$card” não é necessário para esta tarefa. Tire-o da caixa.';
  }

  @override
  String commandOrderWrongTooEarly(Object number, Object card) {
    return 'Ainda é cedo para “$card” na caixa $number. Outro passo precisa vir antes.';
  }

  @override
  String commandOrderHint(Object levelHint, Object card, Object number) {
    return '$levelHint O cartão que brilha, “$card”, vai na caixa $number.';
  }

  @override
  String commandOrderSlotCard(Object number, Object card) {
    return 'Caixa $number: $card. Toque para tirar.';
  }

  @override
  String commandOrderEmptySlot(Object number) {
    return 'Caixa $number, vazia. Toque para colocar um cartão aqui.';
  }

  @override
  String get ifThenIncomplete => 'Primeiro preencha as caixas vazias.';

  @override
  String get ifThenSuccess =>
      'Muito bem! O robô seguiu as regras e chegou à bandeira!';

  @override
  String get ifThenSolved =>
      'Suas regras estão certas! Toque no botão verde Começar.';

  @override
  String get ifThenNoSlot =>
      'Não há nenhuma caixa vazia para este bloco. Toque na caixa que você quer trocar para esvaziá-la.';

  @override
  String get ifThenLockedSlot =>
      'Esta caixa já veio pronta e não pode ser trocada. Coloque o bloco em uma caixa vazia.';

  @override
  String get ifThenWrongType =>
      'Este bloco não cabe aí. As coisas vão na caixa “Se”, e os movimentos vão ao lado da seta.';

  @override
  String get ifThenLane => 'O caminho do robô';

  @override
  String get ifThenObjects => 'Coisas';

  @override
  String get ifThenActions => 'Movimentos';

  @override
  String get ifThenIf => 'Se';

  @override
  String get ifThenElseIf => 'Senão, se';

  @override
  String get ifThenElse => 'Senão';

  @override
  String get ifThenThen => 'está à frente';

  @override
  String ifThenObjectLabel(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Caminho vazio',
      'rock': 'Pedra',
      'water': 'Água',
      'door': 'Porta',
      'other': 'Estrela',
    });
    return '$_temp0';
  }

  @override
  String ifThenActionLabel(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'forward': 'Ir em frente',
      'jump': 'Pular',
      'bridge': 'Fazer ponte',
      'open': 'Abrir porta',
      'other': 'Pegar',
    });
    return '$_temp0';
  }

  @override
  String ifThenObjectName(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'um caminho vazio',
      'rock': 'uma pedra',
      'water': 'água',
      'door': 'uma porta',
      'other': 'uma estrela',
    });
    return '$_temp0';
  }

  @override
  String ifThenProblem(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Num caminho vazio, isso não é preciso.',
      'rock': 'Não dá para atravessar uma pedra.',
      'water': 'O robô não sabe nadar!',
      'door': 'Não dá para passar com a porta fechada.',
      'other': 'A estrela ficou no chão.',
    });
    return '$_temp0';
  }

  @override
  String ifThenAdvice(String object) {
    String _temp0 = intl.Intl.selectLogic(object, {
      'empty': 'Se o caminho está vazio, o robô pode ir em frente.',
      'rock': 'Para passar por uma pedra, é só pular.',
      'water': 'Para atravessar a água, é preciso fazer uma ponte.',
      'door': 'Para passar pela porta, primeiro é preciso abri-la.',
      'other': 'Use o bloco Pegar para pegar a estrela.',
    });
    return '$_temp0';
  }

  @override
  String ifThenRuleNumber(Object number) {
    return 'A regra $number';
  }

  @override
  String get ifThenElseRule => 'A linha “Senão”';

  @override
  String ifThenWrong(
    Object object,
    Object rule,
    Object action,
    Object problem,
  ) {
    return 'Tinha $object à frente. $rule foi usada e o robô fez “$action”. $problem Mude as regras e tente de novo.';
  }

  @override
  String ifThenHint(Object object, Object advice) {
    return 'No quadrado que brilha tem $object. $advice';
  }

  @override
  String ifThenSlot(String kind, Object value) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'condition': 'Caixa de condição',
      'other': 'Caixa de movimento',
    });
    return '$_temp0: $value';
  }

  @override
  String get ifThenSlotEmpty => 'vazia';

  @override
  String ifThenSlotReady(Object label) {
    return '$label, pronta';
  }

  @override
  String ifThenPaletteBlock(String kind, Object label) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'action': 'Movimento',
      'other': 'Coisa',
    });
    return '$_temp0: $label';
  }

  @override
  String get repeatIntro =>
      'Leve o robô até a bandeira. Use o bloco Repetir em vez de adicionar o mesmo movimento várias vezes.';

  @override
  String get repeatCoinIntro =>
      'Primeiro pegue todas as moedas, depois vá até a bandeira. O bloco Repetir deixa tudo mais fácil.';

  @override
  String get repeatEmpty => 'Primeiro adicione uma seta ou um bloco Repetir.';

  @override
  String get repeatFull =>
      'Você chegou ao limite de blocos. Se estiver pronto, toque no botão verde Começar; para mudar algo, escolha um bloco e apague-o.';

  @override
  String get repeatInsideRepeat =>
      'As setas que você adicionar agora vão entrar no bloco laranja. Quando terminar, toque no botão azul-escuro Sair do bloco.';

  @override
  String get repeatEmptyStrip =>
      'Adicione uma seta ou um bloco Repetir e seus blocos vão aparecer em fila aqui.';

  @override
  String get repeatOutsideRepeat =>
      'As setas que você adicionar agora vão ficar fora do bloco, no final.';

  @override
  String get repeatMovedOut =>
      'A seta saiu do bloco. As setas que você adicionar agora também vão ficar fora, no final.';

  @override
  String get repeatEmptyRepeat =>
      'O bloco laranja está vazio. Eu o escolhi para você; agora adicione uma seta dentro dele.';

  @override
  String get repeatMissedGoal =>
      'O robô não chegou à bandeira. Tente trocar o número de repetições ou as setas.';

  @override
  String get repeatSolved =>
      'Seus blocos estão certos! Toque no botão verde Começar.';

  @override
  String get repeatFullHint =>
      'Você chegou ao limite de blocos. Tente trocar um número de repetições, ou apague um bloco e coloque um bloco Repetir no lugar.';

  @override
  String get repeatAddRepeat => 'Repetir';

  @override
  String get repeatLeaveRepeat => 'Sair do bloco ✓';

  @override
  String get repeatAddRepeatLabel => 'Adicionar um bloco Repetir';

  @override
  String get repeatLeaveRepeatLabel =>
      'Sair do bloco; as próximas setas ficam fora';

  @override
  String get repeatDropHere => 'Adicione setas aqui';

  @override
  String get repeatEmptyBody => 'Vazio';

  @override
  String get repeatDecrease => 'Diminuir o número de repetições';

  @override
  String get repeatIncrease => 'Aumentar o número de repetições';

  @override
  String get repeatDeleteLabel => 'Apagar o bloco escolhido';

  @override
  String get repeatMoveOutLabel => 'Tirar a seta escolhida do bloco laranja';

  @override
  String repeatTimes(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: '$times vezes',
      one: '1 vez',
    );
    return '$_temp0';
  }

  @override
  String repeatTimesFull(int times) {
    String _temp0 = intl.Intl.pluralLogic(
      times,
      locale: localeName,
      other: 'repetir $times vezes',
      one: 'repetir 1 vez',
    );
    return '$_temp0';
  }

  @override
  String repeatAddMove(Object direction) {
    return 'Adicionar a seta “$direction”';
  }

  @override
  String repeatArrowName(Object number) {
    return 'A seta $number';
  }

  @override
  String repeatBlockName(Object number) {
    return 'O bloco $number';
  }

  @override
  String repeatInnerArrowName(Object block, Object arrow) {
    return 'A seta $arrow dentro do bloco $block';
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
      other: 'repetir $times vezes',
      one: 'repetir 1 vez',
    );
    return 'Bloco $number: $_temp0. Toque para adicionar setas dentro.';
  }

  @override
  String repeatFixCount(Object number) {
    return 'Tente trocar o número de repetições do bloco $number ou as setas dentro dele.';
  }

  @override
  String repeatOffPath(Object place) {
    return '$place tira o robô do caminho.';
  }

  @override
  String repeatBlocked(Object obstacle, Object advice) {
    return 'O robô deu de cara com $obstacle. $advice';
  }

  @override
  String repeatBlockedInRound(Object round, Object obstacle, Object advice) {
    return 'Na volta $round, o robô deu de cara com $obstacle. $advice';
  }

  @override
  String repeatFixHint(Object advice) {
    return '$advice Eu marquei de vermelho o lugar errado para você.';
  }

  @override
  String repeatNextMoveHint(Object levelHint, Object direction) {
    return '$levelHint Olhe o quadrado que brilha; ali o robô precisa seguir a seta “$direction”.';
  }

  @override
  String get repeatL1Intro =>
      'O robô precisa ir 3 vezes para a direita, mas você só pode usar 2 blocos. Adicione um bloco Repetir e coloque a seta para a direita dentro dele.';

  @override
  String get repeatL1Hint =>
      'O bloco Repetir faz a seta que está dentro dele quantas vezes você quiser. Quantas vezes o robô precisa ir para a direita?';

  @override
  String get repeatL2Intro =>
      'A bandeira está lá em cima. Use o bloco Repetir em vez de adicionar a mesma seta várias vezes.';

  @override
  String get repeatL2Hint =>
      'O robô vai sempre para o mesmo lado. Para qual lado, e quantas vezes?';

  @override
  String get repeatL3Hint =>
      'O robô está indo para baixo. Conte os quadrados e escolha o número de repetições.';

  @override
  String get repeatL4Hint =>
      'Desta vez para a esquerda. Você pode mudar o número de repetições com os botões − e +.';

  @override
  String get repeatL5Intro =>
      'Pegue também as moedas do caminho! Continuam sendo só 2 blocos.';

  @override
  String get repeatL5Hint =>
      'As moedas estão entre o robô e a bandeira, na mesma fileira. O robô só vai para a direita.';

  @override
  String get repeatL6Intro =>
      'Desça como numa escada: direita, baixo, direita, baixo... Você pode colocar duas setas dentro de um bloco Repetir.';

  @override
  String get repeatL6Hint =>
      'Um degrau: uma vez para a direita, uma vez para baixo. Quantos degraus tem?';

  @override
  String get repeatL7Hint =>
      'Duas vezes para a direita, uma vez para cima. Quantas vezes esse padrão se repete?';

  @override
  String get repeatL8Hint =>
      'Primeiro duas para a direita, depois uma para baixo. Repita isso.';

  @override
  String get repeatL9Intro =>
      'Você também pode adicionar uma seta sozinha depois do bloco Repetir.';

  @override
  String get repeatL9Hint =>
      'Repita o padrão cima-esquerda; talvez você precise de mais um passo no final.';

  @override
  String get repeatL10Hint =>
      'Cada degrau tem dois quadrados de largura e um quadrado de altura.';

  @override
  String get repeatL11Intro =>
      'Desta vez você precisa de dois blocos Repetir: um para a direita e outro para baixo.';

  @override
  String get repeatL11Hint =>
      'Quantos quadrados para a direita primeiro? E depois, quantos para baixo? Use um bloco Repetir para cada um.';

  @override
  String get repeatL12Hint =>
      'Primeiro suba, depois vá para a direita. Dois blocos Repetir, dois números diferentes.';

  @override
  String get repeatL13Hint =>
      'Dê a volta nas pedras: direita, baixo, esquerda. Conte os quadrados de cada direção.';

  @override
  String get repeatL14Hint =>
      'O caminho tem três partes: direita, baixo e direita de novo.';

  @override
  String get repeatL15Hint =>
      'As duas moedas estão nas curvas do caminho. Faça cada parte reta com um bloco Repetir.';

  @override
  String get repeatL16Intro =>
      'Só 4 blocos! Percorra o caminho longo com um padrão curto.';

  @override
  String get repeatL16Hint =>
      'As moedas estão em diagonal: repare no padrão direita-baixo.';

  @override
  String get repeatL17Hint =>
      'Cada degrau tem dois quadrados de altura e dois quadrados de largura.';

  @override
  String get repeatL18Hint =>
      'Duas para a direita, duas para baixo. Esse padrão continua até a bandeira.';

  @override
  String get repeatL19Hint =>
      'As moedas estão nas pontas dos degraus. Um degrau: duas para a direita, uma para baixo.';

  @override
  String get repeatL20Intro =>
      'Um caminho longo que faz curvas como uma cobra. Use bem os 10 blocos.';

  @override
  String get repeatL20Hint =>
      'O caminho tem cinco partes retas. Faça cada parte com um bloco Repetir.';

  @override
  String get ifThenL1Intro =>
      'Se tiver uma pedra à frente, o que o robô deve fazer? Coloque um movimento na caixa vazia.';

  @override
  String get ifThenL2Intro =>
      'O robô não sabe nadar. Se tiver água à frente, o que ele deve fazer?';

  @override
  String get ifThenL3Intro =>
      'Tem uma porta fechada no caminho. O que o robô deve fazer quando chegar à porta?';

  @override
  String get ifThenL4Intro =>
      'Não passe pelas estrelas sem pegá-las! Se tiver uma estrela à frente, o que o robô deve fazer?';

  @override
  String get ifThenL5Intro =>
      'Desta vez você também escolhe a condição. O que tem no caminho?';

  @override
  String get ifThenL6Intro =>
      'Se tiver uma pedra, faça uma coisa; senão, faça outra. Preencha as duas caixas.';

  @override
  String get ifThenL7Intro =>
      'O que ele deve fazer se tiver água? E se não tiver água?';

  @override
  String get ifThenL8Intro =>
      'Neste caminho não tem quadrados vazios! Se não tiver uma porta, o que está à frente?';

  @override
  String get ifThenL9Intro => 'Escolha a condição e os dois movimentos.';

  @override
  String get ifThenL10Intro =>
      'Tem pedras e água no caminho. Uma regra e um “Senão” bastam.';

  @override
  String get ifThenL11Intro =>
      'Também tem pedras e água. Faça uma regra para cada uma.';

  @override
  String get ifThenL12Intro => 'Abra as portas e pegue as estrelas.';

  @override
  String get ifThenL13Intro =>
      'Tem três coisas diferentes, mas só duas linhas de regra. Use “Senão” para a terceira.';

  @override
  String get ifThenL14Intro =>
      'Água, portas e caminho vazio. Qual delas você vai deixar para o “Senão”?';

  @override
  String get ifThenL15Intro =>
      'Cuidado: um dos blocos nem aparece neste caminho.';

  @override
  String get ifThenL16Intro =>
      'O robô está indo para o castelo: tem pedras, fossos e portas do castelo.';

  @override
  String get ifThenL17Intro =>
      'Caminho do tesouro: pegue as estrelas e passe pelos obstáculos.';

  @override
  String get ifThenL18Intro =>
      'Neste caminho não tem quadrados vazios. Quatro coisas precisam de quatro decisões.';

  @override
  String get ifThenL19Intro =>
      'Uma longa viagem! Água, pedras, portas e caminho vazio.';

  @override
  String get ifThenL20Intro =>
      'Última tarefa: pegue todas as estrelas e chegue à bandeira.';

  @override
  String get pathFinderL1Intro =>
      'Leve o robô até a bandeira. Aperte a seta para a direita e depois toque no botão verde Começar.';

  @override
  String get pathFinderL2Intro =>
      'A bandeira está acima do robô. Qual seta você deve escolher?';

  @override
  String get pathFinderL3Intro =>
      'A bandeira está à esquerda, a dois quadrados.';

  @override
  String get pathFinderL4Intro => 'O robô precisa descer. Quantas vezes?';

  @override
  String get pathFinderL5Intro =>
      'Desta vez você vai usar duas direções diferentes.';

  @override
  String get pathFinderL11Intro => 'Tem uma pedra no caminho. Dê a volta nela.';

  @override
  String get pathFinderL12Intro =>
      'As pedras estão enfileiradas como um muro. Dê a volta por baixo.';

  @override
  String get pathFinderL13Intro =>
      'O robô não pode entrar na água. Ache o caminho seco.';

  @override
  String get pathFinderL15Intro =>
      'Tem mais de um caminho. Você consegue achar o mais curto?';

  @override
  String get commandOrderL1Title => 'Regar a flor';

  @override
  String get commandOrderL1Step1 => 'Encher o regador';

  @override
  String get commandOrderL1Step2 => 'Molhar a flor';

  @override
  String get commandOrderL1Hint =>
      'Para regar a flor, primeiro precisa ter água no regador.';

  @override
  String get commandOrderL2Title => 'Escovar os dentes';

  @override
  String get commandOrderL2Step1 => 'Pôr pasta na escova';

  @override
  String get commandOrderL2Step2 => 'Escovar os dentes';

  @override
  String get commandOrderL2Step3 => 'Enxaguar a boca';

  @override
  String get commandOrderL2Hint =>
      'Antes de começar a escovar, precisa ter pasta na escova.';

  @override
  String get commandOrderL3Title => 'Lavar as mãos';

  @override
  String get commandOrderL3Step1 => 'Ensaboar as mãos';

  @override
  String get commandOrderL3Step2 => 'Enxaguar as mãos';

  @override
  String get commandOrderL3Step3 => 'Secar as mãos';

  @override
  String get commandOrderL3Hint =>
      'Você não pode secar as mãos antes de tirar a espuma.';

  @override
  String get commandOrderL4Title => 'Calçar os sapatos';

  @override
  String get commandOrderL4Step1 => 'Pôr as meias';

  @override
  String get commandOrderL4Step2 => 'Calçar os sapatos';

  @override
  String get commandOrderL4Step3 => 'Amarrar os cadarços';

  @override
  String get commandOrderL4Hint =>
      'O que precisa estar no seu pé antes de ele entrar no sapato?';

  @override
  String get commandOrderL5Title => 'Fazer um desenho';

  @override
  String get commandOrderL5Step1 => 'Pegar uma folha de papel';

  @override
  String get commandOrderL5Step2 => 'Desenhar';

  @override
  String get commandOrderL5Step3 => 'Pintar o desenho';

  @override
  String get commandOrderL5Hint =>
      'Para pintar, você precisa de um desenho já feito.';

  @override
  String get commandOrderL6Title => 'Fazer um sanduíche';

  @override
  String get commandOrderL6Step1 => 'Pôr o prato na mesa';

  @override
  String get commandOrderL6Step2 => 'Pôr o pão no prato';

  @override
  String get commandOrderL6Step3 => 'Pôr queijo por cima';

  @override
  String get commandOrderL6Step4 => 'Cobrir com pão';

  @override
  String get commandOrderL6Step5 => 'Bom apetite!';

  @override
  String get commandOrderL6Hint =>
      'Você precisa de um lugar para pôr o pão. O que deve estar na mesa primeiro?';

  @override
  String get commandOrderL7Title => 'Guardar os brinquedos';

  @override
  String get commandOrderL7Step1 => 'Trazer a caixa';

  @override
  String get commandOrderL7Step2 => 'Pôr os brinquedos na caixa';

  @override
  String get commandOrderL7Step3 => 'Fechar a tampa';

  @override
  String get commandOrderL7Step4 => 'Pôr a caixa na prateleira';

  @override
  String get commandOrderL7Hint =>
      'O que você faz se a caixa dos brinquedos não estiver do seu lado?';

  @override
  String get commandOrderL8Title => 'Plantar uma semente';

  @override
  String get commandOrderL8Step1 => 'Cavar um buraco na terra';

  @override
  String get commandOrderL8Step2 => 'Pôr a semente no buraco';

  @override
  String get commandOrderL8Step3 => 'Cobrir com terra';

  @override
  String get commandOrderL8Step4 => 'Regar a semente';

  @override
  String get commandOrderL8Step5 => 'Esperar o broto';

  @override
  String get commandOrderL8Hint =>
      'Você não pode pôr a semente na terra sem um buraco para ela.';

  @override
  String get commandOrderL9Title => 'Ficar pronto para a escola';

  @override
  String get commandOrderL9Step1 => 'Acordar quando o despertador tocar';

  @override
  String get commandOrderL9Step2 => 'Vestir a roupa da escola';

  @override
  String get commandOrderL9Step3 => 'Pôr a mochila nas costas';

  @override
  String get commandOrderL9Step4 => 'Entrar no ônibus escolar';

  @override
  String get commandOrderL9Hint =>
      'Você não pode se vestir antes de acordar. O que acontece primeiro de manhã?';

  @override
  String get commandOrderL10Title => 'Mandar uma carta';

  @override
  String get commandOrderL10Step1 => 'Escrever a carta';

  @override
  String get commandOrderL10Step2 => 'Pôr a carta no envelope';

  @override
  String get commandOrderL10Step3 => 'Fechar o envelope';

  @override
  String get commandOrderL10Step4 => 'Pôr na caixa do correio';

  @override
  String get commandOrderL10Hint =>
      'Precisa ter uma carta para pôr no envelope.';

  @override
  String get commandOrderL11Title => 'Fazer um bolo';

  @override
  String get commandOrderL11Stage1 => 'Fazer a massa';

  @override
  String get commandOrderL11Stage2 => 'Assar o bolo';

  @override
  String get commandOrderL11Step1 => 'Pôr os ingredientes na mesa';

  @override
  String get commandOrderL11Step2 => 'Misturar tudo numa tigela';

  @override
  String get commandOrderL11Step3 => 'Despejar a massa na forma';

  @override
  String get commandOrderL11Step4 => 'Pôr a forma no forno';

  @override
  String get commandOrderL11Step5 => 'Esperar o bolo ficar pronto';

  @override
  String get commandOrderL11Step6 => 'Cortar o bolo';

  @override
  String get commandOrderL11Hint =>
      'Você não pode pôr nada no forno antes de a massa ficar pronta.';

  @override
  String get commandOrderL12Title => 'Tomar banho';

  @override
  String get commandOrderL12Stage1 => 'Preparar o banho';

  @override
  String get commandOrderL12Stage2 => 'Hora de lavar';

  @override
  String get commandOrderL12Stage3 => 'Hora de secar';

  @override
  String get commandOrderL12Step1 => 'Encher a banheira de água';

  @override
  String get commandOrderL12Step2 => 'Entrar na banheira';

  @override
  String get commandOrderL12Step3 => 'Lavar o cabelo com xampu';

  @override
  String get commandOrderL12Step4 => 'Enxaguar a espuma';

  @override
  String get commandOrderL12Step5 => 'Se secar com a toalha';

  @override
  String get commandOrderL12Hint =>
      'Se você entrar numa banheira vazia, não dá para se lavar.';

  @override
  String get commandOrderL13Title => 'Andar de bicicleta';

  @override
  String get commandOrderL13Stage1 => 'Preparação';

  @override
  String get commandOrderL13Stage2 => 'Passeio';

  @override
  String get commandOrderL13Stage3 => 'Chegada';

  @override
  String get commandOrderL13Step1 => 'Pôr o capacete';

  @override
  String get commandOrderL13Step2 => 'Subir na bicicleta';

  @override
  String get commandOrderL13Step3 => 'Pedalar';

  @override
  String get commandOrderL13Step4 => 'Usar os freios';

  @override
  String get commandOrderL13Step5 => 'Descer da bicicleta';

  @override
  String get commandOrderL13Hint =>
      'A segurança vem primeiro. O que você põe antes de subir na bicicleta?';

  @override
  String get commandOrderL14Title => 'Pegar um livro na biblioteca';

  @override
  String get commandOrderL14Stage1 => 'Na biblioteca';

  @override
  String get commandOrderL14Stage2 => 'Em casa';

  @override
  String get commandOrderL14Stage3 => 'Devolução';

  @override
  String get commandOrderL14Step1 => 'Ir à biblioteca';

  @override
  String get commandOrderL14Step2 => 'Escolher um livro';

  @override
  String get commandOrderL14Step3 => 'Pegar o livro emprestado';

  @override
  String get commandOrderL14Step4 => 'Levar o livro para casa';

  @override
  String get commandOrderL14Step5 => 'Ler o livro';

  @override
  String get commandOrderL14Step6 => 'Devolver o livro';

  @override
  String get commandOrderL14Hint =>
      'Para escolher um livro, primeiro você precisa ir aonde os livros estão.';

  @override
  String get commandOrderL15Title => 'Montar uma barraca';

  @override
  String get commandOrderL15Stage1 => 'Preparar o lugar';

  @override
  String get commandOrderL15Stage2 => 'Montar a barraca';

  @override
  String get commandOrderL15Stage3 => 'Arrumar o lado de dentro';

  @override
  String get commandOrderL15Step1 => 'Achar um lugar plano';

  @override
  String get commandOrderL15Step2 => 'Estender a barraca no chão';

  @override
  String get commandOrderL15Step3 => 'Colocar as varetas';

  @override
  String get commandOrderL15Step4 => 'Levantar a barraca';

  @override
  String get commandOrderL15Step5 => 'Prender com estacas';

  @override
  String get commandOrderL15Step6 => 'Pôr o saco de dormir dentro';

  @override
  String get commandOrderL15Step7 => 'Acender a lanterna';

  @override
  String get commandOrderL15Hint =>
      'Para estender a barraca, primeiro você precisa achar um bom lugar.';

  @override
  String get commandOrderL16Title => 'Fazer uma pizza';

  @override
  String get commandOrderL16Stage1 => 'Massa';

  @override
  String get commandOrderL16Stage2 => 'Recheio';

  @override
  String get commandOrderL16Stage3 => 'Forno';

  @override
  String get commandOrderL16Step1 => 'Abrir a massa';

  @override
  String get commandOrderL16Step2 => 'Espalhar o molho de tomate';

  @override
  String get commandOrderL16Step3 => 'Pôr queijo por cima';

  @override
  String get commandOrderL16Step4 => 'Pôr a pizza no forno';

  @override
  String get commandOrderL16Step5 => 'Esperar a pizza ficar pronta';

  @override
  String get commandOrderL16Step6 => 'Cortar em pedaços';

  @override
  String get commandOrderL16Extra1 => 'Ligar a TV';

  @override
  String get commandOrderL16Hint =>
      'Nem todo cartão faz parte desta tarefa. Você precisa da TV para fazer uma pizza?';

  @override
  String get commandOrderL17Title => 'Lavar a roupa';

  @override
  String get commandOrderL17Stage1 => 'Preparação';

  @override
  String get commandOrderL17Stage2 => 'Lavagem';

  @override
  String get commandOrderL17Stage3 => 'Secagem';

  @override
  String get commandOrderL17Step1 => 'Juntar a roupa suja';

  @override
  String get commandOrderL17Step2 => 'Pôr a roupa na máquina';

  @override
  String get commandOrderL17Step3 => 'Pôr o sabão';

  @override
  String get commandOrderL17Step4 => 'Ligar a máquina';

  @override
  String get commandOrderL17Step5 => 'Estender a roupa no varal';

  @override
  String get commandOrderL17Step6 => 'Dobrar a roupa quando secar';

  @override
  String get commandOrderL17Extra1 => 'Jogar bola';

  @override
  String get commandOrderL17Hint =>
      'Se a roupa suja está espalhada pela casa, o que você deve fazer primeiro?';

  @override
  String get commandOrderL18Title => 'Viajar de trem';

  @override
  String get commandOrderL18Stage1 => 'Na estação';

  @override
  String get commandOrderL18Stage2 => 'No trem';

  @override
  String get commandOrderL18Stage3 => 'Chegada';

  @override
  String get commandOrderL18Step1 => 'Comprar a passagem';

  @override
  String get commandOrderL18Step2 => 'Ir para a plataforma';

  @override
  String get commandOrderL18Step3 => 'Esperar o trem';

  @override
  String get commandOrderL18Step4 => 'Entrar no trem';

  @override
  String get commandOrderL18Step5 => 'Sentar no seu lugar';

  @override
  String get commandOrderL18Step6 => 'Descer na sua parada';

  @override
  String get commandOrderL18Extra1 => 'Embarcar no avião';

  @override
  String get commandOrderL18Hint =>
      'O que você precisa ter para entrar no trem?';

  @override
  String get commandOrderL19Title => 'Cuidar de uma mudinha';

  @override
  String get commandOrderL19Stage1 => 'Plantio';

  @override
  String get commandOrderL19Stage2 => 'Cuidados';

  @override
  String get commandOrderL19Stage3 => 'Crescimento';

  @override
  String get commandOrderL19Step1 => 'Pôr terra no vaso';

  @override
  String get commandOrderL19Step2 => 'Plantar a semente';

  @override
  String get commandOrderL19Step3 => 'Regar a semente';

  @override
  String get commandOrderL19Step4 => 'Pôr o vaso no sol';

  @override
  String get commandOrderL19Step5 => 'Esperar o broto';

  @override
  String get commandOrderL19Step6 => 'Plantar a muda no jardim';

  @override
  String get commandOrderL19Extra1 => 'Abrir um guarda-chuva';

  @override
  String get commandOrderL19Extra2 => 'Pôr o vaso no escuro';

  @override
  String get commandOrderL19Hint =>
      'As plantas precisam de água e de sol para crescer. Quais cartões fariam mal a elas?';

  @override
  String get commandOrderL20Title => 'Fazer biscoitos e dividir';

  @override
  String get commandOrderL20Stage1 => 'Preparação';

  @override
  String get commandOrderL20Stage2 => 'No forno';

  @override
  String get commandOrderL20Stage3 => 'Hora de dividir';

  @override
  String get commandOrderL20Step1 => 'Lavar as mãos';

  @override
  String get commandOrderL20Step2 => 'Misturar os ingredientes';

  @override
  String get commandOrderL20Step3 => 'Modelar a massa';

  @override
  String get commandOrderL20Step4 => 'Assar os biscoitos';

  @override
  String get commandOrderL20Step5 => 'Deixar esfriar';

  @override
  String get commandOrderL20Step6 => 'Pôr os biscoitos numa caixa';

  @override
  String get commandOrderL20Step7 => 'Dividir com os amigos';

  @override
  String get commandOrderL20Extra1 => 'Brincar com um carrinho';

  @override
  String get commandOrderL20Extra2 => 'Ir dormir';

  @override
  String get commandOrderL20Hint =>
      'Antes de mexer na cozinha, você precisa estar limpo.';
}
