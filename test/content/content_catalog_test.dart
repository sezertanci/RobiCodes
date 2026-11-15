import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/content/content_catalog.dart';
import 'package:robi_codes/content/models/level_pack.dart';
import 'package:robi_codes/content/models/store_product.dart';

import '../support/fakes.dart';
import '../support/test_l10n.dart';

void main() {
  group('buildContentCatalog', () {
    test('buildContentCatalog_Default_HasNoValidationErrors', () {
      // Arrange
      final catalog = buildContentCatalog();

      // Act
      final errors = catalog.validate();

      // Assert
      expect(errors, isEmpty);
    });

    test('buildContentCatalog_Default_HasFourFreeGamesWithEightyLevels', () {
      // Arrange
      final catalog = buildContentCatalog();

      // Act
      final totalLevels = catalog.packs.fold(0, (sum, pack) => sum + pack.levelCount);

      // Assert
      expect(catalog.games, hasLength(4));
      expect(totalLevels, 80);
      expect(catalog.packs.every((pack) => catalog.isFree(pack.id)), isTrue);
    });
  });

  group('ContentCatalog', () {
    test('isFree_PackSoldByProduct_ReturnsFalse', () {
      // Arrange
      final catalog = TestCatalog.build();

      // Act & Assert
      expect(catalog.isFree(TestCatalog.packA), isFalse);
      expect(catalog.isFree(TestCatalog.freePack), isTrue);
    });

    test('freePacksOf_GameWithPaidPacks_ReturnsOnlyFreePack', () {
      // Arrange
      final catalog = TestCatalog.build();

      // Act
      final ids = catalog.freePacksOf(TestCatalog.gameId).map((pack) => pack.id);

      // Assert
      expect(ids, [TestCatalog.freePack]);
    });

    test('productsGranting_PackInBundle_ReturnsOwnProductAndBundle', () {
      // Arrange
      final catalog = TestCatalog.build();

      // Act
      final ids = catalog.productsGranting(TestCatalog.packA).map((product) => product.id);

      // Assert
      expect(ids, [TestCatalog.productA, TestCatalog.bundle]);
    });

    test('validate_BrokenData_ReportsEveryProblem', () {
      // Arrange
      final catalog = ContentCatalog(
        games: const [],
        packs: [
          LevelPack(id: 'p', gameId: 'missing', title: fixedText('P'), groups: const []),
          LevelPack(
            id: 'p',
            gameId: 'missing',
            title: fixedText('P'),
            groups: const [DifficultyGroup(Difficulty.easy, 0)],
          ),
        ],
        products: [
          StoreProduct(id: 'x', title: fixedText('X'), packIds: const ['p', 'p', 'unknown']),
        ],
      );

      // Act
      final errors = catalog.validate();

      // Assert
      expect(errors, hasLength(7));
    });
  });

  group('LevelPack', () {
    test('groupRanges_StandardGroups_SplitsLevelsByFive', () {
      // Arrange
      final pack = buildContentCatalog().packs.first;

      // Act
      final ranges = pack.groupRanges.map((range) => (range.firstLevel, range.lastLevel));

      // Assert
      expect(ranges, [(1, 5), (6, 10), (11, 15), (16, 20)]);
    });
  });
}
