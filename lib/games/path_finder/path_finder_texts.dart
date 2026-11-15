import '../../l10n/l10n.dart';
import 'engine/path_finder_board.dart';

/// Oyunun parçalardan kurulan metinleri. Düz metinler doğrudan ARB dosyalarından okunur; burada
/// yalnızca yön, engel ve sıra numarası gibi değerleri metne yerleştiren yardımcılar bulunur.
/// Robotun söyledikleri [LocalizedText] döndürür; ekran onları o anki dilde çözer.
abstract final class PathFinderTexts {
  static String direction(AppLocalizations t, Direction direction) => t.gameDirection(direction.name);

  static String obstacle(AppLocalizations t, Obstacle obstacle) => t.gameObstacle(obstacle.name);

  static LocalizedText blocked(Obstacle hit, int index) =>
      (t) => t.pathFinderBlocked(obstacle(t, hit), index + 1);

  static LocalizedText fixCommand(int index) =>
      (t) => t.pathFinderFixCommand(index + 1);

  static LocalizedText nextMove(Direction next) =>
      (t) => t.pathFinderNextMove(direction(t, next));

  static String addCommand(AppLocalizations t, Direction added) => t.pathFinderAddCommand(direction(t, added));

  static String commandChip(AppLocalizations t, int index, Direction command) =>
      t.pathFinderCommandChip(index + 1, direction(t, command));
}
