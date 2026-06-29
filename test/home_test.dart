import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fast_courier_app/features/home/home_screen.dart';

void main() {
  testWidgets('Home screen shows greeting, promo, and shipment cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Hello Ferdous,'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Shipping number'), findsOneWidget);
    expect(find.text('Get 15%\nCash back'), findsWidgets);
    expect(find.textContaining('Use the code'), findsWidgets);
    expect(find.text('Shipment History'), findsOneWidget);
    expect(find.text('View All'), findsOneWidget);
    expect(find.text('#124 784 8754'), findsWidgets);
    expect(find.text('Pending'), findsWidgets);
    expect(find.text('Amsterdam, Netherlands'), findsWidgets);
    expect(find.text('New York, USA'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
  });
}