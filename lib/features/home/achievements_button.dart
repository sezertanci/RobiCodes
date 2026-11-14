import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/app_theme.dart';
import '../achievements/achievements_screen.dart';

/// Ana ekranın üst çubuğundaki ödül düğmesi: kupa ve kazanılan ödül sayısı. Dokununca Başarılarım açılır.
final class AchievementsButton extends StatelessWidget {
  const AchievementsButton({super.key});

  static String semanticLabel(int earned, int total) => '${AchievementsScreen.title}: $earned/$total';

  static const _iconSize = 28.0;

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
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: () => AchievementsScreen.open(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.trophy, width: _iconSize, height: _iconSize),
                    const SizedBox(width: 4),
                    Text(
                      '$earned/$total',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
