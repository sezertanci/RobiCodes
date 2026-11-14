import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../app/app_theme.dart';
import '../../app/robi_codes_app.dart';
import '../../content/models/game_definition.dart';
import '../play/level_select_screen.dart';
import '../progress/star_rule.dart';
import '../settings/settings_dialog.dart';
import 'character_button.dart';
import 'game_card.dart';

/// Ana ekran: seçili karakteri ve katalogdaki oyunları ilerlemeleriyle birlikte gösterir.
/// Oyun sayısı katalogdan gelir; ekran sabit bir sayı varsaymaz.
final class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _maxCardWidth = 360.0;
  static const _cardHeight = 220.0;

  @override
  Widget build(BuildContext context) {
    final services = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(RobiCodesApp.title),
        actions: [
          IconButton(
            tooltip: SettingsDialog.title,
            onPressed: () => SettingsDialog.show(context, services.sound),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([services.progress, services.entitlements]),
        builder: (context, _) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(padding: EdgeInsets.only(top: 16), child: CharacterButton()),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.list(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: _maxCardWidth,
                  mainAxisExtent: _cardHeight,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                children: [
                  for (final (index, game) in services.catalog.games.indexed)
                    _buildCard(context, services, game, index),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kartta oyunun yalnızca oynanabilir (ücretsiz veya sahip olunan) paketlerinin yıldızları sayılır.
  Widget _buildCard(BuildContext context, AppServices services, GameDefinition game, int index) {
    final isPlayable = services.games.isPlayable(game.id);
    final packs = services.catalog.packsOf(game.id).where((pack) => services.entitlements.canPlayPack(pack.id));
    return GameCard(
      title: game.title,
      description: game.description,
      accent: AppColors.cardAccents[index % AppColors.cardAccents.length],
      stars: packs.fold(0, (sum, pack) => sum + services.progress.totalStars(pack.id)),
      maxStars: packs.fold(0, (sum, pack) => sum + pack.levelCount * StarRule.perfect),
      isPlayable: isPlayable,
      onTap: isPlayable
          ? () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => LevelSelectScreen(game: game)))
          : null,
    );
  }
}
