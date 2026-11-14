import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/games/game_module.dart';

void main() {
  const packId = 'pack';
  const packs = {
    packId: ['birinci', 'ikinci'],
  };

  group('levelFrom', () {
    test('levelFrom_KnownLevel_ReturnsLevelCountingFromOne', () {
      // Act
      final level = levelFrom(packs, packId, 2);

      // Assert
      expect(level, 'ikinci');
    });

    for (final (pack, level) in [('bilinmeyen', 1), (packId, 0), (packId, 3)]) {
      test('levelFrom_UnknownPackOrLevel_ThrowsArgumentError ($pack / $level)', () {
        // Act & Assert
        expect(() => levelFrom(packs, pack, level), throwsArgumentError);
      });
    }
  });
}
