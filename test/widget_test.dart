import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project2/main.dart';

void main() {
  testWidgets('renders demo home page title and increments counter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Demo Home Page'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
