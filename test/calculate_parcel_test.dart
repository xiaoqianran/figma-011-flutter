import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/features/calculate_parcel/calculate_parcel_screen.dart';
import 'package:fast_courier_app/features/calculate_parcel/calculate_result_screen.dart';

void main() {
  testWidgets('Calculate Parcel screen shows route, sizes, and calculate',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.calculateParcel,
          builder: (context, state) => const CalculateParcelScreen(),
        ),
      ],
      initialLocation: AppRoutes.calculateParcel,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Calculate Parcel'), findsOneWidget);
    expect(find.text('From'), findsOneWidget);
    expect(find.text('To'), findsOneWidget);
    expect(find.text('Gouripur, Daudkandi'), findsOneWidget);
    expect(find.text('Tejgaon, Dhaka'), findsOneWidget);
    expect(find.text('Package Size'), findsOneWidget);
    expect(find.text('0-5 kg'), findsOneWidget);
    expect(find.text('Calculate'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.textContaining('value or size of item'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    expect(
      find.textContaining('Calculate shipping cost base on order'),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.text('5-9 kg'),
      120,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pump();
    expect(find.text('5-9 kg'), findsOneWidget);
  });

  testWidgets('Calculate Parcel navigates to result on Calculate tap',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.calculateParcel,
          builder: (context, state) => const CalculateParcelScreen(),
        ),
        GoRoute(
          path: AppRoutes.calculateResult,
          builder: (context, state) => const CalculateResultScreen(),
        ),
      ],
      initialLocation: AppRoutes.calculateParcel,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();

    expect(find.text('Calculate Result'), findsOneWidget);
    expect(find.text('Suggestion'), findsOneWidget);
    expect(find.text(r'$ 48.00'), findsOneWidget);
    expect(find.text('Compare Price'), findsOneWidget);
    expect(find.text('Back to Home'), findsOneWidget);
  });
}