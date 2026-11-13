import 'package:shared_preferences/shared_preferences.dart';

/// Cihazda metin olarak veri saklayan basit anahtar-değer deposu.
/// İlerleme, satın alma önbelleği ve ayarlar bu arayüz üzerinden kaydedilir;
/// böylece testlerde bellekte çalışan bir sürüm kullanılabilir.
abstract interface class KeyValueStore {
  String? read(String key);

  Future<void> write(String key, String value);

  Future<void> remove(String key);
}

/// Android'de `SharedPreferences` üzerinde çalışan depo.
final class SharedPreferencesStore implements KeyValueStore {
  SharedPreferencesStore(this._preferences);

  final SharedPreferencesWithCache _preferences;

  /// Depoyu açar. Okumalar önbellekten yapıldığı için uygulama açılışında bir kez beklenir.
  static Future<SharedPreferencesStore> open() async {
    final preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    return SharedPreferencesStore(preferences);
  }

  @override
  String? read(String key) => _preferences.getString(key);

  @override
  Future<void> write(String key, String value) => _preferences.setString(key, value);

  @override
  Future<void> remove(String key) => _preferences.remove(key);
}
