import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/features/faq/faq_screen.dart';
import 'package:fast_courier_app/features/help/help_screen.dart';
import 'package:fast_courier_app/features/menu/menu_screen.dart';
import 'package:fast_courier_app/features/profile/profile_screen.dart';

void main() {
  testWidgets('Menu screen shows profile, stats, and menu items',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.menu,
          builder: (context, state) => const MenuScreen(),
        ),
      ],
      initialLocation: AppRoutes.menu,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('Ferdous Sarker'), findsOneWidget);
    expect(find.text('ferdous@gmail.com'), findsOneWidget);
    expect(find.text('Sent'), findsOneWidget);
    expect(find.text('03'), findsOneWidget);
    expect(find.text('Received'), findsOneWidget);
    expect(find.text('09'), findsOneWidget);
    expect(find.text('Notification'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('FAQ'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
  });

  testWidgets('Menu navigates to profile, FAQ, and Help',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.menu,
          builder: (context, state) => const MenuScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: AppRoutes.faq,
          builder: (context, state) => const FaqScreen(),
        ),
        GoRoute(
          path: AppRoutes.help,
          builder: (context, state) => const HelpScreen(),
        ),
      ],
      initialLocation: AppRoutes.menu,
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Save Changes'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.text('FAQ'));
    await tester.pumpAndSettle();
    expect(find.text('Top Question'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Help & Support'));
    await tester.pumpAndSettle();
    expect(find.text('Submit Question'), findsOneWidget);
  });
}