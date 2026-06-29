import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/payment/payment_screen.dart';

void main() {
  testWidgets('Payment screen shows methods and add card',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.payment,
          builder: (context, state) => const PaymentScreen(),
        ),
      ],
      initialLocation: AppRoutes.payment,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('Payment Methods'), findsOneWidget);
    expect(find.text('....1632'), findsOneWidget);
    expect(find.text('Fast Wallet'), findsOneWidget);
    expect(find.text('Add Card'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
  });
}