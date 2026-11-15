import '../../l10n/l10n.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/path_finder_texts.dart';
import '../repeat/engine/repeat_program.dart';

/// "Kendi Komutunu Oluştur" oyununun parçalardan kurulan metinleri. Ana programdaki yerler "Tekrar Et"
/// metinleriyle, komuttaki yerler "Komuttaki …" diye anlatılır.
abstract final class MyCommandTexts {
  static String _placeName(AppLocalizations t, ProgramPlace place) => Places.isInner(place)
      ? t.repeatInnerArrowName(place.block + 1, place.inner + 1)
      : t.repeatBlockName(place.block + 1);

  /// Komuttaki tekrar bloğu ilk turu sorunsuz geçip sonraki bir turda yoldan çıktıysa sorun büyük
  /// olasılıkla tekrar sayısıdır.
  static String _advice(AppLocalizations t, ProgramStep step) =>
      _laterRound(step) ? t.myCommandFixCount(step.block + 1) : t.myCommandOffPath(_placeName(t, Places.of(step)));

  /// Robot komutun içindeki bir harekette çarptı.
  static LocalizedText blockedInCommand(Obstacle obstacle, ProgramStep step) => (t) {
    final hit = PathFinderTexts.obstacle(t, obstacle);
    final advice = _advice(t, step);
    return _laterRound(step) ? t.repeatBlockedInRound(step.round + 1, hit, advice) : t.repeatBlocked(hit, advice);
  };

  static LocalizedText fixHintInCommand(ProgramStep step) =>
      (t) => t.repeatFixHint(_advice(t, step));

  static LocalizedText fullLevelHint(LocalizedText levelHint) =>
      (t) => '${levelHint(t)} ${t.myCommandFullHint}';

  static bool _laterRound(ProgramStep step) => Places.isInner(Places.of(step)) && step.round > 0;
}
