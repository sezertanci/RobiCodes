import 'package:flutter/widgets.dart';

import 'character.dart';

/// Seçili karakteri widget ağacına verir. Robot çizen widget'lar karakteri buradan okur; böylece
/// oyun ekranlarına ayrıca parametre geçmek gerekmez. Ağaçta yoksa (ör. tek bir oyun ekranını
/// deneyen testlerde) varsayılan karakter kullanılır.
final class CharacterScope extends InheritedWidget {
  const CharacterScope({required this.character, required super.child, super.key});

  final Character character;

  static Character of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CharacterScope>()?.character ?? CharacterRoster.defaultCharacter;

  @override
  bool updateShouldNotify(CharacterScope oldWidget) => character != oldWidget.character;
}
