import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../command_order_controller.dart';
import '../../../l10n/l10n.dart';
import 'card_metrics.dart';
import 'draggable_order_card.dart';

/// Henüz yerleşmemiş karışık kartların durduğu havuz. Kutudan sürüklenen kart buraya bırakılınca
/// havuza döner.
final class CardPool extends StatelessWidget {
  const CardPool({required this.controller, required this.metrics, super.key});

  final CommandOrderController controller;
  final CardMetrics metrics;

  static const _padding = 12.0;
  static const _lineWidth = 3.0;
  static const _lineAlpha = 0.12;
  static const _hoverAlpha = 0.2;
  static const _emptyAlpha = 0.45;

  @override
  Widget build(BuildContext context) => DragTarget<CardDrag>(
    onWillAcceptWithDetails: (details) => !controller.isDone && details.data.fromSlot != null,
    onAcceptWithDetails: (details) => controller.returnToPool(details.data.fromSlot!),
    builder: (context, candidates, _) => Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: metrics.height + CardMetrics.lip + _padding * 2),
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: candidates.isEmpty ? null : AppColors.yellow.withValues(alpha: _hoverAlpha),
        border: Border(
          top: BorderSide(
            color: AppColors.navy.withValues(alpha: _lineAlpha),
            width: _lineWidth,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: _cards(context),
    ),
  );

  Widget _cards(BuildContext context) {
    final cards = controller.poolCards;
    if (cards.isEmpty) {
      return Text(
        context.l10n.commandOrderPoolEmpty,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.navy.withValues(alpha: _emptyAlpha),
        ),
      );
    }
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: CardMetrics.gap,
      runSpacing: CardMetrics.gap + CardMetrics.lip,
      children: [
        for (final card in cards)
          DraggableOrderCard(controller: controller, cardId: card.id, slot: null, metrics: metrics),
      ],
    );
  }
}
