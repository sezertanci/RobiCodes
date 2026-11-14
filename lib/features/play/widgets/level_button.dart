import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_texts.dart';
import '../../../app/app_theme.dart';
import 'group_tone.dart';
import 'star_row.dart';

/// Seviye seçimindeki hap biçimli satır: solda grubun renginde numara, sağda yıldızlar veya kilit.
/// Sıradaki seviye sarı bir halkayla vurgulanır.
final class LevelButton extends StatelessWidget {
  const LevelButton({
    required this.level,
    required this.stars,
    required this.unlocked,
    required this.isNext,
    required this.tone,
    required this.ratio,
    required this.onTap,
    super.key,
  });

  final int level;
  final int stars;
  final bool unlocked;
  final bool isNext;
  final GroupTone tone;

  /// Ekran ölçeği; telefonda 1, tablette satırın bütün boyutları bu oranda büyür.
  final double ratio;
  final VoidCallback onTap;

  /// Çocuk parmağı için en küçük dokunma yüksekliği.
  static const _minHeight = 64.0;
  static const _numberSize = 48.0;
  static const _numberLip = 4.0;
  static const _numberFont = 22.0;
  static const _starSize = 28.0;
  static const _lockSize = 30.0;
  static const _lip = 4.0;
  static const _nextRing = 4.0;
  static const _lockedOpacity = 0.6;
  static const _inset = 6.0;
  static const _endInset = 16.0;

  String get _label {
    if (!unlocked) {
      return 'Seviye $level, kilitli';
    }
    return stars > 0 ? 'Seviye $level, ${AppTexts.stars(stars)}' : 'Seviye $level';
  }

  @override
  Widget build(BuildContext context) {
    const shape = StadiumBorder();
    final button = DecoratedBox(
      decoration: ShapeDecoration(
        shape: shape,
        color: unlocked ? Colors.white : Colors.white.withValues(alpha: _lockedOpacity),
        shadows: [
          if (unlocked) const BoxShadow(color: AppColors.shadow, offset: Offset(0, _lip)),
          if (isNext) const BoxShadow(color: AppColors.yellow, spreadRadius: _nextRing),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          customBorder: shape,
          onTap: unlocked ? onTap : null,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: _minHeight * ratio),
            child: Padding(
              padding: EdgeInsets.fromLTRB(_inset, _inset, _endInset, _inset) * ratio,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _number(),
                  // Dar sütunda yıldızlar taşmak yerine küçülür.
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: unlocked
                          ? StarRow(stars: stars, size: _starSize * ratio)
                          : SvgPicture.asset(AppAssets.lock, width: _lockSize * ratio, height: _lockSize * ratio),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Semantics(
      button: true,
      enabled: unlocked,
      label: _label,
      excludeSemantics: true,
      onTap: unlocked ? onTap : null,
      child: unlocked ? button : Opacity(opacity: _lockedOpacity, child: button),
    );
  }

  /// Grubun renginde, alt kenarı koyu tonla kabarık görünen yuvarlak numara.
  Widget _number() {
    const lipStop = 1 - _numberLip / _numberSize;
    return Container(
      width: _numberSize * ratio,
      height: _numberSize * ratio,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [tone.color, tone.color, tone.dark, tone.dark],
          stops: const [0, lipStop, lipStop, 1],
        ),
      ),
      child: Text(
        '$level',
        style: TextStyle(
          fontSize: _numberFont * ratio,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: [Shadow(color: tone.dark, offset: const Offset(0, 2))],
        ),
      ),
    );
  }
}
