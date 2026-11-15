import 'package:flutter/material.dart';

import '../app_theme.dart';

/// Renkli kart (web sürümündeki oyun kartı zemini): tonun renginde, üstten alta solan parlaklık,
/// yarı saydam beyaz halka ve koyu tonda kalın alt kenar. İçindeki yazılar beyaz ve koyu tonda
/// gölgelidir. [onTap] verilirse kart dokunulabilir olur.
final class ToneCard extends StatelessWidget {
  const ToneCard({required this.tone, required this.padding, required this.child, this.onTap, super.key});

  final ColorTone tone;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final VoidCallback? onTap;

  static const _ringWidth = 4.0;
  static const _ringColor = Color(0x59FFFFFF);
  static const _shine = Color(0x2EFFFFFF);
  static const _textShadowOffset = Offset(0, 2);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppMetrics.largeRadius);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.alphaBlend(_shine, tone.base), tone.base],
        ),
        borderRadius: radius,
        border: Border.all(color: _ringColor, width: _ringWidth),
        boxShadow: [BoxShadow(color: tone.dark, offset: const Offset(0, AppMetrics.lip))],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: padding,
            child: DefaultTextStyle.merge(
              style: TextStyle(
                color: Colors.white,
                shadows: [Shadow(color: tone.dark, offset: _textShadowOffset)],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
