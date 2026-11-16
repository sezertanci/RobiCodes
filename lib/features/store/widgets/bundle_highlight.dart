import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

/// Bileşik paket kartını öne çıkarır: kartın etrafında nabız gibi parlayıp sönen altın bir ışık ve sağ üst
/// köşede çapraz altın şerit. "Hareketi azalt" ayarı açıksa ışık yanıp sönmez, orta parlaklıkta sabit kalır.
final class BundleHighlight extends StatefulWidget {
  const BundleHighlight({required this.label, required this.child, super.key});

  /// Şeritte yazan metin.
  final String label;
  final Widget child;

  /// Şeridin kartın üst kenarında sağdan kapladığı genişlik; kart içeriği bu kadar içeriden başlarsa şeridin
  /// altında kalmaz.
  static final reach = (_ribbonDistance + _ribbonThickness / 2) * sqrt2;

  /// Şeridin orta çizgisinin kartın köşesine dik uzaklığı.
  static const _ribbonDistance = 74.0;
  static const _ribbonThickness = 24.0;

  /// Şerit yazısının iki ucunda bırakılan pay.
  static const _labelMargin = 12.0;
  static const _labelStyle = TextStyle(color: AppColors.navy, fontSize: 13, fontWeight: FontWeight.w900);
  static const _ribbonShadow = BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2));

  static const _pulse = Duration(milliseconds: 1400);
  static const _minGlow = 0.35;
  static const _maxGlow = 0.9;
  static const _minBlur = 6.0;
  static const _maxBlur = 22.0;
  static const _maxSpread = 4.0;

  /// "Hareketi azalt" açıkken ışığın sabit kaldığı nokta.
  static const _restingPulse = 0.5;

  @override
  State<BundleHighlight> createState() => _BundleHighlightState();
}

final class _BundleHighlightState extends State<BundleHighlight> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: BundleHighlight._pulse);
  late final Animation<double> _eased = CurvedAnimation(parent: _pulse, curve: Curves.easeInOut);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _pulse.value = BundleHighlight._restingPulse;
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
    final radius = BorderRadius.circular(AppMetrics.largeRadius);
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _eased,
          builder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(borderRadius: radius, boxShadow: [_glow(_eased.value)]),
            child: child,
          ),
          child: widget.child,
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: ClipRRect(
              borderRadius: radius,
              child: Align(alignment: Alignment.topRight, child: _ribbon()),
            ),
          ),
        ),
      ],
    );
  }

  static BoxShadow _glow(double t) => BoxShadow(
    color: AppColors.yellow.withValues(alpha: _lerp(BundleHighlight._minGlow, BundleHighlight._maxGlow, t)),
    blurRadius: _lerp(BundleHighlight._minBlur, BundleHighlight._maxBlur, t),
    spreadRadius: BundleHighlight._maxSpread * t,
  );

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  /// Köşeyi çapraz kesen şerit. Orta çizgisi köşeden [BundleHighlight._ribbonDistance] uzakta olduğundan
  /// kartın içinde kalan boyu bu uzaklığın iki katıdır; yazı, köşeye yakın kısa kenara sığacak şekilde küçülür.
  Widget _ribbon() {
    const distance = BundleHighlight._ribbonDistance;
    const thickness = BundleHighlight._ribbonThickness;
    final box = BundleHighlight.reach;
    final length = box * sqrt2;
    final center = distance / sqrt2;
    return SizedBox.square(
      dimension: box,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: box - center - length / 2,
            top: center - thickness / 2,
            width: length,
            height: thickness,
            child: Transform.rotate(
              angle: pi / 4,
              child: DecoratedBox(
                decoration: const BoxDecoration(color: AppColors.yellow, boxShadow: [BundleHighlight._ribbonShadow]),
                child: Center(
                  child: SizedBox(
                    width: distance * 2 - thickness - BundleHighlight._labelMargin * 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(widget.label, style: BundleHighlight._labelStyle, maxLines: 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
