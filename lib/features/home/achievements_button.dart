import 'package:flutter/material.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/widgets/counter_pill.dart';
import '../../l10n/l10n.dart';
import '../achievements/achievements_screen.dart';
import '../sound/tap_sound.dart';

/// Ana ekrandaki ödül düğmesi: kupa ve kazanılan ödül sayısı. Dokununca Başarılarım açılır.
final class AchievementsButton extends StatelessWidget {
  const AchievementsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = AppScope.of(context).achievements;
    final t = context.l10n;
    return ListenableBuilder(
      listenable: achievements,
      builder: (context, _) {
        final earned = achievements.earnedCount;
        final total = achievements.all.length;
        return Semantics(
          button: true,
          label: t.achievementsButtonLabel(earned, total),
          excludeSemantics: true,
          child: Tooltip(
            message: t.achievementsTitle,
            child: GestureDetector(
              onTap: context.withTapSound(() => AchievementsScreen.open(context)),
              child: CounterPill(icon: AppAssets.trophy, text: '$earned/$total'),
            ),
          ),
        );
      },
    );
  }
}
