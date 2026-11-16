import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';
import '../../sound/tap_sound.dart';

/// Görselli oyun düğmesi (web sürümünün SVG düğmeleri). Pasifken soluk görünür;
/// [highlighted] ise sarı ışıkla parlar (ör. ipucunun önerdiği tuş).
final class ImageButton extends StatelessWidget {
  const ImageButton({
    required this.asset,
    required this.label,
    required this.size,
    required this.onPressed,
    this.highlighted = false,
    super.key,
  });

  final String asset;
  final String label;
  final double size;
  final VoidCallback? onPressed;
  final bool highlighted;

  static const padding = 2.0;

  /// Düğme görsellerinde (128 birimlik SVG) düğmenin kenarı ile görselin kenarı arasındaki şeffaf pay.
  static const _artInsetRatio = 6 / 128;

  /// [size] boyutundaki düğmenin görünen kenarının, widget'ın kenarından ne kadar içeride olduğu.
  /// Düğmeyi başka öğelerle aynı çizgiye hizalamak için kullanılır.
  static double visibleInset(double size) => padding + size * _artInsetRatio;
  static const _disabledOpacity = 0.4;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(padding),
    child: Tooltip(
      message: label,
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        label: label,
        onTap: context.withTapSound(onPressed),
        excludeSemantics: true,
        child: GestureDetector(
          onTap: context.withTapSound(onPressed),
          // Boy anında uygulanır; yalnızca ışık geçişlidir. Boy da geçişli olsaydı düzen yeni boya göre
          // hesaplanırken düğme bir an eski boyda kalır ve satır taşardı.
          child: SizedBox.square(
            dimension: size,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size / 3),
                boxShadow: highlighted
                    ? const [BoxShadow(color: AppColors.yellow, blurRadius: 12, spreadRadius: 4)]
                    : null,
              ),
              child: Opacity(opacity: onPressed == null ? _disabledOpacity : 1, child: SvgPicture.asset(asset)),
            ),
          ),
        ),
      ),
    ),
  );
}
