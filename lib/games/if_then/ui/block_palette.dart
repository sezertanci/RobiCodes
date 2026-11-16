import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/widgets/mark_effects.dart';
import '../if_then_controller.dart';
import '../../../l10n/l10n.dart';
import '../if_then_texts.dart';
import 'block_tile.dart';
import 'if_then_metrics.dart';
import '../../../features/sound/tap_sound.dart';

/// Seçilebilecek bloklar: "Nesneler" (koşul kutusu açıksa) ve "Hareketler". Dokunulan blok
/// seçili veya ilk uygun boş kutuya gider; uzun basınca blok bir kutuya sürüklenebilir.
final class BlockPalette extends StatelessWidget {
  const BlockPalette({required this.controller, required this.metrics, super.key});

  final IfThenController controller;
  final IfThenMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.needsConditions) ...[
          _group(t.ifThenObjects, controller.palette.conditions),
          const SizedBox(height: IfThenMetrics.gap * 1.5),
        ],
        _group(t.ifThenActions, controller.palette.actions),
      ],
    );
  }

  Widget _group(String title, List<Enum> blocks) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Semantics(
        header: true,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16 * metrics.ratio,
            fontWeight: FontWeight.w800,
            color: AppColors.navy.withValues(alpha: 0.7),
          ),
        ),
      ),
      const SizedBox(height: IfThenMetrics.gap - 2),
      Wrap(
        spacing: IfThenMetrics.gap + 2,
        runSpacing: IfThenMetrics.gap + IfThenMetrics.lip,
        children: [for (final block in blocks) _PaletteBlock(controller: controller, block: block, metrics: metrics)],
      ),
    ],
  );
}

final class _PaletteBlock extends StatelessWidget {
  const _PaletteBlock({required this.controller, required this.block, required this.metrics});

  final IfThenController controller;
  final Enum block;
  final IfThenMetrics metrics;

  static const _draggingOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    final tile = BlockTile(block: block, metrics: metrics);
    final editable = controller.isEditable;
    final hinted = controller.hint?.action == block;
    final shown = Semantics(
      button: true,
      enabled: editable,
      label: IfThenTexts.paletteBlock(context.l10n, block),
      excludeSemantics: true,
      onTap: context.withTapSound(editable ? () => controller.tapBlock(block) : null),
      child: GestureDetector(
        onTap: context.withTapSound(editable ? () => controller.tapBlock(block) : null),
        child: hinted ? HintGlow(radius: IfThenMetrics.radius, child: tile) : tile,
      ),
    );
    if (!editable) {
      return shown;
    }
    return LongPressDraggable<Enum>(
      data: block,
      feedback: Material(color: Colors.transparent, child: tile),
      childWhenDragging: Opacity(opacity: _draggingOpacity, child: tile),
      child: shown,
    );
  }
}
