import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/screen_scale.dart';
import '../../path_finder/board_scene.dart';
import '../../path_finder/ui/board_view.dart';
import 'repeat_controls.dart';

/// Blok şeritli oyunların ("Tekrar Et", "Hata Avcısı", "Kendi Komutunu Oluştur") ortak ekran düzeni.
/// Üstte başlık (konuşma balonu ve şeritler) bulunur. Geniş ekranda (tablet) harita solda, kontroller
/// sağdadır; dar ekranda (telefon) kontroller altta sabit durur ve harita aradaki alana sığdırılır.
/// Ekran bunun için fazla kısaysa (ör. yatay telefon) bütün içerik kaydırılır.
/// Düzen "Robotun Yolunu Bul" ekranıyla aynıdır; harita da onunla ortaktır.
final class ProgramGameLayout extends StatelessWidget {
  const ProgramGameLayout({
    required this.scene,
    required this.header,
    required this.controls,
    this.wideRows = 1,
    this.wideMinHeight = defaultWideMinHeight,
    this.fixedControlsMinHeight = defaultFixedControlsMinHeight,
    super.key,
  });

  final BoardScene scene;

  /// Verilen blok boyunda başlık; [compact] dar ekranda etiketlerin kısalacağını söyler.
  final Widget Function(double chipSize, bool compact) header;

  /// Verilen düğme boyunda kontroller; [stacked] düğmelerin yön tuşlarının altında dizileceğini söyler.
  final Widget Function(double buttonSize, bool stacked) controls;

  /// Kontrollerdeki geniş düğme satırı sayısı (bkz. [RepeatControls.stackedButtonSizeFor]).
  final int wideRows;
  final double wideMinHeight;

  /// Dar ekranda kontrollerin sabit kalabilmesi için gereken en az yükseklik.
  final double fixedControlsMinHeight;

  static const wideMinWidth = ScreenScale.wideMinWidth;
  static const defaultWideMinHeight = 520.0;

  /// Blok şeridi tekrar bloğu sığsın diye "Robotun Yolunu Bul" ekranından yüksektir.
  static const defaultFixedControlsMinHeight = 620.0;

  /// Bu genişliğin altında tekrar bloğunun etiketi kısalır.
  static const compactMaxWidth = ScreenScale.narrowMaxWidth;

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

  @override
  Widget build(BuildContext context) {
    final scale = ScreenScale.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < compactMaxWidth;
        final wide = constraints.maxWidth >= wideMinWidth && constraints.maxHeight >= wideMinHeight;
        if (wide) {
          return _wideLayout(scale, compact);
        }
        return constraints.maxHeight >= fixedControlsMinHeight
            ? _narrowLayout(scale, compact)
            : _scrollLayout(scale, compact, constraints.maxWidth);
      },
    );
  }

  Widget _header(double chipSize, bool compact) => Padding(
    padding: const EdgeInsets.only(bottom: _gap),
    child: header(chipSize, compact),
  );

  double _narrowButtonSize(ScreenScale scale) => scale.size(_narrowButton, max: _maxButton);

  Widget _narrowControls(ScreenScale scale) => controls(_narrowButtonSize(scale), false);

  Widget _narrowLayout(ScreenScale scale, bool compact) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(scale.size(_narrowChip, max: _maxChip), compact),
        Expanded(child: LayoutBuilder(builder: (context, area) => _narrowBody(scale, area.maxHeight))),
      ],
    ),
  );

  /// Harita kalan alana sığdırılır, kontroller altta sabit durur. Balon metni o kadar uzarsa ki
  /// (ör. çeviri daha uzunsa) kontrollere bile yer kalmazsa harita ve kontroller birlikte kaydırılır;
  /// böylece düzen hiçbir dilde taşmaz.
  Widget _narrowBody(ScreenScale scale, double height) {
    if (height > _gap + RepeatControls.rowHeight(_narrowButtonSize(scale), wideRows: wideRows)) {
      return Column(
        children: [
          Expanded(child: _fittedBoard(scale)),
          const SizedBox(height: _gap),
          _narrowControls(scale),
        ],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          BoardView(controller: scene, tileSize: _minTileSize),
          const SizedBox(height: _gap),
          _narrowControls(scale),
        ],
      ),
    );
  }

  Widget _scrollLayout(ScreenScale scale, bool compact, double width) => SingleChildScrollView(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(scale.size(_narrowChip, max: _maxChip), compact),
        BoardView(controller: scene, tileSize: _tileSize(scale, width - _padding * 2, double.infinity)),
        const SizedBox(height: _gap * 2),
        _narrowControls(scale),
      ],
    ),
  );

  Widget _wideLayout(ScreenScale scale, bool compact) => Padding(
    padding: const EdgeInsets.all(_padding),
    child: Column(
      children: [
        _header(scale.size(_wideChip, max: _maxChip), compact),
        Expanded(child: LayoutBuilder(builder: (context, area) => _wideBody(scale, area))),
      ],
    ),
  );

  /// Harita ve kontroller ortalanmış tek bir grup olarak yan yana durur. Düğmeler alanın
  /// yüksekliğine sığacak kadar büyür; harita kalan genişliği doldurur.
  Widget _wideBody(ScreenScale scale, BoxConstraints area) {
    final fitting = RepeatControls.stackedButtonSizeFor(area.maxHeight, wideRows: wideRows);
    final buttonSize = max(_narrowButton, min(scale.size(_wideButton, max: _maxButton), fitting));
    final boardWidth = area.maxWidth - RepeatControls.stackedWidth(buttonSize) - _gap * 2;
    final tileSize = _tileSize(scale, boardWidth, area.maxHeight);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (tileSize >= _minTileSize)
          BoardView(controller: scene, tileSize: tileSize)
        else
          Expanded(child: _fittedBoard(scale)),
        const SizedBox(width: _gap * 2),
        Center(child: SingleChildScrollView(child: controls(buttonSize, true))),
      ],
    );
  }

  /// Haritayı verilen alana sığdırır. Alan çok küçükse harita en küçük boyda çizilip kaydırılır.
  Widget _fittedBoard(ScreenScale scale) => LayoutBuilder(
    builder: (context, area) {
      final tileSize = _tileSize(scale, area.maxWidth, area.maxHeight);
      if (tileSize >= _minTileSize) {
        return Center(
          child: BoardView(controller: scene, tileSize: tileSize),
        );
      }
      return SingleChildScrollView(
        child: Center(
          child: BoardView(controller: scene, tileSize: _minTileSize),
        ),
      );
    },
  );

  /// Haritanın verilen alana sığacağı kare boyu.
  double _tileSize(ScreenScale scale, double width, double height) {
    final board = scene.board;
    final frame = BoardView.borderWidth * 2;
    return [
      scale.size(BoardView.maxTileSize),
      (width - frame) / board.width,
      (height - frame) / board.height,
    ].reduce(min);
  }
}
