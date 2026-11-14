import 'package:flutter/material.dart';

import '../../app/app_texts.dart';
import '../sound/sound_service.dart';

/// Ayarlar penceresi: sesi açıp kapatma. Ayar hemen kaydedilir; pencere kapatılınca da geçerli kalır.
final class SettingsDialog extends StatelessWidget {
  const SettingsDialog({required this.sound, super.key});

  final SoundService sound;

  static const title = 'Ayarlar';
  static const soundLabel = 'Ses';
  static const closeLabel = AppTexts.close;

  static Future<void> show(BuildContext context, SoundService sound) => showDialog<void>(
    context: context,
    builder: (_) => SettingsDialog(sound: sound),
  );

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text(title),
    content: ListenableBuilder(
      listenable: sound,
      builder: (context, _) => SwitchListTile(
        title: const Text(soundLabel),
        secondary: Icon(sound.isEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded),
        value: sound.isEnabled,
        onChanged: sound.setEnabled,
      ),
    ),
    actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text(closeLabel))],
  );
}
