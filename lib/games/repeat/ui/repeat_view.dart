import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_theme.dart';

import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../../path_finder/path_finder_controller.dart';
import '../../../l10n/l10n.dart';
import '../engine/repeat_level.dart';
import '../engine/repeat_program.dart';
import '../engine/starting_program.dart';
import '../repeat_controller.dart';
import '../repeat_texts.dart';
import 'inner_block_chip.dart';
import 'program_game_layout.dart';
import 'program_strip.dart';
import 'repeat_assets.dart';
import 'repeat_controls.dart';

/// "Tekrar Et" seviye ekranı. Üstte konuşma balonu ve blok şeridi, altta ya da yanda harita ve
/// kontroller bulunur (bkz. [ProgramGameLayout]).
final class RepeatView extends StatefulWidget {
  const RepeatView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    this.startingProgram,
    this.usesBox = false,
    super.key,
  });

  final RepeatLevel level;

  /// Verilirse seviye bu hazır programla açılır (bkz. [StartingProgram]).
  final StartingProgram? startingProgram;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  /// "Değişken Kutusu" kuralları: kutu blokları, kutu düğmeleri ve şeridin solunda kutu rozeti.
  final bool usesBox;

  @override
  State<RepeatView> createState() => _RepeatViewState();
}

final class _RepeatViewState extends State<RepeatView> {
  RepeatController? _controller;

  static const _gap = 12.0;

  /// Kutu düğmeleri: kutuya sayı koy, 1 ekle, 1 çıkar.
  static const _boxBlocks = [SetBoxBlock(SetBoxBlock.defaultValue), AddBoxBlock.increment, AddBoxBlock.decrement];

  /// Hareketi azaltma ayarı açıksa robot daha hızlı yürür. Ayar seviye başında okunur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= RepeatController(
      level: widget.level,
      onCompleted: widget.onCompleted,
      feedback: widget.feedback,
      startingProgram: widget.startingProgram,
      usesBox: widget.usesBox,
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
    final usesBox = widget.usesBox;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => ProgramGameLayout(
        scene: controller,
        wideRows: usesBox && controller.allowsRepeat ? 2 : 1,
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
              leading: usesBox
                  ? BoxBadge(value: controller.box, size: chipSize, active: controller.activeStep != null)
                  : null,
              emptyText: usesBox ? context.l10n.variableBoxEmptyStrip : null,
              holdsRepeat: controller.allowsRepeat,
            ),
          ],
        ),
        controls: (buttonSize, stacked) => RepeatControls(
          controller: controller,
          buttonSize: buttonSize,
          stacked: stacked,
          commandButton: usesBox ? (width, height) => _boxButtons(controller, width, height) : null,
        ),
      ),
    );
  }

  /// [button] düğmesi ipucunun önerdiği [hint] bloğunu ekliyor mu? "=" düğmesi her sayıyı ekler; sayı sonra
  /// şeritte değiştirilir.
  static bool _addsHinted(InnerBlock? hint, InnerBlock button) => switch ((hint, button)) {
    (SetBoxBlock(), SetBoxBlock()) => true,
    (AddBoxBlock(amount: final want), AddBoxBlock(:final amount)) => want == amount,
    _ => false,
  };

  /// Kutu düğmeleri alttaki görsel düğmelerle (Başlat, İpucu, Temizle) aynı hücrelere bölünür ve her biri
  /// hücredeki görselin görünen kenarlarına oturur; böylece dik ekranda tam üstlerine hizalanır. Satır zaten
  /// [ImageButton.padding] kadar içeriden başladığı için hücre genişliği bu pay eklenerek hesaplanır.
  Widget _boxButtons(RepeatController controller, double width, double height) {
    final t = context.l10n;
    final cell = (width + ImageButton.padding * 2) / _boxBlocks.length;
    final inset = ImageButton.visibleInset(cell - ImageButton.padding * 2);
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: inset - ImageButton.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final block in _boxBlocks)
            WideActionButton(
              tone: AppTones.amber,
              icon: SvgPicture.asset(
                RepeatAssets.boxButton,
                width: height * WideActionButton.iconAboveRatio,
                height: height * WideActionButton.iconAboveRatio,
                colorFilter: const ColorFilter.mode(AppColors.brown, BlendMode.srcIn),
              ),
              iconAbove: true,
              highlighted: _addsHinted(controller.boxHint, block),
              text: RepeatTexts.boxSign(block),
              label: switch (block) {
                SetBoxBlock() => t.variableBoxSetLabel,
                AddBoxBlock(:final amount) when amount > 0 => t.variableBoxIncreaseLabel,
                _ => t.variableBoxDecreaseLabel,
              },
              width: cell - inset * 2,
              height: height,
              onPressed: controller.canAddInner ? () => controller.addInner(block) : null,
            ),
        ],
      ),
    );
  }
}
