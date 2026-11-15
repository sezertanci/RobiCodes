import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/screen_scale.dart';
import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../engine/if_then_level.dart';
import '../if_then_controller.dart';
import '../../../l10n/l10n.dart';
import 'block_palette.dart';
import 'if_then_metrics.dart';
import 'lane_scene.dart';
import 'rule_board.dart';

/// "Eğer Böyleyse" seviye ekranı. Üstte konuşma balonu ve robotun yolu bulunur. Geniş ekranda
/// (tablet) kurallar solda, bloklar ve düğmeler sağdadır; böylece kurallar ekranın alt kenarına kadar
/// uzanır. Dar ekranda bloklar kuralların altında, düğmeler altta sabit durur; ekran bunun için fazla
/// kısaysa (ör. yatay telefon) bütün içerik kaydırılır.
final class IfThenView extends StatefulWidget {
  const IfThenView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    super.key,
  });

  final IfThenLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  static const wideMinWidth = ScreenScale.wideMinWidth;
  static const wideMinHeight = 520.0;

  /// Dar ekranda düğmelerin sabit kalabilmesi için gereken en az yükseklik.
  static const fixedControlsMinHeight = 480.0;

  @override
  State<IfThenView> createState() => _IfThenViewState();
}

final class _IfThenViewState extends State<IfThenView> {
  IfThenController? _controller;

  static const _padding = 16.0;
  static const _gap = 12.0;
  static const _button = 56.0;
  static const _maxButton = 84.0;
  static const _maxCellOnTablet = 104.0;

  /// Tablette kural ve blokların en fazla büyüme oranı.
  static const _maxGrowth = 1.25;

  /// Hareketi azaltma ayarı açıksa robot daha hızlı yürür. Ayar seviye başında okunur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= IfThenController(
      level: widget.level,
      onCompleted: widget.onCompleted,
      feedback: widget.feedback,
      stepDuration: MediaQuery.disableAnimationsOf(context)
          ? IfThenController.reducedStepDuration
          : IfThenController.defaultStepDuration,
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
    final scale = ScreenScale.of(context);
    final ratio = scale.size(1, max: _maxGrowth);
    final buttonSize = scale.size(_button, max: _maxButton);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - _padding * 2;
          final cell = _cellSize(controller, width, scale);
          final wide =
              constraints.maxWidth >= IfThenView.wideMinWidth && constraints.maxHeight >= IfThenView.wideMinHeight;
          if (wide) {
            final metrics = IfThenMetrics.forWidth((width - _gap * 2) / 2, ratio);
            return _fixed(controller, cell, [_wideBody(controller, metrics, buttonSize)]);
          }
          final metrics = IfThenMetrics.forWidth(width, ratio);
          if (constraints.maxHeight < IfThenView.fixedControlsMinHeight) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(_padding),
              child: Column(
                children: [..._top(controller, cell), _program(controller, metrics), _controls(controller, buttonSize)],
              ),
            );
          }
          return _fixed(controller, cell, [
            Expanded(child: SingleChildScrollView(child: _program(controller, metrics))),
            _controls(controller, buttonSize),
          ]);
        },
      ),
    );
  }

  /// Kare boyu: yol ekrana sığacak kadar küçülür ama [LaneScene.minCell] altına inmez.
  static double _cellSize(IfThenController controller, double width, ScreenScale scale) {
    final fit = (width - LaneScene.padding * 2) / LaneScene.cellCount(controller);
    return fit.clamp(LaneScene.minCell, scale.size(LaneScene.maxCell, max: _maxCellOnTablet));
  }

  /// Üst kısmın sabit durduğu düzen; [rest] kalan alanı doldurur.
  Widget _fixed(IfThenController controller, double cell, List<Widget> rest) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(children: [..._top(controller, cell), ...rest]),
  );

  List<Widget> _top(IfThenController controller, double cell) => [
    SpeechBubble(message: controller.message, mood: controller.mood),
    const SizedBox(height: _gap),
    Center(
      child: LaneScene(controller: controller, cell: cell),
    ),
    const SizedBox(height: _gap),
  ];

  Widget _wideBody(IfThenController controller, IfThenMetrics metrics, double buttonSize) => Expanded(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: RuleBoard(controller: controller, metrics: metrics),
          ),
        ),
        const SizedBox(width: _gap * 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: BlockPalette(controller: controller, metrics: metrics),
                ),
              ),
              // Düğmelerin görünen sol kenarı blokların sol kenarıyla aynı çizgiye gelir.
              Transform.translate(
                offset: Offset(-ImageButton.visibleInset(buttonSize), 0),
                child: _controls(controller, buttonSize, alignment: WrapAlignment.start),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  /// Dar düzende kurallar ve altında bloklar.
  Widget _program(IfThenController controller, IfThenMetrics metrics) => Align(
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RuleBoard(controller: controller, metrics: metrics),
        const SizedBox(height: _gap * 2),
        BlockPalette(controller: controller, metrics: metrics),
      ],
    ),
  );

  /// Başlat, İpucu ve Temizle düğmeleri. Dar düzende ortalanır; geniş düzende blokların altında
  /// onlarla aynı hizada, sola yaslı durur.
  Widget _controls(IfThenController controller, double size, {WrapAlignment alignment = WrapAlignment.center}) {
    final editable = controller.isEditable;
    final t = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: _gap),
      child: Wrap(
        alignment: alignment,
        children: [
          ImageButton(
            asset: AppAssets.runButton,
            label: t.commonRun,
            size: size,
            highlighted: editable && controller.isComplete,
            onPressed: editable ? controller.run : null,
          ),
          ImageButton(
            asset: AppAssets.hintButton,
            label: t.commonHint,
            size: size,
            onPressed: editable ? controller.showHint : null,
          ),
          ImageButton(
            asset: AppAssets.clearButton,
            label: t.commonClear,
            size: size,
            onPressed: editable ? controller.clear : null,
          ),
        ],
      ),
    );
  }
}
