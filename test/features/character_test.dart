import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/character/character.dart';
import 'package:robi_codes/features/character/character_dialog.dart';
import 'package:robi_codes/features/character/character_service.dart';
import 'package:robi_codes/features/home/character_button.dart';
import 'package:robi_codes/features/play/widgets/speech_bubble.dart';

import '../support/fakes.dart';
import '../support/ui_test_helpers.dart';

const _fiyo = 'fiyo';

/// Ekranda [image] görselini çizen resimler.
Finder _imagesOf(String image) => find.byWidgetPredicate(
  (widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == image,
);

void main() {
  group('CharacterRoster', () {
    test('all_EveryCharacter_HasUniqueIdAndImageOnDisk', () {
      // Act
      final ids = {for (final character in CharacterRoster.all) character.id};

      // Assert
      expect(ids, hasLength(CharacterRoster.all.length));
      for (final character in CharacterRoster.all) {
        expect(File(character.image).existsSync(), isTrue, reason: character.image);
      }
    });
  });

  group('CharacterService', () {
    test('current_FirstLaunch_IsDefaultCharacter', () {
      // Act
      final service = CharacterService(InMemoryKeyValueStore());

      // Assert
      expect(service.current, CharacterRoster.defaultCharacter);
    });

    test('select_KnownCharacter_IsKeptAfterRestart', () async {
      // Arrange
      final store = InMemoryKeyValueStore();

      // Act
      final selected = await CharacterService(store).select(_fiyo);

      // Assert
      expect(selected, isTrue);
      expect(store.read(StorageKeys.character), '{"characterId":"$_fiyo"}');
      expect(CharacterService(store).current.id, _fiyo);
    });

    test('select_UnknownCharacter_ReturnsFalseAndKeepsCurrent', () async {
      // Arrange
      final store = InMemoryKeyValueStore();
      final service = CharacterService(store);

      // Act
      final selected = await service.select('yok');

      // Assert
      expect(selected, isFalse);
      expect(service.current, CharacterRoster.defaultCharacter);
      expect(store.read(StorageKeys.character), isNull);
    });

    for (final (name, saved) in [
      ('Corrupt', 'bozuk'),
      ('RemovedCharacter', '{"characterId":"silinen"}'),
      ('WrongType', '{"characterId":3}'),
    ]) {
      test('current_${name}Record_FallsBackToDefault', () async {
        // Arrange
        final store = InMemoryKeyValueStore();
        await store.write(StorageKeys.character, saved);

        // Act
        final service = CharacterService(store);

        // Assert
        expect(service.current, CharacterRoster.defaultCharacter);
      });
    }
  });

  group('CharacterDialog', () {
    for (final MapEntry(key: screenName, value: size) in TestScreens.all.entries) {
      testWidgets('selectCharacter_${screenName}_UpdatesHomeAndGamesAndSaves', (tester) async {
        // Arrange
        useScreen(tester, size);
        final store = InMemoryKeyValueStore();
        final services = AppServices.production(store);
        final fiyo = CharacterRoster.find(_fiyo)!;
        await tester.pumpWidget(RobiCodesApp(services: services));
        expect(find.bySemanticsLabel(CharacterButton.semanticLabel('Robi')), findsOneWidget);

        // Act
        await tester.tap(find.byType(CharacterButton));
        await settle(tester);
        expect(find.text(CharacterDialog.title), findsOneWidget);
        expect(tester.takeException(), isNull);
        for (final character in CharacterRoster.all) {
          expect(find.bySemanticsLabel(character.name), findsOneWidget);
        }
        final columns = size.width < 560 ? 2 : 3;
        final rowTops = {
          for (final character in CharacterRoster.all.take(columns))
            tester.getTopLeft(find.bySemanticsLabel(character.name)).dy,
        };
        expect(rowTops, hasLength(1), reason: 'İlk $columns karakter aynı satırda olmalı.');
        await tester.tap(find.bySemanticsLabel(fiyo.name));
        await settle(tester);

        // Assert
        expect(find.byType(CharacterDialog), findsNothing);
        expect(find.bySemanticsLabel(CharacterButton.semanticLabel(fiyo.name)), findsOneWidget);
        expect(store.read(StorageKeys.character), contains(_fiyo));
        await openLevelSelect(tester, 'Robotun Yolunu Bul');
        await openLevel(tester, 1);
        expect(find.descendant(of: find.byType(SpeechBubble), matching: _imagesOf(fiyo.image)), findsOneWidget);
        expect(_imagesOf(CharacterRoster.defaultCharacter.image), findsNothing);
      });
    }

    testWidgets('closeButton_NoSelection_KeepsCharacter', (tester) async {
      // Arrange
      final services = AppServices.production(InMemoryKeyValueStore());
      await tester.pumpWidget(RobiCodesApp(services: services));
      await tester.tap(find.byType(CharacterButton));
      await settle(tester);

      // Act
      await tester.tap(find.text(CharacterDialog.closeLabel));
      await settle(tester);

      // Assert
      expect(find.byType(CharacterDialog), findsNothing);
      expect(services.character.current, CharacterRoster.defaultCharacter);
    });
  });
}
