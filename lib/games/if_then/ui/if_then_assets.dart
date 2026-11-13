import '../../../app/app_assets.dart';
import '../engine/if_then_level.dart';

/// Yalnızca "Eğer Böyleyse" oyununun kullandığı görseller. Dosyalar web sürümünden kopyalandı.
abstract final class IfThenAssets {
  static const tilePath = 'assets/puzzles/tile-path.svg';
  static const door = 'assets/puzzles/door.svg';
  static const forward = 'assets/ui/button-arrow-right.svg';
  static const jump = 'assets/icons/action-jump.svg';
  static const bridge = 'assets/icons/action-bridge.svg';
  static const key = 'assets/icons/action-key.svg';
  static const collect = 'assets/icons/action-collect.svg';

  /// Nesnenin yoldaki ve bloktaki görseli. Boş yolun görseli yol karesidir.
  static String objectOf(LaneObject object) => switch (object) {
    LaneObject.empty => tilePath,
    LaneObject.rock => AppAssets.rock,
    LaneObject.water => AppAssets.water,
    LaneObject.door => door,
    LaneObject.star => AppAssets.star,
  };

  static String actionOf(LaneAction action) => switch (action) {
    LaneAction.forward => forward,
    LaneAction.jump => jump,
    LaneAction.bridge => bridge,
    LaneAction.open => key,
    LaneAction.collect => collect,
  };
}
