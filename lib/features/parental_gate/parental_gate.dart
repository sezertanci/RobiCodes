import 'package:flutter/widgets.dart';

/// Ebeveyn doğrulaması gerektiren işlemler. Yeni bir korumalı işlem buraya eklenir;
/// hangi işlemin korunduğu tek bir yerden görülür. [description], doğrulama penceresinde
/// ebeveyne hangi işlemi onayladığını söyler.
enum ParentalAction {
  purchase('Paket satın alma'),
  linkAccount('Google Play Games hesabını bağlama'),
  enableCloudSync('Bulut kaydını açma'),
  disableCloudSync('Bulut kaydını kapatma'),
  signOut('Google hesabından çıkış'),
  switchAccount('Google hesabını değiştirme');

  const ParentalAction(this.description);

  final String description;
}

/// Ebeveyn doğrulaması. Her çağrıda yeniden sorulur; önceki bir onay hatırlanmaz.
abstract interface class ParentalGate {
  /// Doğrulama geçilirse `true`, vazgeçilirse `false` döner.
  Future<bool> verify(BuildContext context, ParentalAction action);
}

/// Hiçbir korumalı işleme izin vermeyen kapı. Testlerde ve kapının bilerek kapatılması
/// gereken durumlarda varsayılan olarak kullanılır; böylece doğrulamasız bir satın alma
/// veya hesap işlemi yanlışlıkla açılamaz.
final class LockedParentalGate implements ParentalGate {
  const LockedParentalGate();

  @override
  Future<bool> verify(BuildContext context, ParentalAction action) async => false;
}
