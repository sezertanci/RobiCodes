import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../features/sound/tap_sound.dart';

/// Beyaz, kabarık kare düğme; ortasında bir lamba ya da desen parçası durur. "renk yak" düğmeleri ve desen
/// seçenekleri bunu kullanır. İpucu parlattığında kenarı altın sarısı olur.
final class TileButton extends StatelessWidget {
  const TileButton({
    required this.label,
    required this.size,
    required this.edge,
    required this.onPressed,
    required this.child,
    this.highlighted = false,
    super.key,
  });

  final String label;
  final double size;

  /// Kenarın ve gölgenin rengi.
  final Color edge;
  final VoidCallback? onPressed;
  final Widget child;
  final bool highlighted;

  static const _radiusRatio = 0.22;
  static const _borderWidth = 3.0;
  static const _highlightWidth = 5.0;
  static const _highlightGlow = 12.0;
  static const _shadowOffset = Offset(0, 4);
  static const _disabledOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final onTap = context.withTapSound(onPressed);
    final border = highlighted ? AppColors.yellowDark : edge;
    return Padding(
      padding: const EdgeInsets.all(ImageButton.padding),
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        label: label,
        excludeSemantics: true,
        onTap: onTap,
        child: Opacity(
          opacity: onPressed == null ? _disabledOpacity : 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size * _radiusRatio),
                border: Border.all(color: border, width: highlighted ? _highlightWidth : _borderWidth),
                boxShadow: [
                  BoxShadow(color: border, offset: _shadowOffset),
                  if (highlighted) const BoxShadow(color: AppColors.yellow, blurRadius: _highlightGlow),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
