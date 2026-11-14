import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/level_lifecycle.dart';

/// Yaşam döngüsünü denemek için en küçük denetleyici.
final class _Controller extends ChangeNotifier with LevelLifecycle {
  bool get disposed => isDisposed;

  Future<void> complete(ValueChanged<int> onCompleted, int stars) => completeAfter(Duration.zero, onCompleted, stars);
}

void main() {
  group('LevelLifecycle', () {
    test('completeAfter_ScreenOpen_ReportsStars', () async {
      // Arrange
      final completed = <int>[];
      final controller = _Controller();

      // Act
      await controller.complete(completed.add, 3);

      // Assert
      expect(completed, [3]);
      expect(controller.disposed, isFalse);
    });

    test('completeAfter_DisposedWhileWaiting_DoesNotReport', () async {
      // Arrange
      final completed = <int>[];
      final controller = _Controller();

      // Act
      final waiting = controller.complete(completed.add, 2);
      controller.dispose();
      await waiting;

      // Assert
      expect(completed, isEmpty);
      expect(controller.disposed, isTrue);
    });
  });
}
