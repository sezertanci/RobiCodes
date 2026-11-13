import 'package:flutter/widgets.dart';

import 'parental_gate.dart';

/// Korumalı işlemleri çalıştıran tek giriş noktası. Satın alma, hesap ve bulut işlemleri
/// doğrudan değil, bu sınıf üzerinden çağrılır; doğrulama geçilmezse işlem hiç çalışmaz.
final class ProtectedActionRunner {
  const ProtectedActionRunner(this._gate);

  final ParentalGate _gate;

  /// Doğrulama geçilirse işlemin sonucunu, geçilmezse `null` döner.
  Future<T?> run<T>(BuildContext context, ParentalAction action, Future<T> Function() body) async {
    final approved = await _gate.verify(context, action);
    return approved ? body() : null;
  }
}
