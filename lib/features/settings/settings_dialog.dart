import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/app_texts.dart';
import '../parental_gate/parental_gate_trial.dart';
import '../parental_gate/protected_action_runner.dart';
import '../sound/sound_service.dart';

/// Ayarlar penceresi: sesi açıp kapatma. Ayar hemen kaydedilir; pencere kapatılınca da geçerli kalır.
/// Debug derlemelerinde ayrıca ebeveyn doğrulamasını deneme girişi gösterilir.
final class SettingsDialog extends StatelessWidget {
  const SettingsDialog({required this.sound, required this.protectedActions, super.key});

  final SoundService sound;
  final ProtectedActionRunner protectedActions;

  static const title = 'Ayarlar';
  static const soundLabel = 'Ses';
  static const closeLabel = AppTexts.close;

  static Future<void> show(BuildContext context, SoundService sound, ProtectedActionRunner protectedActions) =>
      showDialog<void>(
        context: context,
        builder: (_) => SettingsDialog(sound: sound, protectedActions: protectedActions),
      );

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text(title),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: sound,
            builder: (context, _) => SwitchListTile(
              title: const Text(soundLabel),
              secondary: Icon(sound.isEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded),
              value: sound.isEnabled,
              onChanged: sound.setEnabled,
            ),
          ),
          // Release derlemesinde `kDebugMode` sabit `false` olduğundan bu giriş derlemeden çıkarılır.
          if (kDebugMode) ParentalGateTrial(runner: protectedActions),
        ],
      ),
    ),
    actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(closeLabel))],
  );
}
