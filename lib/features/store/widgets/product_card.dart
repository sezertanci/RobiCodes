import 'package:flutter/material.dart';

import '../../../app/app_services.dart';
import '../../../app/app_theme.dart';
import '../../../app/widgets/game_icon_badge.dart';
import '../../../app/widgets/tone_card.dart';
import '../../../content/models/game_definition.dart';
import '../../../content/models/store_product.dart';
import '../../../l10n/l10n.dart';
import '../offer_policy.dart';
import '../product_buy_button.dart';
import '../store_texts.dart';
import 'bundle_highlight.dart';

/// Ücretli ürünün kartı: ana ekrandaki oyun kartı gibi oyunun renginde, oyun ikonu, ürün adı, açtığı
/// paketler ve sahipliğe göre satın alma düğmesi veya açıklama. Birden çok oyunu kapsayan ürün çivit mavisi
/// tonundadır, her oyunun ikonunu gösterir ve [BundleHighlight] ile öne çıkarılır.
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

  /// İkonların yanında ürün adına en az bu kadar yer kalmazsa ikonlar adın üstüne, ayrı satıra geçer.
  static const _minTitleWidth = 180.0;
  static const _titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.1);
  static const _bodyStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    final catalog = services.catalog;
    final packs = [for (final id in product.packIds) ?catalog.findPack(id)];
    final games = {for (final pack in packs) ?catalog.findGame(pack.gameId)};
    final tone = games.length == 1 ? games.first.tone : AppTones.indigo;
    final t = context.l10n;
    final card = ToneCard(
      tone: tone,
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: _gap,
        children: [
          _header(t, games),
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
    return product.isBundle ? BundleHighlight(label: t.storeBundle, child: card) : card;
  }

  /// Oyun ikonları ve ürün adı. Yer yetiyorsa ikonlar adın solunda durur; telefonda çok oyunlu sette ad
  /// sıkışmasın diye ikonlar üst satıra geçer. Bileşik pakette başlık köşedeki şeridin altında kalmaz.
  Widget _header(AppLocalizations t, Iterable<GameDefinition> games) {
    final icons = [
      for (final game in games) GameIconBadge(icon: game.icon, tone: game.tone, size: _badgeSize, iconSize: _iconSize),
    ];
    final heading = Text(product.title(t), style: _titleStyle);
    final header = LayoutBuilder(
      builder: (context, constraints) {
        final iconsWidth = icons.length * (_badgeSize + _gap);
        if (constraints.maxWidth - iconsWidth >= _minTitleWidth) {
          return Row(
            spacing: _gap,
            children: [
              ...icons,
              Expanded(child: heading),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: _gap,
          children: [
            Wrap(spacing: _gap, runSpacing: _gap, children: icons),
            heading,
          ],
        );
      },
    );
    if (!product.isBundle) {
      return header;
    }
    return Padding(
      padding: EdgeInsets.only(right: BundleHighlight.reach - _padding.right),
      child: header,
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
