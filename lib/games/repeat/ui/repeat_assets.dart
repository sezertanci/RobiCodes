import '../../../app/app_assets.dart';

/// Yalnızca blok şeridi oyunlarının ("Tekrar Et" ve ondan türeyenler) kullandığı görseller.
abstract final class RepeatAssets {
  /// Döngü simgesi: Tekrarla düğmesinde ve turuncu bloğun etiketinde görünür.
  static const icon = AppAssets.gameRepeat;

  /// Küçük açık kutu: "Değişken Kutusu"nun kutu bloklarında ve kutu rozetinde görünür.
  static const box = 'assets/icons/box.svg';

  /// Ortadaki iç kapağı olmayan kutu: "Değişken Kutusu" düğmelerinde tek renge boyanarak görünür.
  static const boxButton = 'assets/icons/box-button.svg';
}
