import 'package:flutter/material.dart';

import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../../path_finder/path_finder_controller.dart';
import '../engine/repeat_level.dart';
import '../engine/starting_program.dart';
import '../repeat_controller.dart';
import 'program_game_layout.dart';
import 'program_strip.dart';
import 'repeat_controls.dart';

/// "Tekrar Et" seviye ekranı. Üstte konuşma balonu ve blok şeridi, altta ya da yanda harita ve
/// kontroller bulunur (bkz. [ProgramGameLayout]).
final class RepeatView extends StatefulWidget {
  const RepeatView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.startingProgram,
    super.key,
  });

  final RepeatLevel level;

  /// Verilirse seviye bu hazır programla açılır (bkz. [StartingProgram]).
  final StartingProgram? startingProgram;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  @override
  State<RepeatView> createState() => _RepeatViewState();
}

final class _RepeatViewState extends State<RepeatView> {
  RepeatController? _controller;

  static const _gap = 12.0;

  /// Hareketi azaltma ayarı açıksa robot daha hızlı yürür. Ayar seviye başında okunur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= RepeatController(
      level: widget.level,
      onCompleted: widget.onCompleted,
      feedback: widget.feedback,
      startingProgram: widget.startingProgram,
      stepDuration: MediaQuery.disableAnimationsOf(context)
          ? PathFinderController.reducedStepDuration
          : PathFinderController.defaultStepDuration,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller!;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => ProgramGameLayout(
        scene: controller,
        header: (chipSize, compact) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SpeechBubble(message: controller.message, mood: controller.mood),
            const SizedBox(height: _gap),
            ProgramStrip(controller: controller, chipSize: chipSize, compact: compact),
          ],
        ),
        controls: (buttonSize, stacked) =>
            RepeatControls(controller: controller, buttonSize: buttonSize, stacked: stacked),
      ),
    );
  }
}
