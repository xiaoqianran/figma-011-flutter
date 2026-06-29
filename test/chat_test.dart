import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/features/chat/chat_detail_screen.dart';
import 'package:figma_011/features/chat/chat_screen.dart';

void main() {
  testWidgets('Chat screen shows messages list and bottom nav',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.chat,
          builder: (context, state) => const ChatScreen(),
        ),
      ],
      initialLocation: AppRoutes.chat,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Sowkot Hasan'), findsOneWidget);
    expect(find.text('Aminur Islam'), findsOneWidget);
    expect(find.text('Yeasin'), findsOneWidget);
    expect(find.text('Russel'), findsOneWidget);
    expect(find.text('Your package will arrive soon...'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
  });

  testWidgets('Chat navigates to conversation detail',
      (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.chat,
          builder: (context, state) => const ChatScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return ChatDetailScreen(conversationId: id);
              },
            ),
          ],
        ),
      ],
      initialLocation: AppRoutes.chat,
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    await tester.tap(find.text('Sowkot Hasan'));
    await tester.pumpAndSettle();

    expect(
      find.text('I will pickup your package\nwithin 1 hours'),
      findsOneWidget,
    );
    expect(
      find.text('It\'s hard to be productive, man 🙄'),
      findsOneWidget,
    );
    expect(find.text('Okay i\'am wating for you'), findsOneWidget);
    expect(find.text('Type something...'), findsOneWidget);
  });
}