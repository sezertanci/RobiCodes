import 'package:flutter/foundation.dart';

import '../../content/content_catalog.dart';
import 'purchase_gateway.dart';

/// Katalogdaki ürünlerin Google Play fiyatlarını yükler. Fiyatlar kodda tutulmaz; her zaman Play'den
/// okunur. Katalogda ürün yoksa Play'e hiç sorulmaz.
final class ListingService extends ChangeNotifier {
  ListingService({required this._catalog, required this._gateway});

  final ContentCatalog _catalog;
  final PurchaseGateway _gateway;

  Map<String, StoreListing> _listings = {};
  StoreError? _error;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Son yüklemenin hatası; başarılıysa `null`.
  StoreError? get error => _error;

  /// Ürünün fiyat bilgisi. Yükleme başarılı olduğu halde `null` ise ürün Play'de bulunmuyor demektir.
  StoreListing? listingOf(String productId) => _listings[productId];

  Future<void> load() async {
    final productIds = {for (final product in _catalog.products) product.id};
    if (productIds.isEmpty || _isLoading) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    switch (await _gateway.queryListings(productIds)) {
      case StoreSuccess(:final value):
        _listings = value;
        _error = null;
      case StoreFailure(:final error):
        _error = error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
