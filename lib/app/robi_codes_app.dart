import 'package:flutter/material.dart';

import '../features/home/home_screen.dart';
import 'app_scope.dart';
import 'app_services.dart';
import 'app_theme.dart';

final class RobiCodesApp extends StatelessWidget {
  const RobiCodesApp({required this.services, super.key});

  static const title = 'Robi Kodluyor';

  final AppServices services;

  @override
  Widget build(BuildContext context) => AppScope(
        services: services,
        child: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(),
          home: const HomeScreen(),
        ),
      );
}
