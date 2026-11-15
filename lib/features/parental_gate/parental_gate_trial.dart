import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

import 'parental_gate.dart';
import 'protected_action_runner.dart';

/// Ebeveyn doğrulamasını gerçek bir işlem başlatmadan denemek için ayarlardaki giriş.
/// Yalnızca debug derlemelerinde gösterilir (bkz. `SettingsDialog`); release derlemesinde
/// `kDebugMode` sabit `false` olduğu için bu sınıf ve metinleri uygulamaya hiç girmez.
/// Doğrulama geçilince yalnızca onayı tüketen zararsız bir işlem çalışır; satın alma yapılmaz.
final class ParentalGateTrial extends StatefulWidget {
  const ParentalGateTrial({required this.runner, super.key});

  final ProtectedActionRunner runner;

  /// Pencerede gösterilen işlem. Deneme işlemi bu onayı yalnızca tüketir.
  static const action = ParentalAction.purchase;

  @override
  State<ParentalGateTrial> createState() => _ParentalGateTrialState();
}

final class _ParentalGateTrialState extends State<ParentalGateTrial> {
  /// Son denemenin sonucu; henüz denenmediyse `null` (açıklama gösterilir). Metin, dil
  /// değişirse güncellensin diye her çizimde kurulur.
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
    final t = context.l10n;
    return ListTile(
      leading: const Icon(Icons.lock_person_rounded),
      title: Text(t.parentalGateTrialLabel),
      subtitle: Text(switch (_passed) {
        null => t.parentalGateTrialHint,
        true => t.parentalGateTrialPassed,
        false => t.parentalGateTrialBlocked,
      }),
      onTap: _try,
    );
  }
}
