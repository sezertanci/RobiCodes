import 'package:flutter/widgets.dart';

import '../../app/app_scope.dart';
import 'sound_effect.dart';

/// Tuşların tıklama sesi. Uygulamadaki bütün tuşlar dokunma geri çağırmasını bununla sarar; böylece ses
/// tek yerden çalınır ve ayarlardaki ses anahtarına uyar.
extension TapSound on BuildContext {
  /// [action] çalışmadan önce tıklama sesini çalan geri çağırma döndürür. [action] `null` ise (tuş
  /// pasifse) `null` döner; pasif tuş ses çıkarmaz.
  VoidCallback? withTapSound(VoidCallback? action) {
    if (action == null) {
      return null;
    }
    return () {
      playTapSound();
      action();
    };
  }

  /// Değer alan geri çağırmalar (ör. açma/kapama anahtarı) için [withTapSound].
  ValueChanged<T>? withTapSoundValue<T>(ValueChanged<T>? action) {
    if (action == null) {
      return null;
    }
    return (value) {
      playTapSound();
      action(value);
    };
  }

  void playTapSound() => AppScope.read(this)?.sound.play(SoundEffect.tap);
}
