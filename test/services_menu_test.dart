import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/features/nearby_courier/nearby_courier_screen.dart';
import 'package:fast_courier_app/features/services/services_menu_screen.dart';
import 'package:fast_courier_app/features/track_order/track_order_screen.dart';

void main() {
  testWidgets('Services menu shows all menu items', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.servicesMenu,
          builder: (context, state) => const ServicesMenuScreen(),
        ),
      ],
      initialLocation: AppRoutes.servicesMenu,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Services'), findsOneWidget);
    expect(find.text('Track Order'), findsOneWidget);
    expect(find.text('Calculate Parcel'), findsOneWidget);
    expect(find.text('Ship Parcel'), findsOneWidget);
    expect(find.text('Nearby Courier'), findsOneWidget);
  });

  testWidgets('Services menu navigates to Nearby Courier',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.servicesMenu,
          builder: (context, state) => const ServicesMenuScreen(),
        ),
        GoRoute(
          path: AppRoutes.nearbyCourier,
          builder: (context, state) => const NearbyCourierScreen(),
        ),
      ],
      initialLocation: AppRoutes.servicesMenu,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('Nearby Courier'));
    await tester.pumpAndSettle();

    expect(find.text('Search address'), findsOneWidget);
    expect(find.text('Nearby'), findsOneWidget);
  });

  testWidgets('Services menu navigates to Track Order',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.servicesMenu,
          builder: (context, state) => const ServicesMenuScreen(),
        ),
        GoRoute(
          path: AppRoutes.trackOrder,
          builder: (context, state) => const TrackOrderScreen(),
        ),
      ],
      initialLocation: AppRoutes.servicesMenu,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('Track Order'));
    await tester.pumpAndSettle();

    expect(find.text('Shipping ID'), findsOneWidget);
    expect(find.text('Package Details'), findsOneWidget);
  });
}