import 'package:flutter/foundation.dart';

/// Oyunda seçilebilen bir karakter. Seçilen karakter ana ekranda ve bütün oyunlarda (harita,
/// konuşma balonu, yol sahnesi) görünür.
@immutable
final class Character {
  const Character({required this.id, required this.name, required this.image});

  /// Kayıtta saklanan kimlik; karakter adı değişse de kayıt bozulmaz.
  final String id;
  final String name;
  final String image;
}

/// Seçilebilen karakterler. Liste ve görseller web sürümündeki `js/core/characters.js` ile aynıdır.
abstract final class CharacterRoster {
  static const robi = Character(id: 'robi', name: 'Robi', image: 'assets/characters/robot.webp');

  static const all = [
    robi,
    Character(id: 'fiyo', name: 'Fiyo', image: 'assets/characters/robot-bow.webp'),
    Character(id: 'isil', name: 'Işıl', image: 'assets/characters/robot-lamp.webp'),
    Character(id: 'pembe', name: 'Pembe', image: 'assets/characters/robot-ribbon.webp'),
    Character(id: 'piril', name: 'Pırıl', image: 'assets/characters/robot-cape.webp'),
  ];

  /// Hiç seçim yapılmamışsa gösterilen karakter.
  static const defaultCharacter = robi;

  /// Kimliği [id] olan karakter; bulunamazsa `null`.
  static Character? find(String id) => all.where((character) => character.id == id).firstOrNull;
}
