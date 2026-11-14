import 'dart:math';

import '../content/catalog_data.dart';
import '../content/content_catalog.dart';
import '../core/storage/key_value_store.dart';
import '../features/achievements/achievement_celebration.dart';
import '../features/achievements/achievement_service.dart';
import '../features/character/character_service.dart';
import '../features/parental_gate/dialog_parental_gate.dart';
import '../features/parental_gate/parental_gate.dart';
import '../features/parental_gate/parental_question.dart';
import '../features/parental_gate/protected_action_runner.dart';
import '../features/progress/progress_repository.dart';
import '../features/progress/unlock_policy.dart';
import '../features/sound/sound_player.dart';
import '../features/sound/sound_service.dart';
import '../features/store/entitlement_service.dart';
import '../features/store/listing_service.dart';
import '../features/store/offer_policy.dart';
import '../features/store/purchase_gateway.dart';
import '../games/command_order/command_order_module.dart';
import '../games/game_registry.dart';
import '../games/if_then/if_then_module.dart';
import '../games/path_finder/path_finder_module.dart';
import '../games/repeat/repeat_module.dart';

/// Uygulamanın bütün servisleri tek yerde kurulur (bileşim kökü). Servisler birbirini
/// arayüzler üzerinden alır; testlerde aynı kurucuya sahte uygulamalar verilir.
final class AppServices {
  AppServices({
    required this.catalog,
    required this.games,
    required KeyValueStore store,
    PurchaseGateway purchaseGateway = const UnavailablePurchaseGateway(),
    ParentalGate parentalGate = const LockedParentalGate(),
    SoundPlayer soundPlayer = const SilentSoundPlayer(),
  }) : progress = ProgressRepository(store),
       sound = SoundService(store: store, player: soundPlayer),
       character = CharacterService(store),
       protectedActions = ProtectedActionRunner(parentalGate) {
    unlockPolicy = UnlockPolicy(progress);
    entitlements = EntitlementService(catalog: catalog, gateway: purchaseGateway, store: store);
    listings = ListingService(catalog: catalog, gateway: purchaseGateway);
    offers = OfferPolicy(catalog, entitlements);
    achievements = AchievementService(store: store, catalog: catalog, games: games, progress: progress);
    celebration = AchievementCelebration(sound: sound);
  }

  /// Uygulamanın gerçek kurulumu. Oyun modülleri, oyunlar aktarıldıkça buraya eklenir.
  /// Korumalı işlemler, her seferinde yeni bir matematik sorusu soran ebeveyn kapısından geçer.
  /// Testlerde ses çalınmaz ve Google Play'e bağlanılmaz; uygulama gerçek ses altyapısını
  /// [soundPlayer], Google Play Billing'i [purchaseGateway] ile verir.
  factory AppServices.production(
    KeyValueStore store, {
    SoundPlayer soundPlayer = const SilentSoundPlayer(),
    PurchaseGateway purchaseGateway = const UnavailablePurchaseGateway(),
  }) => AppServices(
    catalog: buildContentCatalog(),
    games: GameRegistry([PathFinderModule(), CommandOrderModule(), IfThenModule(), RepeatModule()]),
    store: store,
    parentalGate: DialogParentalGate(ParentalQuestionGenerator(Random.secure())),
    soundPlayer: soundPlayer,
    purchaseGateway: purchaseGateway,
  );

  final ContentCatalog catalog;
  final GameRegistry games;
  final ProgressRepository progress;
  final SoundService sound;
  final CharacterService character;
  final ProtectedActionRunner protectedActions;
  late final UnlockPolicy unlockPolicy;
  late final EntitlementService entitlements;
  late final ListingService listings;
  late final OfferPolicy offers;
  late final AchievementService achievements;
  late final AchievementCelebration celebration;
}
