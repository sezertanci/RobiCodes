import 'package:flutter/widgets.dart';
import 'package:robi_codes/features/parental_gate/parental_gate.dart';
import 'package:robi_codes/features/parental_gate/protected_action_runner.dart';

import 'fakes.dart';

/// Ağaca bağlanmamış bir öğe. Sahte kapı bağlamı kullanmadığı için pencere açmadan
/// düz `test` içinde de onay alınabilir.
final BuildContext _detachedContext = const SizedBox().createElement();

/// [action] için, uygulamadaki gibi `ProtectedActionRunner` üzerinden onaylayan bir kapıyla alınmış onay.
/// Testler de onayı başka bir yoldan üretemez.
Future<ParentalApproval> grantApproval(ParentalAction action) async =>
    (await ProtectedActionRunner(FakeParentalGate(approves: true))
        .run(_detachedContext, action, (approval) async => approval))!;
