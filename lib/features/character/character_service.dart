import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/json_utils.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import 'character.dart';

/// Çocuğun seçtiği karakteri tutar ve cihazda saklar. Kayıt yoksa veya artık bulunmayan bir karakteri
/// gösteriyorsa varsayılan karakterle başlanır.
final class CharacterService extends ChangeNotifier {
  CharacterService(this._store)
    : _current = switch (decodeJsonObject(_store.read(StorageKeys.character))?[_idField]) {
        final String id => CharacterRoster.find(id) ?? CharacterRoster.defaultCharacter,
        _ => CharacterRoster.defaultCharacter,
      };

  static const _idField = 'characterId';

  final KeyValueStore _store;
  Character _current;

  Character get current => _current;

  /// Karakteri seçer ve kaydeder. Bilinmeyen bir karakterde hiçbir şey değişmez ve `false` döner.
  Future<bool> select(String id) async {
    final character = CharacterRoster.find(id);
    if (character == null) {
      return false;
    }
    _current = character;
    notifyListeners();
    await _store.write(StorageKeys.character, jsonEncode({_idField: id}));
    return true;
  }
}
