import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../app/app_texts.dart';
import '../../content/models/game_definition.dart';
import '../../content/models/level_pack.dart';
import '../../games/game_module.dart';
import 'game_feedback.dart';
import 'result_panel.dart';

/// Bir seviyenin oynandığı ekran. Oyunu `GameModule`'den alır; seviye bitince sonucu
/// ilerleme kaydına yazar (en iyi sonuç korunur) ve sonuç panelini gösterir.
/// Üst çubuktaki oklarla açık olan önceki ve sonraki seviyeye geçilir.
final class LevelScreen extends StatefulWidget {
  const LevelScreen({required this.game, required this.pack, required this.initialLevel, super.key});

  final GameDefinition game;
  final LevelPack pack;
  final int initialLevel;

  static const previousLabel = 'Önceki seviye';
  static const nextLabel = AppTexts.nextLevel;

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

final class _LevelScreenState extends State<LevelScreen> {
  late int _level = widget.initialLevel;
  int? _resultStars;

  AppServices get _services => AppScope.of(context);

  bool _isOpen(int level) => _services.unlockPolicy.isLevelUnlocked(widget.pack, level);

  void _goTo(int level) => setState(() {
    _level = level;
    _resultStars = null;
  });

  /// Sonucu kaydeder, sonuç panelini açar ve yeni kazanılan ödülleri kutlar.
  Future<void> _complete(int stars) async {
    final services = _services;
    final navigator = Navigator.of(context, rootNavigator: true);
    await services.progress.completeLevel(widget.pack.id, _level, stars);
    if (mounted) {
      setState(() => _resultStars = stars);
    }
    services.celebration.show(navigator, await services.achievements.sync());
  }

  @override
  Widget build(BuildContext context) {
    final module = _services.games.moduleFor(widget.game.id);
    final feedback = SoundGameFeedback(_services.sound);
    final group = widget.pack.groupRanges.firstWhere((range) => range.contains(_level)).group;
    final previous = _level - 1;
    final next = _level + 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title),
        actions: [
          IconButton(
            tooltip: LevelScreen.previousLabel,
            onPressed: _isOpen(previous) ? () => _goTo(previous) : null,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Semantics(
            label: '${group.difficulty.title}, seviye $_level',
            excludeSemantics: true,
            child: Chip(label: Text('${group.difficulty.title} · $_level')),
          ),
          IconButton(
            tooltip: LevelScreen.nextLabel,
            onPressed: _isOpen(next) ? () => _goTo(next) : null,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              child: KeyedSubtree(
                key: ValueKey(_level),
                child:
                    module?.buildLevel(
                      LevelSession(packId: widget.pack.id, level: _level, onCompleted: _complete, feedback: feedback),
                    ) ??
                    const SizedBox.shrink(),
              ),
            ),
          ),
          if (_resultStars case final stars?)
            Positioned.fill(
              child: ResultPanel(
                stars: stars,
                feedback: feedback,
                onBackToLevels: () => Navigator.of(context).pop(),
                onNextLevel: _isOpen(next) ? () => _goTo(next) : null,
              ),
            ),
        ],
      ),
    );
  }
}
