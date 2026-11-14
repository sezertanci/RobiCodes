import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/screen_scale.dart';
import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../engine/path_finder_level.dart';
import '../path_finder_controller.dart';
import 'board_view.dart';
import 'command_strip.dart';
import 'path_finder_controls.dart';

/// Bir seviyenin oyun ekranı. Geniş ekranda (tablet) harita solda, kontroller sağdadır;
/// dar ekranda (telefon) kontroller ekranın altında sabit durur ve harita aradaki alana sığdırılır.
/// Ekran bunun için fazla kısaysa (ör. yatay telefon) bütün içerik kaydırılabilir olur.
/// Düğme, komut kutusu ve harita boyları [ScreenScale] ile tablette büyür.
final class PathFinderView extends StatefulWidget {
  const PathFinderView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    super.key,
  });

  final PathFinderLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  /// Bu genişlik ve yükseklikten büyük ekranlarda kontroller haritanın yanına geçer.
  static const wideMinWidth = ScreenScale.wideMinWidth;
  static const wideMinHeight = 520.0;

  /// Dar ekranda kontrollerin sabit kalabilmesi için gereken en az yükseklik.
  static const fixedControlsMinHeight = 560.0;

  @override
  State<PathFinderView> createState() => _PathFinderViewState();
}

final class _PathFinderViewState extends State<PathFinderView> {
  PathFinderController? _controller;

  static const _padding = 16.0;
  static const _gap = 12.0;
  static const _wideChip = 56.0;
  static const _narrowChip = 50.0;
  static const _wideButton = 60.0;
  static const _narrowButton = 50.0;
  static const _maxChip = 72.0;
  static const _maxButton = 96.0;

  /// Haritanın küçülebileceği en küçük kare boyu; altına inilirse harita kendi içinde kaydırılır.
  static const _minTileSize = 28.0;

  /// Hareketi azaltma ayarı açıksa robot daha hızlı yürür. Ayar seviye başında okunur.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= PathFinderController(
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
    final scale = ScreenScale.of(context);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => LayoutBuilder(
        builder: (context, constraints) {
          final wide =
              constraints.maxWidth >= PathFinderView.wideMinWidth &&
              constraints.maxHeight >= PathFinderView.wideMinHeight;
          if (wide) {
            return _wideLayout(controller, scale);
          }
          return constraints.maxHeight >= PathFinderView.fixedControlsMinHeight
              ? _narrowLayout(controller, scale)
              : _scrollLayout(controller, scale, constraints.maxWidth);
        },
      ),
    );
  }

  Widget _header(PathFinderController controller, double chipSize) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SpeechBubble(message: controller.message, mood: controller.mood),
      const SizedBox(height: _gap),
      CommandStrip(controller: controller, chipSize: chipSize),
      const SizedBox(height: _gap),
    ],
  );

  Widget _narrowControls(PathFinderController controller, ScreenScale scale) => PathFinderControls(
    controller: controller,
    buttonSize: scale.size(_narrowButton, max: _maxButton),
    stacked: false,
  );

  Widget _narrowLayout(PathFinderController controller, ScreenScale scale) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(controller, scale.size(_narrowChip, max: _maxChip)),
        Expanded(child: _fittedBoard(controller, scale)),
        const SizedBox(height: _gap),
        _narrowControls(controller, scale),
      ],
    ),
  );

  Widget _scrollLayout(PathFinderController controller, ScreenScale scale, double width) => SingleChildScrollView(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(controller, scale.size(_narrowChip, max: _maxChip)),
        BoardView(controller: controller, tileSize: _tileSize(scale, width - _padding * 2, double.infinity)),
        const SizedBox(height: _gap * 2),
        _narrowControls(controller, scale),
      ],
    ),
  );

  Widget _wideLayout(PathFinderController controller, ScreenScale scale) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(controller, scale.size(_wideChip, max: _maxChip)),
        Expanded(child: LayoutBuilder(builder: (context, area) => _wideBody(controller, scale, area))),
      ],
    ),
  );

  /// Harita ve kontroller ortalanmış tek bir grup olarak yan yana durur. Düğmeler alanın
  /// yüksekliğine sığacak kadar büyür; harita kalan genişliği doldurur.
  Widget _wideBody(PathFinderController controller, ScreenScale scale, BoxConstraints area) {
    final fitting = PathFinderControls.stackedButtonSizeFor(area.maxHeight);
    final buttonSize = max(_wideButton, min(scale.size(_wideButton, max: _maxButton), fitting));
    final boardWidth = area.maxWidth - PathFinderControls.stackedWidth(buttonSize) - _gap * 2;
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
            child: PathFinderControls(controller: controller, buttonSize: buttonSize, stacked: true),
          ),
        ),
      ],
    );
  }

  /// Haritayı verilen alana sığdırır. Alan çok küçükse harita en küçük boyda çizilip kaydırılır.
  Widget _fittedBoard(PathFinderController controller, ScreenScale scale) => LayoutBuilder(
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

  /// Haritanın verilen alana sığacağı kare boyu. Üst sınır [BoardView.maxTileSize] tabanından
  /// ekrana göre büyütülür; böylece harita tablette de alanı doldurur.
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
