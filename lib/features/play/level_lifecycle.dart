import 'package:flutter/foundation.dart';

/// Oynanış denetleyicilerinin ortak yaşam döngüsü. Ekran kapandıktan sonra süren beklemelerin
/// durmasını ve seviye sonucunun kapanmış bir ekrana bildirilmemesini sağlar.
mixin LevelLifecycle on ChangeNotifier {
  bool _disposed = false;

  /// Ekran kapandı mı? Bir beklemeden sonra devam etmeden önce bakılır.
  @protected
  bool get isDisposed => _disposed;

  /// Kutlama için [delay] kadar bekler; ekran hâlâ açıksa [onCompleted] kazanılan yıldızlarla çağrılır.
  @protected
  Future<void> completeAfter(Duration delay, ValueChanged<int> onCompleted, int stars) async {
    await Future<void>.delayed(delay);
    if (!_disposed) {
      onCompleted(stars);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
