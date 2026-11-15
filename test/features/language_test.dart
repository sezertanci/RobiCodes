import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/language/language_service.dart';
import 'package:robi_codes/l10n/l10n.dart';

import '../support/fakes.dart';
import '../support/test_l10n.dart';
import '../support/ui_test_helpers.dart';

const _arbFolder = 'lib/l10n';
const _templateLanguage = 'tr';
const _metadataPrefix = '@';

Map<String, dynamic> _readArb(String languageCode) =>
    jsonDecode(File('$_arbFolder/app_$languageCode.arb').readAsStringSync()) as Map<String, dynamic>;

/// Çevrilen metinlerin anahtarları; `@` ile başlayan açıklama ve ayar satırları dışarıda kalır.
Set<String> _messageKeys(Map<String, dynamic> arb) => arb.keys.where((key) => !key.startsWith(_metadataPrefix)).toSet();

void main() {
  group('LanguageService', () {
    const supported = [Locale('tr'), Locale('en')];

    test('resolve_SupportedDeviceLanguage_ReturnsIt', () {
      expect(LanguageService.resolve(const [Locale('tr', 'TR')], supported), const Locale('tr'));
    });

    test('resolve_RegionalVariant_MatchesByLanguageCode', () {
      expect(LanguageService.resolve(const [Locale('en', 'GB')], supported), const Locale('en'));
    });

    test('resolve_FirstLanguageUnsupported_UsesNextSupportedOne', () {
      expect(LanguageService.resolve(const [Locale('ja'), Locale('tr')], supported), const Locale('tr'));
    });

    test('resolve_LegacyIndonesianCode_MatchesIndonesian', () {
      // Android, Endonezceyi eski "in" koduyla bildirebilir; Locale bunu "id" olarak okur.
      expect(LanguageService.resolve(const [Locale('in')], const [Locale('id')]), const Locale('id'));
    });

    test('resolve_NoSupportedLanguage_FallsBackToEnglish', () {
      expect(LanguageService.resolve(const [Locale('ja'), Locale('ko')], supported), LanguageService.fallback);
      expect(LanguageService.resolve(null, supported), LanguageService.fallback);
    });

    test('selected_NothingSaved_ReturnsNull', () {
      expect(LanguageService(InMemoryKeyValueStore()).selected, isNull);
    });

    test('select_NewLanguage_NotifiesAndSurvivesRestart', () async {
      // Arrange
      final store = InMemoryKeyValueStore();
      final service = LanguageService(store);
      var notified = false;
      service.addListener(() => notified = true);

      // Act
      await service.select(const Locale('tr'));

      // Assert
      expect(notified, isTrue);
      expect(service.selected, const Locale('tr'));
      expect(LanguageService(store).selected, const Locale('tr'));
    });

    test('selected_SavedLanguageNoLongerSupported_ReturnsNull', () {
      final store = InMemoryKeyValueStore({
        StorageKeys.language: jsonEncode({'language': 'xx'}),
      });
      expect(LanguageService(store).selected, isNull);
    });

    test('selected_CorruptSavedValue_ReturnsNull', () {
      final store = InMemoryKeyValueStore({StorageKeys.language: 'bozuk'});
      expect(LanguageService(store).selected, isNull);
    });
  });

  group('ARB files', () {
    final template = _readArb(_templateLanguage);

    for (final locale in AppLocalizations.supportedLocales) {
      final code = locale.languageCode;

      test('keys_${code}File_MatchesTemplate', () {
        expect(_messageKeys(_readArb(code)), _messageKeys(template));
      });

      test('placeholders_${code}File_KeepsEveryPlaceholder', () {
        final arb = _readArb(code);
        for (final key in _messageKeys(template)) {
          final metadata = template['$_metadataPrefix$key'] as Map<String, dynamic>?;
          final placeholders = (metadata?['placeholders'] as Map<String, dynamic>?)?.keys ?? const <String>[];
          for (final name in placeholders) {
            expect(arb[key] as String, contains('{$name'), reason: '$code: $key');
          }
        }
      });
    }
  });

  group('LanguageTile', () {
    testWidgets('LanguageTile_TurkishSelected_ChangesTextsAndSavesChoice', (tester) async {
      // Arrange
      final store = InMemoryKeyValueStore();
      final services = AppServices.production(store);
      await tester.pumpWidget(RobiCodesApp(services: services));
      await tester.tap(find.byTooltip(texts.settingsTitle));
      await settle(tester);

      // Act
      await tester.tap(find.text(texts.languageName));
      await settle(tester);
      await tester.tap(find.text(trTexts.languageName).last);
      await settle(tester);

      // Assert
      expect(find.text(trTexts.settingsLanguage), findsOneWidget);
      expect(find.text(texts.settingsLanguage), findsNothing);
      expect(LanguageService(store).selected, const Locale('tr'));
    });
  });
}
