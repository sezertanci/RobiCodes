import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../content/models/level_pack.dart';
import '../../content/models/store_product.dart';
import '../parental_gate/parental_gate.dart';
import 'offer_policy.dart';
import 'purchase_gateway.dart';
import 'store_texts.dart';

/// Paket mağazası: ücretli ürünler, fiyatları, sahiplik durumu, ücretsiz paketler ve geri yükleme.
/// Her satın alma merkezi ebeveyn korumasından (`ProtectedActionRunner`) geçer; onay alınamazsa
/// Google Play penceresi hiç açılmaz.
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(_services.listings.load());
  }

  Future<void> _buy(StoreProduct product) => _whileBusy(() async {
    final outcome = await _services.protectedActions.run(
      context,
      ParentalAction.purchase,
      (approval) => _services.entitlements.purchase(product.id, approval: approval),
    );
    return StoreTexts.outcome(outcome ?? PurchaseOutcome.notApproved);
  });

  Future<void> _restore() => _whileBusy(() async {
    final error = await _services.entitlements.refresh();
    return StoreTexts.restoreResult(error, _services.entitlements.ownedProductIds.length);
  });

  /// İşlem sürerken düğmeleri kapatır, bitince sonucu kullanıcıya gösterir.
  Future<void> _whileBusy(Future<String> Function() action) async {
    setState(() => _isBusy = true);
    final message = await action();
    if (!mounted) {
      return;
    }
    setState(() => _isBusy = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final catalog = _services.catalog;
    return Scaffold(
      appBar: AppBar(title: const Text(StoreTexts.title)),
      body: ListenableBuilder(
        listenable: Listenable.merge([_services.entitlements, _services.listings]),
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(_padding),
          children: [
            const Text(StoreTexts.intro),
            _SectionTitle(StoreTexts.paidSection),
            if (catalog.products.isEmpty) const Text(StoreTexts.noProducts),
            for (final product in catalog.products)
              _ProductCard(product: product, services: _services, isBusy: _isBusy, onBuy: _buy),
            _SectionTitle(StoreTexts.freeSection),
            for (final game in catalog.games)
              for (final pack in catalog.freePacksOf(game.id)) ListTile(title: Text(_packLine(_services, pack))),
            const SizedBox(height: _padding),
            OutlinedButton.icon(
              onPressed: _isBusy ? null : _restore,
              icon: const Icon(Icons.restore_rounded),
              label: const Text(StoreTexts.restore),
            ),
            const Text(StoreTexts.restoreHint),
          ],
        ),
      ),
    );
  }
}

/// "Oyun – Paket (N seviye)" satırı.
String _packLine(AppServices services, LevelPack pack) {
  final game = services.catalog.findGame(pack.gameId)?.title ?? pack.gameId;
  return '$game – ${pack.title} (${StoreTexts.levels(pack.levelCount)})';
}

final class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  static const _spacing = 16.0;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: _spacing, bottom: _spacing / 2),
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );
}

/// Tek ürünün kartı: açacağı içerik ve sahipliğe göre fiyat, satın alma düğmesi veya açıklama.
final class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.services, required this.isBusy, required this.onBuy});

  final StoreProduct product;
  final AppServices services;
  final bool isBusy;
  final ValueChanged<StoreProduct> onBuy;

  static const _padding = 16.0;
  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    final packs = [for (final id in product.packIds) ?services.catalog.findPack(id)];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: _gap,
          children: [
            Text(product.title, style: Theme.of(context).textTheme.titleMedium),
            if (product.isBundle) const Chip(label: Text(StoreTexts.bundleLabel)),
            const Text(StoreTexts.unlocksLabel),
            for (final pack in packs) Text('• ${_packLine(services, pack)}'),
            _action(context),
          ],
        ),
      ),
    );
  }

  Widget _action(BuildContext context) {
    final offers = services.offers;
    final listings = services.listings;
    switch (offers.statusOf(product)) {
      case OfferStatus.alreadyOwned:
        return const Chip(avatar: Icon(Icons.check_circle_rounded), label: Text(StoreTexts.ownedLabel));
      case OfferStatus.partiallyOwned:
        final missing = offers.missingPartsOf(product).map((part) => part.title).join(', ');
        return Text('${StoreTexts.partiallyOwned} $missing');
      case OfferStatus.available:
        if (listings.isLoading) {
          return const Text(StoreTexts.priceLoading);
        }
        if (listings.error != null) {
          return Row(
            spacing: _gap,
            children: [
              const Expanded(child: Text(StoreTexts.priceUnavailable)),
              TextButton(onPressed: () => unawaited(listings.load()), child: const Text(StoreTexts.retry)),
            ],
          );
        }
        final listing = listings.listingOf(product.id);
        if (listing == null) {
          return const Text(StoreTexts.notInStore);
        }
        return FilledButton(
          onPressed: isBusy ? null : () => onBuy(product),
          child: Text(StoreTexts.buy(listing.price)),
        );
    }
  }
}
