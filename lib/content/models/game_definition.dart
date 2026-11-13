/// Ana ekranda gösterilen bir oyun. Oyunun kuralları ve seviye içeriği burada değil,
/// oyunun kendi modülündedir (bkz. `GameModule`); burada yalnızca tanıtım bilgisi bulunur.
final class GameDefinition {
  const GameDefinition({required this.id, required this.title, required this.description});

  /// Kalıcı kimlik. İlerleme ve paket kayıtları bu kimliğe bağlı olduğu için değiştirilmez.
  final String id;
  final String title;
  final String description;
}
