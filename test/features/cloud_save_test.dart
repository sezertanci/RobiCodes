import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/cloud_save/cloud_sync_service.dart';
import 'package:robi_codes/features/cloud_save/progress_merger.dart';
import 'package:robi_codes/features/progress/progress_repository.dart';
import 'package:robi_codes/features/progress/progress_snapshot.dart';

import '../support/fakes.dart';

void main() {
  group('ProgressMerger', () {
    test('merge_DifferentProgress_KeepsBestOfBoth', () {
      // Arrange
      final device = ProgressSnapshot.empty.withBest('a', 1, 3).withBest('a', 2, 1);
      final cloud = ProgressSnapshot.empty.withBest('a', 2, 2).withBest('b', 1, 1);

      // Act
      final merged = ProgressMerger.merge(device, cloud);

      // Assert
      expect(merged.stars, {
        'a': {1: 3, 2: 2},
        'b': {1: 1},
      });
    });

    test('merge_SwappedOrder_ReturnsSameResult', () {
      // Arrange
      final first = ProgressSnapshot.empty.withBest('a', 1, 1);
      final second = ProgressSnapshot.empty.withBest('a', 1, 3).withBest('a', 2, 2);

      // Act & Assert
      expect(ProgressMerger.merge(first, second).stars, ProgressMerger.merge(second, first).stars);
    });
  });

  group('CloudSyncService', () {
    late FakeCloudSaveGateway gateway;
    late InMemoryKeyValueStore store;
    late ProgressRepository progress;

    CloudSyncService createService() => CloudSyncService(gateway: gateway, progress: progress, store: store);

    setUp(() {
      gateway = FakeCloudSaveGateway();
      store = InMemoryKeyValueStore();
      progress = ProgressRepository(store);
    });

    test('sync_Disabled_DoesNothing', () async {
      expect(await createService().sync(), CloudSyncResult.disabled);
    });

    test('setEnabled_True_PersistsFlag', () async {
      // Act
      await createService().setEnabled(enabled: true);

      // Assert
      expect(createService().isEnabled, isTrue);
    });

    test('sync_NotSignedIn_ReturnsNotSignedIn', () async {
      // Arrange
      gateway.signedIn = false;
      final service = createService();
      await service.setEnabled(enabled: true);

      // Act & Assert
      expect(await service.sync(), CloudSyncResult.notSignedIn);
    });

    test('sync_BothSidesHaveProgress_MergesIntoDeviceAndCloud', () async {
      // Arrange
      await progress.completeLevel('a', 1, 1);
      gateway.stored = ProgressSnapshot.empty.withBest('a', 1, 3).withBest('a', 2, 2).toJson();
      final service = createService();
      await service.setEnabled(enabled: true);

      // Act
      final result = await service.sync();

      // Assert
      final expected = {
        'a': {1: 3, 2: 2},
      };
      expect(result, CloudSyncResult.synced);
      expect(progress.snapshot.stars, expected);
      expect(ProgressSnapshot.fromJson(gateway.stored).stars, expected);
    });

    test('sync_CloudUnreachable_KeepsDeviceProgress', () async {
      // Arrange
      await progress.completeLevel('a', 1, 2);
      gateway.reachable = false;
      final service = createService();
      await service.setEnabled(enabled: true);

      // Act
      final result = await service.sync();

      // Assert
      expect(result, CloudSyncResult.unavailable);
      expect(progress.starsOf('a', 1), 2);
    });
  });
}
