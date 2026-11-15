import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../core/json_utils.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import '../../l10n/l10n.dart';

/// Uygulamanın dilini seçer ve seçimi cihazda saklar. Seçim yapılmadıysa cihazın dili kullanılır;
/// cihazın dili desteklenmiyorsa uygulama [fallback] diliyle açılır.
final class LanguageService extends ChangeNotifier {
  LanguageService(this._store) : _selected = _read(_store);

  /// Desteklenmeyen bir cihaz dilinde kullanılan dil.
  static const fallback = Locale('en');

  static const _languageField = 'language';

  final KeyValueStore _store;
  Locale? _selected;

  /// Kullanıcının seçtiği dil; seçim yapılmadıysa `null` (cihazın dili kullanılır).
  Locale? get selected => _selected;

  Future<void> select(Locale locale) async {
    _selected = locale;
    notifyListeners();
    await _store.write(StorageKeys.language, jsonEncode({_languageField: locale.languageCode}));
  }

  /// Cihazın dillerinden ilk desteklenenini, hiçbiri desteklenmiyorsa [fallback] dilini döndürür.
  /// Dil kodu yeterlidir; örneğin `en_GB` İngilizce ile eşleşir.
  static Locale resolve(List<Locale>? deviceLocales, Iterable<Locale> supported) {
    for (final device in deviceLocales ?? const <Locale>[]) {
      for (final locale in supported) {
        if (locale.languageCode == device.languageCode) {
          return locale;
        }
      }
    }
    return fallback;
  }

  static Locale? _read(KeyValueStore store) {
    final code = decodeJsonObject(store.read(StorageKeys.language))?[_languageField];
    if (code is! String) {
      return null;
    }
    final known = AppLocalizations.supportedLocales.any((locale) => locale.languageCode == code);
    return known ? Locale(code) : null;
  }
}
