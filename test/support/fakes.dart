import 'package:flutter/widgets.dart';
import 'package:robi_codes/app/app_assets.dart';
import 'package:robi_codes/app/app_theme.dart';
import 'package:robi_codes/content/models/game_definition.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/content/models/store_product.dart';
import 'package:robi_codes/content/content_catalog.dart';
import 'package:robi_codes/core/storage/key_value_store.dart';
import 'package:robi_codes/features/cloud_save/cloud_save_gateway.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/play/game_feedback.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';
import 'package:robi_codes/features/sound/sound_player.dart';
import 'package:robi_codes/features/store/purchase_gateway.dart';

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
  /// `null` ise mağazaya ulaşılamıyor gibi davranır.
  Set<String>? owned = {};
  PurchaseOutcome nextOutcome = PurchaseOutcome.purchased;
  final List<String> purchaseRequests = [];

  @override
  Future<Set<String>?> queryOwnedProductIds() async => owned == null ? null : {...owned!};

  @override
  Future<PurchaseOutcome> purchase(String productId) async {
    purchaseRequests.add(productId);
    if (nextOutcome == PurchaseOutcome.purchased) {
      owned = {...?owned, productId};
    }
    return nextOutcome;
  }
}

/// Bellekte çalışan bulut kaydı.
final class FakeCloudSaveGateway implements CloudSaveGateway {
  bool signedIn = true;
  bool reachable = true;
  String stored = '';

  @override
  Future<bool> isSignedIn() async => signedIn;

  @override
  Future<String?> load() async => reachable ? stored : null;

  @override
  Future<bool> save(String data) async {
    if (!reachable) {
      return false;
    }
    stored = data;
    return true;
  }
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

  static ContentCatalog build() => ContentCatalog(
    games: const [
      GameDefinition(
        id: gameId,
        title: 'Oyun',
        description: 'Açıklama',
        tone: AppTones.blue,
        icon: AppAssets.gamePath,
        trophy: GameTrophy(title: 'Kupa', description: 'Açıklama'),
      ),
    ],
    packs: [
      for (final id in [freePack, packA, packB]) _pack(id),
    ],
    products: const [
      StoreProduct(id: productA, packIds: [packA]),
      StoreProduct(id: productB, packIds: [packB]),
      StoreProduct(id: bundle, packIds: [packA, packB]),
    ],
  );

  static LevelPack _pack(String id) => LevelPack(
    id: id,
    gameId: gameId,
    title: id,
    groups: const [DifficultyGroup(Difficulty.easy, 2), DifficultyGroup(Difficulty.medium, 2)],
  );
}
