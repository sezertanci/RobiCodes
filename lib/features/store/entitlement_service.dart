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
///   internet olmadan da oynanır. Bu kayıt ilerleme kaydından bağımsızdır.
final class EntitlementService extends ChangeNotifier {
  EntitlementService({required this._catalog, required this._gateway, required KeyValueStore store})
    : _store = store,
      _ownedProductIds = _readCache(store);

  final ContentCatalog _catalog;
  final PurchaseGateway _gateway;
  final KeyValueStore _store;
  Set<String> _ownedProductIds;

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
  /// Mağazaya ulaşılamazsa önbellek olduğu gibi kalır ve `false` döner.
  Future<bool> refresh() async {
    final owned = await _gateway.queryOwnedProductIds();
    if (owned == null) {
      return false;
    }
    await _updateCache(owned);
    return true;
  }

  /// Satın almayı başlatır. Yalnızca `ProtectedActionRunner`'ın verdiği, satın alma için geçerli ve
  /// kullanılmamış bir [approval] ile mağazaya gidilir; aksi halde [PurchaseOutcome.notApproved] döner.
  /// Google Play'in kendi satın alma onayı (ör. aile grubu onayı) bundan ayrıca uygulanır.
  Future<PurchaseOutcome> purchase(String productId, {required ParentalApproval approval}) async {
    if (!approval.consume(ParentalAction.purchase)) {
      return PurchaseOutcome.notApproved;
    }
    final outcome = await _gateway.purchase(productId);
    if (outcome == PurchaseOutcome.purchased || outcome == PurchaseOutcome.alreadyOwned) {
      await refresh();
    }
    return outcome;
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
