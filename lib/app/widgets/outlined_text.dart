import 'package:flutter/material.dart';

/// Kalın konturlu yazı (web sürümündeki `-webkit-text-stroke`). Yazı iki kez çizilir: altta kontur
/// (isteğe bağlı gölgesiyle), üstte dolgu. Ekran okuyucu yazıyı yalnızca bir kez okur.
final class OutlinedText extends StatelessWidget {
  const OutlinedText(
    this.text, {
    required this.fontSize,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
    this.shadowOffset,
    this.height,
    this.textAlign = TextAlign.center,
    super.key,
  });

  final String text;
  final double fontSize;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;

  /// Verilirse kontur, kendi renginde bu kadar kaydırılmış bir gölge bırakır.
  final Offset? shadowOffset;
  final double? height;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900, height: height);
    final shadowOffset = this.shadowOffset;
    return Stack(
      children: [
        ExcludeSemantics(
          child: Text(
            text,
            textAlign: textAlign,
            style: style.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..strokeJoin = StrokeJoin.round
                ..color = strokeColor,
              shadows: shadowOffset == null ? null : [Shadow(color: strokeColor, offset: shadowOffset)],
            ),
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          style: style.copyWith(color: color),
        ),
      ],
    );
  }
}
