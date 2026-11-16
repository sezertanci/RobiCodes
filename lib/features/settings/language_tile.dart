import 'dart:async';

import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../language/language_service.dart';
import '../sound/tap_sound.dart';

/// Ayarlardaki dil satırı: sağda yalnızca seçili dilin adı yazar; satıra dokununca desteklenen
/// diller, her biri kendi dilindeki adıyla (ör. "Türkçe", "English") bir pencerede listelenir.
/// Satırın genişliği en uzun dil adına bağlı olmadığı için dar ekranlarda başlık sıkışmaz.
/// Seçim hemen uygulanır ve saklanır. Yeni bir dil ARB dosyasıyla eklendiğinde listede kendiliğinden görünür.
final class LanguageTile extends StatelessWidget {
  const LanguageTile({required this.language, super.key});

  final LanguageService language;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      leading: const Icon(Icons.language_rounded),
      title: Text(l10n.settingsLanguage),
      trailing: Text(l10n.languageName),
      onTap: context.withTapSound(() => unawaited(_pickLanguage(context))),
    );
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final current = Localizations.localeOf(context).languageCode;
    final code = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.settingsLanguage),
        children: [
          for (final locale in AppLocalizations.supportedLocales)
            ListTile(
              title: Text(lookupAppLocalizations(locale).languageName),
              trailing: locale.languageCode == current ? const Icon(Icons.check_rounded) : null,
              onTap: context.withTapSound(() => Navigator.of(context).pop(locale.languageCode)),
            ),
        ],
      ),
    );
    if (code != null && code != current) await language.select(Locale(code));
  }
}
