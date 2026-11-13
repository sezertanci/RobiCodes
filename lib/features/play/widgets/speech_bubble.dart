import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';

/// Robotun konuşma balonundaki duygu.
enum RobotMood { talk, happy, sad }

/// Robot karakteri ve yanında konuşma balonu. Oyunlar yönergeleri ve geri bildirimi bununla verir.
final class SpeechBubble extends StatelessWidget {
  const SpeechBubble({required this.message, this.mood = RobotMood.talk, super.key});

  final String message;
  final RobotMood mood;

  static const _robotSize = 64.0;

  Color get _borderColor => switch (mood) {
        RobotMood.talk => AppColors.blue,
        RobotMood.happy => AppColors.green,
        RobotMood.sad => AppColors.red,
      };

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Image.asset(AppAssets.robot, width: _robotSize, height: _robotSize),
          const SizedBox(width: 8),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _borderColor, width: 3),
              ),
              child: Semantics(
                liveRegion: true,
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.navy),
                ),
              ),
            ),
          ),
        ],
      );
}
