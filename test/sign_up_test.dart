import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_011/features/auth/sign_up_screen.dart';

void main() {
  testWidgets('Sign up screen shows welcome text and all form fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpScreen(),
      ),
    );

    expect(find.text('Welcome to Fast!'), findsOneWidget);
    expect(find.text('Let\u2019s Create Account'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    expect(find.text('Sing up'), findsOneWidget);
    expect(find.text('Ferdous Sarker'), findsOneWidget);
  });
}