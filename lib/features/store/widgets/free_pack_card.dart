import 'package:flutter/material.dart';

import '../../../app/widgets/game_icon_badge.dart';
import '../../../app/widgets/tone_card.dart';
import '../../../content/models/game_definition.dart';
import '../../../content/models/level_pack.dart';
import '../../../l10n/l10n.dart';

/// Ücretsiz paketin küçük kartı: oyunun renginde zemin, oyun ikonu, oyun adı, paket adı ve seviye sayısı.
final class FreePackCard extends StatelessWidget {
  const FreePackCard({required this.game, required this.pack, super.key});

  final GameDefinition game;
  final LevelPack pack;

  static const _padding = EdgeInsets.all(12);
  static const _gap = 12.0;
  static const _badgeSize = 56.0;
  static const _iconSize = 42.0;
  static const _titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w900, height: 1.1);
  static const _bodyStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return ToneCard(
      tone: game.tone,
      padding: _padding,
      child: Row(
        spacing: _gap,
        children: [
          GameIconBadge(icon: game.icon, tone: game.tone, size: _badgeSize, iconSize: _iconSize),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title(t), style: _titleStyle),
                Text(pack.title(t), style: _bodyStyle),
                Text(t.storeLevels(pack.levelCount), style: _bodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
