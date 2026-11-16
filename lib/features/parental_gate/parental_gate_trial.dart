import 'package:flutter/material.dart';

import 'parental_gate.dart';
import 'protected_action_runner.dart';
import '../sound/tap_sound.dart';

/// Ebeveyn doğrulamasını gerçek bir işlem başlatmadan denemek için ayarlardaki giriş.
/// Yalnızca debug derlemelerinde gösterilir (bkz. `SettingsDialog`); release derlemesinde
/// `kDebugMode` sabit `false` olduğu için bu sınıf ve metinleri uygulamaya hiç girmez. Metinleri
/// yalnızca geliştirici gördüğü için ARB'ye eklenmez, burada Türkçe sabit olarak durur (bkz. CLAUDE.md).
/// Doğrulama geçilince yalnızca onayı tüketen zararsız bir işlem çalışır; satın alma yapılmaz.
final class ParentalGateTrial extends StatefulWidget {
  const ParentalGateTrial({required this.runner, super.key});

  final ProtectedActionRunner runner;

  /// Pencerede gösterilen işlem. Deneme işlemi bu onayı yalnızca tüketir.
  static const action = ParentalAction.purchase;

  static const label = 'Ebeveyn doğrulamasını dene';
  static const hint = 'Yalnızca test derlemesinde görünür. Gerçek satın alma yapılmaz.';
  static const passed = 'Doğrulama geçildi; deneme işlemi çalıştı.';
  static const blocked = 'Doğrulama geçilmedi; işlem çalışmadı.';

  @override
  State<ParentalGateTrial> createState() => _ParentalGateTrialState();
}

final class _ParentalGateTrialState extends State<ParentalGateTrial> {
  /// Son denemenin sonucu; henüz denenmediyse `null` (açıklama gösterilir).
  bool? _passed;

  Future<void> _try() async {
    final ran = await widget.runner.run(
      context,
      ParentalGateTrial.action,
      (approval) async => approval.consume(ParentalGateTrial.action),
    );
    if (mounted) {
      setState(() => _passed = ran ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.lock_person_rounded),
      title: const Text(ParentalGateTrial.label),
      subtitle: Text(switch (_passed) {
        null => ParentalGateTrial.hint,
        true => ParentalGateTrial.passed,
        false => ParentalGateTrial.blocked,
      }),
      onTap: context.withTapSound(_try),
    );
  }
}
