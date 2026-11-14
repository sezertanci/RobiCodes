import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/screen_scale.dart';
import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../command_order_controller.dart';
import '../command_order_texts.dart';
import '../engine/command_order_engine.dart';
import '../engine/command_order_level.dart';
import 'card_metrics.dart';
import 'card_pool.dart';
import 'slot_board.dart';
import 'task_card.dart';

/// "Komutları Sırala" seviye ekranı. Geniş ekranda (tablet) görev kartı solda, kutular ve kart
/// havuzu sağdadır; dar ekranda görev kartı üstte bir şerittir. Düğmeler altta sabit durur;
/// ekran bunun için fazla kısaysa (ör. yatay telefon) bütün içerik kaydırılır.
final class CommandOrderView extends StatefulWidget {
  const CommandOrderView({
    required this.level,
    required this.shuffle,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    super.key,
  });

  final CommandOrderLevel level;

  /// Kartları karıştırır; ekran açılırken yalnızca bir kez çağrılır.
  final List<OrderCard> Function() shuffle;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  static const wideMinWidth = ScreenScale.wideMinWidth;
  static const wideMinHeight = 520.0;

  /// Dar ekranda düğmelerin sabit kalabilmesi için gereken en az yükseklik.
  static const fixedControlsMinHeight = 480.0;

  @override
  State<CommandOrderView> createState() => _CommandOrderViewState();
}

final class _CommandOrderViewState extends State<CommandOrderView> {
  late final CommandOrderController _controller = CommandOrderController(
    level: widget.level,
    cards: widget.shuffle(),
    onCompleted: widget.onCompleted,
    feedback: widget.feedback,
  );

  static const _padding = 16.0;
  static const _gap = 12.0;
  static const _button = 56.0;
  static const _maxButton = 84.0;

  /// Tablette kartların en fazla büyüme oranı.
  static const _maxCardGrowth = 1.2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = ScreenScale.of(context);
    final ratio = scale.size(1, max: _maxCardGrowth);
    final buttonSize = scale.size(_button, max: _maxButton);
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => LayoutBuilder(
        builder: (context, constraints) {
          final metrics = CardMetrics.forWidth(constraints.maxWidth, ratio);
          final wide =
              constraints.maxWidth >= CommandOrderView.wideMinWidth &&
              constraints.maxHeight >= CommandOrderView.wideMinHeight;
          if (constraints.maxHeight < CommandOrderView.fixedControlsMinHeight) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(_padding),
              child: Column(
                children: [
                  ..._top(),
                  _board(metrics),
                  const SizedBox(height: _gap),
                  _controls(buttonSize),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(_padding),
            child: Column(
              children: [
                if (wide)
                  ..._wideBody(metrics, ratio)
                else ...[
                  ..._top(),
                  Expanded(child: SingleChildScrollView(child: _board(metrics))),
                ],
                const SizedBox(height: _gap),
                _controls(buttonSize),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Dar düzenin üst kısmı: konuşma balonu ve görev şeridi.
  List<Widget> _top() => [
    SpeechBubble(message: _controller.message, mood: _controller.mood),
    const SizedBox(height: _gap),
    TaskCard(level: widget.level, vertical: false, ratio: 1),
    const SizedBox(height: _gap),
  ];

  List<Widget> _wideBody(CardMetrics metrics, double ratio) => [
    SpeechBubble(message: _controller.message, mood: _controller.mood),
    const SizedBox(height: _gap),
    Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: TaskCard(level: widget.level, vertical: true, ratio: ratio),
          ),
          const SizedBox(width: _gap * 2),
          Expanded(child: SingleChildScrollView(child: _board(metrics))),
        ],
      ),
    ),
  ];

  Widget _board(CardMetrics metrics) => Column(
    children: [
      SlotBoard(controller: _controller, metrics: metrics),
      const SizedBox(height: _gap * 2),
      CardPool(controller: _controller, metrics: metrics),
    ],
  );

  Widget _controls(double size) {
    final playing = !_controller.isDone;
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ImageButton(
          asset: AppAssets.checkButton,
          label: CommandOrderTexts.check,
          size: size,
          highlighted: playing && _controller.isFull,
          onPressed: playing && _controller.isFull ? _controller.check : null,
        ),
        ImageButton(
          asset: AppAssets.hintButton,
          label: CommandOrderTexts.hint,
          size: size,
          onPressed: playing ? _controller.showHint : null,
        ),
        ImageButton(
          asset: AppAssets.clearButton,
          label: CommandOrderTexts.clear,
          size: size,
          onPressed: playing && _controller.poolCards.length < _controller.cards.length ? _controller.clear : null,
        ),
      ],
    );
  }
}
