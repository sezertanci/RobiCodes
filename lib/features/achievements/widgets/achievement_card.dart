import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../achievement.dart';
import 'reward_emblem.dart';

/// Başarılarım ekranındaki tek ödül: çizim, başlık, açıklama, kazanma koşulu ve ilerleme.
final class AchievementCard extends StatelessWidget {
  const AchievementCard({required this.status, super.key});

  final AchievementStatus status;

  static const earnedLabel = 'Kazanıldı!';
  static const conditionLabel = 'Nasıl kazanılır? ';

  static String semanticLabel(String title, {required bool isEarned}) =>
      '$title, ${isEarned ? 'kazanıldı' : 'kilitli'}';

  static const _badgeSize = 76.0;
  static const _trophySize = 104.0;
  static const _radius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    final AchievementStatus(:achievement, :progress, :isEarned) = status;
    final textTheme = Theme.of(context).textTheme;
    final isBadge = achievement.kind == AchievementKind.badge;
    return Semantics(
      container: true,
      label: semanticLabel(achievement.title, isEarned: isEarned),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _radius,
          border: Border.all(color: isEarned ? achievement.tone.base : RewardEmblem.lockedTone.base, width: 3),
          boxShadow: const [BoxShadow(color: AppColors.shadow, offset: Offset(0, 4), blurRadius: 8)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              RewardEmblem(status: status, size: isBadge ? _badgeSize : _trophySize),
              const SizedBox(height: 8),
              Text(
                achievement.title,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 2),
              Text(achievement.description, textAlign: TextAlign.center, style: textTheme.bodyMedium),
              const SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: conditionLabel,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    TextSpan(text: achievement.condition),
                  ],
                ),
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              if (isEarned)
                Text(
                  earnedLabel,
                  style: textTheme.titleSmall?.copyWith(color: AppColors.greenDark, fontWeight: FontWeight.w900),
                )
              else
                _ProgressBar(progress: progress, tone: achievement.tone),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kazanılmamış ödülün ilerleme çubuğu ve `şu an/hedef` sayısı.
final class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress, required this.tone});

  final AchievementProgress progress;
  final ColorTone tone;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.goal == 0 ? 0 : progress.shownCurrent / progress.goal,
            minHeight: 10,
            color: tone.base,
            backgroundColor: AppColors.navy.withValues(alpha: 0.1),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        '${progress.shownCurrent}/${progress.goal}',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
    ],
  );
}
