import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../engine/repeat_program.dart';
import '../../../l10n/l10n.dart';
import '../program_models.dart';
import 'call_chip.dart';
import 'inner_block_chip.dart';
import 'repeat_block_view.dart';
import '../../../features/sound/tap_sound.dart';

/// Blok şeridi: oklar ve turuncu tekrar blokları sırayla tek satırda durur, sığmazsa yatay kayar.
/// Bir bloğa dokunmak onu seçer; seçiliyken sağda, sayacın altında "Sil" ve (bloğun içindeki ok için) "Dışarı çıkar"
/// düğmeleri çıkar. Şeridin ve yön tuşlarının ([tapGroup]) dışına dokunulunca seçim kalkar. Çalışan,
/// hatalı, seçili ya da açık blok görünür tutulur. Komut bloğu ([CallBlock]) turkuaz yapboz çipiyle gösterilir.
final class ProgramStrip extends StatefulWidget {
  const ProgramStrip({
    required this.controller,
    required this.chipSize,
    required this.compact,
    this.emptyText,
    this.dropText,
    this.showCounter = true,
    this.active = false,
    this.onActivate,
    this.leading,
    this.holdsRepeat = true,
    super.key,
  });

  final ProgramStripModel controller;
  final double chipSize;

  /// Dar ekranda bloğun etiketi kısalır.
  final bool compact;

  /// Şerit boşken yazan metin; verilmezse "Tekrar Et" metni kullanılır.
  final String? emptyText;

  /// Açık tekrar bloğunun içinde yazan metin; verilmezse "Tekrar Et" metni ("Okları buraya ekle") kullanılır.
  final String? dropText;

  /// Sağ sütunda blok sayacı gösterilir mi.
  final bool showCounter;

  /// Yön tuşları bu şeride ekliyorsa turkuaz çerçeve alır (iki şeritli ekranda).
  final bool active;

  /// Şeride dokunulunca çağrılır; iki şeritli ekranda yön tuşlarını bu şeride yönlendirir.
  final VoidCallback? onActivate;

  /// Şeridin solundaki başlık (ör. komut simgesi).
  final Widget? leading;

  /// Şeride tekrar bloğu eklenebilir mi; eklenemiyorsa şerit onun için yer ayırmaz ve daha alçak olur.
  final bool holdsRepeat;

  /// Etkin şeridin çerçeve rengi ve kalınlığı.
  static const activeColor = AppColors.teal;
  static const _activeBorder = 4.0;

  /// Material kartının varsayılan köşe yarıçapı; çerçeveli kart da aynı köşede kalır.
  static const _cardRadius = 12.0;

  /// Seçimi kaldırmayan dokunma bölgelerinin ortak grubu; yön tuşu seçili oku değiştirebilsin diye
  /// yön tuşları da bu gruptadır.
  static const tapGroup = #repeatProgramEdit;

  static const _gap = 10.0;

  /// Sıra rozetleri için şeridin üstünde bırakılan boşluk.
  static const _badgeRoom = 12.0;

  /// Şeridin yüksekliği; tekrar bloğu eklense de eklenmese de sabittir. Seviyede tekrar bloğu yoksa
  /// ([holdsRepeat] kapalı) onun için yer ayrılmaz.
  static double heightFor(double chipSize, {bool holdsRepeat = true}) =>
      chipSize + (holdsRepeat ? RepeatBlockView.extraHeight : 0) + _badgeRoom * 2;

  @override
  State<ProgramStrip> createState() => _ProgramStripState();
}

final class _ProgramStripState extends State<ProgramStrip> {
  final Map<ProgramPlace, GlobalKey> _keys = {};
  ProgramPlace? _lastFocus;

  ProgramStripModel get _controller => widget.controller;

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
    final strip = TapRegion(
      groupId: ProgramStrip.tapGroup,
      onTapOutside: (_) => _controller.clearSelection(),
      child: Card(
        margin: EdgeInsets.zero,
        shape: widget.active
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ProgramStrip._cardRadius),
                side: const BorderSide(color: ProgramStrip.activeColor, width: ProgramStrip._activeBorder),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (widget.leading case final leading?) ...[leading, const SizedBox(width: 8)],
              Expanded(
                child: SizedBox(
                  height: ProgramStrip.heightFor(widget.chipSize, holdsRepeat: widget.holdsRepeat),
                  child: _list(),
                ),
              ),
              const SizedBox(width: 8),
              _SidePanel(
                controller: _controller,
                buttonSize: widget.chipSize * _editButtonRatio,
                showCounter: widget.showCounter,
              ),
            ],
          ),
        ),
      ),
    );
    final onActivate = widget.onActivate;
    return onActivate == null ? strip : Listener(onPointerDown: (_) => onActivate(), child: strip);
  }

  Widget _list() {
    final program = _controller.program;
    if (program.isEmpty) {
      return Align(alignment: Alignment.centerLeft, child: Text(widget.emptyText ?? context.l10n.repeatEmptyStrip));
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
      InnerBlock() => InnerBlockChip(
        key: _keyOf(place),
        controller: _controller,
        place: place,
        block: block,
        size: widget.chipSize,
        number: index + 1,
      ),
      RepeatBlock() => RepeatBlockView(
        key: _keyOf(place),
        controller: _controller,
        index: index,
        block: block,
        chipSize: widget.chipSize,
        compact: widget.compact,
        keyOf: _keyOf,
        dropText: widget.dropText,
      ),
      CallBlock() => CallChip(
        key: _keyOf(place),
        label: context.l10n.myCommandCallLabel(index + 1),
        number: index + 1,
        size: widget.chipSize,
        selected: _controller.selected == place,
        active: _controller.activeStep?.block == index,
        wrong: _controller.wrongPlace == place,
        onTap: _controller.isRunning ? null : () => _controller.toggleSelection(place),
      ),
    };
  }
}

/// Şeridin sağındaki sütun: blok sayacı ve seçili blok için düzenleme düğmeleri (sil, bloğun
/// içindeki ok için dışarı çıkar ve hazır programı düzeltme kurallarında önüne ekle). Düğmeler şeridin yanında durduğu için seçim yapınca ekranın
/// düzeni değişmez; dar telefonda da harita ve kontroller yerinde kalır.
final class _SidePanel extends StatelessWidget {
  const _SidePanel({required this.controller, required this.buttonSize, required this.showCounter});

  final ProgramStripModel controller;
  final double buttonSize;
  final bool showCounter;

  static const _gap = 6.0;

  @override
  Widget build(BuildContext context) {
    final selected = controller.isRunning ? null : controller.selected;
    final t = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showCounter)
          Text(
            '${controller.blockCount} / ${controller.maxBlocks}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.navy),
          ),
        if (selected != null) ...[
          if (showCounter) const SizedBox(height: _gap),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _button(context, t.repeatDeleteLabel, Icons.delete_outline, AppColors.red, controller.deleteSelected),
              if (Places.isInner(selected)) ...[
                const SizedBox(width: _gap),
                _button(context, t.repeatMoveOutLabel, Icons.logout, AppColors.orangeDark, controller.moveSelectedOut),
              ],
              if (controller.fixesProgram) ...[
                const SizedBox(width: _gap),
                _button(
                  context,
                  t.bugHunterInsertLabel,
                  controller.isInserting ? Icons.add_circle : Icons.add_circle_outline,
                  AppColors.greenDark,
                  controller.canInsert ? controller.toggleInserting : null,
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }

  Widget _button(BuildContext context, String label, IconData icon, Color color, VoidCallback? onPressed) =>
      SizedBox.square(
        dimension: buttonSize,
        child: IconButton.filledTonal(
          tooltip: label,
          onPressed: context.withTapSound(onPressed),
          padding: EdgeInsets.zero,
          iconSize: buttonSize * 0.6,
          color: color,
          icon: Icon(icon),
        ),
      );
}
