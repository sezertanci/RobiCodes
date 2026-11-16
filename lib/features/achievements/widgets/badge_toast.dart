import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../achievement.dart';
import 'celebration_label.dart';
import 'reward_emblem.dart';
import '../../sound/tap_sound.dart';

/// Yeni rozet bildirimi: ekranın üstünden kayarak gelen beyaz kart. Kendiliğinden kapanır, dokununca
/// hemen kapanır. Süreler web sürümündeki `celebration.js` ve `achievements.css` ile aynıdır.
/// Bildirimin bütün ömrü tek bir animasyonla yönetilir; zamanlayıcı kullanılmaz.
final class BadgeToast extends StatefulWidget {
  const BadgeToast({required this.status, required this.onClosed, super.key});

  final AchievementStatus status;
  final VoidCallback onClosed;

  static const enterDuration = Duration(milliseconds: 500);
  static const visibleDuration = Duration(milliseconds: 3200);
  static const leaveDuration = Duration(milliseconds: 300);

  /// Bildirimin açılıştan kapanışa kadar ekranda kaldığı süre.
  static final totalDuration = enterDuration + visibleDuration + leaveDuration;

  /// Bildirimi [navigator] gezgininin katmanında gösterir; bildirim kapanınca tamamlanır.
  static Future<void> show(NavigatorState navigator, AchievementStatus status) {
    final closed = Completer<void>();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => BadgeToast(
        status: status,
        onClosed: () {
          entry.remove();
          closed.complete();
        },
      ),
    );
    navigator.overlay?.insert(entry);
    return navigator.overlay == null ? Future.value() : closed.future;
  }

  @override
  State<BadgeToast> createState() => _BadgeToastState();
}

final class _BadgeToastState extends State<BadgeToast> with SingleTickerProviderStateMixin {
  static const _margin = 16.0;
  static const _maxWidth = 460.0;
  static const _narrowWidth = 560.0;
  static const _spinDuration = Duration(milliseconds: 800);
  static const _spinTurns = -200 / 360;
  static const _startScale = 0.3;

  /// Kart giriş ve çıkışta kendi yüksekliğinin %140'ı kadar yukarıda durur.
  static const _hiddenOffset = -1.4;

  late final AnimationController _life = AnimationController(vsync: this, duration: BadgeToast.totalDuration)
    ..addStatusListener((status) {
      if (status.isCompleted) {
        widget.onClosed();
      }
    })
    ..forward();

  double get _leaveStart => 1 - _fraction(BadgeToast.leaveDuration);

  static double _fraction(Duration part) => part.inMicroseconds / BadgeToast.totalDuration.inMicroseconds;

  void _close() {
    if (_life.value < _leaveStart) {
      _life
        ..value = _leaveStart
        ..forward();
    }
  }

  @override
  void dispose() {
    _life.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isNarrow = media.size.width < _narrowWidth;
    final reduceMotion = media.disableAnimations;
    return Positioned(
      top: media.padding.top + _margin,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          width: min(_maxWidth, media.size.width - 2 * _margin),
          child: AnimatedBuilder(
            animation: _life,
            builder: (context, child) {
              final (offset, opacity) = reduceMotion ? (0.0, _life.value < _leaveStart ? 1.0 : 0.0) : _slide();
              return Opacity(
                opacity: opacity,
                child: FractionalTranslation(translation: Offset(0, offset), child: child),
              );
            },
            child: _card(context, isNarrow: isNarrow, reduceMotion: reduceMotion),
          ),
        ),
      ),
    );
  }

  /// Kartın dikey kayması (kendi yüksekliğine oranla) ve opaklığı.
  (double, double) _slide() {
    final enterEnd = _fraction(BadgeToast.enterDuration);
    final value = _life.value;
    if (value < enterEnd) {
      final t = Curves.easeOutBack.transform(value / enterEnd);
      return (_hiddenOffset * (1 - t), (value / enterEnd).clamp(0, 1));
    }
    if (value < _leaveStart) {
      return (0, 1);
    }
    final t = Curves.easeIn.transform((value - _leaveStart) / (1 - _leaveStart));
    return (_hiddenOffset * t, 1 - t);
  }

  Widget _card(BuildContext context, {required bool isNarrow, required bool reduceMotion}) {
    final status = widget.status;
    final t = context.l10n;
    final emblem = RewardEmblem(status: status, size: isNarrow ? 60 : 76);
    return Semantics(
      liveRegion: true,
      button: true,
      label: '${t.achievementNewBadge} ${status.achievement.title(t)}. ${status.achievement.description(t)}',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: context.withTapSound(_close),
        child: Material(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.yellow, width: 5),
              boxShadow: const [
                BoxShadow(color: AppColors.yellowDark, offset: Offset(0, 8)),
                BoxShadow(color: Color(0x4D1F2D4F), offset: Offset(0, 16), blurRadius: 40),
              ],
            ),
            child: Padding(
              padding: isNarrow
                  ? const EdgeInsets.symmetric(horizontal: 14, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  if (reduceMotion) emblem else _spinning(emblem),
                  SizedBox(width: isNarrow ? 12 : 16),
                  Expanded(child: _texts(isNarrow: isNarrow)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Rozet dönerek ve büyüyerek gelir.
  Widget _spinning(Widget emblem) => AnimatedBuilder(
    animation: _life,
    builder: (context, child) {
      final t = Curves.easeOut.transform((_life.value / _fraction(_spinDuration)).clamp(0, 1));
      return Transform.rotate(
        angle: _spinTurns * (1 - t) * 2 * pi,
        child: Transform.scale(scale: _startScale + (1 - _startScale) * t, child: child),
      );
    },
    child: emblem,
  );

  Widget _texts({required bool isNarrow}) {
    final achievement = widget.status.achievement;
    final t = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CelebrationLabel(t.achievementNewBadge, fontSize: 15),
        const SizedBox(height: 2),
        Text(
          achievement.title(t),
          style: TextStyle(
            color: AppColors.navy,
            fontSize: isNarrow ? 20 : 24,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
        Text(
          achievement.description(t),
          style: const TextStyle(color: AppColors.navy, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
