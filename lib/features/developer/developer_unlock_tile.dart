import 'package:flutter/material.dart';

import 'developer_unlock.dart';
import '../sound/tap_sound.dart';

/// Ayarlardaki "Tüm kilitleri aç" anahtarı. Yalnızca debug derlemelerinde gösterilir (bkz. `SettingsDialog`).
/// Metinleri yalnızca geliştirici gördüğü için ARB'ye eklenmez, burada Türkçe sabit olarak durur (bkz. CLAUDE.md).
final class DeveloperUnlockTile extends StatelessWidget {
  const DeveloperUnlockTile({required this.unlock, super.key});

  final DeveloperUnlock unlock;

  static const label = 'Tüm kilitleri aç';
  static const hint = 'Yalnızca test derlemesinde görünür. Paketler ve seviyeler satın almadan açılır.';

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: unlock,
    builder: (context, _) => SwitchListTile(
      secondary: const Icon(Icons.lock_open_rounded),
      title: const Text(label),
      subtitle: const Text(hint),
      value: unlock.isEnabled,
      onChanged: context.withTapSoundValue(unlock.setEnabled),
    ),
  );
}
