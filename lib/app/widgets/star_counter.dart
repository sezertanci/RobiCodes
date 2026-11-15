import 'package:flutter/widgets.dart';

import '../app_assets.dart';
import '../../l10n/l10n.dart';
import 'counter_pill.dart';

/// Toplanan yıldız sayısını gösteren hap.
final class StarCounter extends StatelessWidget {
  const StarCounter({required this.stars, super.key});

  final int stars;

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.l10n.commonStars(stars),
    excludeSemantics: true,
    child: CounterPill(icon: AppAssets.star, text: '$stars'),
  );
}
