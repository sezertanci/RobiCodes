import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/json_utils.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import 'sound_effect.dart';
import 'sound_player.dart';

/// Ses efektlerini çalar ve sesin açık mı kapalı mı olduğunu cihazda saklar. Uygulamadaki bütün
/// sesler [play] üzerinden geçer; ses kapalıyken hiçbiri çalmaz. Ses ilk açılışta açıktır.
final class SoundService extends ChangeNotifier {
  SoundService({required KeyValueStore store, required this._player})
    : _store = store,
      _enabled = decodeJsonObject(store.read(StorageKeys.sound))?[_enabledField] != false;

  static const _enabledField = 'enabled';

  final KeyValueStore _store;
  final SoundPlayer _player;
  bool _enabled;

  bool get isEnabled => _enabled;

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    notifyListeners();
    await _store.write(StorageKeys.sound, jsonEncode({_enabledField: value}));
  }

  /// Ses açıksa [effect] efektini çalar; beklenmez, ses çalınırken oyun sürer.
  /// [step] yalnızca yıldız sesinde kullanılır (bkz. [SoundEffect.assetFor]).
  void play(SoundEffect effect, {int step = 0}) {
    if (_enabled) {
      unawaited(_player.play(effect.assetFor(step)));
    }
  }
}
