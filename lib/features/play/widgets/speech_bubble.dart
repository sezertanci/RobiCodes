import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../../character/character_scope.dart';
import 'idle_sway.dart';

/// Robotun konuşma balonundaki duygu.
enum RobotMood { talk, happy, sad }

/// Robot karakteri ve yanında konuşma balonu. Oyunlar yönergeleri ve geri bildirimi bununla verir.
/// Balonun yüksekliği metin ne kadar kısa veya uzun olursa olsun [_lines] satırlık sabittir; böylece mesaj
/// değişince alttaki harita büyüyüp küçülmez. Daha uzun metin balonun içinde kaydırılır.
final class SpeechBubble extends StatelessWidget {
  const SpeechBubble({required this.message, this.mood = RobotMood.talk, super.key});

  /// Balondaki metin; ekranın o anki dilinde çözülür.
  final LocalizedText message;
  final RobotMood mood;

  static const _robotSize = 64.0;
  static const _lines = 3;
  static const _lineHeight = 1.35;
  static const _padding = EdgeInsets.symmetric(horizontal: 14, vertical: 10);
  static const _border = 3.0;

  Color get _borderColor => switch (mood) {
    RobotMood.talk => AppColors.blue,
    RobotMood.happy => AppColors.green,
    RobotMood.sad => AppColors.red,
  };

  @override
  Widget build(BuildContext context) => Row(
    children: [
      IdleSway(
        child: Image.asset(CharacterScope.of(context).image, width: _robotSize, height: _robotSize),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: _padding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppMetrics.mediumRadius),
            border: Border.all(color: _borderColor, width: _border),
          ),
          child: _text(context),
        ),
      ),
    ],
  );

  /// Metin [_lines] satırlık alanda durur; yazı boyutu büyütülmüşse alan da büyür. Mesaj değişince kaydırma
  /// başa döner.
  Widget _text(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.navy, height: _lineHeight);
    final text = message(context.l10n);
    final lineHeight = MediaQuery.textScalerOf(context).scale(style?.fontSize ?? 16) * _lineHeight;
    return SizedBox(
      height: lineHeight * _lines,
      child: Scrollbar(
        child: SingleChildScrollView(
          key: ValueKey(text),
          child: Semantics(liveRegion: true, child: Text(text, style: style)),
        ),
      ),
    );
  }
}
