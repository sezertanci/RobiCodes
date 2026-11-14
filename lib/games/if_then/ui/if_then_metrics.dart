import 'package:flutter/widgets.dart';

import '../../../app/screen_scale.dart';

/// Kural satırları, kutular ve blokların ölçüleri. Dar ekranda (telefon) web sürümünün küçük
/// ölçüleri, tablette ise ekrana göre büyütülmüş ölçüler kullanılır.
final class IfThenMetrics {
  const IfThenMetrics._({
    required this.ratio,
    required this.conditionSlot,
    required this.actionSlot,
    required this.blockHeight,
    required this.fontSize,
    required this.headFontSize,
    required this.headMinHeight,
    required this.indent,
  });

  factory IfThenMetrics.forWidth(double width, double ratio) {
    final compact = width < compactMaxWidth;
    return IfThenMetrics._(
      ratio: ratio,
      conditionSlot: (compact ? const Size(100, 48) : const Size(112, 52)) * ratio,
      actionSlot: (compact ? const Size(150, 52) : const Size(168, 56)) * ratio,
      blockHeight: (compact ? 48 : 52) * ratio,
      fontSize: (compact ? 16 : 17) * ratio,
      headFontSize: (compact ? 17 : 20) * ratio,
      headMinHeight: (compact ? 56 : 64) * ratio,
      indent: (compact ? 14 : 22) * ratio,
    );
  }

  /// Bu genişliğin altındaki alanlarda küçük ölçüler kullanılır.
  static const compactMaxWidth = ScreenScale.narrowMaxWidth;
  static const radius = 14.0;
  static const gap = 8.0;

  /// Blok ve başlıkların altındaki koyu kabarık kenar.
  static const lip = 4.0;

  final double ratio;
  final Size conditionSlot;
  final Size actionSlot;
  final double blockHeight;
  final double fontSize;
  final double headFontSize;
  final double headMinHeight;
  final double indent;

  double get imageSize => 36 * ratio;
  double get iconSize => 32 * ratio;
}
