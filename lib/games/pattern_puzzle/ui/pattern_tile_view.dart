import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../path_finder/engine/lamp.dart';
import '../../path_finder/ui/lamp_bulb.dart';
import '../../repeat/repeat_texts.dart';
import '../engine/pattern_tile.dart';

/// Desenin bir parçası: renkli lamba ya da lacivert daire içinde sayı.
final class PatternTileView extends StatelessWidget {
  const PatternTileView({required this.tile, required this.size, super.key});

  final PatternTile tile;
  final double size;

  static const _textRatio = 0.42;
  static const _borderRatio = 0.06;

  /// Ekran okuyucunun parçayı okuduğu metin.
  static String labelOf(AppLocalizations t, PatternTile tile) => switch (tile) {
    LampTile(:final color, :final shape) => t.patternLampLabel(RepeatTexts.lampColor(t, color), shapeName(t, shape)),
    NumberTile(:final value) => '$value',
  };

  static String shapeName(AppLocalizations t, LampShape shape) => switch (shape) {
    LampShape.circle => t.patternShapeCircle,
    LampShape.square => t.patternShapeSquare,
    LampShape.triangle => t.patternShapeTriangle,
  };

  @override
  Widget build(BuildContext context) => switch (tile) {
    LampTile(:final color, :final shape) => LampBulb(color: color, shape: shape, size: size),
    NumberTile(:final value) => Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTones.navy.base,
        shape: BoxShape.circle,
        border: Border.all(color: AppTones.navy.dark, width: size * _borderRatio),
      ),
      child: FittedBox(
        child: Text(
          '$value',
          style: TextStyle(fontSize: size * _textRatio, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
    ),
  };
}
