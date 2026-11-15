import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:robi_codes/app/app_assets.dart';
import 'package:robi_codes/app/app_theme.dart';
import 'package:robi_codes/content/models/game_definition.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/content/models/store_product.dart';
import 'package:robi_codes/content/content_catalog.dart';
import 'package:robi_codes/core/storage/key_value_store.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/features/sound/sound_player.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';
import 'package:robi_codes/games/game_module.dart';

import 'test_l10n.dart';

/// Katalogdaki bir oyunu oynanabilir yapan, ekranı boş sahte modül.
final class FakeGameModule implements GameModule {
  const FakeGameModule(this.gameId);

  @override
  final String gameId;

  @override
  Widget buildLevel(LevelSession session) => const SizedBox();
}

/// Bellekte çalışan depo.
final class InMemoryKeyValueStore implements KeyValueStore {
  InMemoryKeyValueStore([Map<String, String>? initial]) : values = {...?initial};

  final Map<String, String> values;

  @override
  String? read(String key) => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> remove(String key) async => values.remove(key);
}

/// Çalınması istenen ses dosyalarını sırayla kaydeder.
final class RecordingSoundPlayer implements SoundPlayer {
  final List<String> played = [];

  @override
  Future<void> play(String asset) async => played.add(asset);
}

/// Oyunların ve sonuç panelinin bildirdiği anları sırayla kaydeder.
final class RecordingGameFeedback implements GameFeedback {
  final List<RobotMood> moods = [];
  final List<int> stars = [];
  int levelCompleteCount = 0;

  /// Ses çalınan anlar: robotun konuştuğu anlarda ses çalınmaz.
  List<RobotMood> get audibleMoods => [
    for (final mood in moods)
      if (mood != RobotMood.talk) mood,
  ];

  @override
  void react(RobotMood mood) => moods.add(mood);

  @override
  void star(int index) => stars.add(index);

  @override
  void levelComplete() => levelCompleteCount++;
}

/// Sonuçları testte ayarlanan mağaza.
final class FakePurchaseGateway implements PurchaseGateway {
  /// `null` ise mağazaya ulaşılamıyor gibi davranır ([unreachable] hatasıyla).
  Set<String>? owned = {};
  StoreError unreachable = StoreError.unavailable;

  /// Henüz onaylanmamış (acknowledge edilmemiş) sahip olunan ürünler.
  Set<String> unacknowledged = {};

  /// Play'deki fiyatlar; burada olmayan ürün Play'de bulunmuyor sayılır.
  Map<String, String> prices = {};
  StoreError? listingsError;

  PurchaseOutcome nextOutcome = PurchaseOutcome.purchased;
  bool acknowledgeSucceeds = true;
  final List<String> purchaseRequests = [];
  final List<String> acknowledgeRequests = [];
  final List<Set<String>> listingRequests = [];
  final StreamController<void> changes = StreamController<void>.broadcast();

  static String tokenOf(String productId) => 'token-$productId';

  @override
  Stream<void> get purchasesChanged => changes.stream;

  @override
  Future<StoreQuery<Map<String, StoreListing>>> queryListings(Set<String> productIds) async {
    listingRequests.add(productIds);
    final error = listingsError;
    if (error != null) {
      return StoreFailure(error);
    }
    return StoreSuccess({
      for (final id in productIds)
        if (prices[id] case final price?) id: StoreListing(productId: id, price: price),
    });
  }

  @override
  Future<StoreQuery<List<OwnedPurchase>>> queryOwnedPurchases() async {
    final products = owned;
    if (products == null) {
      return StoreFailure(unreachable);
    }
    return StoreSuccess([for (final id in products) _purchaseOf(id)]);
  }

  @override
  Future<PurchaseResult> purchase(String productId) async {
    purchaseRequests.add(productId);
    if (nextOutcome != PurchaseOutcome.purchased) {
      return PurchaseResult(nextOutcome);
    }
    owned = {...?owned, productId};
    unacknowledged.add(productId);
    return PurchaseResult(nextOutcome, purchase: _purchaseOf(productId));
  }

  @override
  Future<bool> acknowledge(OwnedPurchase purchase) async {
    acknowledgeRequests.add(purchase.token);
    if (acknowledgeSucceeds) {
      unacknowledged.remove(purchase.productId);
    }
    return acknowledgeSucceeds;
  }

  OwnedPurchase _purchaseOf(String productId) => OwnedPurchase(
    productId: productId,
    token: tokenOf(productId),
    isAcknowledged: !unacknowledged.contains(productId),
  );
}

/// Sonucu testte ayarlanan ebeveyn doğrulaması.
final class FakeParentalGate implements ParentalGate {
  FakeParentalGate({required this.approves});

  final bool approves;
  final List<ParentalAction> requests = [];

  @override
  Future<bool> verify(BuildContext context, ParentalAction action) async {
    requests.add(action);
    return approves;
  }
}

/// Mağaza testleri için örnek katalog: bir ücretsiz paket, iki ücretli paket,
/// her ücretli paketin kendi ürünü ve ikisini birlikte açan bir avantajlı paket.
abstract final class TestCatalog {
  static const gameId = 'game';
  static const freePack = 'game.base';
  static const packA = 'game.a';
  static const packB = 'game.b';
  static const productA = 'pack_a';
  static const productB = 'pack_b';
  static const bundle = 'bundle_ab';

  /// [withPaidGame] kataloğundaki, ücretsiz paketi olmayan ve denemesi olan ücretli oyun.
  static const paidGameId = 'paid';
  static const paidPack = 'paid.base';
  static const paidProduct = 'paid_product';

  static ContentCatalog build() => ContentCatalog(
    games: [
      GameDefinition(
        id: gameId,
        title: fixedText('Oyun'),
        description: fixedText('Açıklama'),
        tone: AppTones.blue,
        icon: AppAssets.gamePath,
        trophy: GameTrophy(title: fixedText('Kupa'), description: fixedText('Açıklama')),
      ),
    ],
    packs: [
      for (final id in [freePack, packA, packB]) _pack(id),
    ],
    products: [
      StoreProduct(id: productA, title: fixedText('Paket A'), packIds: const [packA]),
      StoreProduct(id: productB, title: fixedText('Paket B'), packIds: const [packB]),
      StoreProduct(id: bundle, title: fixedText('A ve B'), packIds: const [packA, packB]),
    ],
  );

  /// [build] kataloğuna ücretli bir oyun eklenir: tek paketi satın alınmadan yalnızca deneme seviyeleriyle oynanır.
  static ContentCatalog withPaidGame() {
    final catalog = build();
    return ContentCatalog(
      games: [
        ...catalog.games,
        GameDefinition(
          id: paidGameId,
          title: fixedText('Ücretli Oyun'),
          description: fixedText('Açıklama'),
          tone: AppTones.red,
          icon: AppAssets.gamePath,
          trophy: GameTrophy(title: fixedText('Ücretli Kupa'), description: fixedText('Açıklama')),
        ),
      ],
      packs: [
        ...catalog.packs,
        _pack(paidPack, gameId: paidGameId, freePreview: true),
      ],
      products: [
        ...catalog.products,
        StoreProduct(id: paidProduct, title: fixedText('Ücretli Paket'), packIds: const [paidPack]),
      ],
    );
  }

  static LevelPack _pack(String id, {String gameId = gameId, bool freePreview = false}) => LevelPack(
    id: id,
    gameId: gameId,
    title: fixedText(id),
    freePreview: freePreview,
    groups: const [DifficultyGroup(Difficulty.easy, 2), DifficultyGroup(Difficulty.medium, 2)],
  );
}
