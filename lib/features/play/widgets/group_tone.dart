import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../content/models/level_pack.dart';

/// Bir zorluk grubunun rengi ve koyu tonu. Renkler web sürümüyle aynıdır.
final class GroupTone {
  const GroupTone(this.color, this.dark);

  factory GroupTone.of(Difficulty difficulty) => switch (difficulty) {
    Difficulty.easy => const GroupTone(AppColors.green, AppColors.greenDark),
    Difficulty.medium => const GroupTone(AppColors.blue, AppColors.blueDark),
    Difficulty.hard => const GroupTone(AppColors.purple, AppColors.purpleDark),
    Difficulty.expert => const GroupTone(AppColors.red, AppColors.redDark),
  };

  final Color color;
  final Color dark;

  /// Rengin beyazla karıştırılmış açık tonu; [amount] 0 ise beyaz, 1 ise rengin kendisi.
  Color tint(double amount) => Color.lerp(Colors.white, color, amount)!;
}
