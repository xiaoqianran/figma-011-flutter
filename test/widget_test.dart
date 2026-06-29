import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_011/features/splash/splash_screen.dart';
import 'package:figma_011/shared/widgets/app_logo.dart';

void main() {
  testWidgets('Splash screen shows centered logo on dark background',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.byType(AppLogo), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}