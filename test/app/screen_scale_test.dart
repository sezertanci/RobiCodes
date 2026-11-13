import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robi_codes/app/screen_scale.dart';

void main() {
  test('size_Phone_KeepsBaseSize', () {
    final scale = ScreenScale.fromSize(const Size(360, 690));

    expect(scale.size(50, max: 96), 50);
  });

  test('size_Tablet_GrowsUpToMaximum', () {
    final scale = ScreenScale.fromSize(const Size(711, 1138));

    expect(scale.size(50, max: 96), 50 * ScreenScale.maxFactor);
    expect(scale.size(72, max: 96), 96);
  });

  test('size_PortraitAndLandscape_UseSameScale', () {
    expect(ScreenScale.fromSize(const Size(711, 1138)).factor, ScreenScale.fromSize(const Size(1138, 711)).factor);
  });
}
