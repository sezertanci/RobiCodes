import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

/// Kutlamalardaki sarı etiket ("Yeni rozet!", "Yeni kupa kazandın!").
final class CelebrationLabel extends StatelessWidget {
  const CelebrationLabel(this.text, {required this.fontSize, super.key});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(color: AppColors.yellow, shape: StadiumBorder()),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: fontSize * 0.8, vertical: fontSize * 0.15),
      child: Text(
        text,
        style: TextStyle(color: AppColors.navy, fontSize: fontSize, fontWeight: FontWeight.w900),
      ),
    ),
  );
}
