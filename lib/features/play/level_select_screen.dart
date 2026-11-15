import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../app/screen_scale.dart';
import '../../app/widgets/star_counter.dart';
import '../../app/widgets/top_bar.dart';
import '../../content/models/game_definition.dart';
import '../../content/models/level_pack.dart';
import '../../l10n/l10n.dart';
import '../progress/progress_repository.dart';
import '../progress/unlock_policy.dart';
import '../store/purchase_flow.dart';
import 'level_screen.dart';
import 'widgets/group_tone.dart';
import 'widgets/level_button.dart';
import 'widgets/level_group_panel.dart';
import 'widgets/preview_banner.dart';

/// Bir oyunun seviye seçim ekranı. Oynanabilir (ücretsiz veya sahip olunan) paketler ve satın
/// alınmamış ama deneme seviyeleri olan paketler gösterilir. Deneme paketinin üstünde fiyatlı satın alma
/// bandı durur; kilitli seviyesine dokunmak da satın almayı açar; her paketin seviyeleri zorluk gruplarının renkli panellerinde durur. Paneller ekran
/// genişliğine göre bir, iki veya dört sütuna dizilir (web sürümündeki kırılma noktaları).
/// İlerleme veya paket sahipliği değişince (ör. mağaza açılışta geç cevap verirse) ekran yenilenir.
final class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({required this.game, super.key});

  final GameDefinition game;

  static const _padding = 16.0;
  static const _gap = 18.0;
  static const _twoColumnMinWidth = ScreenScale.narrowMaxWidth;
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
    return ListenableBuilder(
      listenable: Listenable.merge([services.progress, services.entitlements]),
      builder: (context, _) {
        final packs = services.entitlements.visiblePacksOf(game.id);
        final t = context.l10n;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TopBar(
                  title: game.title(t),
                  icon: game.icon,
                  backLabel: t.commonBackToHome,
                  actions: [StarCounter(stars: services.progress.starsIn(packs))],
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = columnsFor(constraints.maxWidth);
                      final ratio = ScreenScale.of(context).size(1, max: _maxRowGrowth);
                      return ListView(
                        padding: const EdgeInsets.all(_padding),
                        children: [
                          for (final pack in packs)
                            ..._packSection(context, services, pack, columns, ratio, titled: packs.length > 1),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Bir paketin başlığı (birden çok paket varsa) ve grup panelleri. Sıradaki seviye paket başına bir kez bulunur.
  List<Widget> _packSection(
    BuildContext context,
    AppServices services,
    LevelPack pack,
    int columns,
    double ratio, {
    required bool titled,
  }) {
    final nextLevel = services.unlockPolicy.nextLevel(pack);
    final product = services.entitlements.isPreviewOnly(pack) ? services.catalog.purchaseFor(pack.id) : null;
    return [
      if (titled) Text(pack.title(context.l10n), style: Theme.of(context).textTheme.headlineSmall),
      if (product != null)
        Padding(
          padding: const EdgeInsets.only(bottom: LevelSelectScreen._gap),
          child: PreviewBanner(product: product, services: services),
        ),
      ..._grid([
        for (final range in pack.groupRanges)
          _GroupPanel(
            game: game,
            pack: pack,
            range: range,
            nextLevel: nextLevel,
            progress: services.progress,
            policy: services.unlockPolicy,
            ratio: ratio,
            onLockedTap: product == null
                ? null
                : () => unawaited(PurchaseFlow.buyAndReport(context, services, product)),
          ),
      ], columns),
    ];
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

/// Bir zorluk grubunun verisini panele bağlar.
final class _GroupPanel extends StatelessWidget {
  const _GroupPanel({
    required this.game,
    required this.pack,
    required this.range,
    required this.nextLevel,
    required this.progress,
    required this.policy,
    required this.ratio,
    required this.onLockedTap,
  });

  final GameDefinition game;
  final LevelPack pack;
  final GroupRange range;

  /// Paketteki sıradaki oynanacak seviye; hepsi bittiyse `null`.
  final int? nextLevel;
  final ProgressRepository progress;
  final UnlockPolicy policy;
  final double ratio;

  /// Satın alınmamış deneme paketinde kilitli seviyeye dokununca satın almayı açar; diğer paketlerde `null`.
  final VoidCallback? onLockedTap;

  @override
  Widget build(BuildContext context) {
    final unlocked = policy.isGroupUnlocked(pack, range);
    final tone = GroupTone.of(range.group.difficulty);
    final t = context.l10n;
    return LevelGroupPanel(
      title: range.group.difficulty.title(t),
      tone: tone,
      unlocked: unlocked,
      progressText: '${policy.groupCompletedCount(pack, range)}/${range.levelCount}',
      // Deneme paketinde kilit önceki grubu bitirmekle açılmaz; ipucu yanıltmasın diye gösterilmez.
      hint: !unlocked && range.index > 0 && onLockedTap == null
          ? t.playFinishGroupFirst(pack.groupRanges[range.index - 1].group.difficulty.title(t))
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
            onLockedTap: onLockedTap,
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
