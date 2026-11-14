import 'package:flutter/material.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/widgets/counter_pill.dart';
import '../achievements/achievements_screen.dart';

/// Ana ekrandaki ödül düğmesi: kupa ve kazanılan ödül sayısı. Dokununca Başarılarım açılır.
final class AchievementsButton extends StatelessWidget {
  const AchievementsButton({super.key});

  static String semanticLabel(int earned, int total) => '${AchievementsScreen.title}: $earned/$total';

  @override
  Widget build(BuildContext context) {
    final achievements = AppScope.of(context).achievements;
    return ListenableBuilder(
      listenable: achievements,
      builder: (context, _) {
        final earned = achievements.earnedCount;
        final total = achievements.all.length;
        return Semantics(
          button: true,
          label: semanticLabel(earned, total),
          excludeSemantics: true,
          child: Tooltip(
            message: AchievementsScreen.title,
            child: GestureDetector(
              onTap: () => AchievementsScreen.open(context),
              child: CounterPill(icon: AppAssets.trophy, text: '$earned/$total'),
            ),
          ),
        );
      },
    );
  }
}
