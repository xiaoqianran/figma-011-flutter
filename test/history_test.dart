import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/features/history/history_screen.dart';

void main() {
  testWidgets('History screen shows title, filters, and shipment cards',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.history,
          builder: (context, state) => const HistoryScreen(),
        ),
      ],
      initialLocation: AppRoutes.history,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Delivery History'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Completed'), findsWidgets);
    expect(find.text('Pending'), findsWidgets);
    expect(find.text('#124 784 8754'), findsWidgets);
    expect(find.text('Amsterdam, Netherlands'), findsWidgets);
    expect(find.text('New York, USA'), findsWidgets);
  });

  testWidgets('History filter shows only completed shipments',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.history,
          builder: (context, state) => const HistoryScreen(),
        ),
      ],
      initialLocation: AppRoutes.history,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.byKey(const ValueKey('history-filter-completed')));
    await tester.pump();

    expect(find.text('Completed'), findsWidgets);
    expect(find.byKey(const ValueKey('history-filter-pending')), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
  });
}