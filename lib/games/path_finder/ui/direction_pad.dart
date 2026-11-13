import 'package:flutter/material.dart';

import '../../../features/play/widgets/image_button.dart';
import '../engine/path_finder_board.dart';
import 'path_finder_assets.dart';

/// Artı şeklinde dört yön tuşu. "Robotun Yolunu Bul" ve "Tekrar Et" ortak kullanır.
/// [highlighted] yön, ipucunun önerdiği tuştur ve sarı ışıkla parlar.
final class DirectionPad extends StatelessWidget {
  const DirectionPad({
    required this.buttonSize,
    required this.enabled,
    required this.label,
    required this.onPressed,
    this.highlighted,
    super.key,
  });

  final double buttonSize;
  final bool enabled;

  /// Tuşun ekran okuyucu etiketi ve ipucu metni.
  final String Function(Direction direction) label;
  final ValueChanged<Direction> onPressed;
  final Direction? highlighted;

  /// Yön tuşlarının kapladığı satır ve sütun sayısı.
  static const gridSize = 3;

  /// Verilen düğme boyunda yön tuşlarının kapladığı kenar uzunluğu.
  static double extent(double buttonSize) => (buttonSize + ImageButton.padding * 2) * gridSize;

  @override
  Widget build(BuildContext context) {
    Widget button(Direction direction) => ImageButton(
      asset: PathFinderAssets.arrow(direction),
      label: label(direction),
      size: buttonSize,
      highlighted: highlighted == direction,
      onPressed: enabled ? () => onPressed(direction) : null,
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
