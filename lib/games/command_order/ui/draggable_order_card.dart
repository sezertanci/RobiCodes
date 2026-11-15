import 'package:flutter/material.dart';

import '../../../features/play/widgets/mark_effects.dart';
import '../command_order_controller.dart';
import '../../../l10n/l10n.dart';
import '../command_order_texts.dart';
import 'card_metrics.dart';
import 'order_card_tile.dart';

/// Sürüklenen kart ve geldiği kutu (havuzdan geldiyse `null`).
typedef CardDrag = ({int cardId, int? fromSlot});

/// Havuzda veya bir kutuda duran kart. Dokununca havuzdaki kart kutuya gider, kutudaki kart
/// havuza döner. Uzun basınca sürüklenebilir. İpucunun gösterdiği kart sarı halkayla parlar.
final class DraggableOrderCard extends StatelessWidget {
  const DraggableOrderCard({
    required this.controller,
    required this.cardId,
    required this.slot,
    required this.metrics,
    super.key,
  });

  final CommandOrderController controller;
  final int cardId;

  /// Kartın durduğu kutu; havuzdaysa `null`.
  final int? slot;
  final CardMetrics metrics;

  static const _draggingOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    final card = controller.cardOf(cardId);
    final slot = this.slot;
    final tile = OrderCardTile(
      card: card,
      position: controller.positionOf(cardId),
      metrics: metrics,
      label: slot == null ? card.step.text(context.l10n) : CommandOrderTexts.slotCard(context.l10n, slot, card),
      onTap: controller.isDone
          ? null
          : () => slot == null ? controller.tapPoolCard(cardId) : controller.returnToPool(slot),
    );
    final mark = controller.mark;
    final hinted = slot == null && mark?.kind == SlotMarkKind.hint && mark?.cardId == cardId;
    final shown = hinted ? HintGlow(radius: CardMetrics.radius, child: tile) : tile;
    if (controller.isDone) {
      return shown;
    }
    return LongPressDraggable<CardDrag>(
      data: (cardId: cardId, fromSlot: slot),
      feedback: Material(color: Colors.transparent, child: tile),
      childWhenDragging: Opacity(opacity: _draggingOpacity, child: tile),
      child: shown,
    );
  }
}
