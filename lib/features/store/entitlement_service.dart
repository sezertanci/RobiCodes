import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../content/content_catalog.dart';
import '../../content/models/level_pack.dart';
import '../../core/json_utils.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import '../parental_gate/parental_gate.dart';
import '../parental_gate/protected_action_runner.dart';
import 'purchase_gateway.dart';

/// Hangi paketlere erişim olduğunu bilen servis.
///
/// - Ücretsiz paketler her zaman açıktır.
/// - Ücretli bir paket, onu açan ürünlerden (paketin kendi ürünü veya onu içeren bir avantajlı
///   paket) biri kullanıcıya aitse açıktır. Ürünün satın alma veya promosyon koduyla kazanılması
///   fark etmez.
/// - Sahip olunan ürünler cihazda ayrı bir kayıtta önbelleğe alınır; böylece satın alınan içerik
///   internet olmadan da oynanır. Bu kayıt ilerleme kaydından bağımsızdır ve yalnızca Google Play'den
///   gelen sahiplikle yazılır. Kayıt bozulursa boş okunur ve ilk sahiplik sorgusuyla yeniden oluşur.
/// - Sahiplik bir ürün kimliği kümesidir; aynı satın almanın tekrar işlenmesi yeni bir hak oluşturmaz.
/// - Onaylama (acknowledge) satın alma anahtarına göre tekilleştirilir; aynı anda gelen yenileme ve
///   satın alma sonucu aynı satın almayı iki kez onaylamaz.
final class EntitlementService extends ChangeNotifier {
  EntitlementService({required this._catalog, required this._gateway, required KeyValueStore store})
    : _store = store,
      _ownedProductIds = _readCache(store) {
    _changes = _gateway.purchasesChanged.listen((_) => unawaited(refresh()));
  }

  final ContentCatalog _catalog;
  final PurchaseGateway _gateway;
  final KeyValueStore _store;
  Set<String> _ownedProductIds;
  late final StreamSubscription<void> _changes;

  /// Satın alma anahtarına göre süren veya başarıyla biten onaylamalar.
  final Map<String, Future<bool>> _acknowledgements = {};

  Set<String> get ownedProductIds => Set.unmodifiable(_ownedProductIds);

  bool ownsProduct(String productId) => _ownedProductIds.contains(productId);

  bool canPlayPack(String packId) =>
      _catalog.isFree(packId) || _catalog.productsGranting(packId).any((product) => ownsProduct(product.id));

  /// Oyunun oynanabilir (ücretsiz veya sahip olunan) paketleri, katalogdaki sırayla.
  List<LevelPack> playablePacksOf(String gameId) => [
    for (final pack in _catalog.packsOf(gameId))
      if (canPlayPack(pack.id)) pack,
  ];

  /// Sahipliği mağazadan yeniden okur (uygulama açılışı, ön plana dönüş, "Satın alımları geri yükle").
  /// Önce erişim verilir, sonra onaylanmamış satın almalar onaylanır. Mağazaya ulaşılamazsa önbellek
  /// olduğu gibi kalır ve hatanın türü döner; başarılıysa `null` döner.
  Future<StoreError?> refresh() async {
    switch (await _gateway.queryOwnedPurchases()) {
      case StoreFailure(:final error):
        return error;
      case StoreSuccess(value: final purchases):
        await _updateCache({for (final purchase in purchases) purchase.productId});
        for (final purchase in purchases.where((purchase) => !purchase.isAcknowledged)) {
          await _acknowledge(purchase);
        }
        return null;
    }
  }

  /// Satın almayı başlatır. Yalnızca `ProtectedActionRunner`'ın verdiği, satın alma için geçerli ve
  /// kullanılmamış bir [approval] ile mağazaya gidilir; aksi halde [PurchaseOutcome.notApproved] döner.
  /// Google Play'in kendi satın alma onayı (ör. aile grubu onayı) bundan ayrıca uygulanır.
  /// Ürünün açtığı bütün paketlere zaten erişim varsa mağazaya gidilmez.
  Future<PurchaseOutcome> purchase(String productId, {required ParentalApproval approval}) async {
    if (!approval.consume(ParentalAction.purchase)) {
      return PurchaseOutcome.notApproved;
    }
    final product = _catalog.findProduct(productId);
    if (product == null) {
      return PurchaseOutcome.productNotFound;
    }
    if (product.packIds.every(canPlayPack)) {
      return PurchaseOutcome.alreadyOwned;
    }
    final result = await _gateway.purchase(productId);
    switch (result) {
      case PurchaseResult(outcome: PurchaseOutcome.purchased, :final purchase?):
        await _updateCache({..._ownedProductIds, purchase.productId});
        await _acknowledge(purchase);
      case PurchaseResult(outcome: PurchaseOutcome.purchased || PurchaseOutcome.alreadyOwned):
        await refresh();
      case _:
        break;
    }
    return result.outcome;
  }

  @override
  void dispose() {
    unawaited(_changes.cancel());
    super.dispose();
  }

  /// Satın almayı bir kez onaylar. Aynı anahtar için süren veya biten onaylama varsa onu kullanır; başarısız
  /// onaylama bir sonraki yenilemede yeniden denenir (Google Play 3 gün tanır).
  Future<void> _acknowledge(OwnedPurchase purchase) async {
    if (purchase.isAcknowledged) {
      return;
    }
    final acknowledged = await (_acknowledgements[purchase.token] ??= _gateway.acknowledge(purchase));
    if (!acknowledged) {
      _acknowledgements.removeWhere((token, _) => token == purchase.token);
    }
  }

  Future<void> _updateCache(Set<String> owned) async {
    if (setEquals(owned, _ownedProductIds)) {
      return;
    }
    _ownedProductIds = owned;
    notifyListeners();
    await _store.write(StorageKeys.ownedProducts, jsonEncode(owned.toList()..sort()));
  }

  static Set<String> _readCache(KeyValueStore store) =>
      decodeJsonList(store.read(StorageKeys.ownedProducts))?.whereType<String>().toSet() ?? {};
}
