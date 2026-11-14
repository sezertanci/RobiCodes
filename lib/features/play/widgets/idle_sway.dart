import 'dart:math';

import 'package:flutter/material.dart';

import '../play_timings.dart';

/// Beklerken hafifçe sağa sola sallanıp nefes alan sarmalayıcı (web sürümündeki `robot-idle`).
/// Robot ayaklarının üstünde döner; "Hareketi azalt" ayarı açıksa hareketsiz durur.
final class IdleSway extends StatefulWidget {
  const IdleSway({required this.child, super.key});

  final Widget child;

  @override
  State<IdleSway> createState() => _IdleSwayState();
}

final class _IdleSwayState extends State<IdleSway> with SingleTickerProviderStateMixin {
  late final AnimationController _cycle = AnimationController(vsync: this, duration: PlayTimings.robotIdle);

  /// Dönüş ve basılmanın döngü boyunca gittiği yer: çeyrekte sola, dörtte üçte sağa yatar.
  static final _tilt = _sequence([(0, -1, 1), (-1, 1, 2), (1, 0, 1)]);
  static final _squash = _sequence([(0, 1, 1), (1, 1, 2), (1, 0, 1)]);

  static const _maxAngle = 3 * pi / 180;
  static const _maxNarrowing = 0.02;
  static const _maxStretch = 0.03;

  /// Dönme noktası: yatayda orta, dikeyde boyun yüzde 90'ı (ayakların hizası).
  static const _pivot = Alignment(0, 0.8);

  static TweenSequence<double> _sequence(List<(double, double, double)> parts) => TweenSequence([
    for (final (begin, end, weight) in parts)
      TweenSequenceItem(
        tween: Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut)),
        weight: weight,
      ),
  ]);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _cycle.value = 0;
    } else if (!_cycle.isAnimating) {
      _cycle.repeat();
    }
  }

  @override
  void dispose() {
    _cycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _cycle,
    builder: (context, child) {
      final squash = _squash.transform(_cycle.value);
      return Transform(
        alignment: _pivot,
        transform: Matrix4.rotationZ(_tilt.transform(_cycle.value) * _maxAngle)
          ..scaleByDouble(1 - _maxNarrowing * squash, 1 + _maxStretch * squash, 1, 1),
        child: child,
      );
    },
    child: widget.child,
  );
}
