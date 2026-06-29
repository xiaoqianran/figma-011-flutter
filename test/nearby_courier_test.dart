import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/nearby_courier/nearby_courier_screen.dart';

void main() {
  testWidgets('Nearby Courier screen shows search, filters, and courier cards',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.nearbyCourier,
          builder: (context, state) => const NearbyCourierScreen(),
        ),
      ],
      initialLocation: AppRoutes.nearbyCourier,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Search address'), findsOneWidget);
    expect(find.text('Open Now'), findsOneWidget);
    expect(find.text('Nearby'), findsOneWidget);
    expect(find.text('Visited'), findsOneWidget);
    expect(find.text('United Parcel Service'), findsOneWidget);
    expect(find.text('Fox Parcel'), findsOneWidget);
    expect(find.text('Open : 9am - 8pm'), findsWidgets);
    expect(find.text('4.0'), findsOneWidget);
    expect(find.text('3.9'), findsOneWidget);
  });

  testWidgets('Nearby Courier toggles to map view via FAB',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.nearbyCourier,
          builder: (context, state) => const NearbyCourierScreen(),
        ),
      ],
      initialLocation: AppRoutes.nearbyCourier,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.byIcon(Icons.confirmation_number_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.view_list), findsOneWidget);
    expect(find.text('United Parcel Service'), findsOneWidget);
  });

  testWidgets('Nearby Courier Open Now filter shows only open couriers',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.nearbyCourier,
          builder: (context, state) => const NearbyCourierScreen(),
        ),
      ],
      initialLocation: AppRoutes.nearbyCourier,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('Open Now'));
    await tester.pumpAndSettle();

    expect(find.text('United Parcel Service'), findsOneWidget);
    expect(find.text('Fast Delivery Hub'), findsOneWidget);
    expect(find.text('Fox Parcel'), findsNothing);
  });
}