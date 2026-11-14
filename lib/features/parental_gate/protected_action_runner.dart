import 'package:flutter/widgets.dart';

import 'parental_gate.dart';

/// Ebeveynin tek bir işlem için verdiği onay. Yalnızca [ProtectedActionRunner] oluşturabilir
/// (kurucu bu dosyaya özeldir). Korunan servis metotları bu nesneyi ister; böylece doğrulamadan
/// geçmeden satın alma veya bulut işlemi çağrılamaz.
final class ParentalApproval {
  ParentalApproval._(this.action);

  /// Onaylanan işlem.
  final ParentalAction action;

  bool _isUsed = false;

  /// Onay [expected] işlem içinse ve daha önce kullanılmadıysa kullanır ve `true` döner.
  /// Böylece bir işlem için alınan onay başka bir işlemde veya ikinci kez kullanılamaz.
  bool consume(ParentalAction expected) {
    if (_isUsed || action != expected) {
      return false;
    }
    _isUsed = true;
    return true;
  }
}

/// Korumalı işlemleri çalıştıran tek giriş noktası. Satın alma, hesap ve bulut işlemleri
/// doğrudan değil, bu sınıf üzerinden çağrılır; doğrulama geçilmezse işlem hiç çalışmaz.
/// Onay hiçbir yerde saklanmaz: her çağrıda ebeveyne yeniden sorulur, uygulama yeniden
/// başlatıldığında da önceki onaylardan hiçbiri geçerli değildir.
final class ProtectedActionRunner {
  const ProtectedActionRunner(this._gate);

  final ParentalGate _gate;

  /// Doğrulama geçilirse işlemi tek kullanımlık onayla çalıştırıp sonucunu, geçilmezse `null` döner.
  Future<T?> run<T>(BuildContext context, ParentalAction action, Future<T> Function(ParentalApproval) body) async {
    final approved = await _gate.verify(context, action);
    return approved ? body(ParentalApproval._(action)) : null;
  }
}
