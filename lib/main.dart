import 'dart:async';

import 'package:flutter/widgets.dart';

import 'app/app_services.dart';
import 'app/robi_codes_app.dart';
import 'core/storage/key_value_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final services = AppServices.production(await SharedPreferencesStore.open());
  // Sahiplik arka planda yenilenir; mağazaya ulaşılamazsa önbellekteki haklar geçerli kalır.
  unawaited(services.entitlements.refresh());
  runApp(RobiCodesApp(services: services));
}
