import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../app/widgets/outlined_text.dart';
import '../../../l10n/l10n.dart';
import '../../play/widgets/confetti.dart';
import '../achievement.dart';
import 'celebration_label.dart';
import 'reward_emblem.dart';
import '../../sound/tap_sound.dart';

/// Yeni kupa penceresi: lacivert zeminde durmadan yağan konfeti, arkasında dönen ışıklarla büyüyerek
/// gelen kupa, kupanın adı ve "Harika!" düğmesi. Ölçüler web sürümündeki `achievements.css` ile aynıdır.
/// "Hareketi azalt" açıksa konfeti, ışık dönüşü ve büyüme gösterilmez.
final class TrophyCelebration extends StatefulWidget {
  const TrophyCelebration({required this.status, super.key});

  final AchievementStatus status;

  /// Pencereyi açar; çocuk "Harika!" deyince (veya geri tuşuyla) kapanınca tamamlanır.
  static Future<void> show(NavigatorState navigator, AchievementStatus status) => navigator.push<void>(
    PageRouteBuilder<void>(
      pageBuilder: (_, _, _) => TrophyCelebration(status: status),
      transitionsBuilder: (_, animation, _, child) => FadeTransition(opacity: animation, child: child),
    ),
  );

  @override
  State<TrophyCelebration> createState() => _TrophyCelebrationState();
}

final class _TrophyCelebrationState extends State<TrophyCelebration> with TickerProviderStateMixin {
  static const _raysTurn = Duration(seconds: 14);
  static const _popDuration = Duration(milliseconds: 900);
  static const _maxStage = 300.0;
  static const _stageRatio = 0.7;
  static const _maxTrophy = 210.0;
  static const _trophyRatio = 0.5;
  static const _maxBodyWidth = 520.0;
  static const _titleStroke = Color(0xFF131C33);

  late final AnimationController _rays = AnimationController(vsync: this, duration: _raysTurn)..repeat();
  late final AnimationController _pop = AnimationController(vsync: this, duration: _popDuration)..forward();

  @override
  void dispose() {
    _rays.dispose();
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final achievement = widget.status.achievement;
    final t = context.l10n;
    final titleSize = (size.width * 0.07).clamp(32.0, 46.0);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 0.9,
            colors: [Color(0xFF3A4D7A), AppColors.navy],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Confetti(loops: true),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _maxBodyWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CelebrationLabel(t.achievementNewTrophy, fontSize: 20),
                        const SizedBox(height: 12),
                        _stage(size, reduceMotion: reduceMotion),
                        const SizedBox(height: 12),
                        _title(achievement.title(t), titleSize),
                        const SizedBox(height: 12),
                        Text(
                          achievement.description(t),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(200, 56),
                            backgroundColor: AppColors.yellow,
                            foregroundColor: AppColors.navy,
                            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                          autofocus: true,
                          onPressed: context.withTapSound(() => Navigator.of(context).pop()),
                          child: Text(t.achievementGreat),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kupa ve arkasındaki ışık hüzmeleri.
  Widget _stage(Size screen, {required bool reduceMotion}) {
    final stage = min(_maxStage, screen.width * _stageRatio);
    final trophy = RewardEmblem(status: widget.status, size: min(_maxTrophy, screen.width * _trophyRatio));
    return SizedBox.square(
      dimension: stage,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: reduceMotion
                ? const CustomPaint(painter: _RaysPainter())
                : RotationTransition(
                    turns: _rays,
                    child: const CustomPaint(painter: _RaysPainter()),
                  ),
          ),
          if (reduceMotion) trophy else _popping(trophy),
        ],
      ),
    );
  }

  /// Kupa küçükten büyüyerek, aşağıdan ve hafif eğik gelir.
  Widget _popping(Widget trophy) => AnimatedBuilder(
    animation: _pop,
    builder: (context, child) {
      final t = Curves.easeOutBack.transform(_pop.value);
      return Opacity(
        opacity: _pop.value,
        child: Transform.translate(
          offset: Offset(0, 60 * (1 - t)),
          child: Transform.rotate(
            angle: -12 * pi / 180 * (1 - t),
            child: Transform.scale(scale: 0.2 + 0.8 * t, child: child),
          ),
        ),
      );
    },
    child: trophy,
  );

  /// Sarı, kalın lacivert konturlu başlık.
  Widget _title(String text, double fontSize) => OutlinedText(
    text,
    fontSize: fontSize,
    color: AppColors.yellow,
    strokeColor: _titleStroke,
    strokeWidth: 8,
    height: 1.05,
  );
}

/// Kupanın arkasındaki ışık hüzmeleri: 30 derecede bir 12 derecelik sarı dilim, kenara doğru solar.
final class _RaysPainter extends CustomPainter {
  const _RaysPainter();

  static const _period = 30 * pi / 180;
  static const _beam = 12 * pi / 180;
  static const _color = Color(0x73FFD24D);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.shortestSide / 2;
    final beam = Paint()..color = _color;
    canvas.saveLayer(rect, Paint());
    for (var angle = 0.0; angle < 2 * pi; angle += _period) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), angle, _beam, true, beam);
    }
    // Hüzmeler merkezden kenara doğru saydamlaşır (web'deki radyal maske).
    final fade = Paint()
      ..blendMode = BlendMode.dstIn
      ..shader = const RadialGradient(
        colors: [Colors.black, Colors.transparent],
        // Web'deki maske köşeye göre ölçülür (%35–%70); kare alanda bu yarıçapın yaklaşık 0,5 ve 1 katıdır.
        stops: [0.5, 1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas
      ..drawRect(rect, fade)
      ..restore();
  }

  @override
  bool shouldRepaint(_RaysPainter oldDelegate) => false;
}
