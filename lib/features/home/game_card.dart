import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_assets.dart';
import '../../app/app_theme.dart';
import '../../app/screen_scale.dart';
import '../../app/widgets/game_icon_badge.dart';
import '../../app/widgets/tone_card.dart';
import '../../l10n/l10n.dart';

/// Ana ekrandaki tek bir oyunun kartı: oyunun renginde zemin, beyaz daire içinde ikon, başlık,
/// açıklama, ilerleme çubuğu, tamamlanan seviye ve yıldız sayısı. Görünüm web sürümündeki
/// `home.css` dosyasıyla aynıdır. Dar ekranda ikon ve açıklama küçülür, açıklama üç satıra kadar uzayabilir.
/// Kart yalnızca kendisine verilen değerleri gösterir.
final class GameCard extends StatelessWidget {
  const GameCard({
    required this.title,
    required this.description,
    required this.tone,
    required this.icon,
    required this.completed,
    required this.levels,
    required this.stars,
    required this.isPlayable,
    this.lockedLabel,
    this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final ColorTone tone;
  final String icon;
  final int completed;
  final int levels;
  final int stars;
  final bool isPlayable;

  /// Satın alınmamış ücretli oyunda seviye metni yerine kilit simgesiyle gösterilen fiyat veya "Kilitli" metni.
  final String? lockedLabel;

  /// Oynanabilir oyunda karta dokununca çağrılır; `null` ise kart dokunulamaz.
  final VoidCallback? onTap;

  static const _padding = EdgeInsets.fromLTRB(16, 18, 16, 16);
  static const _gap = 6.0;
  static const _descriptionSize = 16.0;
  static const _narrowDescriptionSize = 14.0;
  static const _descriptionLines = 2;
  static const _narrowDescriptionLines = 3;
  static const _badgeSize = 84.0;
  static const _iconSize = 64.0;
  static const _narrowBadgeSize = 68.0;
  static const _narrowIconSize = 52.0;

  @override
  Widget build(BuildContext context) {
    final narrow = ScreenScale.isNarrow(context);
    final t = context.l10n;
    return ToneCard(
      tone: tone,
      padding: _padding,
      onTap: onTap,
      child: DefaultTextStyle.merge(
        textAlign: TextAlign.center,
        child: Column(
          children: [
            GameIconBadge(
              icon: icon,
              tone: tone,
              size: narrow ? _narrowBadgeSize : _badgeSize,
              iconSize: narrow ? _narrowIconSize : _iconSize,
            ),
            const SizedBox(height: _gap),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.1),
            ),
            const SizedBox(height: _gap),
            Expanded(
              child: Text(
                description,
                maxLines: narrow ? _narrowDescriptionLines : _descriptionLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: narrow ? _narrowDescriptionSize : _descriptionSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _Progress(
              completed: completed,
              levels: levels,
              stars: stars,
              label: lockedLabel ?? (isPlayable ? t.homeLevels(completed, levels) : t.homeComingSoon),
              isLocked: lockedLabel != null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Beyaz ilerleme çubuğu, altında seviye metni ve yıldız sayısı.
final class _Progress extends StatelessWidget {
  const _Progress({
    required this.completed,
    required this.levels,
    required this.stars,
    required this.label,
    required this.isLocked,
  });

  final int completed;
  final int levels;
  final int stars;
  final String label;
  final bool isLocked;

  static const _barHeight = 14.0;
  static const _barBackground = Color(0x59FFFFFF);
  static const _starSize = 22.0;
  static const _gap = 6.0;
  static const _iconGap = 4.0;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ExcludeSemantics(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_barHeight / 2),
          child: LinearProgressIndicator(
            value: levels == 0 ? 0 : completed / levels,
            minHeight: _barHeight,
            color: Colors.white,
            backgroundColor: _barBackground,
          ),
        ),
      ),
      const SizedBox(height: _gap),
      DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLocked) ...[
                  SvgPicture.asset(AppAssets.lock, width: _starSize, height: _starSize),
                  const SizedBox(width: _iconGap),
                ],
                Text(label),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssets.star, width: _starSize, height: _starSize),
                const SizedBox(width: _iconGap),
                Text('$stars'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
