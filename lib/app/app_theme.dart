import 'package:flutter/material.dart';

import 'app_background.dart';

/// Mevcut web sürümünün renk paleti.
abstract final class AppColors {
  static const yellow = Color(0xFFFFD24D);
  static const blue = Color(0xFF4DA6FF);
  static const green = Color(0xFF6CD46C);
  static const purple = Color(0xFFA97CFF);
  static const orange = Color(0xFFFFA24A);
  static const red = Color(0xFFFF6E6E);
  static const navy = Color(0xFF1F2D4F);
  static const teal = Color(0xFF2EC4B6);

  // Aynı renklerin koyu tonları; kabarık kenar ve yazı gölgesi için.
  static const greenDark = Color(0xFF3DA845);
  static const blueDark = Color(0xFF2B7BD9);
  static const purpleDark = Color(0xFF7C4FE0);
  static const redDark = Color(0xFFD94848);
  static const orangeDark = Color(0xFFE8781C);
  static const yellowDark = Color(0xFFE8A920);
  static const amberDark = Color(0xFFB07510);

  /// Koyu kahve: koyu altın düğmelerdeki tek renk simgeler (ör. kutu düğmeleri) ve kahverengi kartların gölgesi.
  static const brown = Color(0xFF6B4423);

  /// Karton kahvesi: kutu görselinin gövdesiyle aynı ton; "Değişken Kutusu" oyununun rengi.
  static const cardboard = Color(0xFFA0693A);
  static const tealDark = Color(0xFF1C9A8F);

  /// Düğme ve kartların altındaki yumuşak gölge.
  static const shadow = Color(0x261F2D4F);

  /// Üst çubuk başlığı ve sayaçların yarı saydam beyaz zemini (`--panel`).
  static const panel = Color(0xEBFFFFFF);
}

/// Web sürümündeki ortak ölçüler (`--radius-md`, `--radius-lg`, `--lip` ve `--touch`).
abstract final class AppMetrics {
  /// Panel ve kutuların köşe yarıçapı.
  static const mediumRadius = 18.0;

  /// Büyük kartların köşe yarıçapı.
  static const largeRadius = 28.0;

  /// Kart ve düğmelerin altındaki kabarık kenarın kalınlığı.
  static const lip = 6.0;

  /// Dokunulan düğmelerin kenarı; dar ekranda (telefonda) daha küçüktür.
  static const touch = 64.0;
  static const compactTouch = 56.0;
}

/// Bir rengin açık ve koyu tonu. Oyun kartları, rozetler ve kupalar açık tonu zemin, koyu tonu
/// kenar ve gölge olarak kullanır (web sürümündeki `--tone` ve `--tone-dark`).
@immutable
final class ColorTone {
  const ColorTone(this.base, this.dark);

  final Color base;
  final Color dark;
}

/// Oyunların, ödüllerin ve mağaza kartlarının kullandığı renk tonları. Pembe ve altın yalnızca ödüllerde kullanılır.
abstract final class AppTones {
  static const blue = ColorTone(AppColors.blue, AppColors.blueDark);
  static const green = ColorTone(AppColors.green, AppColors.greenDark);
  static const purple = ColorTone(AppColors.purple, AppColors.purpleDark);
  static const orange = ColorTone(AppColors.orange, AppColors.orangeDark);
  static const red = ColorTone(AppColors.red, AppColors.redDark);
  static const teal = ColorTone(AppColors.teal, AppColors.tealDark);
  static const pink = ColorTone(Color(0xFFFF8FB7), Color(0xFFE0608E));
  static const navy = ColorTone(Color(0xFF3A4D7A), AppColors.navy);
  static const gold = ColorTone(AppColors.yellow, AppColors.yellowDark);
  static const brown = ColorTone(AppColors.cardboard, AppColors.brown);

  /// Çivit mavisi: yalnızca birden fazla oyunu açan bileşik paketlerin (bundle) mağaza kartları kullanır.
  static const indigo = ColorTone(Color(0xFF5C6BC0), Color(0xFF3949AB));

  /// Koyu altın: sarı zeminde beyaz yazı ve simge zor okunduğu için "Değişken Kutusu" düğmeleri kullanır.
  static const amber = ColorTone(AppColors.yellowDark, AppColors.amberDark);
}

ThemeData buildAppTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.blue,
    primary: AppColors.blue,
    secondary: AppColors.yellow,
    error: AppColors.red,
  ),
  // Ekranların arkasında çayır çizimi durur (bkz. [AppBackground]); bu yüzden Scaffold saydamdır.
  scaffoldBackgroundColor: Colors.transparent,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      for (final MapEntry(:key, :value) in const PageTransitionsTheme().builders.entries)
        key: BackgroundPageTransitionsBuilder(value),
    },
  ),
  textTheme: ThemeData.light().textTheme.apply(bodyColor: AppColors.navy, displayColor: AppColors.navy),
);
