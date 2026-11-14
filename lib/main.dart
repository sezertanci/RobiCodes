import 'dart:async';

import 'package:flutter/widgets.dart';

import 'app/app_services.dart';
import 'app/robi_codes_app.dart';
import 'core/storage/key_value_store.dart';
import 'features/sound/audioplayers_sound_player.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final services = AppServices.production(
    await SharedPreferencesStore.open(),
    soundPlayer: await AudioplayersSoundPlayer.create(),
  );
  // Sahiplik arka planda yenilenir; mağazaya ulaşılamazsa önbellekteki haklar geçerli kalır.
  unawaited(services.entitlements.refresh());
  // Koşulu önceden sağlanmış ödüller (ör. güncellemeden önce bitirilen seviyeler) pencere açılmadan kaydedilir.
  unawaited(services.achievements.sync());
  runApp(RobiCodesApp(services: services));
}
