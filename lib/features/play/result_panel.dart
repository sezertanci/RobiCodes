import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../progress/star_rule.dart';
import 'widgets/star_row.dart';

/// Seviye bitince açılan sonuç paneli. Yıldızlar web sürümündeki gibi sırayla belirir.
final class ResultPanel extends StatefulWidget {
  const ResultPanel({required this.stars, required this.onBackToLevels, this.onNextLevel, super.key});

  final int stars;
  final VoidCallback onBackToLevels;

  /// Sonraki seviye açıksa dolu; değilse "Sonraki seviye" düğmesi gösterilmez.
  final VoidCallback? onNextLevel;

  static const title = 'Harika! Seviye tamamlandı.';
  static const backLabel = 'Seviyelere dön';
  static const nextLabel = 'Sonraki seviye';

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
    _timer = Timer(ResultPanel.firstStarDelay, _revealNext);
  }

  void _revealNext() {
    if (!mounted || _visible >= StarRule.perfect) {
      return;
    }
    setState(() => _visible++);
    _timer = Timer(ResultPanel.starInterval, _revealNext);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ColoredBox(
      color: Colors.black45,
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.6, end: 1),
          duration: const Duration(milliseconds: 450),
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
