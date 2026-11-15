import 'package:flutter/material.dart';
import 'package:robi_codes/l10n/l10n.dart';

/// Testlerin dili. Test ortamında cihaz dili `en_US` olduğu için uygulama İngilizce açılır; beklenen
/// metinler de bu dilin çevirilerinden okunur.
const testLocale = Locale('en');

/// Testlerin beklediği metinler.
final texts = lookupAppLocalizations(testLocale);

/// Türkçe metinler; dile özgü biçimleri (ör. sayıların yazıyla okunuşu) denetleyen testler içindir.
final trTexts = lookupAppLocalizations(const Locale('tr'));

/// Sahte verilerde dile göre değişmeyen sabit metin.
LocalizedText fixedText(String text) =>
    (_) => text;

/// [home] ekranını uygulamanın dil desteğiyle açan en küçük uygulama.
MaterialApp localizedApp(Widget home, {ThemeData? theme}) => MaterialApp(
  theme: theme,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  locale: testLocale,
  home: home,
);
