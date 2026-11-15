import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../path_finder/ui/command_chip.dart';
import '../engine/repeat_program.dart';
import '../../../l10n/l10n.dart';
import '../repeat_controller.dart';
import '../repeat_texts.dart';
import 'repeat_block_view.dart';

/// Blok şeridi: oklar ve turuncu tekrar blokları sırayla tek satırda durur, sığmazsa yatay kayar.
/// Bir bloğa dokunmak onu seçer; seçiliyken sağda, sayacın altında "Sil" ve (bloğun içindeki ok için) "Dışarı çıkar"
/// düğmeleri çıkar. Şeridin dışına dokunulunca seçim kalkar. Çalışan, hatalı, seçili ya da açık
/// blok görünür tutulur.
final class ProgramStrip extends StatefulWidget {
  const ProgramStrip({required this.controller, required this.chipSize, required this.compact, super.key});

  final RepeatController controller;
  final double chipSize;

  /// Dar ekranda bloğun etiketi kısalır.
  final bool compact;

  static const _gap = 10.0;

  /// Sıra rozetleri için şeridin üstünde bırakılan boşluk.
  static const _badgeRoom = 12.0;

  /// Şeridin yüksekliği; tekrar bloğu olsa da olmasa da sabittir.
  static double heightFor(double chipSize) => chipSize + RepeatBlockView.extraHeight + _badgeRoom * 2;

  @override
  State<ProgramStrip> createState() => _ProgramStripState();
}

final class _ProgramStripState extends State<ProgramStrip> {
  final Map<ProgramPlace, GlobalKey> _keys = {};
  ProgramPlace? _lastFocus;

  RepeatController get _controller => widget.controller;

  /// Düzenleme düğmelerinin blok boyuna oranı; iki düğme ile sayaç şeridin yüksekliğine sığar.
  static const _editButtonRatio = 0.8;

  GlobalKey _keyOf(ProgramPlace place) => _keys.putIfAbsent(place, GlobalKey.new);

  ProgramPlace? get _focus {
    if (_controller.activeStep case final step?) {
      return Places.of(step);
    }
    final target = _controller.target;
    return _controller.wrongPlace ?? _controller.selected ?? (target == null ? null : Places.top(target));
  }

  /// Odaklanan yer değiştiyse şerit onu ortaya getirecek kadar kaydırılır.
  void _revealFocus() {
    final focus = _focus;
    if (focus == null || focus == _lastFocus) {
      _lastFocus = focus;
      return;
    }
    _lastFocus = focus;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _keys[focus]?.currentContext;
      if (context != null && context.mounted) {
        Scrollable.ensureVisible(context, alignment: 0.5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _revealFocus();
    return TapRegion(
      onTapOutside: (_) => _controller.clearSelection(),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(height: ProgramStrip.heightFor(widget.chipSize), child: _list()),
              ),
              const SizedBox(width: 8),
              _SidePanel(controller: _controller, buttonSize: widget.chipSize * _editButtonRatio),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list() {
    final program = _controller.program;
    if (program.isEmpty) {
      return Align(alignment: Alignment.centerLeft, child: Text(context.l10n.repeatEmptyStrip));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: ProgramStrip._badgeRoom),
      child: Row(
        children: [
          for (final (index, block) in program.indexed) ...[
            if (index > 0) const SizedBox(width: ProgramStrip._gap),
            _block(index, block),
          ],
        ],
      ),
    );
  }

  Widget _block(int index, ProgramBlock block) {
    final place = Places.top(index);
    return switch (block) {
      MoveBlock(:final direction) => CommandChip(
        key: _keyOf(place),
        label: RepeatTexts.moveChip(context.l10n, place, direction),
        number: index + 1,
        direction: direction,
        size: widget.chipSize,
        selected: _controller.selected == place,
        active: _controller.activeStep?.block == index,
        wrong: _controller.wrongPlace == place,
        onTap: _controller.isRunning ? null : () => _controller.toggleSelection(place),
      ),
      RepeatBlock() => RepeatBlockView(
        key: _keyOf(place),
        controller: _controller,
        index: index,
        block: block,
        chipSize: widget.chipSize,
        compact: widget.compact,
        keyOf: _keyOf,
      ),
    };
  }
}

/// Şeridin sağındaki sütun: blok sayacı ve seçili blok için düzenleme düğmeleri (sil ve, bloğun
/// içindeki ok için, dışarı çıkar). Düğmeler şeridin yanında durduğu için seçim yapınca ekranın
/// düzeni değişmez; dar telefonda da harita ve kontroller yerinde kalır.
final class _SidePanel extends StatelessWidget {
  const _SidePanel({required this.controller, required this.buttonSize});

  final RepeatController controller;
  final double buttonSize;

  static const _gap = 6.0;

  @override
  Widget build(BuildContext context) {
    final selected = controller.isRunning ? null : controller.selected;
    final t = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${controller.blockCount} / ${controller.maxBlocks}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.navy),
        ),
        if (selected != null) ...[
          const SizedBox(height: _gap),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _button(t.repeatDeleteLabel, Icons.delete_outline, AppColors.red, controller.deleteSelected),
              if (Places.isInner(selected)) ...[
                const SizedBox(width: _gap),
                _button(t.repeatMoveOutLabel, Icons.logout, AppColors.orangeDark, controller.moveSelectedOut),
              ],
            ],
          ),
        ],
      ],
    );
  }

  Widget _button(String label, IconData icon, Color color, VoidCallback onPressed) => SizedBox.square(
    dimension: buttonSize,
    child: IconButton.filledTonal(
      tooltip: label,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      iconSize: buttonSize * 0.6,
      color: color,
      icon: Icon(icon),
    ),
  );
}
