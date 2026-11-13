import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/widgets/group_tone.dart';
import '../engine/command_order_engine.dart';
import 'card_metrics.dart';
import 'step_image.dart';

/// Adım kartı: üstte eylemi anlatan büyük görsel, altta kısa yazı. Kartın rengi karışık sıradaki
/// yerine göre beş renkten biridir (web sürümündeki gibi).
final class OrderCardTile extends StatelessWidget {
  const OrderCardTile({
    required this.card,
    required this.position,
    required this.metrics,
    required this.label,
    required this.onTap,
    super.key,
  });

  final OrderCard card;

  /// Kartın karışık sıradaki yeri.
  final int position;
  final CardMetrics metrics;

  /// Ekran okuyucunun söylediği metin.
  final String label;
  final VoidCallback? onTap;

  static const tones = [
    GroupTone(AppColors.blue, AppColors.blueDark),
    GroupTone(AppColors.green, AppColors.greenDark),
    GroupTone(AppColors.orange, AppColors.orangeDark),
    GroupTone(AppColors.purple, AppColors.purpleDark),
    GroupTone(AppColors.red, AppColors.redDark),
  ];

  static const _artRadius = 14.0;
  static const _textGap = 4.0;

  @override
  Widget build(BuildContext context) {
    final tone = tones[position % tones.length];
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: label,
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: metrics.width,
          height: metrics.height,
          padding: EdgeInsets.all(metrics.padding),
          decoration: BoxDecoration(
            color: tone.color,
            borderRadius: BorderRadius.circular(CardMetrics.radius),
            boxShadow: [BoxShadow(color: tone.dark, offset: const Offset(0, CardMetrics.lip))],
          ),
          child: Column(
            children: [
              Container(
                width: metrics.art,
                height: metrics.art,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_artRadius)),
                clipBehavior: Clip.antiAlias,
                child: StepImage(card.icon, size: metrics.art),
              ),
              const SizedBox(height: _textGap),
              Expanded(child: Center(child: _text(tone))),
            ],
          ),
        ),
      ),
    );
  }

  /// Yazı kalan alana sığmazsa küçülür.
  Widget _text(GroupTone tone) => FittedBox(
    fit: BoxFit.scaleDown,
    child: SizedBox(
      width: metrics.width - metrics.padding * 2,
      child: Text(
        card.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: metrics.fontSize,
          fontWeight: FontWeight.w800,
          height: 1.15,
          color: Colors.white,
          shadows: [Shadow(color: tone.dark, offset: const Offset(0, 2))],
        ),
      ),
    ),
  );
}
