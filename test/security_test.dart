import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/security/security_screen.dart';

void main() {
  testWidgets('Security screen shows password fields and biometric toggle',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.security,
          builder: (context, state) => const SecurityScreen(),
        ),
      ],
      initialLocation: AppRoutes.security,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    expect(find.text('Security'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('Current'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Confirm'), findsOneWidget);
    expect(find.text('Biometric Login'), findsOneWidget);
    expect(find.text('Save Changes'), findsOneWidget);
  });
}