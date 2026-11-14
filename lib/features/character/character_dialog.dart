import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import 'character.dart';
import 'character_service.dart';

/// Karakter seçme penceresi: bütün karakterler resimleriyle listelenir, seçili olan sarı çerçeveyle
/// gösterilir. Bir karaktere dokununca seçim kaydedilir ve pencere kapanır.
final class CharacterDialog extends StatelessWidget {
  const CharacterDialog({required this.characters, super.key});

  final CharacterService characters;

  static const title = 'Karakterini seç';
  static const closeLabel = 'Kapat';

  /// Bu genişliğin altındaki ekranlarda iki, üstündekilerde üç sütun kullanılır (web ile aynı).
  static const _narrowWidth = 560.0;
  static const _maxDialogWidth = 560.0;
  static const _screenMargin = 16.0;
  static const _contentPadding = 48.0;
  static const _gap = 12.0;

  static Future<void> show(BuildContext context, CharacterService characters) => showDialog<void>(
    context: context,
    builder: (_) => CharacterDialog(characters: characters),
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isNarrow = screenWidth < _narrowWidth;
    final columns = isNarrow ? 2 : 3;
    final contentWidth = min(_maxDialogWidth, screenWidth - 2 * _screenMargin) - _contentPadding;
    final optionWidth = (contentWidth - (columns - 1) * _gap) / columns;
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: _screenMargin, vertical: 24),
      title: const Text(title),
      content: SizedBox(
        width: contentWidth,
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: _gap,
            runSpacing: _gap,
            children: [
              for (final character in CharacterRoster.all)
                SizedBox(
                  width: optionWidth,
                  child: _CharacterOption(
                    character: character,
                    isSelected: character == characters.current,
                    imageHeight: isNarrow ? 96 : 120,
                    onTap: () {
                      unawaited(characters.select(character.id));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(closeLabel))],
    );
  }
}

/// Penceredeki tek karakter: resim ve ad. Seçili karakter sarı çerçeve ve zeminle gösterilir.
final class _CharacterOption extends StatelessWidget {
  const _CharacterOption({
    required this.character,
    required this.isSelected,
    required this.imageHeight,
    required this.onTap,
  });

  final Character character;
  final bool isSelected;
  final double imageHeight;
  final VoidCallback onTap;

  static const _radius = BorderRadius.all(Radius.circular(16));

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: isSelected,
    label: character.name,
    excludeSemantics: true,
    child: Material(
      color: isSelected ? AppColors.yellow.withValues(alpha: 0.25) : AppColors.navy.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: isSelected ? AppColors.yellow : Colors.transparent, width: 4),
      ),
      child: InkWell(
        borderRadius: _radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(character.image, height: imageHeight, fit: BoxFit.contain),
              const SizedBox(height: 6),
              Text(
                character.name,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
