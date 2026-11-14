import 'package:flutter/material.dart';

import '../../app/app_assets.dart';
import '../../app/app_scope.dart';
import '../../app/app_services.dart';
import '../../app/app_texts.dart';
import '../../app/app_theme.dart';
import '../../app/screen_scale.dart';
import '../../app/widgets/top_bar.dart';
import '../../content/models/game_definition.dart';
import '../../content/models/level_pack.dart';
import '../../games/game_module.dart';
import 'game_feedback.dart';
import 'result_panel.dart';
import 'widgets/image_button.dart';

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

  static const _arrowSize = 44.0;
  static const _narrowArrowSize = 34.0;

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
    final arrowSize = ScreenScale.isNarrow(context) ? _narrowArrowSize : _arrowSize;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              title: widget.game.title,
              backLabel: AppTexts.backToLevels,
              dense: true,
              actions: [
                ImageButton(
                  asset: AppAssets.levelPrevious,
                  label: LevelScreen.previousLabel,
                  size: arrowSize,
                  onPressed: _isOpen(previous) ? () => _goTo(previous) : null,
                ),
                Semantics(
                  label: '${group.difficulty.title}, seviye $_level',
                  excludeSemantics: true,
                  child: _LevelBadge(text: '${group.difficulty.title} · $_level', tone: widget.game.tone),
                ),
                ImageButton(
                  asset: AppAssets.levelNext,
                  label: LevelScreen.nextLabel,
                  size: arrowSize,
                  onPressed: _isOpen(next) ? () => _goTo(next) : null,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: KeyedSubtree(
                      key: ValueKey(_level),
                      child:
                          module?.buildLevel(
                            LevelSession(
                              packId: widget.pack.id,
                              level: _level,
                              onCompleted: _complete,
                              feedback: feedback,
                            ),
                          ) ??
                          const SizedBox.shrink(),
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
            ),
          ],
        ),
      ),
    );
  }
}

/// Oyunun renginde, zorluk ve seviye numarasını gösteren hap (web sürümündeki `.level-badge`).
final class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.text, required this.tone});

  final String text;
  final ColorTone tone;

  static const _padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const _narrowPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 6);
  static const _fontSize = 16.0;
  static const _narrowFontSize = 13.0;

  @override
  Widget build(BuildContext context) {
    final narrow = ScreenScale.isNarrow(context);
    return Container(
      padding: narrow ? _narrowPadding : _padding,
      decoration: ShapeDecoration(color: tone.base, shape: const StadiumBorder()),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: narrow ? _narrowFontSize : _fontSize,
          fontWeight: FontWeight.w800,
          shadows: [Shadow(color: tone.dark, offset: const Offset(0, 2))],
        ),
      ),
    );
  }
}
