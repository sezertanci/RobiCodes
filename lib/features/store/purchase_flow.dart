import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../content/models/store_product.dart';
import '../../l10n/l10n.dart';
import '../parental_gate/parental_gate.dart';
import 'purchase_gateway.dart';
import 'store_texts.dart';

/// Satın alma akışı: her satın alma merkezi ebeveyn korumasından (`ProtectedActionRunner`) geçer;
/// onay alınamazsa Google Play penceresi hiç açılmaz. Mağaza ekranı ve seviye seçimindeki deneme
/// bandı bu akışı ortak kullanır.
abstract final class PurchaseFlow {
  /// Ürünü ebeveyn onayıyla satın alır ve sonucun metnini döndürür. Metin, gösterileceği anki dilde kurulur.
  static Future<LocalizedText> buy(BuildContext context, AppServices services, StoreProduct product) async {
    final outcome = await services.protectedActions.run(
      context,
      ParentalAction.purchase,
      (approval) => services.entitlements.purchase(product.id, approval: approval),
    );
    return (AppLocalizations t) => StoreTexts.outcome(t, outcome ?? PurchaseOutcome.notApproved);
  }

  /// Ürünü satın alır ve sonucu ekranın altında kısa bir mesajla gösterir.
  static Future<void> buyAndReport(BuildContext context, AppServices services, StoreProduct product) async {
    final message = await buy(context, services, product);
    if (context.mounted) {
      report(context, message);
    }
  }

  /// Mağaza işleminin sonucunu ekranın altında kısa bir mesajla gösterir.
  static void report(BuildContext context, LocalizedText message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message(context.l10n))));
}
