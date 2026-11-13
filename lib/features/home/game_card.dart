import 'package:flutter/material.dart';

import '../../app/app_theme.dart';

/// Ana ekrandaki tek bir oyunun kartı. Yalnızca kendisine verilen değerleri gösterir.
final class GameCard extends StatelessWidget {
  const GameCard({
    required this.title,
    required this.description,
    required this.accent,
    required this.stars,
    required this.maxStars,
    required this.isPlayable,
    this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final Color accent;
  final int stars;
  final int maxStars;
  final bool isPlayable;

  /// Oynanabilir oyunda karta dokununca çağrılır; `null` ise kart dokunulamaz.
  final VoidCallback? onTap;

  static const _comingSoonLabel = 'Yakında';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: accent.withValues(alpha: 0.18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: accent, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: Text(description, style: textTheme.bodyMedium, overflow: TextOverflow.fade),
              ),
              _Footer(stars: stars, maxStars: maxStars, isPlayable: isPlayable),
            ],
          ),
        ),
      ),
    );
  }
}

final class _Footer extends StatelessWidget {
  const _Footer({required this.stars, required this.maxStars, required this.isPlayable});

  final int stars;
  final int maxStars;
  final bool isPlayable;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 4,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: AppColors.yellow),
          const SizedBox(width: 4),
          Text('$stars / $maxStars'),
        ],
      ),
      if (!isPlayable) const Chip(label: Text(GameCard._comingSoonLabel)),
    ],
  );
}
