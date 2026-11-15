import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../engine/command_order_level.dart';
import 'card_metrics.dart';
import 'step_image.dart';

/// Görev kartı: görevin büyük görseli ve adı. Geniş ekranda dikey ve solda, dar ekranda yatay
/// bir şerit olarak üstte durur.
final class TaskCard extends StatelessWidget {
  const TaskCard({required this.level, required this.vertical, required this.ratio, super.key});

  final CommandOrderLevel level;
  final bool vertical;
  final double ratio;

  static const verticalWidth = 220.0;
  static const _verticalArt = 150.0;
  static const _stripArt = 64.0;
  static const _padding = 12.0;
  static const _gap = 10.0;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      level.title(context.l10n),
      textAlign: vertical ? TextAlign.center : TextAlign.start,
      style: TextStyle(fontSize: 20 * ratio, fontWeight: FontWeight.w900, color: AppColors.navy),
    );
    final art = StepImage(level.icon, size: (vertical ? _verticalArt : _stripArt) * ratio);
    return Container(
      width: vertical ? verticalWidth * ratio : double.infinity,
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CardMetrics.radius),
        boxShadow: const [BoxShadow(color: AppColors.shadow, offset: Offset(0, CardMetrics.lip))],
      ),
      child: Semantics(
        header: true,
        child: vertical
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  art,
                  const SizedBox(height: _gap),
                  title,
                ],
              )
            : Row(
                children: [
                  art,
                  const SizedBox(width: _gap),
                  Expanded(child: title),
                ],
              ),
      ),
    );
  }
}
