import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../../../features/play/widgets/dashed_frame.dart';
import '../../../features/play/widgets/pulsing_hint_frame.dart';
import '../../../features/play/widgets/robot_sprite.dart';
import '../engine/if_then_level.dart';
import '../if_then_controller.dart';
import '../if_then_texts.dart';
import 'if_then_assets.dart';

/// Robotun yolu: başlangıç karesi, yol kareleri ve bayrak tek sırada. Robotun geçtiği karelerde
/// suya köprü kurulmuş, kapı açılmış, yıldız toplanmış görünür. Yol ekrana sığmazsa yatay kayar
/// ve robot her adımda görünür kalır.
final class LaneScene extends StatefulWidget {
  const LaneScene({required this.controller, required this.cell, super.key});

  final IfThenController controller;

  /// Kare boyu.
  final double cell;

  /// Kare boyunun alt ve üst sınırı; tablette üst sınır ekran ölçeğiyle büyütülür.
  static const minCell = 54.0;
  static const maxCell = 76.0;
  static const padding = 12.0;

  /// Başlangıç ve bayrak kareleriyle birlikte sıradaki kare sayısı.
  static int cellCount(IfThenController controller) => controller.lane.length + 2;

  @override
  State<LaneScene> createState() => _LaneSceneState();
}

final class _LaneSceneState extends State<LaneScene> {
  final _scroll = ScrollController();
  int _shownCell = IfThenController.startCell;

  static const _objectScale = 0.78;
  static const _robotScale = 0.86;
  static const _startInset = 0.08;
  static const _startAlpha = 0.5;
  static const _wrongRing = 5.0;
  static const _radius = 16.0;
  static const _lip = 4.0;

  IfThenController get _controller => widget.controller;
  double get _cell => widget.cell;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _followRobot();
    final lane = _controller.lane;
    final headroom = _headroom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        LaneScene.padding,
        max(0, LaneScene.padding - headroom),
        LaneScene.padding,
        LaneScene.padding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: const [BoxShadow(color: AppColors.shadow, offset: Offset(0, _lip))],
      ),
      child: Semantics(
        label: IfThenTexts.lane,
        excludeSemantics: true,
        child: SingleChildScrollView(
          controller: _scroll,
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: LaneScene.cellCount(_controller) * _cell,
            height: headroom + _cell,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: headroom),
                  child: Row(
                    children: [
                      _tile(_startFrame()),
                      for (var index = 0; index < lane.length; index++) _laneCell(index, lane[index]),
                      _tile(_scaled(_objectScale, SvgPicture.asset(AppAssets.flag))),
                    ],
                  ),
                ),
                _robot(headroom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Robot yeni bir kareye geçince, kare görünmüyorsa yol kaydırılır.
  void _followRobot() {
    final cell = _controller.robotCell;
    if (cell == _shownCell) {
      return;
    }
    _shownCell = cell;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) {
        return;
      }
      final position = _scroll.position;
      final robotLeft = (cell + 1) * _cell;
      final target = (robotLeft - (position.viewportDimension - _cell) / 2).clamp(0.0, position.maxScrollExtent);
      _scroll.animateTo(target, duration: _controller.stepDuration * 0.85, curve: Curves.easeInOut);
    });
  }

  Widget _startFrame() => Padding(
    padding: EdgeInsets.all(_cell * _startInset),
    child: DashedFrame(color: AppColors.navy.withValues(alpha: _startAlpha), strokeWidth: 4),
  );

  /// Yol karesi; [child] kare zemininin üstüne çizilir.
  Widget _tile(Widget child, {String ground = IfThenAssets.tilePath}) => SizedBox.square(
    dimension: _cell,
    child: Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(ground, fit: BoxFit.cover),
        child,
      ],
    ),
  );

  Widget _laneCell(int index, LaneObject object) {
    final passed = index <= _controller.robotCell;
    final content = Stack(
      fit: StackFit.expand,
      children: [
        switch (object) {
          LaneObject.empty => const SizedBox.shrink(),
          LaneObject.water => passed ? _Bridge(cell: _cell) : const SizedBox.shrink(),
          LaneObject.door => _scaled(_objectScale, _OpenableDoor(open: passed)),
          LaneObject.rock || LaneObject.star => _scaled(
            _objectScale,
            _Collectable(collected: passed && object == LaneObject.star, asset: IfThenAssets.objectOf(object)),
          ),
        },
        if (_controller.wrongCell == index)
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.red, width: _wrongRing),
            ),
          ),
        if (_controller.hint?.index == index) const PulsingHintFrame(),
      ],
    );
    return _tile(content, ground: object == LaneObject.water ? AppAssets.water : IfThenAssets.tilePath);
  }

  /// Zıplayan robot yolun kayan alanında kırpılmasın diye karelerin üstünde bırakılan boşluk:
  /// robotun yükselişinden, karedeki kendi üst boşluğu çıkarılır.
  double get _headroom => max(0, RobotSprite.maxRise(_cell * _robotScale) - _cell * (1 - _robotScale) / 2);

  Widget _robot(double top) => AnimatedPositioned(
    duration: _controller.stepDuration * 0.85,
    curve: Curves.easeInOut,
    left: (_controller.robotCell + 1) * _cell,
    top: top,
    width: _cell,
    height: _cell,
    child: _scaled(_robotScale, RobotSprite(reaction: _controller.reaction, reactionCount: _controller.reactionCount)),
  );

  static Widget _scaled(double factor, Widget child) => Center(
    child: FractionallySizedBox(widthFactor: factor, heightFactor: factor, child: child),
  );
}

/// Suyun üstüne kurulan tahta köprü.
final class _Bridge extends StatelessWidget {
  const _Bridge({required this.cell});

  final double cell;

  static const _inset = 0.28;
  static const _planks = 4;
  static const _light = Color(0xFFB97A3D);
  static const _dark = Color(0xFF8C5A2B);
  static const _edge = Color(0xFF5E3A17);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: cell * _inset),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: _edge, width: 5)),
      ),
      child: Row(
        children: [
          for (var plank = 0; plank < _planks; plank++)
            const Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _light,
                  border: Border(right: BorderSide(color: _dark, width: 4)),
                ),
                child: SizedBox.expand(),
              ),
            ),
        ],
      ),
    ),
  );
}

/// Robot geçince sola doğru dönerek açılan kapı.
final class _OpenableDoor extends StatelessWidget {
  const _OpenableDoor({required this.open});

  final bool open;

  static const _openAngle = -70 * pi / 180;
  static const _openOpacity = 0.6;
  static const _perspective = 0.006;
  static const _duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(end: open ? 1 : 0),
    duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : _duration,
    builder: (context, value, child) => Opacity(
      opacity: 1 - (1 - _openOpacity) * value,
      child: Transform(
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateY(_openAngle * value),
        child: child,
      ),
    ),
    child: SvgPicture.asset(IfThenAssets.door),
  );
}

/// Taş veya yıldız. Toplanan yıldız büyüyüp yukarı süzülerek kaybolur.
final class _Collectable extends StatelessWidget {
  const _Collectable({required this.collected, required this.asset});

  final bool collected;
  final String asset;

  static const _duration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context) ? Duration.zero : _duration;
    return AnimatedSlide(
      offset: collected ? const Offset(0, -0.6) : Offset.zero,
      duration: duration,
      child: AnimatedOpacity(
        opacity: collected ? 0 : 1,
        duration: duration,
        child: AnimatedScale(scale: collected ? 0.4 : 1, duration: duration, child: SvgPicture.asset(asset)),
      ),
    );
  }
}
