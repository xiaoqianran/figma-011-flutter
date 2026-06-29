import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/ship_parcel/ship_parcel_details_screen.dart';
import 'package:figma_011/features/ship_parcel/ship_parcel_screen.dart';
import 'package:figma_011/features/ship_parcel/ship_payment_screen.dart';

void main() {
  testWidgets('Ship Parcel packaging screen shows route and packaging',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.shipParcel,
          builder: (context, state) => const ShipParcelScreen(),
        ),
      ],
      initialLocation: AppRoutes.shipParcel,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Ship Parcel'), findsOneWidget);
    expect(find.text('Packaging'), findsOneWidget);
    expect(find.text('Box'), findsOneWidget);
    expect(find.text('# Of Packages'), findsOneWidget);
    expect(find.text('Weight Per Package'), findsOneWidget);
    expect(find.text('Add Package'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Ship Parcel flow navigates to payment',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.shipParcel,
          builder: (context, state) => const ShipParcelScreen(),
        ),
        GoRoute(
          path: AppRoutes.shipParcelDetails,
          builder: (context, state) => const ShipParcelDetailsScreen(),
        ),
        GoRoute(
          path: AppRoutes.shipPayment,
          builder: (context, state) => const ShipPaymentScreen(),
        ),
      ],
      initialLocation: AppRoutes.shipParcel,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Internal Reference ID'), findsOneWidget);
    expect(find.text('Home Delivery'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Arives On'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    await tester.tap(find.text('Ship'));
    await tester.pumpAndSettle();

    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('Order Summary'), findsOneWidget);
    expect(find.text('Pay \$53.00'), findsOneWidget);
    expect(find.text(r'$53.00'), findsOneWidget);
  });
}