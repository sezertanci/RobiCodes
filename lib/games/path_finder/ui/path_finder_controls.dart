import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../features/play/widgets/image_button.dart';
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
      (height - _stackedGap) / _stackedRows - ImageButton.padding * 2;

  /// Alt alta düzenin verilen düğme boyundaki genişliği.
  static double stackedWidth(double buttonSize) => (buttonSize + ImageButton.padding * 2) * _stackedColumns;

  @override
  Widget build(BuildContext context) {
    final pad = _DirectionPad(controller: controller, buttonSize: buttonSize);
    final actions = [
      ImageButton(
        asset: PathFinderAssets.run,
        label: PathFinderTexts.run,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.run,
      ),
      ImageButton(
        asset: AppAssets.hintButton,
        label: PathFinderTexts.hint,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.showHint,
      ),
      ImageButton(
        asset: AppAssets.clearButton,
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
    Widget button(Direction direction) => ImageButton(
          asset: PathFinderAssets.arrow(direction),
          label: PathFinderTexts.addCommand(direction),
          size: buttonSize,
          highlighted: controller.hint?.direction == direction,
          onPressed: enabled ? () => controller.addCommand(direction) : null,
        );
    final gap = SizedBox.square(dimension: buttonSize + ImageButton.padding * 2);
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

