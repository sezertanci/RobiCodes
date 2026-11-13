import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

/// İpucu işareti: kutu, kart veya bloğun çevresinde nabız gibi atan sarı halka.
/// "Hareketi azalt" ayarı açıksa halka sabit durur.
final class HintGlow extends StatefulWidget {
  const HintGlow({required this.radius, required this.child, super.key});

  /// Halkanın köşe yarıçapı; işaretlenen öğeninkiyle aynı olmalı.
  final double radius;
  final Widget child;

  static const ring = 8.0;

  @override
  State<HintGlow> createState() => _HintGlowState();
}

final class _HintGlowState extends State<HintGlow> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  static const _staticRing = 5.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _pulse.stop();
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final still = MediaQuery.disableAnimationsOf(context);
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: [
            BoxShadow(color: AppColors.yellow, spreadRadius: still ? _staticRing : HintGlow.ring * _pulse.value),
          ],
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}

/// Yanlış kart veya kutu işareti: kırmızı halka ve [trigger] her değiştiğinde bir kez yana sallanma.
final class WrongShake extends StatefulWidget {
  const WrongShake({required this.trigger, required this.radius, required this.child, super.key});

  final int trigger;

  /// Halkanın köşe yarıçapı; işaretlenen öğeninkiyle aynı olmalı.
  final double radius;
  final Widget child;

  @override
  State<WrongShake> createState() => _WrongShakeState();
}

final class _WrongShakeState extends State<WrongShake> with SingleTickerProviderStateMixin {
  late final AnimationController _shake = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

  static const _distance = 5.0;
  static const _ring = 5.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _play();
  }

  @override
  void didUpdateWidget(WrongShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) {
      _play();
    }
  }

  void _play() {
    if (!MediaQuery.disableAnimationsOf(context) && !_shake.isAnimating) {
      _shake.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _shake,
    builder: (context, child) =>
        Transform.translate(offset: Offset(sin(_shake.value * 2 * pi) * -_distance, 0), child: child),
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        boxShadow: const [BoxShadow(color: AppColors.red, spreadRadius: _ring)],
      ),
      child: widget.child,
    ),
  );
}
