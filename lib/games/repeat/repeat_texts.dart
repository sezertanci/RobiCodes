import '../../l10n/l10n.dart';
import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/path_finder_texts.dart';
import 'engine/repeat_engine.dart';
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

  /// Ana programdaki yerlerin öneri metinleri.
  static const mainAdvice = AdviceTexts(offPath: _mainOffPath, fixCount: _mainFixCount);

  static String _mainOffPath(AppLocalizations t, String place) => t.repeatOffPath(place);
  static String _mainFixCount(AppLocalizations t, int block) => t.repeatFixCount(block);

  static String _placeName(AppLocalizations t, ProgramPlace place) => Places.isInner(place)
      ? t.repeatInnerArrowName(place.block + 1, place.inner + 1)
      : t.repeatBlockName(place.block + 1);

  /// Tekrar bloğu ilk turu sorunsuz geçip sonraki bir turda yoldan çıktıysa sorun büyük olasılıkla
  /// tekrar sayısıdır.
  static String _fixAdvice(AppLocalizations t, ProgramStep step, AdviceTexts texts) =>
      _laterRound(step) ? texts.fixCount(t, step.block + 1) : texts.offPath(t, _placeName(t, Places.of(step)));

  /// Robot [step] hareketinde [obstacle]a çarptı; öneri [texts] ile yerin adından kurulur.
  static LocalizedText blocked(Obstacle obstacle, ProgramStep step, {AdviceTexts texts = mainAdvice}) =>
      blockedWith(obstacle, step, (t) => _fixAdvice(t, step, texts));

  /// Çarpma metni; öneri ([advice]) hazır verilir.
  static LocalizedText blockedWith(Obstacle obstacle, ProgramStep step, LocalizedText advice) => (t) {
    final hit = PathFinderTexts.obstacle(t, obstacle);
    return _laterRound(step) ? t.repeatBlockedInRound(step.round + 1, hit, advice(t)) : t.repeatBlocked(hit, advice(t));
  };

  static LocalizedText fixHint(ProgramStep step, {AdviceTexts texts = mainAdvice}) =>
      fixHintWith((t) => _fixAdvice(t, step, texts));

  /// Yanlış yeri gösteren ipucu; öneri ([advice]) hazır verilir.
  static LocalizedText fixHintWith(LocalizedText advice) =>
      (t) => t.repeatFixHint(advice(t));

  /// Programın önerilen çözümden ayrıldığı yeri anlatan ipucu (bkz. [SolutionDifference]).
  static LocalizedText differenceHint(SolutionDifference difference) => fixHintWith((t) {
    final place = difference.place;
    return switch (difference.kind) {
      DifferenceKind.wrongBlock => t.repeatOffPath(_placeName(t, place)),
      DifferenceKind.wrongCount => t.repeatFixCount(place.block + 1),
      DifferenceKind.extraBlock => t.repeatExtraBlock(_placeName(t, place)),
    };
  });

  static LocalizedText fullLevelHint(LocalizedText levelHint) =>
      (t) => '${levelHint(t)} ${t.repeatFullHint}';

  static LocalizedText nextMoveHint(LocalizedText levelHint, Direction direction) =>
      (t) => t.repeatNextMoveHint(levelHint(t), PathFinderTexts.direction(t, direction).toLowerCase());

  static bool _laterRound(ProgramStep step) => Places.isInner(Places.of(step)) && step.round > 0;
}

/// Robotu yoldan çıkaran yer için öneri metinleri: yer yoldan çıkarıyor ([offPath]) ya da tekrar
/// sayısı yanlış ([fixCount]). Ana program ve "Kendi Komutunu Oluştur"un komut şeridi farklı metin kullanır.
final class AdviceTexts {
  const AdviceTexts({required this.offPath, required this.fixCount});

  final String Function(AppLocalizations t, String place) offPath;
  final String Function(AppLocalizations t, int block) fixCount;
}
