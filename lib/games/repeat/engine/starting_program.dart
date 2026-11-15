import 'repeat_program.dart';

/// Hazır bir programla başlayan oyunların (ör. "Hata Avcısı") ayarı. Program bu bloklarla açılır;
/// oyuncu bir oku seçip yön tuşuna basınca o ok değişir, seçili bloğun önüne yeni ok ekleyebilir ve
/// "Baştan al" ile bu bloklara geri döner.
final class StartingProgram {
  const StartingProgram(this.blocks, {required this.allowsRepeat});

  final List<ProgramBlock> blocks;

  /// `false` ise Tekrarla düğmesi gösterilmez; yalnızca oklu seviyelerde kullanılır.
  final bool allowsRepeat;
}
