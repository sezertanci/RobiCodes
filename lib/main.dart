import 'dart:async';

import 'package:flutter/widgets.dart';

import 'app/app_services.dart';
import 'app/robi_codes_app.dart';
import 'core/storage/key_value_store.dart';
import 'features/sound/audioplayers_sound_player.dart';
import 'features/store/play_purchase_gateway.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final services = AppServices.production(
    await SharedPreferencesStore.open(),
    soundPlayer: await AudioplayersSoundPlayer.create(),
    purchaseGateway: PlayPurchaseGateway.create(),
  );
  // Sahiplik arka planda yenilenir; mağazaya ulaşılamazsa önbellekteki haklar geçerli kalır.
  // Promosyon kodu Play Store'da, uygulama dışında da kullanılabildiği için ön plana her dönüşte
  // yeniden sorgulanır. Dinleyici uygulama boyunca yaşar.
  unawaited(services.entitlements.refresh());
  // Ücretli oyunların kartında ve deneme bandında fiyat gösterilir.
  unawaited(services.listings.load());
  AppLifecycleListener(onResume: () => unawaited(services.entitlements.refresh()));
  // Koşulu önceden sağlanmış ödüller (ör. güncellemeden önce bitirilen seviyeler) pencere açılmadan kaydedilir.
  unawaited(services.achievements.sync());
  runApp(RobiCodesApp(services: services));
}
