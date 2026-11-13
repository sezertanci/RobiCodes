import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../engine/path_finder_board.dart';
import '../path_finder_controller.dart';
import '../../../features/play/widgets/dashed_frame.dart';
import 'path_finder_assets.dart';

/// Oyun alanı: çim kareler, engeller, altınlar, bayrak, robotun izi, ipucu karesi ve robot.
/// Kare boyu dışarıdan verilir; böylece harita telefonda ve tablette ekrana sığar.
final class BoardView extends StatelessWidget {
  const BoardView({required this.controller, required this.tileSize, super.key});

  final PathFinderController controller;
  final double tileSize;

  /// Telefondaki en büyük kare boyu; tablette ekran ölçeğiyle büyütülür.
  static const maxTileSize = 104.0;
  static const borderWidth = 6.0;
  static const _grassLight = Color(0xFFA6E682);
  static const _grassDark = Color(0xFF92DA6C);
  static const _border = Color(0xFF3DA845);
  static const _rockScale = 0.8;
  static const _startScale = 0.88;
  static const _robotScale = 0.72;
  static const _coinScale = 0.6;
  static const _trailScale = 0.4;

  PathFinderBoard get _board => controller.board;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: _border, width: borderWidth),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: _board.width * tileSize,
            height: _board.height * tileSize,
            child: Stack(
              children: [
                for (var y = 0; y < _board.height; y++)
                  for (var x = 0; x < _board.width; x++) _cell((x: x, y: y), _tile((x: x, y: y))),
                _cell(_board.start, _scaled(_startScale, const DashedFrame(color: AppColors.navy))),
                for (final MapEntry(key: point, value: direction) in controller.trail.entries)
                  _cell(point, _scaled(_trailScale, _TrailMark(direction))),
                for (final (index, coin) in _board.coins.indexed)
                  if (!controller.collectedCoins.contains(index))
                    _cell(coin, _scaled(_coinScale, SvgPicture.asset(PathFinderAssets.coin))),
                _cell(_board.goal, SvgPicture.asset(PathFinderAssets.flag)),
                if (controller.hint case final hint?) _cell(hint.target, const _PulsingHint()),
                _robot(),
              ],
            ),
          ),
        ),
      );

  Widget _tile(GridPoint point) {
    final grass = ColoredBox(color: (point.x + point.y).isEven ? _grassLight : _grassDark);
    return switch (_board.obstacles[point]) {
      Obstacle.water => SvgPicture.asset(PathFinderAssets.water, fit: BoxFit.cover),
      Obstacle.rock => Stack(
          fit: StackFit.expand,
          children: [grass, _scaled(_rockScale, SvgPicture.asset(PathFinderAssets.rock))],
        ),
      _ => grass,
    };
  }

  Widget _cell(GridPoint point, Widget child) => Positioned(
        left: point.x * tileSize,
        top: point.y * tileSize,
        width: tileSize,
        height: tileSize,
        child: child,
      );

  static Widget _scaled(double factor, Widget child) =>
      Center(child: FractionallySizedBox(widthFactor: factor, heightFactor: factor, child: child));

  Widget _robot() => AnimatedPositioned(
        duration: controller.stepDuration * 0.85,
        curve: Curves.easeInOut,
        left: controller.robot.x * tileSize,
        top: controller.robot.y * tileSize,
        width: tileSize,
        height: tileSize,
        child: _scaled(
          _robotScale,
          _RobotSprite(
            reaction: controller.reaction,
            reactionCount: controller.reactionCount,
            bumpDirection: controller.bumpDirection,
          ),
        ),
      );
}

/// Robotun ayrıldığı karede kalan yön oku.
final class _TrailMark extends StatelessWidget {
  const _TrailMark(this.direction);

  final Direction direction;

  static const _icons = {
    Direction.up: Icons.arrow_upward_rounded,
    Direction.down: Icons.arrow_downward_rounded,
    Direction.left: Icons.arrow_back_rounded,
    Direction.right: Icons.arrow_forward_rounded,
  };

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.yellow, shape: BoxShape.circle),
        child: FittedBox(child: Icon(_icons[direction], color: AppColors.navy)),
      );
}

/// İpucunun gösterdiği kare: nabız gibi atan sarı, kesik çizgili çerçeve.
final class _PulsingHint extends StatefulWidget {
  const _PulsingHint();

  @override
  State<_PulsingHint> createState() => _PulsingHintState();
}

final class _PulsingHintState extends State<_PulsingHint> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 700), lowerBound: 0.85);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _pulse.value = 1;
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _pulse,
        child: const DashedFrame(color: AppColors.yellow, strokeWidth: 5),
      );
}

/// Robot ve tek seferlik hareketleri: engele çarpma, sevinç zıplaması ve kafa sallama.
final class _RobotSprite extends StatefulWidget {
  const _RobotSprite({required this.reaction, required this.reactionCount, required this.bumpDirection});

  final RobotReaction reaction;
  final int reactionCount;
  final Direction? bumpDirection;

  @override
  State<_RobotSprite> createState() => _RobotSpriteState();
}

final class _RobotSpriteState extends State<_RobotSprite> with SingleTickerProviderStateMixin {
  late final AnimationController _animation =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  static const _bumpDistance = 0.25;
  static const _jumpHeight = 0.3;
  static const _shakeAngle = 0.25;

  @override
  void didUpdateWidget(_RobotSprite oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changed = widget.reactionCount != oldWidget.reactionCount;
    if (changed && widget.reaction != RobotReaction.none && !MediaQuery.disableAnimationsOf(context)) {
      _animation.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: _transform(_animation.value, constraints.maxWidth),
            child: child,
          ),
          child: Image.asset(AppAssets.robot),
        ),
      );

  Matrix4 _transform(double t, double size) {
    if (t == 0 || t == 1) {
      return Matrix4.identity();
    }
    switch (widget.reaction) {
      case RobotReaction.bump:
        final direction = widget.bumpDirection ?? Direction.right;
        final distance = sin(t * pi) * _bumpDistance * size;
        return Matrix4.translationValues(direction.dx * distance, direction.dy * distance, 0);
      case RobotReaction.celebrate:
        return Matrix4.translationValues(0, -sin(t * 2 * pi).abs() * _jumpHeight * size, 0);
      case RobotReaction.shake:
        return Matrix4.rotationZ(sin(t * 4 * pi) * _shakeAngle);
      case RobotReaction.none:
        return Matrix4.identity();
    }
  }
}
