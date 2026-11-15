/// Cihazdaki kayıt anahtarları. Her kayıt ayrı bir anahtarda tutulur; böylece örneğin
/// ilerleme sıfırlandığında satın alma bilgisi etkilenmez.
/// Kaydın biçimi değişirse anahtarın sonundaki sürüm numarası artırılır.
abstract final class StorageKeys {
  static const progress = 'progress.v1';
  static const ownedProducts = 'owned-products.v1';
  static const sound = 'sound.v1';
  static const character = 'character.v1';
  static const achievements = 'achievements.v1';
  static const language = 'language.v1';
}
