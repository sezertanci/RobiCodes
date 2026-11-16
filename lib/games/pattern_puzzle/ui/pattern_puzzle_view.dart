import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../../../app/screen_scale.dart';
import '../../../features/play/game_feedback.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../../features/play/widgets/speech_bubble.dart';
import '../../../features/sound/tap_sound.dart';
import '../../../l10n/l10n.dart';
import '../../path_finder/ui/lamp_bulb.dart';
import '../engine/pattern_level.dart';
import '../pattern_puzzle_controller.dart';
import 'pattern_tile_view.dart';
import 'tile_button.dart';

/// "Desen Bulmacası" Kolay–Zor ekranı: üstte konuşma balonu, ortada desen ve seçenekler, altta İpucu düğmesi.
final class PatternPuzzleView extends StatefulWidget {
  const PatternPuzzleView({
    required this.level,
    required this.onCompleted,
    this.feedback = const SilentGameFeedback(),
    super.key,
  });

  final PatternPuzzleLevel level;
  final ValueChanged<int> onCompleted;

  /// Robot sevindiğinde veya üzüldüğünde çalınan ses; verilmezse ses çalınmaz.
  final GameFeedback feedback;

  @override
  State<PatternPuzzleView> createState() => _PatternPuzzleViewState();
}

final class _PatternPuzzleViewState extends State<PatternPuzzleView> {
  late final _controller = PatternPuzzleController(
    level: widget.level,
    onCompleted: widget.onCompleted,
    feedback: widget.feedback,
  );

  static const _padding = 16.0;
  static const _gap = 12.0;
  static const _tileGap = 8.0;
  static const _minTile = 36.0;
  static const _tile = 72.0;
  static const _maxTile = 104.0;
  static const _button = 56.0;
  static const _maxButton = 84.0;

  /// Seçenek düğmesinin desen parçasından büyüklüğü ve içindeki parçanın düğmeye oranı.
  static const _optionGrowth = 1.2;
  static const _optionTileRatio = 0.7;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = ScreenScale.of(context);
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            SpeechBubble(message: _controller.message, mood: _controller.mood),
            const SizedBox(height: _gap),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final tile = _tileSize(constraints.maxWidth, scale);
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _pattern(tile),
                          const SizedBox(height: _gap * 3),
                          _options(tile * _optionGrowth),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: _gap),
            ImageButton(
              asset: AppAssets.hintButton,
              label: context.l10n.commonHint,
              size: scale.size(_button, max: _maxButton),
              onPressed: _controller.isDone ? null : _controller.showHint,
            ),
          ],
        ),
      ),
    );
  }

  /// Desen tek satıra sığacak kadar küçülür; çok küçülecekse alt satıra geçer.
  double _tileSize(double width, ScreenScale scale) {
    final count = widget.level.tiles.length;
    final fit = (width - _padding * 2 - (count - 1) * _tileGap) / count;
    return fit.clamp(_minTile, scale.size(_tile, max: _maxTile));
  }

  Widget _pattern(double size) => DecoratedBox(
    decoration: BoxDecoration(
      color: AppColors.panel,
      borderRadius: BorderRadius.circular(AppMetrics.mediumRadius),
      boxShadow: const [BoxShadow(color: AppColors.shadow, offset: Offset(0, AppMetrics.lip))],
    ),
    child: Padding(
      padding: const EdgeInsets.all(_padding),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: _tileGap,
        runSpacing: _tileGap,
        children: [for (var i = 0; i < widget.level.tiles.length; i++) _slot(i, size)],
      ),
    ),
  );

  Widget _slot(int index, double size) {
    final tile = _controller.shownTile(index);
    if (tile != null && index != _controller.wrongSlot) {
      return Semantics(
        label: PatternTileView.labelOf(context.l10n, tile),
        child: PatternTileView(tile: tile, size: size),
      );
    }
    if (tile != null) {
      return SizedBox.square(
        dimension: size,
        child: Stack(
          children: [
            PatternTileView(tile: tile, size: size),
            const Positioned.fill(child: WrongLampFrame()),
          ],
        ),
      );
    }
    return _MissingSlot(
      size: size,
      selected: _controller.selected == index,
      onPressed: () => _controller.selectSlot(index),
    );
  }

  Widget _options(double size) {
    final t = context.l10n;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: _tileGap,
      runSpacing: _tileGap,
      children: [
        for (final option in widget.level.options)
          TileButton(
            label: PatternTileView.labelOf(t, option),
            size: size,
            edge: AppColors.navy,
            highlighted: option == _controller.highlighted,
            onPressed: _controller.isDone ? null : () => _controller.pick(option),
            child: PatternTileView(tile: option, size: size * _optionTileRatio),
          ),
      ],
    );
  }
}

/// Doldurulmayı bekleyen eksik parça: soru işaretli daire. Seçenekler seçili olanı doldurur; kalın kenarlıdır.
final class _MissingSlot extends StatelessWidget {
  const _MissingSlot({required this.size, required this.selected, required this.onPressed});

  final double size;
  final bool selected;
  final VoidCallback onPressed;

  static const _border = 2.0;
  static const _selectedBorder = 5.0;
  static const _textRatio = 0.5;

  @override
  Widget build(BuildContext context) {
    final onTap = context.withTapSound(onPressed);
    return Semantics(
      button: true,
      selected: selected,
      label: context.l10n.patternMissingSlot,
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.navy, width: selected ? _selectedBorder : _border),
          ),
          child: Text(
            '?',
            style: TextStyle(fontSize: size * _textRatio, fontWeight: FontWeight.w900, color: AppColors.navy),
          ),
        ),
      ),
    );
  }
}
