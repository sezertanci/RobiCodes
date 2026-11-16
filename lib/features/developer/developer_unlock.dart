import 'package:flutter/foundation.dart';

/// Geliştiricinin seviyeleri satın almadan ve sırayla bitirmeden test etmesi için bütün kilitleri açan durum.
/// Açıkken her paket sahip olunmuş, her grup ve seviye açık sayılır. Durum yalnızca bellekte tutulur:
/// uygulama yeniden açılınca kapanır ve sahiplik kaydına hiçbir şey yazılmaz.
/// Release derlemesinde `kDebugMode` sabit `false` olduğu için [isEnabled] her zaman `false` döner.
final class DeveloperUnlock extends ChangeNotifier {
  bool _enabled = false;

  bool get isEnabled => kDebugMode && _enabled;

  void setEnabled(bool enabled) {
    if (_enabled == enabled) {
      return;
    }
    _enabled = enabled;
    notifyListeners();
  }
}
