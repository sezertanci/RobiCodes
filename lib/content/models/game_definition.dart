import '../../app/app_theme.dart';

/// Ana ekranda gösterilen bir oyun. Oyunun kuralları ve seviye içeriği burada değil,
/// oyunun kendi modülündedir (bkz. `GameModule`); burada yalnızca tanıtım bilgisi bulunur.
final class GameDefinition {
  const GameDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.tone,
    required this.icon,
    required this.trophy,
  });

  /// Kalıcı kimlik. İlerleme ve paket kayıtları bu kimliğe bağlı olduğu için değiştirilmez.
  final String id;
  final String title;
  final String description;

  /// Oyun kartının ve oyunun kupasının rengi.
  final ColorTone tone;

  /// Oyunun ikonu; oyunun kupasının ortasında görünür.
  final String icon;

  /// Oyunun bütün ücretsiz seviyeleri bitince kazanılan kupa.
  final GameTrophy trophy;
}

/// Bir oyunu bitirme kupasının adı ve açıklaması. Kupanın koşulu ve hedefi oyundan hesaplanır;
/// böylece yeni bir oyun eklenince kupası da kendiliğinden oluşur.
final class GameTrophy {
  const GameTrophy({required this.title, required this.description});

  final String title;
  final String description;
}
