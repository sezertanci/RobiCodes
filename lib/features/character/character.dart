import 'package:flutter/foundation.dart';

import '../../l10n/l10n.dart';

/// Oyunda seçilebilen bir karakter. Seçilen karakter ana ekranda ve bütün oyunlarda (harita,
/// konuşma balonu, yol sahnesi) görünür.
@immutable
final class Character {
  const Character({required this.id, required this.image});

  /// Kayıtta saklanan kimlik; karakter adı değişse de kayıt bozulmaz.
  final String id;
  final String image;

  /// Karakterin seçili dildeki adı.
  String name(AppLocalizations t) => t.characterName(id);
}

/// Seçilebilen karakterler. Liste ve görseller web sürümündeki `js/core/characters.js` ile aynıdır.
abstract final class CharacterRoster {
  static const robi = Character(id: 'robi', image: 'assets/characters/robot.webp');

  static const all = [
    robi,
    Character(id: 'fiyo', image: 'assets/characters/robot-bow.webp'),
    Character(id: 'pervane', image: 'assets/characters/robot-propeller.webp'),
    Character(id: 'isil', image: 'assets/characters/robot-lamp.webp'),
    Character(id: 'kahraman', image: 'assets/characters/robot-hero.webp'),
    Character(id: 'pembe', image: 'assets/characters/robot-ribbon.webp'),
    Character(id: 'sovalye', image: 'assets/characters/robot-knight.webp'),
    Character(id: 'piril', image: 'assets/characters/robot-cape.webp'),
  ];

  /// Hiç seçim yapılmamışsa gösterilen karakter.
  static const defaultCharacter = robi;

  /// Kimliği [id] olan karakter; bulunamazsa `null`.
  static Character? find(String id) => all.where((character) => character.id == id).firstOrNull;
}
