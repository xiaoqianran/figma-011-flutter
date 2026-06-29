import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_router.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_theme.dart';

class Figma011App extends StatefulWidget {
  const Figma011App({super.key});

  @override
  State<Figma011App> createState() => _Figma011AppState();
}

class _Figma011AppState extends State<Figma011App> {
  late final GoRouter _router = createAppRouter();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Fast Courier',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: _router,
        );
      },
    );
  }
}