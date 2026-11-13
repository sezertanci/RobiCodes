import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Kesik çizgili, köşeleri yuvarlak çerçeve. Başlangıç karesini ve ipucu karesini işaretler.
final class DashedFrame extends StatelessWidget {
  const DashedFrame({required this.color, this.strokeWidth = 3, super.key});

  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _DashedFramePainter(color: color, strokeWidth: strokeWidth), child: const SizedBox.expand());
}

final class _DashedFramePainter extends CustomPainter {
  const _DashedFramePainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  static const _dash = 8.0;
  static const _gap = 5.0;
  static const _radiusRatio = 0.18;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(size.shortestSide * _radiusRatio)));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    for (final PathMetric metric in path.computeMetrics()) {
      for (var distance = 0.0; distance < metric.length; distance += _dash + _gap) {
        canvas.drawPath(metric.extractPath(distance, distance + _dash), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedFramePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
