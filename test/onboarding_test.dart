import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_011/features/onboarding/onboarding_screen.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

void main() {
  testWidgets('Onboarding first page shows title and Get Started',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OnboardingScreen(),
      ),
    );

    expect(find.textContaining('We deliver'), findsOneWidget);
    expect(find.text('1/3'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
  });
}