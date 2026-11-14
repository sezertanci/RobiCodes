import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/features/play/level_select_screen.dart';

/// Arayüz testlerinde denenen ekran boyutları: küçük bir telefon (telefon dikeye sabitlenir), yatay
/// tablet ve test tabletinin (2560x1600, yoğunluk 360) iki yöndeki mantıksal boyutu.
abstract final class TestScreens {
  static const phone = Size(360, 690);
  static const tablet = Size(1024, 768);
  static const tabletPortrait = Size(711, 1138);
  static const tabletLandscape = Size(1138, 711);

  /// Her boyutta tekrarlanan testler için ad ve boyut; ad test adına girer.
  static const all = {
    'Phone': phone,
    'Tablet': tablet,
    'TabletPortrait': tabletPortrait,
    'TabletLandscape': tabletLandscape,
  };
}

/// Test ekranını [size] mantıksal boyutuna ayarlar; test bitince eski haline döner.
void useScreen(WidgetTester tester, Size size) {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

/// Ekran okuyucu etiketi [label] olan dokunulabilir düğme, kart, blok veya kutu. Aynı yazı düğme
/// olmayan bir metinde de geçebildiği için yalnızca düğmeler aranır.
Finder findButton(String label) => find.byWidgetPredicate(
  (widget) => widget is Semantics && widget.properties.button == true && widget.properties.label == label,
);

/// Öğe ekran dışındaysa önce görünür hale getirilir, sonra dokunulur.
Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await tester.pump();
}

/// Robotun yürüyüşü, kutlama ve sonuç paneli animasyonlarının bitmesi için yeterli süre.
Future<void> waitForAnimations(WidgetTester tester, {int steps = 50}) async {
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

/// Ana ekrandan [gameTitle] oyununun seviye seçim ekranını açar. Ana ekrandaki ızgara yalnızca
/// görünen kartları kurduğu için kart aşağıdaysa önce kaydırılır ve tamamen görünür hale getirilir.
Future<void> openLevelSelect(WidgetTester tester, String gameTitle) async {
  await tester.scrollUntilVisible(find.text(gameTitle), 200, scrollable: find.byType(Scrollable).first);
  await tester.ensureVisible(find.text(gameTitle));
  await settle(tester);
  await tester.tap(find.text(gameTitle));
  await settle(tester);
  expect(find.byType(LevelSelectScreen), findsOneWidget);
}

/// Seviye seçim ekranında [number]. seviyeyi açar.
Future<void> openLevel(WidgetTester tester, int number) async {
  await tester.tap(find.bySemanticsLabel('Seviye $number'));
  await settle(tester);
}

/// Sayfa geçişi veya pencere açılıp kapanması gibi kısa animasyonların bitmesini bekler. Robotlar
/// beklerken hep sallandığı için ekran hiç durulmaz ve `pumpAndSettle` zaman aşımına uğrar; onun
/// yerine bu kısa animasyonların süresi kadar beklenir.
Future<void> settle(WidgetTester tester) => waitForAnimations(tester, steps: _settleSteps);

/// Sayfa geçişi (300 ms) ve sonuç paneli (450 ms) gibi kısa animasyonlara yeten `waitForAnimations` adımı.
const _settleSteps = 5;
