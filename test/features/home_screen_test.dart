import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/app_services.dart';
import 'package:robi_codes/app/robi_codes_app.dart';
import 'package:robi_codes/content/catalog_data.dart';
import 'package:robi_codes/features/home/game_card.dart';

import '../support/fakes.dart';

void main() {
  testWidgets('HomeScreen_DefaultCatalog_ShowsEveryGameWithProgress', (tester) async {
    // Arrange
    final services = AppServices.production(InMemoryKeyValueStore());
    await services.progress.completeLevel(basePackId(GameIds.pathFinder), 1, 3);

    // Act
    await tester.pumpWidget(RobiCodesApp(services: services));

    // Assert
    expect(find.byType(GameCard), findsNWidgets(services.catalog.games.length));
    expect(find.text('Robotun Yolunu Bul'), findsOneWidget);
    expect(find.text('3 / 60'), findsOneWidget);
    expect(find.text('Komutları Sırala'), findsOneWidget);
    final playable = services.catalog.games.where((game) => services.games.isPlayable(game.id)).length;
    expect(playable, 2);
    expect(find.text('Yakında'), findsNWidgets(services.catalog.games.length - playable));
  });
}
