import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../l10n/l10n.dart';
import '../../progress/star_rule.dart';

/// Kazanılan yıldızları dolu, kalanları boş yıldızla gösterir.
final class StarRow extends StatelessWidget {
  const StarRow({required this.stars, this.size = 16, this.visibleCount = StarRule.perfect, super.key});

  final int stars;
  final double size;

  /// Sırayla beliren yıldızlar için: o ana kadar gösterilen yıldız sayısı.
  final int visibleCount;

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.l10n.commonStars(stars),
    excludeSemantics: true,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < StarRule.perfect; index++)
          AnimatedScale(
            scale: index < visibleCount ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: SvgPicture.asset(index < stars ? AppAssets.star : AppAssets.starEmpty, width: size, height: size),
          ),
      ],
    ),
  );
}
