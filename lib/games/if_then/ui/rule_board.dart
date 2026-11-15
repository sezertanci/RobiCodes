import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/widgets/dashed_frame.dart';
import '../../../features/play/widgets/mark_effects.dart';
import '../engine/if_then_engine.dart';
import '../if_then_controller.dart';
import '../../../l10n/l10n.dart';
import '../if_then_texts.dart';
import 'block_tile.dart';
import 'if_then_metrics.dart';

/// Kural satırları ve en sonda "Değilse" satırı. Her satırda üstte mavi "Eğer ... varsa" başlığı,
/// altında içeri girmiş hareket kutusu bulunur. Çalışan kural sarı, yanlış kural kırmızı halkayla,
/// ipucunun gösterdiği kural nabız gibi atan halkayla işaretlenir.
final class RuleBoard extends StatelessWidget {
  const RuleBoard({required this.controller, required this.metrics, super.key});

  final IfThenController controller;
  final IfThenMetrics metrics;

  static const _ruleGap = 12.0;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    spacing: _ruleGap,
    children: [
      for (var rule = 0; rule < controller.level.rules.length; rule++) _rule(rule),
      _rule(IfThenEngine.elseRule),
    ],
  );

  Widget _rule(int rule) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      _marked(rule, _RuleHead(controller: controller, rule: rule, metrics: metrics)),
      _RuleBody(controller: controller, rule: rule, metrics: metrics),
    ],
  );

  Widget _marked(int rule, Widget head) {
    if (controller.wrongRule == rule) {
      return WrongShake(trigger: controller.wrongCount, radius: _RuleHead.radius, child: head);
    }
    if (controller.hint?.rule == rule) {
      return HintGlow(radius: _RuleHead.radius, child: head);
    }
    if (controller.activeRule == rule) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_RuleHead.radius),
          boxShadow: const [BoxShadow(color: AppColors.yellow, spreadRadius: _activeRing)],
        ),
        child: head,
      );
    }
    return head;
  }

  static const _activeRing = 5.0;
}

/// Mavi başlık: "Eğer [koşul] varsa", "Değilse eğer [koşul] varsa" veya yalnızca "Değilse".
final class _RuleHead extends StatelessWidget {
  const _RuleHead({required this.controller, required this.rule, required this.metrics});

  final IfThenController controller;
  final int rule;
  final IfThenMetrics metrics;

  static const radius = 16.0;

  @override
  Widget build(BuildContext context) {
    final isElse = rule == IfThenEngine.elseRule;
    final t = context.l10n;
    final word = isElse ? t.ifThenElse : (rule == 0 ? t.ifThenIf : t.ifThenElseIf);
    return Container(
      constraints: BoxConstraints(minHeight: metrics.headMinHeight),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: const BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        boxShadow: [BoxShadow(color: AppColors.blueDark, offset: Offset(0, IfThenMetrics.lip))],
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: IfThenMetrics.gap,
        runSpacing: IfThenMetrics.gap,
        children: [
          _word(word),
          if (!isElse) ...[
            _SlotBox(controller: controller, slot: (rule: rule, part: SlotPart.condition), metrics: metrics),
            _word(t.ifThenThen),
          ],
        ],
      ),
    );
  }

  Widget _word(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: IfThenMetrics.gap),
    child: Text(
      text,
      style: TextStyle(fontSize: metrics.headFontSize, fontWeight: FontWeight.w900, color: Colors.white),
    ),
  );
}

/// Başlığın altında içeri girmiş, ok işaretli hareket kutusu.
final class _RuleBody extends StatelessWidget {
  const _RuleBody({required this.controller, required this.rule, required this.metrics});

  final IfThenController controller;
  final int rule;
  final IfThenMetrics metrics;

  static const _border = 8.0;
  static const _fillAlpha = 0.12;
  static const _arrow = '→';

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(left: metrics.indent),
    padding: const EdgeInsets.fromLTRB(10, 8, 12, 8 + IfThenMetrics.lip),
    decoration: BoxDecoration(
      color: AppColors.blue.withValues(alpha: _fillAlpha),
      border: const Border(
        left: BorderSide(color: AppColors.blue, width: _border),
      ),
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(_RuleHead.radius)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: IfThenMetrics.gap,
      children: [
        ExcludeSemantics(
          child: Text(
            _arrow,
            style: TextStyle(fontSize: 26 * metrics.ratio, fontWeight: FontWeight.w900, color: AppColors.blueDark),
          ),
        ),
        _SlotBox(controller: controller, slot: (rule: rule, part: SlotPart.action), metrics: metrics),
      ],
    ),
  );
}

/// Tek kutu. Boşsa "?" görünür ve dokununca hedef seçilir; doluysa içindeki blok görünür ve
/// dokununca kutu boşalır. Paletten blok sürüklenip bırakılabilir.
final class _SlotBox extends StatelessWidget {
  const _SlotBox({required this.controller, required this.slot, required this.metrics});

  final IfThenController controller;
  final SlotRef slot;
  final IfThenMetrics metrics;

  static const _hoverOpacity = 0.6;

  @override
  Widget build(BuildContext context) {
    final condition = slot.part == SlotPart.condition;
    final size = condition ? metrics.conditionSlot : metrics.actionSlot;
    final value = controller.valueOf(slot);
    final locked = controller.isLocked(slot);
    final onTap = controller.isEditable ? () => controller.tapSlot(slot) : null;
    return DragTarget<Enum>(
      onWillAcceptWithDetails: (_) => controller.isEditable,
      onAcceptWithDetails: (details) => controller.dropBlock(details.data, slot),
      builder: (context, candidates, _) => Opacity(
        opacity: candidates.isEmpty ? 1 : _hoverOpacity,
        child: Semantics(
          button: true,
          selected: controller.target == slot,
          enabled: onTap != null,
          label: IfThenTexts.slot(context.l10n, condition: condition, value: value, locked: locked),
          excludeSemantics: true,
          onTap: onTap,
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox.fromSize(
              size: size,
              child: value == null
                  ? _EmptySlot(onBlue: condition, targeted: controller.target == slot, metrics: metrics)
                  : Center(
                      child: FittedBox(
                        child: BlockTile(block: value, metrics: metrics),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Boş kutu: kesik çerçeve ve soru işareti. Mavi başlığın içindeyse beyaz tonlarla çizilir;
/// hedef seçildiyse sarı olur.
final class _EmptySlot extends StatelessWidget {
  const _EmptySlot({required this.onBlue, required this.targeted, required this.metrics});

  final bool onBlue;
  final bool targeted;
  final IfThenMetrics metrics;

  static const _border = 3.0;
  static const _question = '?';

  @override
  Widget build(BuildContext context) {
    final (fill, line, text) = switch ((targeted, onBlue)) {
      (true, _) => (AppColors.yellow.withValues(alpha: 0.6), AppColors.navy, AppColors.navy),
      (false, true) => (Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.85), Colors.white),
      (false, false) => (
        AppColors.navy.withValues(alpha: 0.06),
        AppColors.navy.withValues(alpha: 0.35),
        AppColors.navy.withValues(alpha: 0.45),
      ),
    };
    return DecoratedBox(
      decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(IfThenMetrics.radius)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          DashedFrame(color: line, strokeWidth: _border),
          Text(
            _question,
            style: TextStyle(fontSize: 26 * metrics.ratio, fontWeight: FontWeight.w900, color: text),
          ),
        ],
      ),
    );
  }
}
