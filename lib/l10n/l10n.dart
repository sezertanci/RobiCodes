import 'package:flutter/widgets.dart';

import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';

/// Dile göre değişen metin: veri (seviye, oyun, rozet) metnin kendisini değil, o anki dilin
/// çevirilerinden metni seçen bu fonksiyonu tutar. Böylece veri sabit kalır, metin dile göre çözülür.
typedef LocalizedText = String Function(AppLocalizations t);

extension LocalizationContext on BuildContext {
  /// Ekranın o anki dilindeki metinler.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
