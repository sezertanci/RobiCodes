import 'package:flutter/widgets.dart';

import '../app_assets.dart';
import '../app_texts.dart';
import 'counter_pill.dart';

/// Toplanan yıldız sayısını gösteren hap.
final class StarCounter extends StatelessWidget {
  const StarCounter({required this.stars, super.key});

  final int stars;

  @override
  Widget build(BuildContext context) => Semantics(
    label: AppTexts.stars(stars),
    excludeSemantics: true,
    child: CounterPill(icon: AppAssets.star, text: '$stars'),
  );
}
