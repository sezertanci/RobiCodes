import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../content/models/game_definition.dart';
import '../../content/models/level_pack.dart';
import '../../l10n/l10n.dart';
import '../play/level_select_screen.dart';
import 'game_card.dart';
import 'home_header.dart';

/// Ana ekran: logo, seçili karakter, sayaçlar ve katalogdaki oyunlar ilerlemeleriyle birlikte.
/// Oyun sayısı katalogdan gelir; ekran sabit bir sayı varsaymaz.
final class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _maxCardWidth = 360.0;
  static const _cardHeight = 280.0;

  @override
  Widget build(BuildContext context) {
    final services = AppScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([services.progress, services.entitlements, services.listings]),
          builder: (context, _) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: HomeHeader(stars: services.progress.starsIn(services.catalog.packs))),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid.list(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: _maxCardWidth,
                    mainAxisExtent: _cardHeight,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  children: [for (final game in services.catalog.games) _buildCard(context, services, game)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Kartta oyunun seviye seçiminde görünen (ücretsiz, sahip olunan veya denemesi olan) paketleri sayılır.
  Widget _buildCard(BuildContext context, AppServices services, GameDefinition game) {
    final isPlayable = services.games.isPlayable(game.id);
    final packs = services.entitlements.visiblePacksOf(game.id);
    final t = context.l10n;
    return GameCard(
      title: game.title(t),
      description: game.description(t),
      tone: game.tone,
      icon: game.icon,
      completed: services.progress.completedIn(packs),
      levels: packs.levelCount,
      stars: services.progress.starsIn(packs),
      isPlayable: isPlayable,
      lockedLabel: isPlayable ? _lockedLabel(t, services, packs) : null,
      onTap: isPlayable
          ? () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => LevelSelectScreen(game: game)))
          : null,
    );
  }

  /// Oyunun bütün paketleri yalnızca denemeyle oynanıyorsa ilk paketin fiyatı, fiyat bilinmiyorsa
  /// "Kilitli"; oynanabilir paketi varsa `null`.
  static String? _lockedLabel(AppLocalizations t, AppServices services, List<LevelPack> packs) {
    if (packs.isEmpty || !packs.every(services.entitlements.isPreviewOnly)) {
      return null;
    }
    final product = services.catalog.purchaseFor(packs.first.id);
    return (product == null ? null : services.listings.listingOf(product.id)?.price) ?? t.homeLocked;
  }
}
