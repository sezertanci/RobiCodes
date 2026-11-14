import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';
import '../screen_scale.dart';

/// Yarı saydam beyaz hap içinde ikon ve sayı (web sürümündeki `.star-counter`). Dar ekranda küçülür.
final class CounterPill extends StatelessWidget {
  const CounterPill({required this.icon, required this.text, super.key});

  final String icon;
  final String text;

  static const _padding = EdgeInsets.fromLTRB(8, 6, 16, 6);
  static const _narrowPadding = EdgeInsets.fromLTRB(6, 4, 12, 4);
  static const _iconSize = 36.0;
  static const _narrowIconSize = 28.0;
  static const _fontSize = 22.0;
  static const _narrowFontSize = 18.0;
  static const _gap = 6.0;

  @override
  Widget build(BuildContext context) {
    final narrow = ScreenScale.isNarrow(context);
    final iconSize = narrow ? _narrowIconSize : _iconSize;
    return DecoratedBox(
      decoration: const ShapeDecoration(color: AppColors.panel, shape: StadiumBorder()),
      child: Padding(
        padding: narrow ? _narrowPadding : _padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon, width: iconSize, height: iconSize),
            const SizedBox(width: _gap),
            Text(
              text,
              style: TextStyle(
                color: AppColors.navy,
                fontSize: narrow ? _narrowFontSize : _fontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
