import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/app_texts.dart';
import '../../app/app_theme.dart';
import '../../app/screen_scale.dart';
import '../../app/widgets/top_bar.dart';
import 'achievement.dart';
import 'widgets/achievement_card.dart';

/// "Başarılarım" ekranı: önce rozetler, sonra kupalar. Her bölümde önce kazanılanlar, sonra
/// kazanılacaklar ilerlemeleriyle listelenir.
final class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  static const title = 'Başarılarım';
  static const backLabel = AppTexts.backToHome;

  static String summaryText(int earned) => '$earned ödül kazandın!';

  static const _padding = 16.0;
  static const _gap = 14.0;
  static const _maxContentWidth = 1100.0;

  /// Geniş ekranda bir hücrenin en küçük genişliği; telefonda rozetler iki, kupalar tek sütundur.
  static const _badgeMinWidth = 190.0;
  static const _trophyMinWidth = 230.0;
  static const _phoneBadgeColumns = 2;
  static const _phoneTrophyColumns = 1;

  static const _badges = _Section(
    kind: AchievementKind.badge,
    title: 'Rozetler',
    subtitle: 'Küçük başarılar',
    color: AppColors.blue,
    textColor: Colors.white,
    earnedTitle: 'Kazandığın rozetler',
    lockedTitle: 'Kazanılacak rozetler',
    emptyText: 'Henüz rozetin yok. İlk seviyeni bitir!',
    minCellWidth: _badgeMinWidth,
    phoneColumns: _phoneBadgeColumns,
  );

  static const _trophies = _Section(
    kind: AchievementKind.trophy,
    title: 'Kupalar',
    subtitle: 'Büyük hedefler',
    color: AppColors.yellow,
    textColor: AppColors.navy,
    earnedTitle: 'Kazandığın kupalar',
    lockedTitle: 'Kilitli kupalar',
    emptyText: 'Henüz kupan yok. Büyük hedeflere doğru devam!',
    minCellWidth: _trophyMinWidth,
    phoneColumns: _phoneTrophyColumns,
  );

  static Future<void> open(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const AchievementsScreen()));

  @override
  Widget build(BuildContext context) {
    final achievements = AppScope.of(context).achievements;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(title: title, icon: AppAssets.trophy, backLabel: backLabel),
            Expanded(
              child: ListenableBuilder(
                listenable: achievements,
                builder: (context, _) {
                  final statuses = achievements.statuses();
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final width = min(constraints.maxWidth, _maxContentWidth) - 2 * _padding;
                      final isWide = constraints.maxWidth >= ScreenScale.wideMinWidth;
                      return Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: width + 2 * _padding,
                          child: ListView(
                            padding: const EdgeInsets.all(_padding),
                            children: [
                              _Summary(statuses: statuses),
                              for (final section in [_badges, _trophies])
                                _SectionView(
                                  section: section,
                                  statuses: [
                                    for (final status in statuses)
                                      if (status.achievement.kind == section.kind) status,
                                  ],
                                  columns: isWide
                                      ? max(1, ((width + _gap) / (section.minCellWidth + _gap)).floor())
                                      : section.phoneColumns,
                                  width: width,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static int _earnedOf(Iterable<AchievementStatus> statuses) => statuses.where((status) => status.isEarned).length;
}

/// Bir bölümün (rozetler veya kupalar) metinleri ve düzeni.
final class _Section {
  const _Section({
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.textColor,
    required this.earnedTitle,
    required this.lockedTitle,
    required this.emptyText,
    required this.minCellWidth,
    required this.phoneColumns,
  });

  final AchievementKind kind;
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final String earnedTitle;
  final String lockedTitle;
  final String emptyText;
  final double minCellWidth;
  final int phoneColumns;
}

/// Ekranın üstündeki özet: toplam kazanılan ödül ve bölüm sayaçları.
final class _Summary extends StatelessWidget {
  const _Summary({required this.statuses});

  final List<AchievementStatus> statuses;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String count(AchievementKind kind) {
      final ofKind = statuses.where((status) => status.achievement.kind == kind);
      return '${AchievementsScreen._earnedOf(ofKind)}/${ofKind.length}';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Text(
            AchievementsScreen.summaryText(AchievementsScreen._earnedOf(statuses)),
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            '${AchievementsScreen._badges.title}: ${count(AchievementKind.badge)}   '
            '${AchievementsScreen._trophies.title}: ${count(AchievementKind.trophy)}',
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

/// Bir bölüm: renkli başlık, kazanılanlar ve kazanılacaklar.
final class _SectionView extends StatelessWidget {
  const _SectionView({required this.section, required this.statuses, required this.columns, required this.width});

  final _Section section;
  final List<AchievementStatus> statuses;
  final int columns;
  final double width;

  @override
  Widget build(BuildContext context) {
    final earned = statuses.where((status) => status.isEarned).toList();
    final locked = statuses.where((status) => !status.isEarned).toList();
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: AchievementsScreen._gap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(textTheme, earned.length),
          _groupTitle(textTheme, section.earnedTitle),
          if (earned.isEmpty) Text(section.emptyText, style: textTheme.bodyLarge) else _grid(earned),
          if (locked.isNotEmpty) ...[_groupTitle(textTheme, section.lockedTitle), _grid(locked)],
        ],
      ),
    );
  }

  Widget _header(TextTheme textTheme, int earnedCount) => DecoratedBox(
    decoration: BoxDecoration(color: section.color, borderRadius: BorderRadius.circular(AppMetrics.mediumRadius)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title,
                  style: textTheme.titleLarge?.copyWith(color: section.textColor, fontWeight: FontWeight.w900),
                ),
                Text(section.subtitle, style: textTheme.bodyMedium?.copyWith(color: section.textColor)),
              ],
            ),
          ),
          Text(
            '$earnedCount/${statuses.length}',
            style: textTheme.titleLarge?.copyWith(color: section.textColor, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );

  Widget _groupTitle(TextTheme textTheme, String text) => Padding(
    padding: const EdgeInsets.only(top: 14, bottom: 10),
    child: Text(text, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
  );

  Widget _grid(List<AchievementStatus> items) {
    final cellWidth = (width - (columns - 1) * AchievementsScreen._gap) / columns;
    return Wrap(
      spacing: AchievementsScreen._gap,
      runSpacing: AchievementsScreen._gap,
      children: [
        for (final status in items)
          SizedBox(
            width: cellWidth,
            child: AchievementCard(status: status),
          ),
      ],
    );
  }
}
