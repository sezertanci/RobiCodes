import 'package:flutter/material.dart';

/// Mevcut web sürümünün renk paleti.
abstract final class AppColors {
  static const yellow = Color(0xFFFFD24D);
  static const blue = Color(0xFF4DA6FF);
  static const green = Color(0xFF6CD46C);
  static const purple = Color(0xFFA97CFF);
  static const orange = Color(0xFFFFA24A);
  static const red = Color(0xFFFF6E6E);
  static const navy = Color(0xFF1F2D4F);

  // Aynı renklerin koyu tonları; kabarık kenar ve yazı gölgesi için.
  static const greenDark = Color(0xFF3DA845);
  static const blueDark = Color(0xFF2B7BD9);
  static const purpleDark = Color(0xFF7C4FE0);
  static const redDark = Color(0xFFD94848);

  /// Düğme ve kartların altındaki yumuşak gölge.
  static const shadow = Color(0x261F2D4F);

  /// Ana ekrandaki oyun kartlarının sırayla aldığı renkler.
  static const cardAccents = [blue, green, purple, orange];
}

ThemeData buildAppTheme() => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
        primary: AppColors.blue,
        secondary: AppColors.yellow,
        error: AppColors.red,
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF8E7),
      textTheme: ThemeData.light().textTheme.apply(bodyColor: AppColors.navy, displayColor: AppColors.navy),
    );
