import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import 'group_tone.dart';

/// Bir zorluk grubunun paneli: grubun renginde başlık şeridi, tamamlanan seviye rozeti, kilitliyse
/// uyarı ve seviye satırları. Kilitli grup soluk görünür. Görünüm web sürümüyle aynıdır.
final class LevelGroupPanel extends StatelessWidget {
  const LevelGroupPanel({
    required this.title,
    required this.tone,
    required this.unlocked,
    required this.progressText,
    required this.levels,
    this.hint,
    super.key,
  });

  final String title;
  final GroupTone tone;
  final bool unlocked;

  /// Açık grupta rozette gösterilen "tamamlanan/toplam" metni.
  final String progressText;
  final String? hint;
  final List<Widget> levels;

  static const _radius = 28.0;
  static const _border = 4.0;
  static const _lip = 6.0;
  static const _bodyTint = 0.14;
  static const _lockedBodyTint = 0.06;
  static const _lockedEdgeTint = 0.55;
  static const _listPadding = 14.0;
  static const _rowGap = 10.0;

  @override
  Widget build(BuildContext context) {
    final edge = unlocked ? tone.color : tone.tint(_lockedEdgeTint);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: tone.tint(unlocked ? _bodyTint : _lockedBodyTint),
        border: Border.all(color: edge, width: _border),
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [BoxShadow(color: unlocked ? tone.dark : AppColors.shadow, offset: const Offset(0, _lip))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(title: title, tone: tone, color: edge, badge: unlocked ? progressText : null),
          if (hint case final hint?) _Hint(text: hint, tone: tone),
          Padding(
            padding: const EdgeInsets.all(_listPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (index, level) in levels.indexed) ...[
                  if (index > 0) const SizedBox(height: _rowGap),
                  level,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _Header extends StatelessWidget {
  const _Header({required this.title, required this.tone, required this.color, required this.badge});

  final String title;
  final GroupTone tone;
  final Color color;

  /// Rozet metni; yoksa grup kilitlidir ve kilit simgesi gösterilir.
  final String? badge;

  static const _titleFont = 26.0;
  static const _badgeFont = 17.0;
  static const _badgeAlpha = 0.28;
  static const _lockSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final shadow = [Shadow(color: tone.dark, offset: const Offset(0, 2))];
    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: _titleFont, fontWeight: FontWeight.w900, color: Colors.white, shadows: shadow),
              ),
            ),
            if (badge case final badge?)
              DecoratedBox(
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: Colors.white.withValues(alpha: _badgeAlpha),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    badge,
                    style: const TextStyle(fontSize: _badgeFont, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
              )
            else
              SvgPicture.asset(AppAssets.lock, width: _lockSize, height: _lockSize, semanticsLabel: 'kilitli'),
          ],
        ),
      ),
    );
  }
}

final class _Hint extends StatelessWidget {
  const _Hint({required this.text, required this.tone});

  final String text;
  final GroupTone tone;

  static const _radius = 18.0;
  static const _font = 15.0;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.fromLTRB(14, 12, 14, 0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_radius)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: _font, fontWeight: FontWeight.w800, color: tone.dark),
        ),
      );
}
