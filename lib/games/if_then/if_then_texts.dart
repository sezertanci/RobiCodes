import '../../l10n/l10n.dart';
import 'engine/if_then_engine.dart';
import 'engine/if_then_level.dart';

/// Oyunun parçalardan kurulan metinleri. Düz metinler doğrudan ARB dosyalarından okunur; burada
/// yalnızca nesne, hareket ve kural adlarını metne yerleştiren yardımcılar bulunur.
/// Robotun söyledikleri [LocalizedText] döndürür; ekran onları o anki dilde çözer.
abstract final class IfThenTexts {
  static String objectLabel(AppLocalizations t, LaneObject object) => t.ifThenObjectLabel(object.name);

  static String actionLabel(AppLocalizations t, LaneAction action) => t.ifThenActionLabel(action.name);

  static String _ruleName(AppLocalizations t, int rule) =>
      rule == IfThenEngine.elseRule ? t.ifThenElseRule : t.ifThenRuleNumber(rule + 1);

  /// Yanlış harekette robotun söylediği cümle. Program tam olduğu için hareket her zaman doludur.
  static LocalizedText wrong(LaneStep step) =>
      (t) => t.ifThenWrong(
        t.ifThenObjectName(step.object.name),
        _ruleName(t, step.rule),
        actionLabel(t, step.action!),
        t.ifThenProblem(step.object.name),
      );

  static LocalizedText hint(LaneObject object) =>
      (t) => t.ifThenHint(t.ifThenObjectName(object.name), t.ifThenAdvice(object.name));

  /// Bloğun adı: nesne veya hareket.
  static String label(AppLocalizations t, Enum block) =>
      block is LaneAction ? actionLabel(t, block) : objectLabel(t, block as LaneObject);

  /// Kutunun ekran okuyucu etiketi.
  static String slot(AppLocalizations t, {required bool condition, required Enum? value, required bool locked}) {
    final shown = value == null ? t.ifThenSlotEmpty : label(t, value);
    return t.ifThenSlot(condition ? _conditionKind : _actionKind, locked ? t.ifThenSlotReady(shown) : shown);
  }

  /// Paletteki bloğun ekran okuyucu etiketi.
  static String paletteBlock(AppLocalizations t, Enum block) =>
      t.ifThenPaletteBlock(block is LaneAction ? _actionKind : _objectKind, label(t, block));

  // ARB dosyalarındaki select seçenekleriyle aynı olmalıdır.
  static const _conditionKind = 'condition';
  static const _actionKind = 'action';
  static const _objectKind = 'object';
}
