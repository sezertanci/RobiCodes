import 'package:flutter/widgets.dart';

import '../../l10n/l10n.dart';

/// Ebeveyn doğrulaması gerektiren işlemler. Yeni bir korumalı işlem buraya eklenir;
/// hangi işlemin korunduğu tek bir yerden görülür. Her işlemin açıklaması ARB dosyalarındaki
/// `parentalGateAction` seçiminde bulunur.
enum ParentalAction {
  purchase;

  /// Doğrulama penceresinde ebeveyne hangi işlemi onayladığını söyleyen metin.
  String description(AppLocalizations t) => t.parentalGateAction(name);
}

/// Ebeveyn doğrulaması. Her çağrıda yeniden sorulur; önceki bir onay hatırlanmaz.
abstract interface class ParentalGate {
  /// Doğrulama geçilirse `true`, vazgeçilirse `false` döner.
  Future<bool> verify(BuildContext context, ParentalAction action);
}

/// Hiçbir korumalı işleme izin vermeyen kapı. Testlerde ve kapının bilerek kapatılması
/// gereken durumlarda varsayılan olarak kullanılır; böylece doğrulamasız bir satın alma
/// yanlışlıkla açılamaz.
final class LockedParentalGate implements ParentalGate {
  const LockedParentalGate();

  @override
  Future<bool> verify(BuildContext context, ParentalAction action) async => false;
}
