import 'package:flutter/material.dart';

import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../../../l10n/l10n.dart';
import '../../path_finder/engine/lamp.dart';
import '../../path_finder/path_finder_controller.dart';
import '../../path_finder/ui/lamp_bulb.dart';
import '../../repeat/repeat_texts.dart';
import '../../repeat/ui/program_game_layout.dart';
import '../../repeat/ui/program_strip.dart';
import '../../repeat/ui/repeat_controls.dart';
import '../engine/pattern_level.dart';
import '../lamp_program_controller.dart';
import 'tile_button.dart';

/// "Desen Bulmacası" Uzman ekranı: "Tekrar Et" düzeninde blok şeridi, lamba şeridi ve kontroller. Yön tuşlarının
/// yerinde seviyedeki renklerin "renk yak" düğmeleri durur.
final class LampProgramView extends StatefulWidget {
  const LampProgramView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    super.key,
  });

  final PatternProgramLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  @override
  State<LampProgramView> createState() => _LampProgramViewState();
}

final class _LampProgramViewState extends State<LampProgramView> {
  LampProgramController? _controller;

  static const _gap = 12.0;

  /// Renk düğmeleri iki sütunlu bir ızgarada durur.
  static const _columns = 2;

  /// Hareketi azaltma ayarı açıksa robot daha hızlı yürür. Ayar seviye başında okunur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= LampProgramController(
      level: widget.level,
      onCompleted: widget.onCompleted,
      feedback: widget.feedback,
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
            ProgramStrip(
              controller: controller,
              chipSize: chipSize,
              compact: compact,
              emptyText: context.l10n.patternEmptyStrip,
              dropText: context.l10n.patternDropHere,
            ),
          ],
        ),
        controls: (buttonSize, stacked) => RepeatControls(
          controller: controller,
          buttonSize: buttonSize,
          stacked: stacked,
          customPad: (extent) => _colorPad(controller, extent),
          leaveLabel: context.l10n.patternLeaveRepeatLabel,
        ),
      ),
    );
  }

  /// Seviyedeki renklerin düğmeleri; renkler [LampColor] sırasıyla dizilir.
  Widget _colorPad(LampProgramController controller, double extent) {
    final colors = LampColor.values.where(widget.level.lamps.contains).toList();
    final cell = extent / _columns;
    return TapRegion(
      groupId: ProgramStrip.tapGroup,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          for (final color in colors)
            LightButton(
              color: color,
              size: cell - ImageButton.padding * 2,
              onPressed: controller.canAddInner ? () => controller.addLight(color) : null,
            ),
        ],
      ),
    );
  }
}

/// "renk yak" düğmesi: beyaz kabarık düğmenin ortasında o rengin lambası.
final class LightButton extends StatelessWidget {
  const LightButton({required this.color, required this.size, required this.onPressed, super.key});

  final LampColor color;
  final double size;
  final VoidCallback? onPressed;

  static const _lampRatio = 0.7;

  @override
  Widget build(BuildContext context) => TileButton(
    label: context.l10n.patternLightLabel(RepeatTexts.lampColor(context.l10n, color)),
    size: size,
    edge: LampBulb.toneOf(color).dark,
    onPressed: onPressed,
    child: LampBulb(color: color, size: size * _lampRatio),
  );
}
