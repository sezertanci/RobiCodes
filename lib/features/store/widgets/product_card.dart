import 'package:flutter/material.dart';

import '../../../app/app_services.dart';
import '../../../app/app_theme.dart';
import '../../../app/widgets/game_icon_badge.dart';
import '../../../app/widgets/tone_card.dart';
import '../../../content/models/store_product.dart';
import '../../../l10n/l10n.dart';
import '../offer_policy.dart';
import '../product_buy_button.dart';
import '../store_texts.dart';

/// Ücretli ürünün kartı: ana ekrandaki oyun kartı gibi oyunun renginde, oyun ikonu, ürün adı, açtığı
/// paketler ve sahipliğe göre satın alma düğmesi veya açıklama. Birden çok oyunu kapsayan ürün altın
/// tonundadır ve her oyunun ikonunu gösterir.
final class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.services,
    required this.isBusy,
    required this.onBuy,
    super.key,
  });

  final StoreProduct product;
  final AppServices services;
  final bool isBusy;
  final ValueChanged<StoreProduct> onBuy;

  static const _padding = EdgeInsets.all(18);
  static const _gap = 12.0;
  static const _badgeSize = 72.0;
  static const _iconSize = 54.0;
  static const _titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.1);
  static const _bodyStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    final catalog = services.catalog;
    final packs = [for (final id in product.packIds) ?catalog.findPack(id)];
    final games = {for (final pack in packs) ?catalog.findGame(pack.gameId)};
    final tone = games.length == 1 ? games.first.tone : AppTones.gold;
    final t = context.l10n;
    return ToneCard(
      tone: tone,
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: _gap,
        children: [
          Row(
            spacing: _gap,
            children: [
              for (final game in games)
                GameIconBadge(icon: game.icon, tone: game.tone, size: _badgeSize, iconSize: _iconSize),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title(t), style: _titleStyle),
                    if (product.isBundle) Chip(label: Text(t.storeBundle)),
                  ],
                ),
              ),
            ],
          ),
          DefaultTextStyle.merge(
            style: _bodyStyle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.storeUnlocks),
                for (final pack in packs) Text('• ${StoreTexts.packLine(t, services, pack)}'),
              ],
            ),
          ),
          Theme(data: _actionTheme(Theme.of(context), tone), child: _action(t)),
        ],
      ),
    );
  }

  /// Renkli zeminde okunması için satın alma düğmesi beyaz, yazısı oyunun koyu tonundadır.
  static ThemeData _actionTheme(ThemeData theme, ColorTone tone) => theme.copyWith(
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: tone.dark,
        minimumSize: const Size.fromHeight(AppMetrics.compactTouch),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w900),
      ),
    ),
  );

  Widget _action(AppLocalizations t) {
    final offers = services.offers;
    return switch (offers.statusOf(product)) {
      OfferStatus.alreadyOwned => Align(
        alignment: Alignment.centerLeft,
        child: Chip(avatar: const Icon(Icons.check_circle_rounded), label: Text(t.storeOwned)),
      ),
      OfferStatus.partiallyOwned => Text(
        t.storePartiallyOwned(offers.missingPartsOf(product).map((part) => part.title(t)).join(', ')),
      ),
      OfferStatus.available => ProductBuyButton(
        product: product,
        listings: services.listings,
        isBusy: isBusy,
        onBuy: onBuy,
      ),
    };
  }
}
