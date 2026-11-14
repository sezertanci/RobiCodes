import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_assets.dart';
import '../../app/app_theme.dart';

/// Ana ekrandaki tek bir oyunun kartı: oyunun renginde zemin, beyaz daire içinde ikon, başlık,
/// açıklama, ilerleme çubuğu, tamamlanan seviye ve yıldız sayısı. Görünüm web sürümündeki
/// `home.css` dosyasıyla aynıdır. Kart yalnızca kendisine verilen değerleri gösterir.
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

  /// Oynanabilir oyunda karta dokununca çağrılır; `null` ise kart dokunulamaz.
  final VoidCallback? onTap;

  static const comingSoonLabel = 'Yakında';

  static String levelsText(int completed, int levels) => '$completed/$levels seviye';

  /// Kartın içindeki yarı saydam beyaz halka ve üstten alta solan parlaklık.
  static const _ringWidth = 4.0;
  static const _ringColor = Color(0x59FFFFFF);
  static const _shine = Color(0x2EFFFFFF);
  static const _padding = EdgeInsets.fromLTRB(16, 18, 16, 16);
  static const _gap = 6.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppMetrics.largeRadius);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.alphaBlend(_shine, tone.base), tone.base],
        ),
        borderRadius: radius,
        border: Border.all(color: _ringColor, width: _ringWidth),
        boxShadow: [BoxShadow(color: tone.dark, offset: const Offset(0, AppMetrics.lip))],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: _padding,
            child: DefaultTextStyle.merge(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                shadows: [Shadow(color: tone.dark, offset: const Offset(0, 2))],
              ),
              child: Column(
                children: [
                  _IconBadge(icon: icon, tone: tone),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  _Progress(
                    completed: completed,
                    levels: levels,
                    stars: stars,
                    label: isPlayable ? levelsText(completed, levels) : comingSoonLabel,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Beyaz daire içinde oyunun ikonu.
final class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.tone});

  final String icon;
  final ColorTone tone;

  static const _size = 84.0;
  static const _iconSize = 64.0;
  static const _lip = 4.0;

  @override
  Widget build(BuildContext context) => Container(
    width: _size,
    height: _size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: tone.dark, offset: const Offset(0, _lip))],
    ),
    child: SvgPicture.asset(icon, width: _iconSize, height: _iconSize),
  );
}

/// Beyaz ilerleme çubuğu, altında seviye metni ve yıldız sayısı.
final class _Progress extends StatelessWidget {
  const _Progress({required this.completed, required this.levels, required this.stars, required this.label});

  final int completed;
  final int levels;
  final int stars;
  final String label;

  static const _barHeight = 14.0;
  static const _barBackground = Color(0x59FFFFFF);
  static const _starSize = 22.0;
  static const _gap = 6.0;

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
            Text(label),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssets.star, width: _starSize, height: _starSize),
                const SizedBox(width: 4),
                Text('$stars'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
