import 'game_module.dart';

/// Uygulamaya eklenmiş oyun modülleri. Katalogda olup modülü henüz eklenmemiş oyunlar
/// ana ekranda "Yakında" olarak görünür.
final class GameRegistry {
  GameRegistry(Iterable<GameModule> modules) : _modules = {for (final module in modules) module.gameId: module};

  final Map<String, GameModule> _modules;

  GameModule? moduleFor(String gameId) => _modules[gameId];

  bool isPlayable(String gameId) => _modules.containsKey(gameId);
}
