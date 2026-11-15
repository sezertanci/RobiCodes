import '../../l10n/l10n.dart';
import 'purchase_gateway.dart';

/// Mağaza sonuçlarını seçili dildeki metne çevirir. Metinler ARB dosyalarındadır; ton sakin ve
/// bilgilendiricidir, satın almaya yönlendiren, aciliyet veya indirim vurgusu yapan ifadeler kullanılmaz.
abstract final class StoreTexts {
  static String restoreResult(AppLocalizations t, StoreError? error, int ownedCount) => switch (error) {
    null => t.storeRestored(ownedCount),
    StoreError.offline => t.storeRestoreOffline,
    StoreError.unavailable => t.storeRestoreUnavailable,
  };

  static String outcome(AppLocalizations t, PurchaseOutcome outcome) => switch (outcome) {
    PurchaseOutcome.purchased => t.storePurchased,
    PurchaseOutcome.pending => t.storePending,
    PurchaseOutcome.cancelled => t.storeCancelled,
    PurchaseOutcome.alreadyOwned => t.storeAlreadyOwned,
    PurchaseOutcome.productNotFound => t.storeNotInStore,
    PurchaseOutcome.offline => t.storeOffline,
    PurchaseOutcome.unavailable => t.storeUnavailable,
    PurchaseOutcome.failed => t.storeFailed,
    PurchaseOutcome.notApproved => t.storeNotApproved,
  };
}
