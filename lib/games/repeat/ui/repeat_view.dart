import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/screen_scale.dart';
import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../../path_finder/ui/board_view.dart';
import '../engine/repeat_level.dart';
import '../engine/starting_program.dart';
import '../repeat_controller.dart';
import 'program_strip.dart';
import 'repeat_controls.dart';

/// "Tekrar Et" seviye ekranı. Üstte konuşma balonu ve blok şeridi bulunur. Geniş ekranda (tablet)
/// harita solda, kontroller sağdadır; dar ekranda (telefon) kontroller altta sabit durur ve harita
/// aradaki alana sığdırılır. Ekran bunun için fazla kısaysa (ör. yatay telefon) bütün içerik kaydırılır.
/// Düzen "Robotun Yolunu Bul" ekranıyla aynıdır; harita da onunla ortaktır.
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

  static const wideMinWidth = ScreenScale.wideMinWidth;
  static const wideMinHeight = 520.0;

  /// Dar ekranda kontrollerin sabit kalabilmesi için gereken en az yükseklik. Blok şeridi tekrar
  /// bloğu sığsın diye "Robotun Yolunu Bul" şeridinden yüksektir.
  static const fixedControlsMinHeight = 620.0;

  /// Bu genişliğin altında tekrar bloğunun etiketi kısalır.
  static const compactMaxWidth = ScreenScale.narrowMaxWidth;

  @override
  State<RepeatView> createState() => _RepeatViewState();
}

final class _RepeatViewState extends State<RepeatView> {
  RepeatController? _controller;

  static const _padding = 16.0;
  static const _gap = 12.0;
  static const _wideChip = 50.0;
  static const _narrowChip = 44.0;
  static const _wideButton = 60.0;
  static const _narrowButton = 50.0;
  static const _maxChip = 64.0;
  static const _maxButton = 96.0;

  /// Haritanın küçülebileceği en küçük kare boyu; altına inilirse harita kendi içinde kaydırılır.
  static const _minTileSize = 28.0;

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
          ? RepeatController.reducedStepDuration
          : RepeatController.defaultStepDuration,
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
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < RepeatView.compactMaxWidth;
          final wide =
              constraints.maxWidth >= RepeatView.wideMinWidth && constraints.maxHeight >= RepeatView.wideMinHeight;
          if (wide) {
            return _wideLayout(controller, scale, compact);
          }
          return constraints.maxHeight >= RepeatView.fixedControlsMinHeight
              ? _narrowLayout(controller, scale, compact)
              : _scrollLayout(controller, scale, compact, constraints.maxWidth);
        },
      ),
    );
  }

  Widget _header(RepeatController controller, double chipSize, bool compact) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SpeechBubble(message: controller.message, mood: controller.mood),
      const SizedBox(height: _gap),
      ProgramStrip(controller: controller, chipSize: chipSize, compact: compact),
      const SizedBox(height: _gap),
    ],
  );

  double _narrowButtonSize(ScreenScale scale) => scale.size(_narrowButton, max: _maxButton);

  Widget _narrowControls(RepeatController controller, ScreenScale scale) =>
      RepeatControls(controller: controller, buttonSize: _narrowButtonSize(scale), stacked: false);

  Widget _narrowLayout(RepeatController controller, ScreenScale scale, bool compact) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(controller, scale.size(_narrowChip, max: _maxChip), compact),
        Expanded(child: LayoutBuilder(builder: (context, area) => _narrowBody(controller, scale, area.maxHeight))),
      ],
    ),
  );

  /// Harita kalan alana sığdırılır, kontroller altta sabit durur. Balon metni o kadar uzarsa ki
  /// (ör. çeviri daha uzunsa) kontrollere bile yer kalmazsa harita ve kontroller birlikte kaydırılır;
  /// böylece düzen hiçbir dilde taşmaz.
  Widget _narrowBody(RepeatController controller, ScreenScale scale, double height) {
    if (height > _gap + RepeatControls.rowHeight(_narrowButtonSize(scale))) {
      return Column(
        children: [
          Expanded(child: _fittedBoard(controller, scale)),
          const SizedBox(height: _gap),
          _narrowControls(controller, scale),
        ],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          BoardView(controller: controller, tileSize: _minTileSize),
          const SizedBox(height: _gap),
          _narrowControls(controller, scale),
        ],
      ),
    );
  }

  Widget _scrollLayout(RepeatController controller, ScreenScale scale, bool compact, double width) =>
      SingleChildScrollView(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            _header(controller, scale.size(_narrowChip, max: _maxChip), compact),
            BoardView(controller: controller, tileSize: _tileSize(scale, width - _padding * 2, double.infinity)),
            const SizedBox(height: _gap * 2),
            _narrowControls(controller, scale),
          ],
        ),
      );

  Widget _wideLayout(RepeatController controller, ScreenScale scale, bool compact) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(controller, scale.size(_wideChip, max: _maxChip), compact),
        Expanded(child: LayoutBuilder(builder: (context, area) => _wideBody(controller, scale, area))),
      ],
    ),
  );

  /// Harita ve kontroller ortalanmış tek bir grup olarak yan yana durur. Düğmeler alanın
  /// yüksekliğine sığacak kadar büyür; harita kalan genişliği doldurur.
  Widget _wideBody(RepeatController controller, ScreenScale scale, BoxConstraints area) {
    final fitting = RepeatControls.stackedButtonSizeFor(area.maxHeight);
    final buttonSize = max(_narrowButton, min(scale.size(_wideButton, max: _maxButton), fitting));
    final boardWidth = area.maxWidth - RepeatControls.stackedWidth(buttonSize) - _gap * 2;
    final tileSize = _tileSize(scale, boardWidth, area.maxHeight);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (tileSize >= _minTileSize)
          BoardView(controller: controller, tileSize: tileSize)
        else
          Expanded(child: _fittedBoard(controller, scale)),
        const SizedBox(width: _gap * 2),
        Center(
          child: SingleChildScrollView(
            child: RepeatControls(controller: controller, buttonSize: buttonSize, stacked: true),
          ),
        ),
      ],
    );
  }

  /// Haritayı verilen alana sığdırır. Alan çok küçükse harita en küçük boyda çizilip kaydırılır.
  Widget _fittedBoard(RepeatController controller, ScreenScale scale) => LayoutBuilder(
    builder: (context, area) {
      final tileSize = _tileSize(scale, area.maxWidth, area.maxHeight);
      if (tileSize >= _minTileSize) {
        return Center(
          child: BoardView(controller: controller, tileSize: tileSize),
        );
      }
      return SingleChildScrollView(
        child: Center(
          child: BoardView(controller: controller, tileSize: _minTileSize),
        ),
      );
    },
  );

  /// Haritanın verilen alana sığacağı kare boyu.
  double _tileSize(ScreenScale scale, double width, double height) {
    final board = _controller!.board;
    final frame = BoardView.borderWidth * 2;
    return [
      scale.size(BoardView.maxTileSize),
      (width - frame) / board.width,
      (height - frame) / board.height,
    ].reduce(min);
  }
}
