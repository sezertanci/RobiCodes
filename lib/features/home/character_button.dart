import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../app/app_theme.dart';
import '../../app/screen_scale.dart';
import '../../l10n/l10n.dart';
import '../character/character_dialog.dart';
import '../character/character_scope.dart';
import '../play/widgets/idle_sway.dart';

/// Ana ekrandaki seçili karakter; beklerken hafifçe sallanır. Dokununca karakter seçme penceresi açılır; seçilen karakter hemen görünür.
final class CharacterButton extends StatelessWidget {
  const CharacterButton({super.key});

  /// Telefondaki robot boyu; tablette web'deki geniş ekran boyuna (120) kadar büyür.
  static const _robotHeight = 76.0;
  static const _maxRobotHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    final character = CharacterScope.of(context);
    final t = context.l10n;
    final height = ScreenScale.of(context).size(_robotHeight, max: _maxRobotHeight);
    return Center(
      child: Semantics(
        button: true,
        label: t.homeCharacterLabel(character.name(t)),
        excludeSemantics: true,
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => CharacterDialog.show(context, AppScope.of(context).character),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IdleSway(
                child: Image.asset(character.image, height: height, fit: BoxFit.contain),
              ),
              const SizedBox(height: 4),
              DecoratedBox(
                decoration: const ShapeDecoration(color: Colors.white, shape: StadiumBorder()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    t.homeChangeCharacter,
                    style: Theme.of(context).textTheme.labelLarge
                        ?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
