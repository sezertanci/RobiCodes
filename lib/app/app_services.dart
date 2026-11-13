import '../content/catalog_data.dart';
import '../content/content_catalog.dart';
import '../core/storage/key_value_store.dart';
import '../features/cloud_save/cloud_save_gateway.dart';
import '../features/cloud_save/cloud_sync_service.dart';
import '../features/parental_gate/parental_gate.dart';
import '../features/parental_gate/protected_action_runner.dart';
import '../features/progress/progress_repository.dart';
import '../features/progress/unlock_policy.dart';
import '../features/store/entitlement_service.dart';
import '../features/store/offer_policy.dart';
import '../features/store/purchase_gateway.dart';
import '../games/command_order/command_order_module.dart';
import '../games/game_registry.dart';
import '../games/if_then/if_then_module.dart';
import '../games/path_finder/path_finder_module.dart';

/// Uygulamanın bütün servisleri tek yerde kurulur (bileşim kökü). Servisler birbirini
/// arayüzler üzerinden alır; testlerde aynı kurucuya sahte uygulamalar verilir.
final class AppServices {
  AppServices({
    required this.catalog,
    required this.games,
    required KeyValueStore store,
    PurchaseGateway purchaseGateway = const UnavailablePurchaseGateway(),
    CloudSaveGateway cloudSaveGateway = const NoCloudSaveGateway(),
    ParentalGate parentalGate = const LockedParentalGate(),
  }) : progress = ProgressRepository(store),
       protectedActions = ProtectedActionRunner(parentalGate) {
    unlockPolicy = UnlockPolicy(progress);
    entitlements = EntitlementService(catalog: catalog, gateway: purchaseGateway, store: store);
    offers = OfferPolicy(catalog, entitlements);
    cloudSync = CloudSyncService(gateway: cloudSaveGateway, progress: progress, store: store);
  }

  /// Uygulamanın gerçek kurulumu. Oyun modülleri, oyunlar aktarıldıkça buraya eklenir.
  factory AppServices.production(KeyValueStore store) => AppServices(
    catalog: buildContentCatalog(),
    games: GameRegistry([PathFinderModule(), CommandOrderModule(), IfThenModule()]),
    store: store,
  );

  final ContentCatalog catalog;
  final GameRegistry games;
  final ProgressRepository progress;
  final ProtectedActionRunner protectedActions;
  late final UnlockPolicy unlockPolicy;
  late final EntitlementService entitlements;
  late final OfferPolicy offers;
  late final CloudSyncService cloudSync;
}
