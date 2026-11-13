import 'package:flutter/widgets.dart';

/// Ebeveyn doğrulaması gerektiren işlemler. Yeni bir korumalı işlem buraya eklenir;
/// hangi işlemin korunduğu tek bir yerden görülür.
enum ParentalAction {
  purchase,
  linkAccount,
  enableCloudSync,
  signOut,
  switchAccount,
}

/// Ebeveyn doğrulaması. Doğrulamanın nasıl yapılacağı (soru, basılı tutma vb.) henüz
/// belirlenmedi; seçilen yöntem bu arayüzü uygulayan bir sınıfla eklenir.
abstract interface class ParentalGate {
  /// Doğrulama geçilirse `true` döner.
  Future<bool> verify(BuildContext context, ParentalAction action);
}

/// Nihai doğrulama yazılana kadar kullanılan kapı: hiçbir korumalı işleme izin vermez.
/// Böylece doğrulamasız bir satın alma veya hesap işlemi yanlışlıkla açılamaz.
final class LockedParentalGate implements ParentalGate {
  const LockedParentalGate();

  @override
  Future<bool> verify(BuildContext context, ParentalAction action) async => false;
}
