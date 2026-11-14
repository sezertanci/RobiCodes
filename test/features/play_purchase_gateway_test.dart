import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:robi_codes/features/store/play_purchase_gateway.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';

const _productId = 'pack_a';
const _source = 'google_play';

/// Eklentinin yanıtlarını testte ayarlanan sahte Android platformu.
final class _FakePlatform implements InAppPurchaseAndroidPlatform {
  final StreamController<List<PurchaseDetails>> updates = StreamController.broadcast();
  bool available = true;
  List<ProductDetails> products = [];
  IAPError? productsError;

  /// Satın alma penceresi açıldığında Play'in göndereceği güncelleme.
  List<PurchaseDetails> Function()? onBuy;
  Object? buyThrows;
  final List<String> buyRequests = [];
  final List<PurchaseDetails> completed = [];
  BillingResponse completeResponse = BillingResponse.ok;

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => updates.stream;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<ProductDetailsResponse> queryProductDetails(Set<String> identifiers) async => ProductDetailsResponse(
    productDetails: [
      for (final product in products)
        if (identifiers.contains(product.id)) product,
    ],
    notFoundIDs: [],
    error: productsError,
  );

  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) async {
    if (buyThrows case final error?) {
      throw error;
    }
    buyRequests.add(purchaseParam.productDetails.id);
    if (onBuy case final update?) {
      updates.add(update());
    }
    return true;
  }

  @override
  Future<BillingResultWrapper> completePurchase(PurchaseDetails purchase) async {
    completed.add(purchase);
    return BillingResultWrapper(responseCode: completeResponse);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FakeAddition implements InAppPurchaseAndroidPlatformAddition {
  List<GooglePlayPurchaseDetails> pastPurchases = [];
  IAPError? error;

  @override
  Future<QueryPurchaseDetailsResponse> queryPastPurchases({String? applicationUserName}) async =>
      QueryPurchaseDetailsResponse(pastPurchases: pastPurchases, error: error);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

GooglePlayPurchaseDetails _purchase(PurchaseStateWrapper state, {bool isAcknowledged = false}) =>
    GooglePlayPurchaseDetails.fromPurchase(
      PurchaseWrapper(
        orderId: 'order',
        packageName: 'robi.codes',
        purchaseTime: 0,
        purchaseToken: 'token-$_productId',
        signature: 'signature',
        products: const [_productId],
        isAutoRenewing: false,
        originalJson: '{}',
        isAcknowledged: isAcknowledged,
        purchaseState: state,
      ),
    ).single;

ProductDetails _product(String id) =>
    ProductDetails(id: id, title: id, description: id, price: '₺10,00', rawPrice: 10, currencyCode: 'TRY');

IAPError _error(BillingResponse response) => IAPError(source: _source, code: 'error', message: '$response');

/// Eklentinin hatalı sonuçlarda gönderdiği, ürün kimliği boş kayıt.
PurchaseDetails _errorUpdate(PurchaseStatus status, BillingResponse response) => PurchaseDetails(
  productID: '',
  verificationData: PurchaseVerificationData(localVerificationData: '', serverVerificationData: '', source: _source),
  transactionDate: null,
  status: status,
)..error = _error(response);

void main() {
  late _FakePlatform platform;
  late _FakeAddition addition;
  late PlayPurchaseGateway gateway;

  setUp(() {
    platform = _FakePlatform();
    addition = _FakeAddition();
    gateway = PlayPurchaseGateway(platform, addition);
  });

  group('outcomeOfError', () {
    const cases = {
      BillingResponse.userCanceled: PurchaseOutcome.cancelled,
      BillingResponse.itemAlreadyOwned: PurchaseOutcome.alreadyOwned,
      BillingResponse.itemUnavailable: PurchaseOutcome.productNotFound,
      BillingResponse.networkError: PurchaseOutcome.offline,
      BillingResponse.serviceUnavailable: PurchaseOutcome.offline,
      BillingResponse.serviceDisconnected: PurchaseOutcome.unavailable,
      BillingResponse.billingUnavailable: PurchaseOutcome.unavailable,
      BillingResponse.developerError: PurchaseOutcome.failed,
    };
    for (final MapEntry(key: response, value: outcome) in cases.entries) {
      test('outcomeOfError_${response.name}_Returns${outcome.name}', () {
        expect(PlayPurchaseGateway.outcomeOfError(_error(response)), outcome);
      });
    }
  });

  group('queryOwnedPurchases', () {
    test('queryOwnedPurchases_PendingPurchase_IsNotOwned', () async {
      // Arrange
      addition.pastPurchases = [_purchase(PurchaseStateWrapper.pending)];

      // Act
      final result = await gateway.queryOwnedPurchases();

      // Assert
      expect((result as StoreSuccess<List<OwnedPurchase>>).value, isEmpty);
    });

    test('queryOwnedPurchases_CompletedPurchase_ReturnsTokenAndAcknowledgement', () async {
      // Arrange
      addition.pastPurchases = [_purchase(PurchaseStateWrapper.purchased, isAcknowledged: true)];

      // Act
      final result = await gateway.queryOwnedPurchases();

      // Assert
      final owned = (result as StoreSuccess<List<OwnedPurchase>>).value.single;
      expect(owned.productId, _productId);
      expect(owned.token, 'token-$_productId');
      expect(owned.isAcknowledged, isTrue);
    });

    test('queryOwnedPurchases_NetworkError_ReturnsOffline', () async {
      // Arrange
      addition.error = _error(BillingResponse.networkError);

      // Act
      final result = await gateway.queryOwnedPurchases();

      // Assert
      expect((result as StoreFailure).error, StoreError.offline);
    });

    test('queryOwnedPurchases_BillingNotAvailable_ReturnsUnavailable', () async {
      // Arrange
      platform.available = false;

      // Act
      final result = await gateway.queryOwnedPurchases();

      // Assert
      expect((result as StoreFailure).error, StoreError.unavailable);
    });
  });

  group('queryListings', () {
    test('queryListings_ProductMissingInPlay_LeavesItOut', () async {
      // Arrange
      platform.products = [_product(_productId)];

      // Act
      final result = await gateway.queryListings({_productId, 'missing'});

      // Assert
      final listings = (result as StoreSuccess<Map<String, StoreListing>>).value;
      expect(listings.keys, [_productId]);
      expect(listings[_productId]!.price, '₺10,00');
    });

    test('queryListings_ErrorWithoutProducts_ReturnsFailure', () async {
      // Arrange
      platform.productsError = _error(BillingResponse.serviceUnavailable);

      // Act
      final result = await gateway.queryListings({_productId});

      // Assert
      expect((result as StoreFailure).error, StoreError.offline);
    });
  });

  group('purchase', () {
    test('purchase_AlreadyOwned_DoesNotOpenPlay', () async {
      // Arrange
      addition.pastPurchases = [_purchase(PurchaseStateWrapper.purchased)];
      platform.products = [_product(_productId)];

      // Act
      final result = await gateway.purchase(_productId);

      // Assert
      expect(result.outcome, PurchaseOutcome.alreadyOwned);
      expect(platform.buyRequests, isEmpty);
    });

    test('purchase_ProductNotInPlay_ReturnsProductNotFound', () async {
      // Act
      final result = await gateway.purchase(_productId);

      // Assert
      expect(result.outcome, PurchaseOutcome.productNotFound);
      expect(platform.buyRequests, isEmpty);
    });

    test('purchase_Completed_ReturnsPurchaseThatCanBeAcknowledged', () async {
      // Arrange
      platform
        ..products = [_product(_productId)]
        ..onBuy = () => [_purchase(PurchaseStateWrapper.purchased)];

      // Act
      final result = await gateway.purchase(_productId);
      final acknowledged = await gateway.acknowledge(result.purchase!);

      // Assert
      expect(result.outcome, PurchaseOutcome.purchased);
      expect(result.purchase!.isAcknowledged, isFalse);
      expect(acknowledged, isTrue);
      expect(platform.completed.single.productID, _productId);
    });

    test('purchase_Pending_ReturnsPendingWithoutPurchase', () async {
      // Arrange
      platform
        ..products = [_product(_productId)]
        ..onBuy = () => [_purchase(PurchaseStateWrapper.pending)];

      // Act
      final result = await gateway.purchase(_productId);

      // Assert
      expect(result.outcome, PurchaseOutcome.pending);
      expect(result.purchase, isNull);
    });

    test('purchase_UserCancelled_ReturnsCancelled', () async {
      // Arrange
      platform
        ..products = [_product(_productId)]
        ..onBuy = () => [_errorUpdate(PurchaseStatus.canceled, BillingResponse.userCanceled)];

      // Act
      final result = await gateway.purchase(_productId);

      // Assert
      expect(result.outcome, PurchaseOutcome.cancelled);
    });

    test('purchase_NetworkErrorDuringPayment_ReturnsOffline', () async {
      // Arrange
      platform
        ..products = [_product(_productId)]
        ..onBuy = () => [_errorUpdate(PurchaseStatus.error, BillingResponse.networkError)];

      // Act
      final result = await gateway.purchase(_productId);

      // Assert
      expect(result.outcome, PurchaseOutcome.offline);
    });

    test('purchase_PlatformException_ReturnsUnavailable', () async {
      // Arrange
      platform
        ..products = [_product(_productId)]
        ..buyThrows = PlatformException(code: 'error');

      // Act
      final result = await gateway.purchase(_productId);

      // Assert
      expect(result.outcome, PurchaseOutcome.unavailable);
    });
  });

  test('acknowledge_PlayRejects_ReturnsFalse', () async {
    // Arrange
    addition.pastPurchases = [_purchase(PurchaseStateWrapper.purchased)];
    platform.completeResponse = BillingResponse.error;
    final owned = (await gateway.queryOwnedPurchases() as StoreSuccess<List<OwnedPurchase>>).value.single;

    // Act
    final acknowledged = await gateway.acknowledge(owned);

    // Assert
    expect(acknowledged, isFalse);
  });

  test('purchasesChanged_CompletedPurchaseOutsideFlow_Notifies', () async {
    // Arrange: bekleyen ödeme uygulama dışında tamamlandı.
    var notifications = 0;
    final subscription = gateway.purchasesChanged.listen((_) => notifications++);
    addTearDown(subscription.cancel);

    // Act
    platform.updates.add([_purchase(PurchaseStateWrapper.purchased)]);
    await pumpEventQueue();

    // Assert
    expect(notifications, 1);
  });
}
