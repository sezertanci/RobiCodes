import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../path_finder/ui/command_chip.dart';
import '../../../features/sound/tap_sound.dart';

/// Ana programdaki komut bloğu: turkuaz zeminde beyaz yapboz parçası. Adı yazmaz; çocuk komutu
/// rengiyle ve simgesiyle tanır. Durumları yön kutusuyla ([CommandChip]) aynıdır: seçiliyse lacivert,
/// hatalıysa kırmızı çerçeve alır, çalışırken sarı zeminle parlar.
final class CallChip extends StatelessWidget {
  const CallChip({
    required this.label,
    required this.size,
    required this.onTap,
    this.number,
    this.selected = false,
    this.active = false,
    this.wrong = false,
    super.key,
  });

  /// Ekran okuyucu etiketi.
  final String label;
  final double size;
  final VoidCallback? onTap;
  final int? number;
  final bool selected;
  final bool active;
  final bool wrong;

  /// Yapboz simgesinin çip boyuna oranı.
  static const _iconRatio = 0.7;

  Color get _borderColor {
    if (wrong) {
      return AppColors.red;
    }
    return selected ? AppColors.navy : AppColors.tealDark;
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: label,
    excludeSemantics: true,
    onTap: context.withTapSound(onTap),
    child: GestureDetector(
      onTap: context.withTapSound(onTap),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: active ? AppColors.yellow : AppColors.teal,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _borderColor, width: 3),
            ),
            child: Icon(Icons.extension, color: Colors.white, size: size * _iconRatio),
          ),
          if (number case final number?) Positioned(left: -6, top: -8, child: NumberBadge(number)),
        ],
      ),
    ),
  );
}
