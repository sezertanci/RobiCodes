import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_assets.dart';

/// Ekranların arkasındaki çayır çizimi (web sürümündeki `meadow.svg`). Çizim ekranı kaplar,
/// taşan kenarları kırpılır. Çizim yüklenene kadar gökyüzü rengi görünür. Açık gökyüzünde okunsun
/// diye durum çubuğu simgeleri koyu çizilir.
final class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  /// Çizimdeki gökyüzünün üst rengi.
  static const _sky = Color(0xFF9FD8FF);

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: ColoredBox(
      color: _sky,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(AppAssets.meadow, fit: BoxFit.cover),
          child,
        ],
      ),
    ),
  );
}

/// Sayfa geçişini [inner] geçişine bırakır, sayfayı da [AppBackground] ile sarar. Böylece her sayfa
/// kendi arka planıyla kayar; geçişte ve Android'in geri hareketinde sayfalar üst üste saydam görünmez.
final class BackgroundPageTransitionsBuilder implements PageTransitionsBuilder {
  const BackgroundPageTransitionsBuilder(this.inner);

  final PageTransitionsBuilder inner;

  @override
  DelegatedTransitionBuilder? get delegatedTransition => inner.delegatedTransition;

  @override
  Duration get transitionDuration => inner.transitionDuration;

  @override
  Duration get reverseTransitionDuration => inner.reverseTransitionDuration;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => inner.buildTransitions(route, context, animation, secondaryAnimation, AppBackground(child: child));
}
