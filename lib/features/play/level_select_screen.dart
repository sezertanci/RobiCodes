import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/screen_scale.dart';
import '../../content/models/game_definition.dart';
import '../../content/models/level_pack.dart';
import '../progress/progress_repository.dart';
import '../progress/unlock_policy.dart';
import 'level_screen.dart';
import 'widgets/group_tone.dart';
import 'widgets/level_button.dart';
import 'widgets/level_group_panel.dart';

/// Bir oyunun seviye seçim ekranı. Yalnızca oynanabilir (ücretsiz veya sahip olunan) paketler
/// gösterilir; her paketin seviyeleri zorluk gruplarının renkli panellerinde durur. Paneller ekran
/// genişliğine göre bir, iki veya dört sütuna dizilir (web sürümündeki kırılma noktaları).
final class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({required this.game, super.key});

  final GameDefinition game;

  static const _padding = 16.0;
  static const _gap = 18.0;
  static const _twoColumnMinWidth = 560.0;
  static const _fourColumnMinWidth = 960.0;

  /// Tablette seviye satırlarının en fazla büyüme oranı; yatay tablette dört panelin ekrana sığması için sınırlıdır.
  static const _maxRowGrowth = 1.2;

  /// Verilen genişlikte kaç sütun panel dizileceği.
  static int columnsFor(double width) => switch (width) {
        >= _fourColumnMinWidth => 4,
        >= _twoColumnMinWidth => 2,
        _ => 1,
      };

  @override
  Widget build(BuildContext context) {
    final services = AppScope.of(context);
    final packs = [
      for (final pack in services.catalog.packsOf(game.id))
        if (services.entitlements.canPlayPack(pack.id)) pack,
    ];
    return ListenableBuilder(
      listenable: services.progress,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(game.title),
          actions: [_StarCounter(stars: packs.fold(0, (sum, pack) => sum + services.progress.totalStars(pack.id)))],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final columns = columnsFor(constraints.maxWidth);
            final ratio = ScreenScale.of(context).size(1, max: _maxRowGrowth);
            return ListView(
              padding: const EdgeInsets.all(_padding),
              children: [
                for (final pack in packs) ...[
                  if (packs.length > 1) Text(pack.title, style: Theme.of(context).textTheme.headlineSmall),
                  ..._grid([
                    for (final range in pack.groupRanges)
                      _GroupPanel(
                        game: game,
                        pack: pack,
                        range: range,
                        progress: services.progress,
                        policy: services.unlockPolicy,
                        ratio: ratio,
                      ),
                  ], columns),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Panelleri satır satır, her satırda [columns] eşit genişlikte sütun olacak şekilde dizer.
List<Widget> _grid(List<Widget> panels, int columns) => [
      for (var start = 0; start < panels.length; start += columns)
        Padding(
          padding: const EdgeInsets.only(bottom: LevelSelectScreen._gap),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var column = 0; column < columns; column++) ...[
                if (column > 0) const SizedBox(width: LevelSelectScreen._gap),
                Expanded(child: start + column < panels.length ? panels[start + column] : const SizedBox.shrink()),
              ],
            ],
          ),
        ),
    ];

final class _StarCounter extends StatelessWidget {
  const _StarCounter({required this.stars});

  final int stars;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.star, width: 24, height: 24),
            const SizedBox(width: 4),
            Text('$stars', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
}

/// Bir zorluk grubunun verisini panele bağlar.
final class _GroupPanel extends StatelessWidget {
  const _GroupPanel({
    required this.game,
    required this.pack,
    required this.range,
    required this.progress,
    required this.policy,
    required this.ratio,
  });

  final GameDefinition game;
  final LevelPack pack;
  final GroupRange range;
  final ProgressRepository progress;
  final UnlockPolicy policy;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final unlocked = policy.isGroupUnlocked(pack, range);
    final nextLevel = policy.nextLevel(pack);
    final tone = GroupTone.of(range.group.difficulty);
    return LevelGroupPanel(
      title: range.group.difficulty.title,
      tone: tone,
      unlocked: unlocked,
      progressText: '${policy.groupCompletedCount(pack, range)}/${range.levelCount}',
      hint: !unlocked && range.index > 0
          ? 'Önce ${pack.groupRanges[range.index - 1].group.difficulty.title} seviyelerini bitir'
          : null,
      levels: [
        for (var level = range.firstLevel; level <= range.lastLevel; level++)
          LevelButton(
            level: level,
            stars: progress.starsOf(pack.id, level),
            unlocked: policy.isLevelUnlocked(pack, level),
            isNext: level == nextLevel,
            tone: tone,
            ratio: ratio,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => LevelScreen(game: game, pack: pack, initialLevel: level),
              ),
            ),
          ),
      ],
    );
  }
}
