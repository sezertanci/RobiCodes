import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../engine/lamp.dart';

/// Tek bir lamba: biçimi ([LampShape]) renginde çizilir, ortasında rengin işareti durur; böylece renkler
/// renk körlüğünde de ayırt edilir. Yanan lamba parlak ve ışıltılı, sönük lamba soluktur. Yanlış lamba kırmızı
/// halkayla yanıp söner.
final class LampBulb extends StatelessWidget {
  const LampBulb({required this.color, required this.size, this.shape = LampShape.circle, this.lit = true, super.key});

  final LampColor color;
  final LampShape shape;
  final double size;
  final bool lit;

  /// Sönük lambanın saydamlığı.
  static const _dimAlpha = 0.35;
  static const _glowRatio = 0.25;
  static const _markRatio = 0.42;

  /// Üçgenin işareti ağırlık merkezine, biraz aşağıya oturur.
  static const _triangleMarkShift = 0.08;

  static ColorTone toneOf(LampColor color) => switch (color) {
    LampColor.red => AppTones.red,
    LampColor.blue => AppTones.blue,
    LampColor.yellow => AppTones.gold,
    LampColor.green => AppTones.green,
  };

  static IconData markOf(LampColor color) => switch (color) {
    LampColor.red => Icons.favorite,
    LampColor.blue => Icons.water_drop,
    LampColor.yellow => Icons.star,
    LampColor.green => Icons.eco,
  };

  @override
  Widget build(BuildContext context) {
    final tone = toneOf(color);
    final shift = shape == LampShape.triangle ? size * _triangleMarkShift : 0.0;
    return Opacity(
      opacity: lit ? 1 : _dimAlpha,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _LampPainter(shape: shape, tone: tone, glow: lit ? size * _glowRatio : 0),
          child: Padding(
            padding: EdgeInsets.only(top: shift),
            child: Center(
              child: Icon(markOf(color), size: size * _markRatio, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

/// Lambanın biçimini, koyu kenarını ve yanarken etrafındaki ışıltıyı çizer.
final class _LampPainter extends CustomPainter {
  const _LampPainter({required this.shape, required this.tone, required this.glow});

  final LampShape shape;
  final ColorTone tone;
  final double glow;

  static const _borderRatio = 0.07;
  static const _cornerRatio = 0.18;
  static const _inset = 0.08;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final path = pathOf(shape, rect.deflate(size.shortestSide * _inset));
    if (glow > 0) {
      canvas.drawPath(
        path,
        Paint()
          ..color = tone.base.withValues(alpha: 0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow),
      );
    }
    canvas
      ..drawPath(path, Paint()..color = tone.base)
      ..drawPath(
        path,
        Paint()
          ..color = tone.dark
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.shortestSide * _borderRatio,
      );
  }

  static Path pathOf(LampShape shape, Rect rect) => switch (shape) {
    LampShape.circle => Path()..addOval(rect),
    LampShape.square =>
      Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(rect.shortestSide * _cornerRatio))),
    LampShape.triangle =>
      Path()
        ..moveTo(rect.center.dx, rect.top)
        ..lineTo(rect.right, rect.bottom - rect.height * (1 - sqrt(3) / 2) / 2)
        ..lineTo(rect.left, rect.bottom - rect.height * (1 - sqrt(3) / 2) / 2)
        ..close(),
  };

  @override
  bool shouldRepaint(_LampPainter oldDelegate) =>
      oldDelegate.shape != shape || oldDelegate.tone != tone || oldDelegate.glow != glow;
}

/// Yanlış lambanın üstünde yanıp sönen kırmızı halka. Hareketi azaltma ayarı açıksa sabit durur.
final class WrongLampFrame extends StatefulWidget {
  const WrongLampFrame({super.key});

  @override
  State<WrongLampFrame> createState() => _WrongLampFrameState();
}

final class _WrongLampFrameState extends State<WrongLampFrame> with SingleTickerProviderStateMixin {
  late final AnimationController _blink = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

  static const _width = 5.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _blink.value = 1;
    } else if (!_blink.isAnimating) {
      _blink.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _blink,
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.redDark, width: _width),
      ),
    ),
  );
}
