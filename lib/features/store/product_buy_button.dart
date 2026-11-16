import 'dart:async';

import 'package:flutter/material.dart';

import '../../content/models/store_product.dart';
import '../../l10n/l10n.dart';
import 'listing_service.dart';
import '../sound/tap_sound.dart';

/// Henüz sahip olunmayan ürünün fiyatlı satın alma düğmesi. Fiyat yüklenirken, yüklenemediğinde
/// (yeniden deneme düğmesiyle) ve ürün Play'de bulunmadığında bunu anlatan metin gösterilir.
final class ProductBuyButton extends StatelessWidget {
  const ProductBuyButton({
    required this.product,
    required this.listings,
    required this.isBusy,
    required this.onBuy,
    super.key,
  });

  final StoreProduct product;
  final ListingService listings;

  /// Bir mağaza işlemi sürerken düğme kapalıdır.
  final bool isBusy;
  final ValueChanged<StoreProduct> onBuy;

  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    if (listings.isLoading) {
      return Text(t.storePriceLoading);
    }
    if (listings.error != null) {
      return Row(
        spacing: _gap,
        children: [
          Expanded(child: Text(t.storePriceUnavailable)),
          TextButton(onPressed: context.withTapSound(() => unawaited(listings.load())), child: Text(t.storeRetry)),
        ],
      );
    }
    final listing = listings.listingOf(product.id);
    if (listing == null) {
      return Text(t.storeNotInStore);
    }
    return FilledButton(
      onPressed: context.withTapSound(isBusy ? null : () => onBuy(product)),
      child: Text(t.storeBuy(listing.price)),
    );
  }
}
