import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/app_theme.dart';
import '../../app/robi_codes_app.dart';
import '../../app/screen_scale.dart';
import '../../app/widgets/outlined_text.dart';
import '../../app/widgets/star_counter.dart';
import '../play/widgets/image_button.dart';
import '../settings/settings_dialog.dart';
import 'achievements_button.dart';
import 'character_button.dart';

/// Ana ekranın üst kısmı (web sürümündeki `.home-header` ve `.home-hero`): sağ üstte ödül düğmesi,
/// toplam yıldız sayacı ve ayarlar; altında solda robot, ortada logo ve slogan.
/// Dar ekranda robot solda kalır, logo kalan alanın ortasına geçer.
final class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.stars, super.key});

  /// Bütün oyunlarda toplanan yıldız sayısı.
  final int stars;

  static const tagline = 'Oyna • Öğren • Keşfet';

  static const _padding = EdgeInsets.fromLTRB(16, 8, 16, 0);
  static const _gap = 12.0;
  static const _heroGap = 16.0;
  static const _narrowHeroGap = 8.0;

  @override
  Widget build(BuildContext context) {
    final services = AppScope.of(context);
    final narrow = ScreenScale.isNarrow(context);
    return Padding(
      padding: _padding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const AchievementsButton(),
              const SizedBox(width: _gap),
              StarCounter(stars: stars),
              const SizedBox(width: _gap),
              ImageButton(
                asset: AppAssets.settings,
                label: SettingsDialog.title,
                size: narrow ? AppMetrics.compactTouch : AppMetrics.touch,
                onPressed: () => SettingsDialog.show(context, services.sound),
              ),
            ],
          ),
          if (narrow)
            const Row(
              children: [
                CharacterButton(),
                SizedBox(width: _narrowHeroGap),
                Expanded(child: Center(child: _Logo(narrow: true))),
              ],
            )
          else
            const Row(
              children: [
                Expanded(child: CharacterButton()),
                SizedBox(width: _heroGap),
                _Logo(narrow: false),
                SizedBox(width: _heroGap),
                Spacer(),
              ],
            ),
        ],
      ),
    );
  }
}

/// İki satırlık, konturlu ve hafif eğik "Robi Kodluyor" yazısı ile altındaki sarı slogan.
final class _Logo extends StatelessWidget {
  const _Logo({required this.narrow});

  final bool narrow;

  static const top = 'Robi';
  static const bottom = 'Kodluyor';

  static const _tilt = -3 * pi / 180;
  static const _lineHeight = 0.95;
  static const _gap = 10.0;
  static const _stroke = 10.0;
  static const _narrowStroke = 7.0;
  static const _shadow = Offset(0, 6);
  static const _narrowShadow = Offset(0, 3);
  static const _narrowTopSize = 28.0;
  static const _narrowBottomSize = 34.0;

  @override
  Widget build(BuildContext context) {
    Widget line(String text, Color color, double fontSize) => OutlinedText(
      text,
      fontSize: fontSize,
      color: color,
      strokeColor: AppColors.navy,
      strokeWidth: narrow ? _narrowStroke : _stroke,
      shadowOffset: narrow ? _narrowShadow : _shadow,
      height: _lineHeight,
    );
    return Semantics(
      header: true,
      label: RobiCodesApp.title,
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: _tilt,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                line(top, Colors.white, narrow ? _narrowTopSize : ScreenScale.fluid(context, 36, 0.07, 64)),
                line(bottom, AppColors.yellow, narrow ? _narrowBottomSize : ScreenScale.fluid(context, 42, 0.08, 76)),
              ],
            ),
          ),
          const SizedBox(height: _gap),
          _Tagline(narrow: narrow),
        ],
      ),
    );
  }
}

/// Sarı hap içindeki slogan.
final class _Tagline extends StatelessWidget {
  const _Tagline({required this.narrow});

  final bool narrow;

  static const _padding = EdgeInsets.symmetric(horizontal: 22, vertical: 6);
  static const _narrowPadding = EdgeInsets.symmetric(horizontal: 14, vertical: 4);
  static const _narrowFontSize = 15.0;
  static const _lip = 4.0;

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: _Logo._tilt,
    child: Container(
      padding: narrow ? _narrowPadding : _padding,
      decoration: const ShapeDecoration(
        color: AppColors.yellow,
        shape: StadiumBorder(),
        shadows: [BoxShadow(color: AppColors.yellowDark, offset: Offset(0, _lip))],
      ),
      child: Text(
        HomeHeader.tagline,
        style: TextStyle(
          color: AppColors.navy,
          fontWeight: FontWeight.w900,
          fontSize: narrow ? _narrowFontSize : ScreenScale.fluid(context, 17, 0.024, 22),
        ),
      ),
    ),
  );
}
