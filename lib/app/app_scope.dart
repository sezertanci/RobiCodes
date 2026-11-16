import 'package:flutter/widgets.dart';

import 'app_services.dart';

/// Servisleri widget ağacına verir. Ekranlar servislere `AppScope.of(context)` ile ulaşır;
/// hiçbir ekran servis oluşturmaz.
final class AppScope extends InheritedWidget {
  const AppScope({required this.services, required super.child, super.key});

  final AppServices services;

  static AppServices of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope widget ağacında bulunamadı.');
    return scope!.services;
  }

  /// Servisleri ağaca bağımlılık kurmadan okur; geri çağırmalarda (ör. dokunma anında) kullanılır.
  /// Ağaçta [AppScope] yoksa (bileşenlerin tek başına denendiği testlerde) `null` döner.
  static AppServices? read(BuildContext context) => context.getInheritedWidgetOfExactType<AppScope>()?.services;

  @override
  bool updateShouldNotify(AppScope oldWidget) => services != oldWidget.services;
}
