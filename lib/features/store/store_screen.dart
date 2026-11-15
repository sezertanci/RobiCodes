import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../app/app_theme.dart';
import '../../app/screen_scale.dart';
import '../../app/widgets/top_bar.dart';
import '../../content/models/store_product.dart';
import '../../l10n/l10n.dart';
import 'purchase_flow.dart';
import 'store_texts.dart';
import 'widgets/free_pack_card.dart';
import 'widgets/product_card.dart';

/// Paket mağazası: ücretli ürünler, fiyatları, sahiplik durumu, ücretsiz paketler ve geri yükleme.
/// Satın alma `PurchaseFlow` ile ebeveyn onayından geçer.
final class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  static Future<void> open(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const StoreScreen()));

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

final class _StoreScreenState extends State<StoreScreen> {
  late final AppServices _services = AppScope.of(context);
  bool _isBusy = false;

  static const _padding = 16.0;
  static const _gap = 16.0;
  static const _maxContentWidth = 1000.0;

  /// Geniş ekranda bir kartın en küçük genişliği; daha dar ekranda kartlar tek sütundur.
  static const _productMinWidth = 420.0;
  static const _freePackMinWidth = 260.0;

  /// Fiyatlar ilk kareden sonra yenilenir; yükleme bildirimi, fiyatları dinleyen diğer ekranlar
  /// (ör. ana ekran) kurulurken gelmesin diye.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(_services.listings.load());
      }
    });
  }

  Future<void> _buy(StoreProduct product) => _whileBusy(() => PurchaseFlow.buy(context, _services, product));

  Future<void> _restore() => _whileBusy(() async {
    final error = await _services.entitlements.refresh();
    final owned = _services.entitlements.ownedProductIds.length;
    return (AppLocalizations t) => StoreTexts.restoreResult(t, error, owned);
  });

  /// İşlem sürerken düğmeleri kapatır, bitince sonucu kullanıcıya gösterir. Sonuç metni, ekran hâlâ
  /// açıkken o anki dilde kurulur.
  Future<void> _whileBusy(Future<LocalizedText> Function() action) async {
    setState(() => _isBusy = true);
    final message = await action();
    if (!mounted) {
      return;
    }
    setState(() => _isBusy = false);
    PurchaseFlow.report(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(title: t.storeTitle, backLabel: t.commonBackToHome),
            Expanded(
              child: ListenableBuilder(
                listenable: Listenable.merge([_services.entitlements, _services.listings]),
                builder: (context, _) => LayoutBuilder(
                  builder: (context, constraints) {
                    final width = min(constraints.maxWidth, _maxContentWidth) - 2 * _padding;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: width + 2 * _padding,
                        child: ListView(padding: const EdgeInsets.all(_padding), children: _content(t, width)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _content(AppLocalizations t, double width) {
    final catalog = _services.catalog;
    final small = Theme.of(context).textTheme.bodyMedium;
    return [
      _Panel(
        child: Row(
          spacing: _gap,
          children: [
            const Icon(Icons.info_outline_rounded, color: AppColors.navy),
            Expanded(child: Text(t.storeIntro, style: small)),
          ],
        ),
      ),
      _SectionTitle(t.storePaidSection),
      if (catalog.products.isEmpty)
        _Panel(child: Text(t.storeNoProducts))
      else
        _Grid(
          width: width,
          minCellWidth: _productMinWidth,
          children: [
            for (final product in catalog.products)
              ProductCard(product: product, services: _services, isBusy: _isBusy, onBuy: _buy),
          ],
        ),
      _SectionTitle(t.storeFreeSection),
      _Grid(
        width: width,
        minCellWidth: _freePackMinWidth,
        children: [
          for (final game in catalog.games)
            for (final pack in catalog.freePacksOf(game.id)) FreePackCard(game: game, pack: pack),
        ],
      ),
      const SizedBox(height: _gap * 2),
      _Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: _gap / 2,
          children: [
            OutlinedButton.icon(
              onPressed: _isBusy ? null : _restore,
              icon: const Icon(Icons.restore_rounded),
              label: Text(t.storeRestore),
            ),
            Text(t.storeRestoreHint, style: small),
          ],
        ),
      ),
    ];
  }
}

/// Bölüm başlığı.
final class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  static const _spacing = 24.0;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: _spacing, bottom: _spacing / 2),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w900),
    ),
  );
}

/// Bilgi metinleri için gölgeli beyaz panel.
final class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  static const _padding = EdgeInsets.all(14);
  static const _radius = BorderRadius.all(Radius.circular(AppMetrics.mediumRadius));
  static const _shadow = BoxShadow(color: AppColors.shadow, offset: Offset(0, 4), blurRadius: 8);

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: Colors.white, borderRadius: _radius, boxShadow: [_shadow]),
    child: Padding(padding: _padding, child: child),
  );
}

/// Kartları sığdığı kadar sütuna dizer; dar ekranda tek sütundur.
final class _Grid extends StatelessWidget {
  const _Grid({required this.width, required this.minCellWidth, required this.children});

  final double width;
  final double minCellWidth;
  final List<Widget> children;

  static const _gap = 16.0;

  @override
  Widget build(BuildContext context) {
    final cellWidth = ScreenScale.cellWidth(width, ScreenScale.columns(width, minCellWidth, _gap), _gap);
    return Wrap(
      spacing: _gap,
      runSpacing: _gap + AppMetrics.lip,
      children: [for (final child in children) SizedBox(width: cellWidth, child: child)],
    );
  }
}
