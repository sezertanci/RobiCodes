import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';

/// Robotun tek seferlik hareketi. Ekran her yeni tepkide animasyonu baştan oynatır.
enum RobotReaction { none, bump, celebrate, shake, hop }

/// Robot ve tek seferlik hareketleri: engele çarpma, sevinç zıplaması, kafa sallama ve tek zıplama.
/// "Hareketi azalt" ayarı açıksa tepkiler oynatılmaz.
final class RobotSprite extends StatefulWidget {
  const RobotSprite({
    required this.reaction,
    required this.reactionCount,
    this.bumpDirection = const Offset(1, 0),
    super.key,
  });

  final RobotReaction reaction;

  /// Her tepkide artar; aynı tepki art arda gelse de animasyon yeniden başlar.
  final int reactionCount;

  /// Çarpmada robotun itildiği yön (ör. sağ için `Offset(1, 0)`).
  final Offset bumpDirection;

  /// Robotun tepkilerde kendi boyunun en fazla ne kadar yukarı çıktığı (tek zıplama en yükseğidir).
  static double maxRise(double size) => _RobotSpriteState._hopHeight * size;

  @override
  State<RobotSprite> createState() => _RobotSpriteState();
}

final class _RobotSpriteState extends State<RobotSprite> with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  static const _bumpDistance = 0.25;
  static const _jumpHeight = 0.3;
  static const _hopHeight = 0.5;
  static const _shakeAngle = 0.25;

  @override
  void didUpdateWidget(RobotSprite oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changed = widget.reactionCount != oldWidget.reactionCount;
    if (changed && widget.reaction != RobotReaction.none && !MediaQuery.disableAnimationsOf(context)) {
      _animation.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: _transform(_animation.value, constraints.maxWidth),
        child: child,
      ),
      child: Image.asset(AppAssets.robot),
    ),
  );

  Matrix4 _transform(double t, double size) {
    if (t == 0 || t == 1) {
      return Matrix4.identity();
    }
    switch (widget.reaction) {
      case RobotReaction.bump:
        final distance = sin(t * pi) * _bumpDistance * size;
        return Matrix4.translationValues(widget.bumpDirection.dx * distance, widget.bumpDirection.dy * distance, 0);
      case RobotReaction.celebrate:
        return Matrix4.translationValues(0, -sin(t * 2 * pi).abs() * _jumpHeight * size, 0);
      case RobotReaction.shake:
        return Matrix4.rotationZ(sin(t * 4 * pi) * _shakeAngle);
      case RobotReaction.hop:
        return Matrix4.translationValues(0, -sin(t * pi) * _hopHeight * size, 0);
      case RobotReaction.none:
        return Matrix4.identity();
    }
  }
}
