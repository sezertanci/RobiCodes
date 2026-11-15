import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_services.dart';
import '../../../app/app_theme.dart';
import '../../../content/models/store_product.dart';
import '../../../l10n/l10n.dart';
import '../../store/product_buy_button.dart';
import '../../store/purchase_flow.dart';

/// Satın alınmamış ücretli paketin seviye seçiminde üstte duran bilgi bandı: hangi seviyelerin
/// ücretsiz denenebildiğini anlatır ve paketin ürününü fiyatıyla satın alma düğmesi sunar.
/// Satın alma ebeveyn onayından geçer; metin sakin ve bilgilendiricidir.
final class PreviewBanner extends StatefulWidget {
  const PreviewBanner({required this.product, required this.services, super.key});

  final StoreProduct product;
  final AppServices services;

  @override
  State<PreviewBanner> createState() => _PreviewBannerState();
}

final class _PreviewBannerState extends State<PreviewBanner> {
  bool _isBusy = false;

  static const _padding = 16.0;
  static const _gap = 12.0;
  static const _lockSize = 32.0;

  Future<void> _buy(StoreProduct product) async {
    setState(() => _isBusy = true);
    await PurchaseFlow.buyAndReport(context, widget.services, product);
    if (mounted) {
      setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppMetrics.largeRadius)),
    child: Padding(
      padding: const EdgeInsets.all(_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: _gap,
        children: [
          Row(
            spacing: _gap,
            children: [
              SvgPicture.asset(AppAssets.lock, width: _lockSize, height: _lockSize),
              Expanded(child: Text(context.l10n.playPreviewNote)),
            ],
          ),
          ListenableBuilder(
            listenable: widget.services.listings,
            builder: (context, _) => ProductBuyButton(
              product: widget.product,
              listings: widget.services.listings,
              isBusy: _isBusy,
              onBuy: _buy,
            ),
          ),
        ],
      ),
    ),
  );
}
