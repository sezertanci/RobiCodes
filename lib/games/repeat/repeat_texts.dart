import '../../l10n/l10n.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/path_finder_texts.dart';
import 'engine/repeat_program.dart';

/// Oyunun parçalardan kurulan metinleri. Düz metinler doğrudan ARB dosyalarından okunur; burada
/// yalnızca yön, engel, blok numarası ve tekrar sayısını metne yerleştiren yardımcılar bulunur.
/// Robotun söyledikleri [LocalizedText] döndürür; ekran onları o anki dilde çözer.
abstract final class RepeatTexts {
  static String addMove(AppLocalizations t, Direction direction) =>
      t.repeatAddMove(PathFinderTexts.direction(t, direction));

  static String moveChip(AppLocalizations t, ProgramPlace place, Direction direction) {
    final name = Places.isInner(place) ? t.repeatArrowName(place.inner + 1) : t.repeatBlockName(place.block + 1);
    return t.repeatMoveChip(name, PathFinderTexts.direction(t, direction));
  }

  static String repeatLabel(AppLocalizations t, int index, int times) => t.repeatBlockLabel(index + 1, times);

  /// Çalışırken gösterilen tur rozeti; her dilde aynı biçimdedir.
  static String round(int round, int times) => '${round + 1}/$times';

  static String _placeName(AppLocalizations t, ProgramPlace place) => Places.isInner(place)
      ? t.repeatInnerArrowName(place.block + 1, place.inner + 1)
      : t.repeatBlockName(place.block + 1);

  /// Tekrar bloğu ilk turu sorunsuz geçip sonraki bir turda yoldan çıktıysa sorun büyük olasılıkla
  /// tekrar sayısıdır.
  static String _fixAdvice(AppLocalizations t, ProgramStep step) =>
      _laterRound(step) ? t.repeatFixCount(step.block + 1) : t.repeatOffPath(_placeName(t, Places.of(step)));

  static LocalizedText blocked(Obstacle obstacle, ProgramStep step) => (t) {
    final hit = PathFinderTexts.obstacle(t, obstacle);
    final advice = _fixAdvice(t, step);
    return _laterRound(step) ? t.repeatBlockedInRound(step.round + 1, hit, advice) : t.repeatBlocked(hit, advice);
  };

  static LocalizedText fixHint(ProgramStep step) =>
      (t) => t.repeatFixHint(_fixAdvice(t, step));

  static LocalizedText fullLevelHint(LocalizedText levelHint) =>
      (t) => '${levelHint(t)} ${t.repeatFullHint}';

  static LocalizedText nextMoveHint(LocalizedText levelHint, Direction direction) =>
      (t) => t.repeatNextMoveHint(levelHint(t), PathFinderTexts.direction(t, direction).toLowerCase());

  static bool _laterRound(ProgramStep step) => Places.isInner(Places.of(step)) && step.round > 0;
}
