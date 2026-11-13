import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';

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
            onTap: onPressed,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: onPressed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 3),
                  boxShadow: highlighted ? const [BoxShadow(color: AppColors.yellow, blurRadius: 12, spreadRadius: 4)] : null,
                ),
                child: Opacity(
                  opacity: onPressed == null ? _disabledOpacity : 1,
                  child: SvgPicture.asset(asset),
                ),
              ),
            ),
          ),
        ),
      );
}
