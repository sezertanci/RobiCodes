import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/widgets/dashed_frame.dart';
import '../command_order_controller.dart';
import '../command_order_texts.dart';
import 'card_metrics.dart';
import 'draggable_order_card.dart';
import 'mark_effects.dart';

/// Numaralı kutular. Zor ve Uzman seviyelerinde kutular aşama başlıklarıyla gruplanır.
final class SlotBoard extends StatelessWidget {
  const SlotBoard({required this.controller, required this.metrics, super.key});

  final CommandOrderController controller;
  final CardMetrics metrics;

  static const _stageGap = 24.0;
  static const _titleGap = 6.0;

  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.center,
    spacing: _stageGap,
    runSpacing: CardMetrics.gap + CardMetrics.lip,
    children: [
      for (final group in controller.level.slotGroups)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (group.title.isNotEmpty) ...[_StageTitle(group.title), const SizedBox(height: _titleGap)],
            Wrap(
              alignment: WrapAlignment.center,
              spacing: CardMetrics.gap,
              runSpacing: CardMetrics.gap + CardMetrics.lip,
              children: [for (final slot in group.slots) _Slot(controller: controller, slot: slot, metrics: metrics)],
            ),
          ],
        ),
    ],
  );
}

/// Lacivert hap biçimli aşama başlığı.
final class _StageTitle extends StatelessWidget {
  const _StageTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
    decoration: const ShapeDecoration(color: AppColors.navy, shape: StadiumBorder()),
    child: Semantics(
      header: true,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
      ),
    ),
  );
}

/// Tek kutu: boşsa numarası görünür ve dokununca hedef seçilir; doluysa içindeki kart görünür.
/// Kutuya kart sürüklenebilir; yanlış ve ipucu işaretleri kutunun üstünde gösterilir.
final class _Slot extends StatelessWidget {
  const _Slot({required this.controller, required this.slot, required this.metrics});

  final CommandOrderController controller;
  final int slot;
  final CardMetrics metrics;

  static const _hoverOpacity = 0.6;

  @override
  Widget build(BuildContext context) => DragTarget<CardDrag>(
    onWillAcceptWithDetails: (details) => !controller.isDone && details.data.fromSlot != slot,
    onAcceptWithDetails: (details) => controller.dropOnSlot(details.data.cardId, details.data.fromSlot, slot),
    builder: (context, candidates, _) {
      final content = _marked(_content());
      return candidates.isEmpty ? content : Opacity(opacity: _hoverOpacity, child: content);
    },
  );

  Widget _content() {
    final cardId = controller.slots[slot];
    if (cardId != null) {
      return DraggableOrderCard(controller: controller, cardId: cardId, slot: slot, metrics: metrics);
    }
    return _EmptySlot(
      slot: slot,
      metrics: metrics,
      targeted: controller.target == slot,
      onTap: controller.isDone ? null : () => controller.toggleTarget(slot),
    );
  }

  Widget _marked(Widget content) {
    final mark = controller.mark;
    if (mark == null || mark.slot != slot) {
      return content;
    }
    return switch (mark.kind) {
      SlotMarkKind.wrong => WrongShake(trigger: controller.wrongCount, child: content),
      SlotMarkKind.hint => HintGlow(child: content),
    };
  }
}

final class _EmptySlot extends StatelessWidget {
  const _EmptySlot({required this.slot, required this.metrics, required this.targeted, required this.onTap});

  final int slot;
  final CardMetrics metrics;
  final bool targeted;
  final VoidCallback? onTap;

  static const _border = 4.0;
  static const _fillAlpha = 0.06;
  static const _lineAlpha = 0.3;
  static const _numberAlpha = 0.35;
  static const _targetAlpha = 0.35;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: targeted,
    enabled: onTap != null,
    label: CommandOrderTexts.emptySlot(slot),
    excludeSemantics: true,
    onTap: onTap,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: metrics.width,
        height: metrics.height,
        decoration: BoxDecoration(
          color: targeted
              ? AppColors.yellow.withValues(alpha: _targetAlpha)
              : AppColors.navy.withValues(alpha: _fillAlpha),
          borderRadius: BorderRadius.circular(CardMetrics.radius),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            DashedFrame(
              color: targeted ? AppColors.navy : AppColors.navy.withValues(alpha: _lineAlpha),
              strokeWidth: _border,
            ),
            Text(
              '${slot + 1}',
              style: TextStyle(
                fontSize: metrics.numberSize,
                fontWeight: FontWeight.w900,
                color: targeted ? AppColors.navy : AppColors.navy.withValues(alpha: _numberAlpha),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
