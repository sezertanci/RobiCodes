import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';

/// Beyaz daire içinde oyunun ikonu; dairenin altında oyunun koyu tonunda kalın kenar.
final class GameIconBadge extends StatelessWidget {
  const GameIconBadge({required this.icon, required this.tone, required this.size, required this.iconSize, super.key});

  final String icon;
  final ColorTone tone;
  final double size;
  final double iconSize;

  static const _lip = 4.0;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: tone.dark, offset: const Offset(0, _lip))],
    ),
    child: SvgPicture.asset(icon, width: iconSize, height: iconSize),
  );
}
