import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_011/features/auth/login_screen.dart';

void main() {
  testWidgets('Login screen shows welcome text and form fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Let\u2019s Get Start'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('ferdous@gmail.com'), findsOneWidget);
  });
}