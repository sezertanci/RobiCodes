import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';
import '../engine/path_finder_board.dart';
import 'path_finder_assets.dart';
import '../../../features/sound/tap_sound.dart';

/// Komut şeridindeki yön kutusu. Seçiliyse lacivert, hatalıysa kırmızı çerçeve alır; çalışırken
/// sarı zeminle parlar. [number] verilirse sol üst köşede sıra rozeti görünür.
/// "Robotun Yolunu Bul" ve "Tekrar Et" ortak kullanır.
final class CommandChip extends StatelessWidget {
  const CommandChip({
    required this.label,
    required this.direction,
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
  final Direction direction;
  final double size;
  final VoidCallback? onTap;
  final int? number;
  final bool selected;
  final bool active;
  final bool wrong;

  Color get _borderColor {
    if (wrong) {
      return AppColors.red;
    }
    return selected ? AppColors.navy : Colors.transparent;
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
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: active ? AppColors.yellow : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _borderColor, width: 3),
            ),
            child: SvgPicture.asset(PathFinderAssets.arrow(direction)),
          ),
          if (number case final number?) Positioned(left: -6, top: -8, child: NumberBadge(number)),
        ],
      ),
    ),
  );
}

/// Şeritteki blokların sol üst köşesindeki lacivert sıra rozeti.
final class NumberBadge extends StatelessWidget {
  const NumberBadge(this.number, {super.key});

  final int number;

  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: 10,
    backgroundColor: AppColors.navy,
    child: Text('$number', style: const TextStyle(fontSize: 11, color: Colors.white)),
  );
}
