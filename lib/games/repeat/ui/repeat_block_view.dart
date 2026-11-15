import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/widgets/dashed_frame.dart';
import '../../path_finder/engine/path_finder_board.dart';
import '../../path_finder/ui/command_chip.dart';
import '../engine/repeat_program.dart';
import '../../../l10n/l10n.dart';
import '../program_models.dart';
import '../repeat_texts.dart';
import 'repeat_assets.dart';

/// Turuncu "N kez tekrarla" bloğu. Başlıkta sıra rozeti, −/+ düğmeleri, etiket ve çalışırken tur
/// rozeti; yanında gövdede içindeki oklar durur. Etikete dokunmak bloğu açar (oklar içine eklenir),
/// bloğun boş yerine dokunmak onu seçer. Kenar halkası: açıksa yeşil, seçiliyse lacivert, çalışıyorsa
/// sarı, hatalıysa kırmızı.
final class RepeatBlockView extends StatelessWidget {
  const RepeatBlockView({
    required this.controller,
    required this.index,
    required this.block,
    required this.chipSize,
    required this.compact,
    required this.keyOf,
    super.key,
  });

  final ProgramStripModel controller;
  final int index;
  final RepeatBlock block;
  final double chipSize;

  /// Dar ekranda etiketteki "tekrarla" kelimesi gizlenir.
  final bool compact;

  /// Şeridin odaklanan yeri kaydırıp gösterebilmesi için her okun anahtarı.
  final GlobalKey Function(ProgramPlace place) keyOf;

  static const _background = Color(0xFFFFE2C4);
  static const _border = 4.0;
  static const _ring = 5.0;
  static const _radius = 20.0;
  static const _gap = 8.0;

  /// Bloğun kendi yüksekliği okun boyundan bu kadar fazladır (iç boşluklar ve kenar).
  static const extraHeight = 34.0;

  ProgramPlace get _place => Places.top(index);
  bool get _isTarget => controller.target == index;
  bool get _isRunning => controller.activeStep?.block == index;

  Color? get _ringColor {
    if (controller.wrongPlace == _place) {
      return AppColors.red;
    }
    if (_isRunning) {
      return AppColors.yellow;
    }
    if (_isTarget) {
      return AppColors.green;
    }
    return controller.selected == _place ? AppColors.navy : null;
  }

  @override
  Widget build(BuildContext context) {
    final ring = _ringColor;
    return GestureDetector(
      onTap: controller.isRunning ? null : () => controller.toggleSelection(_place),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: AppColors.orange, width: _border),
          boxShadow: [if (ring != null) BoxShadow(color: ring, spreadRadius: _ring)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _head(context),
            const SizedBox(width: _gap + 2),
            _body(context),
          ],
        ),
      ),
    );
  }

  Widget _head(BuildContext context) {
    final step = controller.activeStep;
    final editable = !controller.isRunning;
    final t = context.l10n;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TimesButton(
              text: '−',
              label: t.repeatDecrease,
              size: chipSize * 0.8,
              onPressed: editable && block.times > RepeatBlock.minTimes
                  ? () => controller.changeTimes(index, -1)
                  : null,
            ),
            const SizedBox(width: 6),
            _label(t, editable),
            const SizedBox(width: 6),
            _TimesButton(
              text: '+',
              label: t.repeatIncrease,
              size: chipSize * 0.8,
              onPressed: editable && block.times < RepeatBlock.maxTimes ? () => controller.changeTimes(index, 1) : null,
            ),
            if (step != null && _isRunning) ...[const SizedBox(width: 6), _RoundBadge(step.round, block.times)],
          ],
        ),
        Positioned(left: -16, top: -16, child: NumberBadge(index + 1)),
      ],
    );
  }

  Widget _label(AppLocalizations t, bool editable) => Semantics(
    button: true,
    selected: _isTarget,
    label: RepeatTexts.repeatLabel(t, index, block.times),
    excludeSemantics: true,
    child: GestureDetector(
      onTap: editable ? () => controller.toggleTarget(index) : null,
      child: Container(
        height: chipSize * 0.88,
        padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: AppColors.orangeDark, offset: Offset(0, 4))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepeatIcon(size: chipSize * 0.56),
            const SizedBox(width: 6),
            Text(compact ? t.repeatTimes(block.times) : t.repeatTimesFull(block.times), style: _labelStyle),
          ],
        ),
      ),
    ),
  );

  static const _labelStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    shadows: [Shadow(color: AppColors.orangeDark, offset: Offset(0, 2))],
  );

  Widget _body(BuildContext context) {
    final showDrop = (_isTarget && !controller.isFull) || block.body.isEmpty;
    return Container(
      height: chipSize + 8,
      padding: const EdgeInsets.fromLTRB(14, 4, 4, 4),
      decoration: BoxDecoration(
        border: const Border(left: BorderSide(color: AppColors.orange, width: 6)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (inner, direction) in block.body.indexed) ...[
            if (inner > 0) const SizedBox(width: _gap),
            _innerChip(context, inner, direction),
          ],
          if (showDrop) ...[
            if (block.body.isNotEmpty) const SizedBox(width: _gap),
            _DropHint(
              text: _isTarget && !controller.isFull ? context.l10n.repeatDropHere : context.l10n.repeatEmptyBody,
              size: chipSize,
            ),
          ],
        ],
      ),
    );
  }

  Widget _innerChip(BuildContext context, int inner, Direction direction) {
    final place = (block: index, inner: inner);
    final step = controller.activeStep;
    return CommandChip(
      key: keyOf(place),
      label: RepeatTexts.moveChip(context.l10n, place, direction),
      direction: direction,
      size: chipSize,
      selected: controller.selected == place,
      active: step != null && Places.of(step) == place,
      wrong: controller.wrongPlace == place,
      onTap: controller.isRunning ? null : () => controller.toggleSelection(place),
    );
  }
}

/// Döngü simgesi; turuncu zeminde kaybolmasın diye beyaz daire içinde durur.
final class RepeatIcon extends StatelessWidget {
  const RepeatIcon({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    padding: const EdgeInsets.all(2),
    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
    child: SvgPicture.asset(RepeatAssets.icon),
  );
}

/// Tekrar sayısını değiştiren beyaz yuvarlak − / + düğmesi.
final class _TimesButton extends StatelessWidget {
  const _TimesButton({required this.text, required this.label, required this.size, required this.onPressed});

  final String text;
  final String label;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: label,
    excludeSemantics: true,
    child: GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? 0.4 : 1,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.orangeDark, offset: Offset(0, 3))],
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: size * 0.6, fontWeight: FontWeight.w900, color: AppColors.orangeDark, height: 1),
          ),
        ),
      ),
    ),
  );
}

/// Çalışırken kaçıncı turda olunduğunu gösteren sarı rozet.
final class _RoundBadge extends StatelessWidget {
  const _RoundBadge(this.round, this.times);

  final int round;
  final int times;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(999)),
    child: Text(
      RepeatTexts.round(round, times),
      style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.navy),
    ),
  );
}

/// Bloğun gövdesindeki kesik turuncu çerçeveli "Okları buraya ekle" ya da "Boş" yazısı.
final class _DropHint extends StatelessWidget {
  const _DropHint({required this.text, required this.size});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: size,
    child: Stack(
      children: [
        const Positioned.fill(child: DashedFrame(color: AppColors.orange)),
        Container(
          constraints: BoxConstraints(minWidth: size),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.orangeDark),
          ),
        ),
      ],
    ),
  );
}
