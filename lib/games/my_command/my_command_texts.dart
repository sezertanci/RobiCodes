import '../../l10n/l10n.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../repeat/engine/repeat_program.dart';
import '../repeat/repeat_texts.dart';

/// "Kendi Komutunu Oluştur" oyununun parçalardan kurulan metinleri. Ana programdaki yerler "Tekrar Et"
/// metinleriyle, komuttaki yerler "Komuttaki …" diye anlatılır; metinler [RepeatTexts] ile kurulur.
abstract final class MyCommandTexts {
  static const _commandAdvice = AdviceTexts(offPath: _offPath, fixCount: _fixCount);

  static String _offPath(AppLocalizations t, String place) => t.myCommandOffPath(place);
  static String _fixCount(AppLocalizations t, int block) => t.myCommandFixCount(block);

  /// Robot komutun ilk kullanımındaki bir harekette çarptı.
  static LocalizedText blockedInCommand(Obstacle obstacle, ProgramStep step) =>
      RepeatTexts.blocked(obstacle, step, texts: _commandAdvice);

  static LocalizedText fixHintInCommand(ProgramStep step) => RepeatTexts.fixHint(step, texts: _commandAdvice);

  /// Robot komutun sonraki bir kullanımında çarptı; [step] ana programdaki komut bloğunun hareketidir.
  static LocalizedText blockedInLaterCall(Obstacle obstacle, ProgramStep step) =>
      RepeatTexts.blockedWith(obstacle, step, _laterCall);

  static LocalizedText fixHintInLaterCall() => RepeatTexts.fixHintWith(_laterCall);

  static String _laterCall(AppLocalizations t) => t.myCommandLaterCall;

  static LocalizedText fullLevelHint(LocalizedText levelHint) =>
      (t) => '${levelHint(t)} ${t.myCommandFullHint}';
}
