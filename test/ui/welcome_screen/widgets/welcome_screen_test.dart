import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/ui/welcome_screen/widgets/welcome_screen.dart';

void main() {
  testWidgets('Welcome screen has icon, title and button', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: WelcomeScreen(),
    ));

    expect(find.byIcon(Icons.map), findsOneWidget);
    expect(find.text('Narracity'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
  });
}