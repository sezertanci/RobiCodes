import 'package:flutter/foundation.dart';

/// Geliştiricinin seviyeleri satın almadan ve sırayla bitirmeden test etmesi için bütün kilitleri açan durum.
/// Açıkken her paket sahip olunmuş, her grup ve seviye açık sayılır. Durum yalnızca bellekte tutulur:
/// uygulama her açılışta [enabled] ile başlar ve sahiplik kaydına hiçbir şey yazılmaz.
/// Release derlemesinde `kDebugMode` sabit `false` olduğu için [isEnabled] her zaman `false` döner.
final class DeveloperUnlock extends ChangeNotifier {
  DeveloperUnlock({this._enabled = false});

  bool _enabled;

  bool get isEnabled => kDebugMode && _enabled;

  void setEnabled(bool enabled) {
    if (_enabled == enabled) {
      return;
    }
    _enabled = enabled;
    notifyListeners();
  }
}
