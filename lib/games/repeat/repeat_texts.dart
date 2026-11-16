import '../../l10n/l10n.dart';
import '../path_finder/engine/lamp.dart';
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

  /// Okun ekran okuyucu etiketi; [steps] verilirse okun kaç kare yürüteceği de söylenir.
  static String moveChip(AppLocalizations t, ProgramPlace place, Direction direction, {int? steps}) {
    final name = Places.isInner(place) ? t.repeatArrowName(place.inner + 1) : t.repeatBlockName(place.block + 1);
    final label = t.repeatMoveChip(name, PathFinderTexts.direction(t, direction));
    return steps == null ? label : t.variableBoxArrowSteps(label, steps);
  }

  /// Kutu bloğunun ekran okuyucu etiketi.
  static String boxChip(AppLocalizations t, ProgramPlace place, InnerBlock block) {
    final name = _placeName(t, place, isMove: false);
    return switch (block) {
      SetBoxBlock(:final value) => t.variableBoxSetChip(name, value),
      AddBoxBlock(:final amount) when amount > 0 => t.variableBoxIncreaseChip(name),
      _ => t.variableBoxDecreaseChip(name),
    };
  }

  /// "Renk yak" bloğunun ekran okuyucu etiketi.
  static String lightChip(AppLocalizations t, ProgramPlace place, LampColor color) {
    final name = Places.isInner(place)
        ? t.patternInnerName(place.block + 1, place.inner + 1)
        : t.repeatBlockName(place.block + 1);
    return t.patternLightChip(name, lampColor(t, color));
  }

  static String lampColor(AppLocalizations t, LampColor color) => switch (color) {
    LampColor.red => t.patternColorRed,
    LampColor.blue => t.patternColorBlue,
    LampColor.yellow => t.patternColorYellow,
    LampColor.green => t.patternColorGreen,
  };

  /// Kutu bloğunun üstünde yazan kısa işaret ("= 3", "+1", "−1"); her dilde aynıdır.
  static String boxSign(InnerBlock block) => switch (block) {
    SetBoxBlock(:final value) => '= $value',
    AddBoxBlock(:final amount) when amount > 0 => '+$amount',
    AddBoxBlock(:final amount) => '−${-amount}',
    MoveBlock() || LightBlock() => '',
  };

  static String repeatLabel(AppLocalizations t, int index, int times) => t.repeatBlockLabel(index + 1, times);

  /// Çalışırken gösterilen tur rozeti; her dilde aynı biçimdedir.
  static String round(int round, int times) => '${round + 1}/$times';

  /// Ana programdaki yerlerin öneri metinleri.
  static const mainAdvice = AdviceTexts(offPath: _mainOffPath, fixCount: _mainFixCount);

  static String _mainOffPath(AppLocalizations t, String place) => t.repeatOffPath(place);
  static String _mainFixCount(AppLocalizations t, int block) => t.repeatFixCount(block);

  /// Yerin adı; tekrar bloğunun içindeki kutu bloğu ([isMove] `false`) ok yerine "kutu bloğu" diye anılır.
  static String _placeName(AppLocalizations t, ProgramPlace place, {bool isMove = true}) {
    if (!Places.isInner(place)) {
      return t.repeatBlockName(place.block + 1);
    }
    return isMove
        ? t.repeatInnerArrowName(place.block + 1, place.inner + 1)
        : t.variableBoxInnerName(place.block + 1, place.inner + 1);
  }

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

  /// Programın önerilen çözümden ayrıldığı yeri anlatan ipucu (bkz. [SolutionDifference]); [block] o yerdeki
  /// bloktur.
  static LocalizedText differenceHint(SolutionDifference difference, ProgramBlock block) => fixHintWith((t) {
    final place = difference.place;
    final name = _placeName(t, place, isMove: block is MoveBlock);
    return switch (difference.kind) {
      DifferenceKind.wrongBlock => t.repeatOffPath(name),
      DifferenceKind.wrongCount => t.repeatFixCount(place.block + 1),
      DifferenceKind.extraBlock => t.repeatExtraBlock(name),
    };
  });

  /// Kutuda 1'den farklı bir sayı varken robotun kaç kare yürüdüğünü [text]in sonuna ekler.
  static LocalizedText withBox(LocalizedText text, int box) =>
      box == BoxRules.start ? text : (t) => '${text(t)} ${t.variableBoxWalked(box)}';

  static LocalizedText fullLevelHint(LocalizedText levelHint, {bool usesBox = false}) =>
      (t) => '${levelHint(t)} ${usesBox ? t.variableBoxFullHint : t.repeatFullHint}';

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
