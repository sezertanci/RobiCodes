import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_texts.dart';
import '../../app/app_theme.dart';
import '../progress/star_rule.dart';
import 'game_feedback.dart';
import 'widgets/confetti.dart';
import 'widgets/star_row.dart';

/// Seviye bitince açılan sonuç paneli. Panel açılınca seviye sonu sesi çalar; yıldızlar web sürümündeki
/// gibi sırayla belirir ve kazanılan her yıldızda tonu yükselen yıldız sesi çalar.
final class ResultPanel extends StatefulWidget {
  const ResultPanel({
    required this.stars,
    required this.feedback,
    required this.onBackToLevels,
    this.onNextLevel,
    super.key,
  });

  final int stars;
  final GameFeedback feedback;
  final VoidCallback onBackToLevels;

  /// Sonraki seviye açıksa dolu; değilse "Sonraki seviye" düğmesi gösterilmez.
  final VoidCallback? onNextLevel;

  static const title = 'Harika! Seviye tamamlandı.';
  static const backLabel = 'Seviyelere dön';
  static const nextLabel = AppTexts.nextLevel;

  static const firstStarDelay = Duration(milliseconds: 750);
  static const starInterval = Duration(milliseconds: 380);

  @override
  State<ResultPanel> createState() => _ResultPanelState();
}

final class _ResultPanelState extends State<ResultPanel> {
  int _visible = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    widget.feedback.levelComplete();
    _timer = Timer(ResultPanel.firstStarDelay, _revealNext);
  }

  void _revealNext() {
    if (!mounted || _visible >= StarRule.perfect) {
      return;
    }
    setState(() => _visible++);
    if (_visible <= widget.stars) {
      widget.feedback.star(_visible - 1);
    }
    _timer = Timer(ResultPanel.starInterval, _revealNext);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Panel ve üstünde bir kez yağan konfeti (web sürümündeki gibi). "Hareketi azalt" açıksa konfeti
  /// gösterilmez ve panel büyüyerek değil, doğrudan açılır.
  @override
  Widget build(BuildContext context) => Stack(fit: StackFit.expand, children: [_panel(context), const Confetti()]);

  Widget _panel(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ColoredBox(
      color: Colors.black45,
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.6, end: 1),
          duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 450),
          curve: Curves.easeOutBack,
          builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ResultPanel.title,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(color: AppColors.navy, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  StarRow(stars: widget.stars, size: 56, visibleCount: _visible),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      OutlinedButton(onPressed: widget.onBackToLevels, child: const Text(ResultPanel.backLabel)),
                      if (widget.onNextLevel case final onNext?)
                        FilledButton(onPressed: onNext, child: const Text(ResultPanel.nextLabel)),
                    ],
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
