import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../l10n/l10n.dart';
import '../path_finder_controller.dart';
import '../path_finder_texts.dart';
import 'direction_pad.dart';

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

  /// Alt alta düzenin [height] yüksekliğe sığması için düğme boyu.
  static double stackedButtonSizeFor(double height) => (height - _stackedGap) / _stackedRows - ImageButton.padding * 2;

  /// Alt alta düzenin verilen düğme boyundaki genişliği.
  static double stackedWidth(double buttonSize) => DirectionPad.extent(buttonSize);

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final pad = DirectionPad(
      buttonSize: buttonSize,
      enabled: !controller.isRunning && !controller.isFull,
      highlighted: controller.hint?.direction,
      label: (direction) => PathFinderTexts.addCommand(t, direction),
      onPressed: controller.addCommand,
    );
    final actions = [
      ImageButton(
        asset: AppAssets.runButton,
        label: t.commonRun,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.run,
      ),
      ImageButton(
        asset: AppAssets.hintButton,
        label: t.commonHint,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.showHint,
      ),
      ImageButton(
        asset: AppAssets.clearButton,
        label: t.commonClear,
        size: buttonSize,
        onPressed: controller.isRunning ? null : controller.clear,
      ),
    ];
    if (stacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pad,
          const SizedBox(height: _stackedGap),
          Row(mainAxisSize: MainAxisSize.min, children: actions),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        pad,
        const SizedBox(width: _rowGap),
        Column(mainAxisSize: MainAxisSize.min, children: actions),
      ],
    );
  }
}
