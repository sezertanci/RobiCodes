import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../path_finder/ui/direction_pad.dart';
import '../repeat_controller.dart';
import '../repeat_texts.dart';
import 'repeat_block_view.dart';

/// Yön tuşları, Tekrarla düğmesi ile Başlat, İpucu ve Temizle düğmeleri.
/// Geniş ekranda düğmeler yön tuşlarının altında durur: üstte tam satır Tekrarla, altında üç düğme.
/// Dar ekranda yön tuşlarının sağında Tekrarla üstte, Başlat ile İpucu ortada, Temizle altta durur.
final class RepeatControls extends StatelessWidget {
  const RepeatControls({required this.controller, required this.buttonSize, required this.stacked, super.key});

  final RepeatController controller;
  final double buttonSize;

  /// `true` ise düğmeler yön tuşlarının altında dizilir.
  final bool stacked;

  static const _stackedGap = 16.0;
  static const _rowGap = 24.0;

  /// Tekrarla düğmesinin yüksekliğinin düğme boyuna oranı.
  static const _repeatHeightRatio = 0.8;

  /// Alt alta düzende düğme boyunda satır sayısı: yön tuşlarının üç satırı ve eylem düğmeleri.
  static const _stackedRows = 4;

  /// Alt alta düzenin [height] yüksekliğe sığması için düğme boyu.
  static double stackedButtonSizeFor(double height) =>
      (height - _stackedGap - ImageButton.padding * 2 * (_stackedRows + 1)) / (_stackedRows + _repeatHeightRatio);

  /// Alt alta düzenin verilen düğme boyundaki genişliği.
  static double stackedWidth(double buttonSize) => DirectionPad.extent(buttonSize);

  double get _cell => buttonSize + ImageButton.padding * 2;

  @override
  Widget build(BuildContext context) {
    final pad = DirectionPad(
      buttonSize: buttonSize,
      enabled: controller.canAddMove,
      highlighted: controller.hint?.direction,
      label: RepeatTexts.addMove,
      onPressed: controller.addMove,
    );
    final run = _action(AppAssets.runButton, RepeatTexts.run, controller.run);
    final hint = _action(AppAssets.hintButton, RepeatTexts.hint, controller.showHint);
    final clear = _action(AppAssets.clearButton, RepeatTexts.clear, controller.clear);
    if (stacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pad,
          const SizedBox(height: _stackedGap),
          _repeatButton(columns: DirectionPad.gridSize),
          Row(mainAxisSize: MainAxisSize.min, children: [run, hint, clear]),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        pad,
        const SizedBox(width: _rowGap),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _repeatButton(columns: 2),
            Row(mainAxisSize: MainAxisSize.min, children: [run, hint]),
            clear,
          ],
        ),
      ],
    );
  }

  Widget _action(String asset, String label, VoidCallback onPressed) =>
      ImageButton(asset: asset, label: label, size: buttonSize, onPressed: controller.isRunning ? null : onPressed);

  Widget _repeatButton({required int columns}) => Padding(
    padding: const EdgeInsets.all(ImageButton.padding),
    child: RepeatButton(
      leaving: controller.target != null,
      width: _cell * columns - ImageButton.padding * 2,
      height: buttonSize * _repeatHeightRatio,
      onPressed: controller.canUseRepeatButton ? controller.pressRepeatButton : null,
    ),
  );
}

/// Turuncu "Tekrarla" düğmesi. Blok açıkken lacivert "Bloktan çık" olur ve döngü simgesi gizlenir;
/// böylece yeşil Başlat ve mavi yön tuşlarıyla karışmaz.
final class RepeatButton extends StatelessWidget {
  const RepeatButton({
    required this.leaving,
    required this.width,
    required this.height,
    required this.onPressed,
    super.key,
  });

  final bool leaving;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  static const _navyDark = Color(0xFF111A30);
  static const _disabledOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final color = leaving ? AppColors.navy : AppColors.orange;
    final dark = leaving ? _navyDark : AppColors.orangeDark;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: leaving ? RepeatTexts.leaveRepeatLabel : RepeatTexts.addRepeatLabel,
      excludeSemantics: true,
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? _disabledOpacity : 1,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: dark, offset: const Offset(0, 4))],
            ),
            child: FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!leaving) ...[RepeatIcon(size: height * 0.6), const SizedBox(width: 8)],
                  Text(
                    leaving ? RepeatTexts.leaveRepeat : RepeatTexts.addRepeat,
                    style: TextStyle(
                      fontSize: height * 0.36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [Shadow(color: dark, offset: const Offset(0, 2))],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
