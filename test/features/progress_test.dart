import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/progress/progress_repository.dart';
import 'package:robi_codes/features/progress/progress_snapshot.dart';
import 'package:robi_codes/features/progress/star_rule.dart';
import 'package:robi_codes/features/progress/unlock_policy.dart';

import '../support/fakes.dart';

void main() {
  group('StarRule', () {
    test('calculate_HintUsed_ReturnsOneStar', () {
      expect(StarRule.calculate(hintUsed: true, targetMet: true), 1);
    });

    test('calculate_NoHintTargetMissed_ReturnsTwoStars', () {
      expect(StarRule.calculate(hintUsed: false, targetMet: false), 2);
    });

    test('calculate_NoHintTargetMet_ReturnsThreeStars', () {
      expect(StarRule.calculate(hintUsed: false, targetMet: true), 3);
    });
  });

  group('ProgressSnapshot', () {
    test('withBest_LowerScore_KeepsBestScore', () {
      // Arrange
      final snapshot = ProgressSnapshot.empty.withBest('pack', 1, 3);

      // Act
      final result = snapshot.withBest('pack', 1, 1);

      // Assert
      expect(result.starsOf('pack', 1), 3);
    });

    test('fromJson_RoundTrip_ReturnsSameStars', () {
      // Arrange
      final snapshot = ProgressSnapshot.empty.withBest('a', 1, 2).withBest('b', 4, 3);

      // Act
      final restored = ProgressSnapshot.fromJson(snapshot.toJson());

      // Assert
      expect(restored.stars, snapshot.stars);
    });

    test('fromJson_CorruptValues_SkipsInvalidEntries', () {
      // Arrange
      const raw = '{"version":1,"packs":{"a":{"1":2,"0":3,"x":1,"2":9,"3":"3"},"b":5}}';

      // Act
      final result = ProgressSnapshot.fromJson(raw);

      // Assert
      expect(result.stars, {
        'a': {1: 2},
      });
    });

    test('fromJson_NotJson_ReturnsEmpty', () {
      expect(ProgressSnapshot.fromJson('bozuk').stars, isEmpty);
    });
  });

  group('ProgressRepository', () {
    test('completeLevel_NewLevel_PersistsToStore', () async {
      // Arrange
      final store = InMemoryKeyValueStore();
      final repository = ProgressRepository(store);

      // Act
      await repository.completeLevel(TestCatalog.freePack, 1, 2);

      // Assert
      expect(ProgressRepository(store).starsOf(TestCatalog.freePack, 1), 2);
      expect(store.values, contains(StorageKeys.progress));
    });

    test('totalStars_TwoLevels_ReturnsSum', () async {
      // Arrange
      final repository = ProgressRepository(InMemoryKeyValueStore());
      await repository.completeLevel('pack', 1, 3);
      await repository.completeLevel('pack', 2, 1);

      // Act & Assert
      expect(repository.totalStars('pack'), 4);
      expect(repository.completedCount('pack'), 2);
    });

    test('reset_AfterProgress_ClearsEverything', () async {
      // Arrange
      final store = InMemoryKeyValueStore();
      final repository = ProgressRepository(store);
      await repository.completeLevel('pack', 1, 3);

      // Act
      await repository.reset();

      // Assert
      expect(repository.snapshot.stars, isEmpty);
      expect(store.values, isEmpty);
    });
  });

  group('UnlockPolicy', () {
    // Test paketi: 2'şer seviyelik iki grup (1–2 ve 3–4).
    final pack = TestCatalog.build().findPack(TestCatalog.freePack)!;

    test('isLevelUnlocked_FirstLevel_ReturnsTrue', () {
      final policy = UnlockPolicy(ProgressRepository(InMemoryKeyValueStore()));

      expect(policy.isLevelUnlocked(pack, 1), isTrue);
      expect(policy.isLevelUnlocked(pack, 2), isFalse);
    });

    test('isLevelUnlocked_PreviousGroupIncomplete_ReturnsFalse', () async {
      // Arrange
      final progress = ProgressRepository(InMemoryKeyValueStore());
      await progress.completeLevel(pack.id, 1, 1);
      final policy = UnlockPolicy(progress);

      // Act & Assert
      expect(policy.isLevelUnlocked(pack, 2), isTrue);
      expect(policy.isLevelUnlocked(pack, 3), isFalse);
    });

    test('isLevelUnlocked_PreviousGroupComplete_OpensNextGroup', () async {
      // Arrange
      final progress = ProgressRepository(InMemoryKeyValueStore());
      await progress.completeLevel(pack.id, 1, 1);
      await progress.completeLevel(pack.id, 2, 1);
      final policy = UnlockPolicy(progress);

      // Act & Assert
      expect(policy.isLevelUnlocked(pack, 3), isTrue);
      expect(policy.nextLevel(pack), 3);
    });

    test('isLevelUnlocked_OutsidePack_ReturnsFalse', () {
      final policy = UnlockPolicy(ProgressRepository(InMemoryKeyValueStore()));

      expect(policy.isLevelUnlocked(pack, 0), isFalse);
      expect(policy.isLevelUnlocked(pack, 5), isFalse);
    });

    test('nextLevel_AllCompleted_ReturnsNull', () async {
      // Arrange
      final progress = ProgressRepository(InMemoryKeyValueStore());
      for (var level = 1; level <= pack.levelCount; level++) {
        await progress.completeLevel(pack.id, level, 3);
      }

      // Act & Assert
      expect(UnlockPolicy(progress).nextLevel(pack), isNull);
    });
  });
}
