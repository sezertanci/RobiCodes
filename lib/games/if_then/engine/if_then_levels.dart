import 'if_then_level.dart';

/// "Eğer Böyleyse" oyununun 20 seviyesi. Yollar, hazır kutular ve cümleler web sürümüyle aynıdır.
const ifThenBaseLevels = <IfThenLevel>[
  // Kolay 1–5: tek koşul ve tek karar. "Değilse" hazır: İleri Git.
  IfThenLevel(
    lane: '..#..',
    rules: [RuleSlot(condition: LaneObject.rock)],
    otherwise: LaneAction.forward,
    intro: 'Önünde taş varsa robot ne yapmalı? Boş kutuya bir hareket koy.',
  ),
  IfThenLevel(
    lane: '.~..~',
    rules: [RuleSlot(condition: LaneObject.water)],
    otherwise: LaneAction.forward,
    intro: 'Robot yüzemez. Önünde su varsa ne yapmalı?',
  ),
  IfThenLevel(
    lane: '..D..',
    rules: [RuleSlot(condition: LaneObject.door)],
    otherwise: LaneAction.forward,
    intro: 'Yolda kapalı bir kapı var. Kapının önüne gelince ne yapmalı?',
  ),
  IfThenLevel(
    lane: '.*.*.',
    rules: [RuleSlot(condition: LaneObject.star)],
    otherwise: LaneAction.forward,
    intro: 'Yıldızları toplamadan geçme! Önünde yıldız varsa ne yapmalı?',
  ),
  IfThenLevel(
    lane: '#..#.',
    rules: [RuleSlot()],
    otherwise: LaneAction.forward,
    extras: [LaneObject.water],
    intro: 'Bu kez koşulu da sen seç. Yolda ne var?',
  ),

  // Orta 6–10: eğer / değilse ile iki olasılık.
  IfThenLevel(
    lane: '..#..#',
    rules: [RuleSlot(condition: LaneObject.rock)],
    intro: 'Taş varsa bir şey, yoksa başka bir şey yapmalı. İki kutuyu da doldur.',
  ),
  IfThenLevel(
    lane: '~.~.~.',
    rules: [RuleSlot(condition: LaneObject.water)],
    intro: 'Su varsa ne yapmalı? Su yoksa ne yapmalı?',
  ),
  IfThenLevel(
    lane: 'D*D*D*',
    rules: [RuleSlot(condition: LaneObject.door)],
    intro: 'Bu yolda boş kare yok! Kapı yoksa önünde ne var?',
  ),
  IfThenLevel(lane: '.*..*.', rules: [RuleSlot()], extras: [LaneObject.rock], intro: 'Koşulu ve iki hareketi sen seç.'),
  IfThenLevel(lane: '~#~~#', rules: [RuleSlot()], intro: 'Yolda taş ve su var. Bir kural ve bir "değilse" yeter.'),

  // Zor 11–15: birden fazla koşul.
  IfThenLevel(
    lane: '.#.~.#.',
    rules: [RuleSlot(), RuleSlot()],
    intro: 'Taş da var su da. Her biri için bir kural kur.',
  ),
  IfThenLevel(lane: 'D.*.D.*', rules: [RuleSlot(), RuleSlot()], intro: 'Kapıları aç, yıldızları topla.'),
  IfThenLevel(
    lane: '#~*#~*',
    rules: [RuleSlot(), RuleSlot()],
    intro: 'Üç farklı şey var ama iki kural satırı. Üçüncüsü için "değilse" kullan.',
  ),
  IfThenLevel(
    lane: '~D~.D~',
    rules: [RuleSlot(), RuleSlot()],
    intro: 'Su, kapı ve boş yol. Hangisini "değilse"ye bırakırsın?',
  ),
  IfThenLevel(
    lane: '*#.*#.',
    rules: [RuleSlot(), RuleSlot()],
    extras: [LaneObject.water],
    intro: 'Dikkat: bloklardan biri bu yolda hiç yok.',
  ),

  // Uzman 16–20: birkaç koşulu birleştiren küçük senaryolar.
  IfThenLevel(
    lane: '#~D.#~D.',
    rules: [RuleSlot(), RuleSlot(), RuleSlot()],
    intro: 'Robot kaleye gidiyor: taşlar, hendekler ve kale kapıları var.',
  ),
  IfThenLevel(
    lane: '.*#~*.#~',
    rules: [RuleSlot(), RuleSlot(), RuleSlot()],
    intro: 'Hazine yolu: yıldızları topla, engelleri aş.',
  ),
  IfThenLevel(
    lane: 'D*~#D*~#',
    rules: [RuleSlot(), RuleSlot(), RuleSlot()],
    intro: 'Bu yolda hiç boş kare yok. Dört şey için dört karar gerek.',
  ),
  IfThenLevel(
    lane: '~#..D~#.D',
    rules: [RuleSlot(), RuleSlot(), RuleSlot()],
    intro: 'Uzun bir yolculuk! Su, taş, kapı ve boş yol.',
  ),
  IfThenLevel(
    lane: '*D#~*D#~*',
    rules: [RuleSlot(), RuleSlot(), RuleSlot()],
    intro: 'Son görev: bütün yıldızları toplayıp bayrağa ulaş.',
  ),
];
