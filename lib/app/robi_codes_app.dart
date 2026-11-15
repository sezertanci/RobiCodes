import 'package:flutter/material.dart';

import '../features/character/character_scope.dart';
import '../features/home/home_screen.dart';
import '../features/language/language_service.dart';
import '../l10n/l10n.dart';
import 'app_scope.dart';
import 'app_services.dart';
import 'app_theme.dart';

/// Uygulamanın kökü. Dil veya karakter değişince bütün ekranlar yeniden çizilir; dil seçilmediyse
/// cihazın dili, o da desteklenmiyorsa [LanguageService.fallback] kullanılır.
final class RobiCodesApp extends StatelessWidget {
  const RobiCodesApp({required this.services, super.key});

  final AppServices services;

  @override
  Widget build(BuildContext context) => AppScope(
    services: services,
    child: ListenableBuilder(
      listenable: Listenable.merge([services.character, services.language]),
      builder: (context, _) => CharacterScope(
        character: services.character.current,
        child: MaterialApp(
          onGenerateTitle: (context) => context.l10n.appTitle,
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(),
          locale: services.language.selected,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          localeListResolutionCallback: (locales, supported) => LanguageService.resolve(locales, supported),
          home: const HomeScreen(),
        ),
      ),
    ),
  );
}
