import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../engine/path_finder_board.dart';
import '../path_finder_controller.dart';
import '../path_finder_texts.dart';
import 'command_chip.dart';

/// Komut şeridi: eklenen komutlar sırayla görünür. Komuta dokunmak onu seçer; seçili komut
/// sola/sağa taşınabilir ya da silinebilir. Komuta basılı tutup sürükleyerek de yeri değişir.
/// Şeridin dışına dokunulunca seçim kalkar.
final class CommandStrip extends StatefulWidget {
  const CommandStrip({required this.controller, required this.chipSize, super.key});

  final PathFinderController controller;
  final double chipSize;

  static const _gap = 8.0;

  @override
  State<CommandStrip> createState() => _CommandStripState();
}

final class _CommandStripState extends State<CommandStrip> {
  final ScrollController _scroll = ScrollController();
  int? _lastFocus;

  PathFinderController get _controller => widget.controller;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  /// Çalışan, hatalı ya da seçili komut şeritte görünür hale getirilir.
  void _revealFocus() {
    final focus = _controller.activeIndex ?? _controller.wrongIndex ?? _controller.selectedIndex;
    if (focus == null || focus == _lastFocus) {
      _lastFocus = focus;
      return;
    }
    _lastFocus = focus;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) {
        return;
      }
      final position = _scroll.position;
      final itemStart = focus * (widget.chipSize + CommandStrip._gap);
      final target = (itemStart - (position.viewportDimension - widget.chipSize) / 2).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );
      _scroll.jumpTo(target);
    });
  }

  @override
  Widget build(BuildContext context) {
    _revealFocus();
    final commands = _controller.commands;
    return TapRegion(
      onTapOutside: (_) => _controller.clearSelection(),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(height: widget.chipSize + 8, child: _list(commands)),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${commands.length} / ${_controller.commandLimit}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.navy),
                  ),
                ],
              ),
              if (_controller.selectedIndex != null && !_controller.isRunning) _EditBar(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list(List<Direction> commands) {
    if (commands.isEmpty) {
      return Align(alignment: Alignment.centerLeft, child: Text(context.l10n.pathFinderEmptyStrip));
    }
    // Listenin boş kısmına bırakılan komut sona gider.
    return DragTarget<int>(
      onAcceptWithDetails: (details) => _controller.reorder(details.data, null),
      builder: (context, _, _) => ListView.separated(
        controller: _scroll,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 8),
        itemCount: commands.length,
        separatorBuilder: (_, _) => const SizedBox(width: CommandStrip._gap),
        itemBuilder: (context, index) => _draggableChip(index, commands[index]),
      ),
    );
  }

  Widget _draggableChip(int index, Direction direction) {
    final chip = CommandChip(
      label: PathFinderTexts.commandChip(context.l10n, index, direction),
      number: index + 1,
      direction: direction,
      size: widget.chipSize,
      selected: index == _controller.selectedIndex,
      active: index == _controller.activeIndex,
      wrong: index == _controller.wrongIndex,
      onTap: _controller.isRunning ? null : () => _controller.toggleSelection(index),
    );
    if (_controller.isRunning) {
      return chip;
    }
    // Sürüklenen komut, bırakıldığı komutun yerine geçer.
    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != index,
      onAcceptWithDetails: (details) => _controller.reorder(details.data, index),
      builder: (context, candidates, _) => LongPressDraggable<int>(
        data: index,
        feedback: Material(color: Colors.transparent, child: chip),
        childWhenDragging: Opacity(opacity: 0.3, child: chip),
        child: candidates.isEmpty ? chip : Opacity(opacity: 0.6, child: chip),
      ),
    );
  }
}

/// Seçili komutun düzenleme düğmeleri: sola taşı, sağa taşı ve sil.
final class _EditBar extends StatelessWidget {
  const _EditBar({required this.controller});

  final PathFinderController controller;

  @override
  Widget build(BuildContext context) {
    final index = controller.selectedIndex!;
    final t = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          _button(
            label: t.pathFinderMoveLeft,
            text: PathFinderTexts.direction(t, Direction.left),
            icon: Icons.arrow_back_rounded,
            onPressed: index == 0 ? null : () => controller.moveSelected(-1),
          ),
          _button(
            label: t.pathFinderMoveRight,
            text: PathFinderTexts.direction(t, Direction.right),
            icon: Icons.arrow_forward_rounded,
            onPressed: index == controller.commands.length - 1 ? null : () => controller.moveSelected(1),
          ),
          _button(
            label: t.commonDelete,
            text: t.commonDelete,
            icon: Icons.close_rounded,
            onPressed: controller.deleteSelected,
            color: AppColors.red,
          ),
        ],
      ),
    );
  }

  static Widget _button({
    required String label,
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
    Color? color,
  }) => Tooltip(
    message: label,
    child: FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: color == null ? null : FilledButton.styleFrom(foregroundColor: color),
    ),
  );
}
