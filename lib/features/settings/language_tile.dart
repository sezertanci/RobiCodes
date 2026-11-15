import 'dart:async';

import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../language/language_service.dart';

/// Ayarlardaki dil satırı: desteklenen diller, her biri kendi dilindeki adıyla listelenir
/// (ör. "Türkçe", "English"). Seçim hemen uygulanır ve saklanır. Yeni bir dil ARB dosyasıyla
/// eklendiğinde listede kendiliğinden görünür.
final class LanguageTile extends StatelessWidget {
  const LanguageTile({required this.language, super.key});

  final LanguageService language;

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context);
    return ListTile(
      leading: const Icon(Icons.language_rounded),
      title: Text(context.l10n.settingsLanguage),
      trailing: DropdownButton<String>(
        value: current.languageCode,
        underline: const SizedBox.shrink(),
        items: [
          for (final locale in AppLocalizations.supportedLocales)
            DropdownMenuItem(value: locale.languageCode, child: Text(lookupAppLocalizations(locale).languageName)),
        ],
        onChanged: (code) {
          if (code != null) unawaited(language.select(Locale(code)));
        },
      ),
    );
  }
}
