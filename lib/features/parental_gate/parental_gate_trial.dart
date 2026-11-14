import 'package:flutter/material.dart';

import 'parental_gate.dart';
import 'protected_action_runner.dart';

/// Ebeveyn doğrulamasını gerçek bir işlem başlatmadan denemek için ayarlardaki giriş.
/// Yalnızca debug derlemelerinde gösterilir (bkz. `SettingsDialog`); release derlemesinde
/// `kDebugMode` sabit `false` olduğu için bu sınıf ve metinleri uygulamaya hiç girmez.
/// Doğrulama geçilince yalnızca onayı tüketen zararsız bir işlem çalışır; satın alma yapılmaz.
final class ParentalGateTrial extends StatefulWidget {
  const ParentalGateTrial({required this.runner, super.key});

  final ProtectedActionRunner runner;

  static const label = 'Ebeveyn doğrulamasını dene';
  static const hint = 'Yalnızca test derlemesinde görünür. Gerçek satın alma yapılmaz.';
  static const passed = 'Doğrulama geçildi; deneme işlemi çalıştı.';
  static const blocked = 'Doğrulama geçilmedi; işlem çalışmadı.';

  /// Pencerede gösterilen işlem. Deneme işlemi bu onayı yalnızca tüketir.
  static const action = ParentalAction.purchase;

  @override
  State<ParentalGateTrial> createState() => _ParentalGateTrialState();
}

final class _ParentalGateTrialState extends State<ParentalGateTrial> {
  String _status = ParentalGateTrial.hint;

  Future<void> _try() async {
    final ran = await widget.runner.run(
      context,
      ParentalGateTrial.action,
      (approval) async => approval.consume(ParentalGateTrial.action),
    );
    if (mounted) {
      setState(() => _status = ran ?? false ? ParentalGateTrial.passed : ParentalGateTrial.blocked);
    }
  }

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.lock_person_rounded),
    title: const Text(ParentalGateTrial.label),
    subtitle: Text(_status),
    onTap: _try,
  );
}
