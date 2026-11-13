import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import 'dashed_frame.dart';

/// İpucunun gösterdiği kare: nabız gibi atan sarı, kesik çizgili çerçeve.
final class PulsingHintFrame extends StatefulWidget {
  const PulsingHintFrame({super.key});

  @override
  State<PulsingHintFrame> createState() => _PulsingHintFrameState();
}

final class _PulsingHintFrameState extends State<PulsingHintFrame> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    lowerBound: 0.85,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _pulse.value = 1;
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: _pulse,
    child: const DashedFrame(color: AppColors.yellow, strokeWidth: 5),
  );
}
