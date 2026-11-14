import 'dart:async';

import 'package:flutter/services.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

import 'purchase_gateway.dart';

/// Google Play Billing ile çalışan mağaza (resmi `in_app_purchase_android` eklentisi üzerinden).
///
/// - Satın alma güncellemeleri, uygulama açılır açılmaz dinlenmeye başlanır; böylece uygulama
///   kapalıyken tamamlanan veya bekleyen ödemeler kaçırılmaz.
/// - Ürünler tüketilmez; yalnızca onaylanır (acknowledge).
/// - Eklentiden gelen platform hataları burada yakalanır ve uygulamanın sonuç türlerine çevrilir.
final class PlayPurchaseGateway implements PurchaseGateway {
  PlayPurchaseGateway(this._platform, this._addition) {
    _platform.purchaseStream.listen(_onUpdates);
  }

  /// Gerçek Android eklentisini kurar. Uygulama açılışında bir kez çağrılır.
  factory PlayPurchaseGateway.create() {
    InAppPurchaseAndroidPlatform.registerPlatform();
    // Eklenti, kurulumda kendini ve ek API'sini bu genel kayıtlara yazar.
    return PlayPurchaseGateway(
      InAppPurchasePlatform.instance as InAppPurchaseAndroidPlatform,
      InAppPurchasePlatformAddition.instance! as InAppPurchaseAndroidPlatformAddition,
    );
  }

  final InAppPurchaseAndroidPlatform _platform;
  final InAppPurchaseAndroidPlatformAddition _addition;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  /// Onaylama için gereken eklenti kayıtları, satın alma anahtarına göre.
  final Map<String, GooglePlayPurchaseDetails> _details = {};

  /// Açık olan satın alma penceresinin ürünü ve sonucu bekleyen tamamlayıcı.
  ({String productId, Completer<PurchaseDetails> result})? _waiter;

  @override
  Stream<void> get purchasesChanged => _changes.stream;

  @override
  Future<StoreQuery<Map<String, StoreListing>>> queryListings(Set<String> productIds) => _guardQuery(() async {
    final response = await _platform.queryProductDetails(productIds);
    final error = response.error;
    if (error != null && response.productDetails.isEmpty) {
      return StoreFailure(storeErrorOf(error));
    }
    return StoreSuccess({
      for (final details in response.productDetails)
        if (productIds.contains(details.id)) details.id: StoreListing(productId: details.id, price: details.price),
    });
  });

  @override
  Future<StoreQuery<List<OwnedPurchase>>> queryOwnedPurchases() => _guardQuery(() async {
    if (!await _platform.isAvailable()) {
      return const StoreFailure(StoreError.unavailable);
    }
    final response = await _addition.queryPastPurchases();
    final error = response.error;
    if (error != null) {
      return StoreFailure(storeErrorOf(error));
    }
    final completed = response.pastPurchases.where(
      (details) => details.billingClientPurchase.purchaseState == PurchaseStateWrapper.purchased,
    );
    return StoreSuccess([for (final details in completed) _remember(details)]);
  });

  @override
  Future<PurchaseResult> purchase(String productId) async {
    if (_waiter != null) {
      return const PurchaseResult(PurchaseOutcome.failed);
    }
    try {
      return await _purchase(productId);
    } on PlatformException {
      return const PurchaseResult(PurchaseOutcome.unavailable);
    } on InAppPurchaseException {
      return const PurchaseResult(PurchaseOutcome.failed);
    } finally {
      _waiter = null;
    }
  }

  @override
  Future<bool> acknowledge(OwnedPurchase purchase) async {
    final details = _details[purchase.token];
    if (details == null) {
      return false;
    }
    try {
      final result = await _platform.completePurchase(details);
      return result.responseCode == BillingResponse.ok;
    } on PlatformException {
      return false;
    }
  }

  /// Satın alma adımları: Play'e bağlantı, mevcut sahiplik, ürün bilgisi, ödeme penceresi.
  Future<PurchaseResult> _purchase(String productId) async {
    switch (await queryOwnedPurchases()) {
      case StoreFailure(:final error):
        return PurchaseResult(_outcomeOfStoreError(error));
      case StoreSuccess(value: final owned) when owned.any((purchase) => purchase.productId == productId):
        return const PurchaseResult(PurchaseOutcome.alreadyOwned);
      case StoreSuccess():
        break;
    }
    final response = await _platform.queryProductDetails({productId});
    final product = response.productDetails.where((details) => details.id == productId).firstOrNull;
    if (product == null) {
      final error = response.error;
      return PurchaseResult(error == null ? PurchaseOutcome.productNotFound : outcomeOfError(error));
    }
    final waiter = (productId: productId, result: Completer<PurchaseDetails>());
    _waiter = waiter;
    if (!await _platform.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: product))) {
      return const PurchaseResult(PurchaseOutcome.failed);
    }
    final details = await waiter.result.future;
    final outcome = outcomeOf(details);
    final purchase = outcome == PurchaseOutcome.purchased && details is GooglePlayPurchaseDetails
        ? _remember(details)
        : null;
    return PurchaseResult(outcome, purchase: purchase);
  }

  void _onUpdates(List<PurchaseDetails> updates) {
    final waiter = _waiter;
    for (final details in updates) {
      // Hatalı sonuçlarda eklenti ürün kimliği boş bir kayıt gönderir.
      final answersWaiter = details.productID == waiter?.productId || details.productID.isEmpty;
      if (waiter != null && answersWaiter && !waiter.result.isCompleted) {
        waiter.result.complete(details);
      }
    }
    if (updates.any((details) => details.status == PurchaseStatus.purchased)) {
      _changes.add(null);
    }
  }

  OwnedPurchase _remember(GooglePlayPurchaseDetails details) {
    final purchase = details.billingClientPurchase;
    _details[purchase.purchaseToken] = details;
    return OwnedPurchase(
      productId: details.productID,
      token: purchase.purchaseToken,
      isAcknowledged: purchase.isAcknowledged,
    );
  }

  /// Satın alma güncellemesini uygulamanın sonucuna çevirir.
  static PurchaseOutcome outcomeOf(PurchaseDetails details) {
    final error = details.error;
    return switch (details.status) {
      PurchaseStatus.canceled => PurchaseOutcome.cancelled,
      _ when error != null => outcomeOfError(error),
      PurchaseStatus.purchased => PurchaseOutcome.purchased,
      PurchaseStatus.pending => PurchaseOutcome.pending,
      PurchaseStatus.error || PurchaseStatus.restored => PurchaseOutcome.failed,
    };
  }

  /// Eklenti, Billing yanıt kodunu hata mesajına `BillingResponse.<ad>` biçiminde yazar.
  static PurchaseOutcome outcomeOfError(IAPError error) =>
      switch (BillingResponse.values.where((response) => '$response' == error.message).firstOrNull) {
        BillingResponse.userCanceled => PurchaseOutcome.cancelled,
        BillingResponse.itemAlreadyOwned => PurchaseOutcome.alreadyOwned,
        BillingResponse.itemUnavailable => PurchaseOutcome.productNotFound,
        BillingResponse.networkError || BillingResponse.serviceUnavailable => PurchaseOutcome.offline,
        BillingResponse.serviceTimeout ||
        BillingResponse.serviceDisconnected ||
        BillingResponse.billingUnavailable => PurchaseOutcome.unavailable,
        _ => PurchaseOutcome.failed,
      };

  static StoreError storeErrorOf(IAPError error) =>
      outcomeOfError(error) == PurchaseOutcome.offline ? StoreError.offline : StoreError.unavailable;

  static PurchaseOutcome _outcomeOfStoreError(StoreError error) => switch (error) {
    StoreError.offline => PurchaseOutcome.offline,
    StoreError.unavailable => PurchaseOutcome.unavailable,
  };

  static Future<StoreQuery<T>> _guardQuery<T>(Future<StoreQuery<T>> Function() query) async {
    try {
      return await query();
    } on PlatformException {
      return StoreFailure<T>(StoreError.unavailable);
    } on InAppPurchaseException {
      return StoreFailure<T>(StoreError.unavailable);
    }
  }
}
