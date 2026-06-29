import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/services/services_screen.dart';

void main() {
  testWidgets('Services screen shows compare price UI and courier cards',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.services,
          builder: (context, state) => const ServicesScreen(),
        ),
      ],
      initialLocation: AppRoutes.services,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Compare Price'), findsOneWidget);
    expect(find.text('Search address'), findsOneWidget);
    expect(find.text('Fast Delivery Services'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Fox Parcel'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    expect(find.text('USB Express Ltd.'), findsOneWidget);
    expect(find.text('Fox Parcel'), findsOneWidget);
    expect(find.text('Continue with Fast'), findsOneWidget);
    expect(find.text('Back to Home'), findsOneWidget);
    expect(find.text('Tracking'), findsWidgets);
    expect(find.text('4.8'), findsWidgets);
  });
}