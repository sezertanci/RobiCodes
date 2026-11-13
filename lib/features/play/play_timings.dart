/// Bütün oyunların ortak animasyon süreleri.
abstract final class PlayTimings {
  /// Başarıdan sonra sonuç paneli açılmadan önceki kutlama süresi.
  static const celebrate = Duration(milliseconds: 900);

  /// "Hareketi azalt" ayarı açıkken robotun bir adımı.
  static const reducedStep = Duration(milliseconds: 150);
}
