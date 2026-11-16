import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../l10n/l10n.dart';
import '../developer/developer_unlock_tile.dart';
import '../parental_gate/parental_gate_trial.dart';
import '../store/store_screen.dart';
import 'language_tile.dart';
import '../sound/tap_sound.dart';

/// Ayarlar penceresi: sesi açıp kapatma, dil seçimi ve paket mağazasına giriş. Ayar hemen kaydedilir; pencere kapatılınca da geçerli kalır.
/// Debug derlemelerinde ayrıca ebeveyn doğrulamasını deneme girişi ve bütün kilitleri açan anahtar gösterilir.
final class SettingsDialog extends StatelessWidget {
  const SettingsDialog({required this.services, super.key});

  final AppServices services;

  static Future<void> show(BuildContext context, AppServices services) => showDialog<void>(
    context: context,
    builder: (_) => SettingsDialog(services: services),
  );

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final sound = services.sound;
    return AlertDialog(
      title: Text(t.settingsTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListenableBuilder(
              listenable: sound,
              builder: (context, _) => SwitchListTile(
                title: Text(t.settingsSound),
                secondary: Icon(sound.isEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded),
                value: sound.isEnabled,
                onChanged: context.withTapSoundValue(sound.setEnabled),
              ),
            ),
            LanguageTile(language: services.language),
            ListTile(
              leading: const Icon(Icons.storefront_rounded),
              title: Text(t.storeTitle),
              onTap: context.withTapSound(() => StoreScreen.open(context)),
            ),
            // Release derlemesinde `kDebugMode` sabit `false` olduğundan bu girişler derlemeden çıkarılır.
            if (kDebugMode) ...[
              ParentalGateTrial(runner: services.protectedActions),
              DeveloperUnlockTile(unlock: services.developerUnlock),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: context.withTapSound(() => Navigator.of(context).pop()), child: Text(t.commonClose)),
      ],
    );
  }
}
