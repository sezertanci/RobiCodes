import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../path_finder/ui/command_chip.dart';
import '../engine/repeat_program.dart';
import '../program_models.dart';
import '../repeat_texts.dart';
import 'repeat_assets.dart';
import 'stepper_button.dart';
import '../../../features/sound/tap_sound.dart';

/// Tekrar bloğunun içine de konabilen blok: ok ([CommandChip]) ya da kutu bloğu ([BoxChip]). Seçim, çalışma
/// ve hata durumunu [controller]dan okur. [number] verilirse sıra rozeti görünür (üst düzey bloklar).
final class InnerBlockChip extends StatelessWidget {
  const InnerBlockChip({
    required this.controller,
    required this.place,
    required this.block,
    required this.size,
    this.number,
    super.key,
  });

  final ProgramStripModel controller;
  final ProgramPlace place;
  final InnerBlock block;
  final double size;
  final int? number;

  bool get _active => switch (controller.activeStep) {
    final step? => Places.of(step) == place,
    null => false,
  };

  VoidCallback? get _onTap => controller.isRunning ? null : () => controller.toggleSelection(place);

  @override
  Widget build(BuildContext context) => switch (block) {
    MoveBlock(:final direction) => CommandChip(
      label: RepeatTexts.moveChip(context.l10n, place, direction),
      number: number,
      direction: direction,
      size: size,
      selected: controller.selected == place,
      active: _active,
      wrong: controller.wrongPlace == place,
      onTap: _onTap,
    ),
    _ => BoxChip(
      controller: controller,
      place: place,
      block: block,
      size: size,
      number: number,
      active: _active,
      onTap: _onTap,
    ),
  };
}

/// Altın renkli kutu bloğu: küçük kutu simgesi ve "= 3", "+1" ya da "−1" işareti. "kutu = N" bloğunda iki yanda
/// sayıyı değiştiren − / + düğmeleri bulunur. Seçiliyse lacivert, hatalıysa kırmızı çerçeve alır; çalışırken
/// sarı zeminle parlar.
final class BoxChip extends StatelessWidget {
  const BoxChip({
    required this.controller,
    required this.place,
    required this.block,
    required this.size,
    required this.active,
    required this.onTap,
    this.number,
    super.key,
  });

  final ProgramStripModel controller;
  final ProgramPlace place;
  final InnerBlock block;
  final double size;
  final bool active;
  final VoidCallback? onTap;
  final int? number;

  static const _background = Color(0xFFFFF1C2);
  static const _radius = 14.0;
  static const _border = 3.0;
  static const _iconRatio = 0.5;
  static const _textRatio = 0.34;
  static const _stepperRatio = 0.5;
  static const _gap = 4.0;

  Color get _borderColor {
    if (controller.wrongPlace == place) {
      return AppColors.red;
    }
    return controller.selected == place ? AppColors.navy : AppColors.yellowDark;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final value = switch (block) {
      SetBoxBlock(:final value) => value,
      _ => null,
    };
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: context.withTapSound(onTap),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: size,
            constraints: BoxConstraints(minWidth: size),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: active ? AppColors.yellow : _background,
              borderRadius: BorderRadius.circular(_radius),
              border: Border.all(color: _borderColor, width: _border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (value != null) ...[_stepper(t.variableBoxDecrease, -1, value), const SizedBox(width: _gap)],
                _face(context, t),
                if (value != null) ...[const SizedBox(width: _gap), _stepper(t.variableBoxIncrease, 1, value)],
              ],
            ),
          ),
        ),
        if (number case final number?) Positioned(left: -6, top: -8, child: NumberBadge(number)),
      ],
    );
  }

  Widget _face(BuildContext context, AppLocalizations t) => Semantics(
    button: true,
    selected: controller.selected == place,
    label: RepeatTexts.boxChip(t, place, block),
    excludeSemantics: true,
    onTap: context.withTapSound(onTap),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(RepeatAssets.box, width: size * _iconRatio, height: size * _iconRatio),
        Text(
          RepeatTexts.boxSign(block),
          style: TextStyle(fontSize: size * _textRatio, fontWeight: FontWeight.w900, color: AppColors.navy, height: 1),
        ),
      ],
    ),
  );

  Widget _stepper(String label, int offset, int value) {
    final next = value + offset;
    final allowed = !controller.isRunning && next >= BoxRules.minValue && next <= BoxRules.maxValue;
    return StepperButton(
      text: offset < 0 ? StepperButton.decrease : StepperButton.increase,
      label: label,
      size: size * _stepperRatio,
      color: AppColors.yellowDark,
      onPressed: allowed ? () => controller.changeBoxValue(place, offset) : null,
    );
  }
}

/// Şeridin solunda kutunun o anki sayısını gösteren büyük kutu rozeti. Sayı kahverengi gövdede okunsun diye beyazdır.
final class BoxBadge extends StatelessWidget {
  const BoxBadge({required this.value, required this.size, super.key});

  final int value;
  final double size;

  static const _textRatio = 0.4;

  /// Sayı kutunun gövdesine otursun diye ortadan bu oranda aşağı kayar.
  static const _bodyOffset = 0.3;

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.l10n.variableBoxBadge(value),
    excludeSemantics: true,
    child: SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(RepeatAssets.box, width: size, height: size),
          Padding(
            padding: EdgeInsets.only(top: size * _bodyOffset),
            child: Text(
              '$value',
              style: TextStyle(fontSize: size * _textRatio, fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
