import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/core/storage/storage_keys.dart';
import 'package:robi_codes/features/developer/developer_unlock.dart';
import 'package:robi_codes/features/developer/developer_unlock_tile.dart';
import 'package:robi_codes/features/progress/progress_repository.dart';
import 'package:robi_codes/features/progress/unlock_policy.dart';
import 'package:robi_codes/features/settings/settings_dialog.dart';
import 'package:robi_codes/features/store/entitlement_service.dart';
import 'package:robi_codes/games/game_registry.dart';

import '../support/fakes.dart';
import '../support/test_l10n.dart';

bool _notOwned(String packId) => false;

void main() {
  late DeveloperUnlock unlock;

  setUp(() => unlock = DeveloperUnlock());

  group('EntitlementService', () {
    test('canPlayPack_DeveloperUnlockEnabled_OpensPaidPackWithoutWritingOwnership', () {
      // Arrange
      final store = InMemoryKeyValueStore();
      final service = EntitlementService(
        catalog: TestCatalog.build(),
        gateway: FakePurchaseGateway(),
        store: store,
        developerUnlock: unlock,
      );
      var notified = 0;
      service.addListener(() => notified++);

      // Act
      unlock.setEnabled(true);

      // Assert
      expect(service.canPlayPack(TestCatalog.packA), isTrue);
      expect(notified, 1);
      expect(store.values.containsKey(StorageKeys.ownedProducts), isFalse);
    });

    test('canPlayPack_DeveloperUnlockDisabledAgain_LocksPaidPack', () {
      // Arrange
      final service = EntitlementService(
        catalog: TestCatalog.build(),
        gateway: FakePurchaseGateway(),
        store: InMemoryKeyValueStore(),
        developerUnlock: unlock,
      );
      unlock.setEnabled(true);

      // Act
      unlock.setEnabled(false);

      // Assert
      expect(service.canPlayPack(TestCatalog.packA), isFalse);
    });
  });

  group('UnlockPolicy', () {
    final pack = TestCatalog.build().findPack(TestCatalog.freePack)!;

    test('isLevelUnlocked_DeveloperUnlockEnabled_OpensEveryLevelAndGroup', () {
      // Arrange
      final policy = UnlockPolicy(ProgressRepository(InMemoryKeyValueStore()), _notOwned, developerUnlock: unlock);

      // Act
      unlock.setEnabled(true);

      // Assert
      for (var level = 1; level <= pack.levelCount; level++) {
        expect(policy.isLevelUnlocked(pack, level), isTrue);
      }
      expect(pack.groupRanges.every((range) => policy.isGroupUnlocked(pack, range)), isTrue);
      expect(policy.isLevelUnlocked(pack, pack.levelCount + 1), isFalse);
    });

    test('isLevelUnlocked_DeveloperUnlockDisabled_KeepsNormalRules', () {
      final policy = UnlockPolicy(ProgressRepository(InMemoryKeyValueStore()), _notOwned, developerUnlock: unlock);

      expect(policy.isLevelUnlocked(pack, 1), isFalse);
    });
  });

  group('DeveloperUnlockTile', () {
    testWidgets('SettingsDialog_SwitchTapped_EnablesDeveloperUnlock', (tester) async {
      // Arrange
      final services = AppServices(
        catalog: TestCatalog.build(),
        games: GameRegistry(const []),
        store: InMemoryKeyValueStore(),
      );
      await tester.pumpWidget(localizedApp(Scaffold(body: SettingsDialog(services: services))));

      // Act
      await tester.tap(find.text(DeveloperUnlockTile.label));
      await tester.pump();

      // Assert
      expect(services.developerUnlock.isEnabled, isTrue);
      expect(services.entitlements.canPlayPack(TestCatalog.packA), isTrue);
    });
  });
}
