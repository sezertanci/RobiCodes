import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';
import '../engine/path_finder_board.dart';
import '../path_finder_controller.dart';
import '../path_finder_texts.dart';
import 'path_finder_assets.dart';

/// Yön tuşları (artı şeklinde) ile Başlat, İpucu ve Temizle düğmeleri.
/// Geniş ekranda düğmeler yön tuşlarının altında, dar ekranda sağında alt alta durur.
final class PathFinderControls extends StatelessWidget {
  const PathFinderControls({required this.controller, required this.buttonSize, required this.stacked, super.key});

  final PathFinderController controller;
  final double buttonSize;

  /// `true` ise eylem düğmeleri yön tuşlarının altında yan yana dizilir.
  final bool stacked;

  static const _stackedGap = 16.0;
  static const _rowGap = 24.0;

  /// Alt alta düzende satır sayısı: yön tuşlarının üç satırı ve eylem düğmeleri.
  static const _stackedRows = 4;

  /// Alt alta düzende her satırdaki düğme sayısı.
  static const _stackedColumns = 3;

  /// Alt alta düzenin [height] yüksekliğe sığması için düğme boyu.
  static double stackedButtonSizeFor(double height) =>
      (height - _stackedGap) / _stackedRows - _ImageButton.padding * 2;

  /// Alt alta düzenin verilen düğme boyundaki genişliği.
  static double stackedWidth(double buttonSize) => (buttonSize + _ImageButton.padding * 2) * _stackedColumns;

  @override
  Widget build(BuildContext context) {
    final pad = _DirectionPad(controller: controller, buttonSize: buttonSize);
    final actions = [
      _ImageButton(
        asset: PathFinderAssets.run,
        label: PathFinderTexts.run,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.run,
      ),
      _ImageButton(
        asset: PathFinderAssets.hint,
        label: PathFinderTexts.hint,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.showHint,
      ),
      _ImageButton(
        asset: PathFinderAssets.clear,
        label: PathFinderTexts.clear,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.clear,
      ),
    ];
    if (stacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [pad, const SizedBox(height: _stackedGap), Row(mainAxisSize: MainAxisSize.min, children: actions)],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [pad, const SizedBox(width: _rowGap), Column(mainAxisSize: MainAxisSize.min, children: actions)],
    );
  }
}

final class _DirectionPad extends StatelessWidget {
  const _DirectionPad({required this.controller, required this.buttonSize});

  final PathFinderController controller;
  final double buttonSize;

  @override
  Widget build(BuildContext context) {
    final enabled = !controller.isRunning && !controller.isFull;
    Widget button(Direction direction) => _ImageButton(
          asset: PathFinderAssets.arrow(direction),
          label: PathFinderTexts.addCommand(direction),
          size: buttonSize,
          highlighted: controller.hint?.direction == direction,
          onPressed: enabled ? () => controller.addCommand(direction) : null,
        );
    final gap = SizedBox.square(dimension: buttonSize + _ImageButton.padding * 2);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [gap, button(Direction.up), gap]),
        Row(mainAxisSize: MainAxisSize.min, children: [button(Direction.left), gap, button(Direction.right)]),
        Row(mainAxisSize: MainAxisSize.min, children: [gap, button(Direction.down), gap]),
      ],
    );
  }
}

/// Görselli düğme. Pasifken soluk görünür; ipucunun önerdiği yön tuşu sarı ışıkla parlar.
final class _ImageButton extends StatelessWidget {
  const _ImageButton({
    required this.asset,
    required this.label,
    required this.size,
    required this.onPressed,
    this.highlighted = false,
  });

  final String asset;
  final String label;
  final double size;
  final VoidCallback? onPressed;
  final bool highlighted;

  static const padding = 2.0;
  static const _disabledOpacity = 0.4;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(padding),
        child: Tooltip(
          message: label,
          child: Semantics(
            button: true,
            enabled: onPressed != null,
            label: label,
            onTap: onPressed,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: onPressed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 3),
                  boxShadow: highlighted ? const [BoxShadow(color: AppColors.yellow, blurRadius: 12, spreadRadius: 4)] : null,
                ),
                child: Opacity(
                  opacity: onPressed == null ? _disabledOpacity : 1,
                  child: SvgPicture.asset(asset),
                ),
              ),
            ),
          ),
        ),
      );
}
