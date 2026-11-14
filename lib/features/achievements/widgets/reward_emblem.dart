import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../achievement.dart';

/// Rozetin (kurdeleli madalya) veya kupanın çizimi. Ölçüler web sürümündeki `achievements.css`
/// dosyasından oranlanmıştır; [size] madalyanın çapı ya da kupanın kenarıdır.
/// Kazanılmamış ödül gri tonla, soluk ve sağ altta kilitle çizilir.
final class RewardEmblem extends StatelessWidget {
  const RewardEmblem({required this.status, required this.size, super.key});

  final AchievementStatus status;
  final double size;

  static const lockedTone = ColorTone(Color(0xFFB8BFCC), Color(0xFF8A93A6));
  static const _lockedOpacity = 0.4;
  static const _lockRatio = 0.3;

  /// Rozetin yüksekliği çapının bu katıdır (altta kurdeleler sarkar).
  static const badgeHeightRatio = 1.22;

  @override
  Widget build(BuildContext context) {
    final AchievementStatus(:achievement, :isEarned, :progress) = status;
    final tone = isEarned ? achievement.tone : lockedTone;
    final goal = achievement.symbol.showsGoal ? '${progress.goal}' : null;
    final isBadge = achievement.kind == AchievementKind.badge;
    final emblem = isBadge
        ? _Badge(tone: tone, symbol: achievement.symbol, goal: goal, size: size)
        : _Trophy(tone: tone, symbol: achievement.symbol, size: size, isGold: tone == AppTones.gold);
    final height = isBadge ? size * badgeHeightRatio : size;
    return ExcludeSemantics(
      child: SizedBox(
        width: size,
        height: height,
        child: isEarned
            ? emblem
            : Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(opacity: _lockedOpacity, child: emblem),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: SvgPicture.asset(AppAssets.lock, width: size * _lockRatio, height: size * _lockRatio),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Kurdeleli madalya.
final class _Badge extends StatelessWidget {
  const _Badge({required this.tone, required this.symbol, required this.goal, required this.size});

  final ColorTone tone;
  final RewardSymbol symbol;
  final String? goal;
  final double size;

  static const _ribbonWidth = 0.26;
  static const _ribbonHeight = 0.5;
  static const _ribbonInset = 0.24;
  static const _ribbonTilt = 14 * pi / 180;
  static const _ringInset = 0.17;

  @override
  Widget build(BuildContext context) {
    final border = max(3.0, size * 0.05);
    return Stack(
      children: [
        _ribbon(left: true, border: border),
        _ribbon(left: false, border: border),
        Positioned(
          top: 0,
          left: 0,
          width: size,
          height: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.35, -0.4),
                colors: [Color.lerp(tone.base, Colors.white, 0.45)!, tone.base],
                stops: const [0, 0.6],
              ),
              border: Border.all(color: tone.dark, width: border),
              boxShadow: [BoxShadow(color: tone.dark, offset: Offset(0, border))],
            ),
            child: Padding(
              padding: EdgeInsets.all(size * _ringInset - border),
              child: CustomPaint(
                painter: _DashedRingPainter(width: max(2.0, size * 0.025)),
                child: Center(
                  child: RewardSymbolView(symbol: symbol, goal: goal, size: size),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ribbon({required bool left, required double border}) => Positioned(
    left: left ? size * _ribbonInset : null,
    right: left ? null : size * _ribbonInset,
    bottom: 0,
    width: size * _ribbonWidth,
    height: size * _ribbonHeight,
    child: Transform.rotate(
      angle: left ? _ribbonTilt : -_ribbonTilt,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: left ? tone.base : Colors.white,
          border: Border.all(color: tone.dark, width: border * 0.6),
        ),
      ),
    ),
  );
}

/// Madalyanın içindeki beyaz kesikli halka.
final class _DashedRingPainter extends CustomPainter {
  const _DashedRingPainter({required this.width});

  final double width;

  static const _dashes = 24;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    final rect = Offset.zero & size;
    const sweep = 2 * pi / _dashes;
    for (var index = 0; index < _dashes; index++) {
      canvas.drawArc(rect.deflate(width / 2), index * sweep, sweep / 2, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedRingPainter oldDelegate) => oldDelegate.width != width;
}

/// Kupa: ortasında beyaz arma (ikon), altında ödülün renginde kaide.
final class _Trophy extends StatelessWidget {
  const _Trophy({required this.tone, required this.symbol, required this.size, required this.isGold});

  final ColorTone tone;
  final RewardSymbol symbol;
  final double size;
  final bool isGold;

  static const _crestTop = 0.15;
  static const _crestWidth = 0.36;
  static const _iconRatio = 0.26;
  static const _baseTop = 0.734;
  static const _baseLeft = 0.297;
  static const _baseWidth = 0.406;
  static const _baseHeight = 0.14;

  @override
  Widget build(BuildContext context) {
    final crest = size * _crestWidth;
    return Stack(
      children: [
        if (isGold)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [AppColors.yellow.withValues(alpha: 0.6), Colors.transparent]),
              ),
            ),
          ),
        Positioned.fill(child: SvgPicture.asset(AppAssets.trophy)),
        Positioned(
          top: size * _crestTop,
          left: (size - crest) / 2,
          width: crest,
          height: crest,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: tone.base, width: max(2.0, size * 0.025)),
            ),
            child: Center(child: RewardImage(symbol.image, size: size * _iconRatio)),
          ),
        ),
        Positioned(
          top: size * _baseTop,
          left: size * _baseLeft,
          width: size * _baseWidth,
          height: size * _baseHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tone.base,
              border: Border.all(color: tone.dark, width: max(2.0, size * 0.015)),
              borderRadius: BorderRadius.circular(size * 0.035),
            ),
          ),
        ),
      ],
    );
  }
}

/// Rozetin ortasındaki işaret: sayı, ikon, ikon ve sayı, yıldız sırası veya üstü çizili ikon.
final class RewardSymbolView extends StatelessWidget {
  const RewardSymbolView({required this.symbol, required this.goal, required this.size, super.key});

  final RewardSymbol symbol;
  final String? goal;

  /// Madalyanın çapı; işaretin ölçüleri buna göre oranlanır.
  final double size;

  static const _textRatio = 0.38;
  static const _iconRatio = 0.5;
  static const _pairedIconRatio = 0.38;
  static const _pairedTextRatio = 0.24;
  static const _starRatio = 0.26;
  static const _middleStarRatio = 0.32;

  @override
  Widget build(BuildContext context) {
    final image = symbol.image;
    final goal = this.goal;
    if (symbol.stars > 0) {
      return _stars();
    }
    if (image == null) {
      return _text(goal ?? '', size * _textRatio);
    }
    final icon = _icon(image, size * (goal == null ? _iconRatio : _pairedIconRatio));
    return goal == null
        ? icon
        : Column(mainAxisSize: MainAxisSize.min, children: [icon, _text(goal, size * _pairedTextRatio)]);
  }

  Widget _icon(String image, double iconSize) => symbol.isCrossed
      ? SizedBox(
          width: iconSize,
          height: iconSize,
          child: CustomPaint(
            foregroundPainter: _CrossPainter(width: max(3.0, size * 0.06)),
            child: RewardImage(image, size: iconSize),
          ),
        )
      : RewardImage(image, size: iconSize);

  /// Yıldızlar iç halkaya sığmazsa (küçük rozetlerde) satır orantılı olarak küçülür.
  Widget _stars() => FittedBox(
    fit: BoxFit.scaleDown,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < symbol.stars; index++)
          Padding(
            padding: EdgeInsets.only(bottom: index == symbol.stars ~/ 2 ? size * 0.06 : 0),
            child: SvgPicture.asset(
              AppAssets.star,
              width: size * (index == symbol.stars ~/ 2 ? _middleStarRatio : _starRatio),
            ),
          ),
      ],
    ),
  );

  Widget _text(String text, double fontSize) => Text(
    text,
    maxLines: 1,
    style: TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      height: 1,
      shadows: const [Shadow(color: Color(0x80000000), offset: Offset(0, 2))],
    ),
  );
}

/// Üstü çizili ikonun kırmızı çizgisi (-45°), beyaz kenarlı.
final class _CrossPainter extends CustomPainter {
  const _CrossPainter({required this.width});

  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width * 0.1, size.height * 0.9);
    final end = Offset(size.width * 0.9, size.height * 0.1);
    final outline = Paint()
      ..color = Colors.white
      ..strokeWidth = width * 1.6
      ..strokeCap = StrokeCap.round;
    final line = Paint()
      ..color = AppColors.red
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(start, end, outline)
      ..drawLine(start, end, line);
  }

  @override
  bool shouldRepaint(_CrossPainter oldDelegate) => oldDelegate.width != width;
}

/// Ödülde kullanılan görsel; SVG ikonlar ve karakter resimleri (webp) aynı şekilde çizilir.
final class RewardImage extends StatelessWidget {
  const RewardImage(this.image, {required this.size, super.key});

  final String? image;
  final double size;

  static const _svgExtension = '.svg';

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    if (image == null) {
      return SizedBox.square(dimension: size);
    }
    return image.endsWith(_svgExtension)
        ? SvgPicture.asset(image, width: size, height: size)
        : Image.asset(image, width: size, height: size, fit: BoxFit.contain);
  }
}
