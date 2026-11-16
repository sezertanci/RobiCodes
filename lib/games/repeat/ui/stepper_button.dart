import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/sound/tap_sound.dart';

/// Bir sayıyı azaltan ya da artıran beyaz yuvarlak − / + düğmesi. Tekrar bloğunun tekrar sayısında ve
/// "kutu = N" bloğunun sayısında kullanılır; [color] yazının ve gölgenin rengidir.
final class StepperButton extends StatelessWidget {
  const StepperButton({
    required this.text,
    required this.label,
    required this.size,
    required this.onPressed,
    this.color = AppColors.orangeDark,
    super.key,
  });

  final String text;

  /// Ekran okuyucu etiketi.
  final String label;
  final double size;
  final VoidCallback? onPressed;
  final Color color;

  static const decrease = '−';
  static const increase = '+';

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: label,
    excludeSemantics: true,
    child: GestureDetector(
      onTap: context.withTapSound(onPressed),
      child: Opacity(
        opacity: onPressed == null ? 0.4 : 1,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color, offset: const Offset(0, 3))],
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: size * 0.6, fontWeight: FontWeight.w900, color: color, height: 1),
          ),
        ),
      ),
    ),
  );
}
