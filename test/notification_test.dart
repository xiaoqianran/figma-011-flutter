import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/notification/notification_screen.dart';

void main() {
  testWidgets('Notification screen shows sections and items',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.notification,
          builder: (context, state) => const NotificationScreen(),
        ),
      ],
      initialLocation: AppRoutes.notification,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    expect(find.text('Notification'), findsOneWidget);
    expect(find.text('Mark All as Read'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Last Week'), findsOneWidget);
    expect(find.text('Your package has been delivered.'), findsWidgets);
    expect(find.text('How is our seller'), findsWidgets);
    expect(find.textContaining('Ferdous,'), findsWidgets);
  });

  testWidgets('Mark All as Read is tappable', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.notification,
          builder: (context, state) => const NotificationScreen(),
        ),
      ],
      initialLocation: AppRoutes.notification,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    await tester.tap(find.text('Mark All as Read'));
    await tester.pumpAndSettle();

    expect(find.text('Mark All as Read'), findsOneWidget);
  });
}