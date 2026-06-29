import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_router.dart';
import 'package:figma_011/core/theme/app_theme.dart';

class Figma011App extends StatelessWidget {
  Figma011App({super.key});

  final GoRouter _router = createAppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fast Courier',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}