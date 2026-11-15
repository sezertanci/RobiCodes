import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../../../l10n/l10n.dart';
import '../../repeat/ui/program_game_layout.dart';
import '../../repeat/ui/program_strip.dart';
import '../../repeat/ui/repeat_controls.dart';
import '../my_command_controller.dart';
import '../my_command_level.dart';

/// "Kendi Komutunu Oluştur" seviye ekranı. Üstte konuşma balonu, yapboz simgeli komut şeridi ve ana
/// program şeridi bulunur; dokunulan şerit etkin olur ve yön tuşları ona ok ekler. Kontrollerde
/// Tekrarla'nın üstünde turkuaz Komut düğmesi vardır (bkz. [ProgramGameLayout]).
final class MyCommandView extends StatefulWidget {
  const MyCommandView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    super.key,
  });

  final MyCommandLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  @override
  State<MyCommandView> createState() => _MyCommandViewState();
}

final class _MyCommandViewState extends State<MyCommandView> {
  MyCommandController? _controller;

  static const _gap = 8.0;

  /// İkinci şeridin kapladığı yer; düzen eşikleri bu kadar yükselir.
  static const _secondStripRoom = 140.0;

  /// Yapboz simgesinin şerit blok boyuna oranı.
  static const _iconRatio = 0.6;

  /// Hareketi azaltma ayarı açıksa robot daha hızlı yürür. Ayar seviye başında okunur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= MyCommandController(
      level: widget.level,
      onCompleted: widget.onCompleted,
      feedback: widget.feedback,
      stepDuration: MediaQuery.disableAnimationsOf(context)
          ? MyCommandController.reducedStepDuration
          : MyCommandController.defaultStepDuration,
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
        wideRows: controller.allowsRepeat ? 2 : 1,
        wideMinHeight: ProgramGameLayout.defaultWideMinHeight + _secondStripRoom,
        fixedControlsMinHeight: ProgramGameLayout.defaultFixedControlsMinHeight + _secondStripRoom,
        header: (chipSize, compact) => _header(controller, chipSize, compact),
        controls: (buttonSize, stacked) => RepeatControls(
          controller: controller,
          buttonSize: buttonSize,
          stacked: stacked,
          commandButton: (width, height) => _commandButton(controller, width, height),
        ),
      ),
    );
  }

  Widget _header(MyCommandController controller, double chipSize, bool compact) {
    final t = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SpeechBubble(message: controller.message, mood: controller.mood),
        const SizedBox(height: _gap),
        ProgramStrip(
          controller: controller.commandStrip,
          chipSize: chipSize,
          compact: compact,
          emptyText: t.myCommandCommandEmpty,
          showCounter: false,
          active: controller.lane == CommandLane.command,
          onActivate: () => controller.activate(CommandLane.command),
          leading: Icon(Icons.extension, color: AppColors.teal, size: chipSize * _iconRatio),
        ),
        const SizedBox(height: _gap),
        ProgramStrip(
          controller: controller.mainStrip,
          chipSize: chipSize,
          compact: compact,
          emptyText: t.myCommandMainEmpty,
          active: controller.lane == CommandLane.main,
          onActivate: () => controller.activate(CommandLane.main),
        ),
      ],
    );
  }

  Widget _commandButton(MyCommandController controller, double width, double height) => WideActionButton(
    tone: AppTones.teal,
    icon: Icon(Icons.extension, color: Colors.white, size: height * WideActionButton.iconRatio),
    text: context.l10n.myCommandButton,
    label: context.l10n.myCommandButtonLabel,
    width: width,
    height: height,
    onPressed: controller.canAddCommand ? controller.addCommand : null,
  );
}
