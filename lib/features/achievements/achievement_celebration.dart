import 'package:flutter/material.dart';

import '../sound/sound_effect.dart';
import '../sound/sound_service.dart';
import 'achievement.dart';
import 'widgets/badge_toast.dart';
import 'widgets/trophy_celebration.dart';

/// Yeni kazanılan ödüllerin kutlaması. Rozet için ekranın üstünde kısa bir bildirim açılır ve
/// kendiliğinden kapanır; kupa için konfetili, tam ekran bir pencere açılır ve çocuk "Harika!" diyerek kapatır.
/// Aynı anda birden çok ödül gelirse sırayla gösterilir (önce rozetler, sonra kupalar). Kuyruk bütün
/// uygulamada tektir; böylece seviyeler hızlı geçilse de kutlamalar üst üste binmez.
final class AchievementCelebration {
  AchievementCelebration({required this._sound});

  final SoundService _sound;
  Future<void> _queue = Future.value();

  /// [achievements] ödüllerini kuyruğa ekler. Kutlamalar [navigator] kök gezginin üstünde gösterilir;
  /// böylece seviye ekranından çıkılsa da yarıda kalmaz.
  void show(NavigatorState navigator, List<AchievementStatus> achievements) {
    for (final status in achievements) {
      _queue = _queue.then((_) => navigator.mounted ? _present(navigator, status) : null);
    }
  }

  Future<void> _present(NavigatorState navigator, AchievementStatus status) {
    final isTrophy = status.achievement.kind == AchievementKind.trophy;
    _sound.play(isTrophy ? SoundEffect.trophy : SoundEffect.badge);
    return isTrophy ? TrophyCelebration.show(navigator, status) : BadgeToast.show(navigator, status);
  }
}
