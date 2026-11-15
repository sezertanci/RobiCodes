import 'if_then_level.dart';

/// "Eğer Böyleyse" oyununun 20 seviyesi. Yollar, hazır kutular ve cümleler web sürümüyle aynıdır.
final ifThenBaseLevels = <IfThenLevel>[
  // Kolay 1–5: tek koşul ve tek karar. "Değilse" hazır: İleri Git.
  IfThenLevel(
    lane: '..#..',
    rules: [RuleSlot(condition: LaneObject.rock)],
    otherwise: LaneAction.forward,
    intro: (t) => t.ifThenL1Intro,
  ),
  IfThenLevel(
    lane: '.~..~',
    rules: [RuleSlot(condition: LaneObject.water)],
    otherwise: LaneAction.forward,
    intro: (t) => t.ifThenL2Intro,
  ),
  IfThenLevel(
    lane: '..D..',
    rules: [RuleSlot(condition: LaneObject.door)],
    otherwise: LaneAction.forward,
    intro: (t) => t.ifThenL3Intro,
  ),
  IfThenLevel(
    lane: '.*.*.',
    rules: [RuleSlot(condition: LaneObject.star)],
    otherwise: LaneAction.forward,
    intro: (t) => t.ifThenL4Intro,
  ),
  IfThenLevel(
    lane: '#..#.',
    rules: [RuleSlot()],
    otherwise: LaneAction.forward,
    extras: [LaneObject.water],
    intro: (t) => t.ifThenL5Intro,
  ),

  // Orta 6–10: eğer / değilse ile iki olasılık.
  IfThenLevel(
    lane: '..#..#',
    rules: [RuleSlot(condition: LaneObject.rock)],
    intro: (t) => t.ifThenL6Intro,
  ),
  IfThenLevel(
    lane: '~.~.~.',
    rules: [RuleSlot(condition: LaneObject.water)],
    intro: (t) => t.ifThenL7Intro,
  ),
  IfThenLevel(
    lane: 'D*D*D*',
    rules: [RuleSlot(condition: LaneObject.door)],
    intro: (t) => t.ifThenL8Intro,
  ),
  IfThenLevel(lane: '.*..*.', rules: [RuleSlot()], extras: [LaneObject.rock], intro: (t) => t.ifThenL9Intro),
  IfThenLevel(lane: '~#~~#', rules: [RuleSlot()], intro: (t) => t.ifThenL10Intro),

  // Zor 11–15: birden fazla koşul.
  IfThenLevel(lane: '.#.~.#.', rules: [RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL11Intro),
  IfThenLevel(lane: 'D.*.D.*', rules: [RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL12Intro),
  IfThenLevel(lane: '#~*#~*', rules: [RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL13Intro),
  IfThenLevel(lane: '~D~.D~', rules: [RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL14Intro),
  IfThenLevel(
    lane: '*#.*#.',
    rules: [RuleSlot(), RuleSlot()],
    extras: [LaneObject.water],
    intro: (t) => t.ifThenL15Intro,
  ),

  // Uzman 16–20: birkaç koşulu birleştiren küçük senaryolar.
  IfThenLevel(lane: '#~D.#~D.', rules: [RuleSlot(), RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL16Intro),
  IfThenLevel(lane: '.*#~*.#~', rules: [RuleSlot(), RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL17Intro),
  IfThenLevel(lane: 'D*~#D*~#', rules: [RuleSlot(), RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL18Intro),
  IfThenLevel(lane: '~#..D~#.D', rules: [RuleSlot(), RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL19Intro),
  IfThenLevel(lane: '*D#~*D#~*', rules: [RuleSlot(), RuleSlot(), RuleSlot()], intro: (t) => t.ifThenL20Intro),
];
