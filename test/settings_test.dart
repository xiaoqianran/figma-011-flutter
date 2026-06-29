import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/settings/settings_screen.dart';

void main() {
  testWidgets('Settings screen shows toggles and info rows',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
      initialLocation: AppRoutes.settings,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    expect(find.text('Setting'), findsOneWidget);
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Push Notification'), findsOneWidget);
    expect(find.text('Email Notification'), findsOneWidget);
    expect(find.text('Location Services'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('App Version'), findsOneWidget);
    expect(find.text('1.0.0'), findsOneWidget);
  });
}