import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../engine/path_finder_board.dart';
import '../board_scene.dart';
import '../../../features/play/widgets/dashed_frame.dart';
import '../../../features/play/widgets/pulsing_hint_frame.dart';
import '../../../features/play/widgets/robot_sprite.dart';
import 'path_finder_assets.dart';

/// Oyun alanı: çim kareler, engeller, altınlar, bayrak, robotun izi, ipucu karesi ve robot.
/// Kare boyu dışarıdan verilir; böylece harita telefonda ve tablette ekrana sığar.
final class BoardView extends StatelessWidget {
  const BoardView({required this.controller, required this.tileSize, super.key});

  final BoardScene controller;
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
            _cell(_board.goal, SvgPicture.asset(AppAssets.flag)),
            if (controller.hint case final hint?) _cell(hint.target, const PulsingHintFrame()),
            _robot(),
          ],
        ),
      ),
    ),
  );

  Widget _tile(GridPoint point) {
    final grass = ColoredBox(color: (point.x + point.y).isEven ? _grassLight : _grassDark);
    return switch (_board.obstacles[point]) {
      Obstacle.water => SvgPicture.asset(AppAssets.water, fit: BoxFit.cover),
      Obstacle.rock => Stack(
        fit: StackFit.expand,
        children: [grass, _scaled(_rockScale, SvgPicture.asset(AppAssets.rock))],
      ),
      _ => grass,
    };
  }

  Widget _cell(GridPoint point, Widget child) =>
      Positioned(left: point.x * tileSize, top: point.y * tileSize, width: tileSize, height: tileSize, child: child);

  static Offset _bumpOffset(Direction? direction) =>
      direction == null ? const Offset(1, 0) : Offset(direction.dx.toDouble(), direction.dy.toDouble());

  static Widget _scaled(double factor, Widget child) => Center(
    child: FractionallySizedBox(widthFactor: factor, heightFactor: factor, child: child),
  );

  Widget _robot() => AnimatedPositioned(
    duration: controller.stepDuration * 0.85,
    curve: Curves.easeInOut,
    left: controller.robot.x * tileSize,
    top: controller.robot.y * tileSize,
    width: tileSize,
    height: tileSize,
    child: _scaled(
      _robotScale,
      RobotSprite(
        reaction: controller.reaction,
        reactionCount: controller.reactionCount,
        bumpDirection: _bumpOffset(controller.bumpDirection),
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
