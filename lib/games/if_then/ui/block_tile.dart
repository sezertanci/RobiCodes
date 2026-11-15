import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';
import '../engine/if_then_level.dart';
import '../../../l10n/l10n.dart';
import '../if_then_texts.dart';
import 'if_then_assets.dart';
import 'if_then_metrics.dart';

/// Bir bloğun görünüşü. Nesne blokları beyazdır ve nesnenin resmini taşır; hareket blokları
/// renklidir ve hareketin simgesini taşır. Paletteki ve kutulardaki bloklar aynı görünür.
final class BlockTile extends StatelessWidget {
  const BlockTile({required this.block, required this.metrics, super.key});

  /// [LaneObject] veya [LaneAction].
  final Enum block;
  final IfThenMetrics metrics;

  static const _padding = 12.0;
  static const _textShadow = Offset(0, 2);

  @override
  Widget build(BuildContext context) {
    final block = this.block;
    final (fill, dark, text) = block is LaneAction ? _tone(block) : (Colors.white, AppColors.shadow, AppColors.navy);
    final (image, imageSize) = block is LaneAction
        ? (IfThenAssets.actionOf(block), metrics.iconSize)
        : (IfThenAssets.objectOf(block as LaneObject), metrics.imageSize);
    final picture = SvgPicture.asset(image, width: imageSize, height: imageSize);
    final caption = Text(
      IfThenTexts.label(context.l10n, block),
      maxLines: 1,
      style: TextStyle(
        fontSize: metrics.fontSize,
        fontWeight: FontWeight.w800,
        color: text,
        shadows: block is LaneAction && text == Colors.white ? [Shadow(color: dark, offset: _textShadow)] : null,
      ),
    );
    final iconAtEnd = block == LaneAction.forward;
    return Container(
      constraints: BoxConstraints(minHeight: metrics.blockHeight),
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(IfThenMetrics.radius),
        boxShadow: [BoxShadow(color: dark, offset: const Offset(0, IfThenMetrics.lip))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: IfThenMetrics.gap - 2,
        children: iconAtEnd ? [caption, picture] : [picture, caption],
      ),
    );
  }

  /// Hareket bloğunun rengi, koyu tonu ve yazı rengi. Sarı blokta yazı lacivert olur.
  static (Color, Color, Color) _tone(LaneAction action) => switch (action) {
    LaneAction.forward => (AppColors.green, AppColors.greenDark, Colors.white),
    LaneAction.jump => (AppColors.orange, AppColors.orangeDark, Colors.white),
    LaneAction.bridge => (AppColors.blue, AppColors.blueDark, Colors.white),
    LaneAction.open => (AppColors.purple, AppColors.purpleDark, Colors.white),
    LaneAction.collect => (AppColors.yellow, AppColors.yellowDark, AppColors.navy),
  };
}
