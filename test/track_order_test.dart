import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/track_order/track_order_screen.dart';

void main() {
  testWidgets('Track Order screen shows map, shipping ID, and timeline',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.trackOrder,
          builder: (context, state) => const TrackOrderScreen(),
        ),
      ],
      initialLocation: AppRoutes.trackOrder,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Track Order'), findsOneWidget);
    expect(find.text('97847548956'), findsWidgets);
    expect(find.text('Shipping ID'), findsOneWidget);
    expect(find.text('Package has been received'), findsOneWidget);
    expect(find.text('Arrived at destination area'), findsOneWidget);
    expect(find.text('Accept by Wedx'), findsOneWidget);
    expect(find.text('May 21'), findsOneWidget);
    expect(find.text('May 20'), findsOneWidget);
    expect(find.text('May 19'), findsOneWidget);
    expect(find.text('Package Details'), findsOneWidget);
    expect(find.text('W Market Rd, Gouripur 3517'), findsWidgets);
  });
}