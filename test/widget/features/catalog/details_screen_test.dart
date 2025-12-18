import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/presentation/details_screen.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

void main() {
  group('DetailsScreen Widget Tests', () {
    late Scenario testScenario;
    final exampleScenario = [
      ScenarioNode(
        id: 'introduction', 
        elements: [
          TextElement(text: 'This the introduction')
        ]
      )
    ];

    setUp(() {
      testScenario = Scenario(
        title: 'Mystery in Old Town',
        description: 'Solve a centuries-old mystery while exploring the historic streets of the old town. This adventure will take you through hidden passages and ancient secrets.',
        location: 'Warsaw, Poland',
        distance: '15km',
        duration: '3 hours',
        image: 'assets/cat.webp',
        startNode: exampleScenario[0]
      );
    });

    testWidgets('should display all scenario details', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      expect(find.text(testScenario.title), findsOneWidget);
      expect(find.text(testScenario.description), findsOneWidget);
      expect(find.text(testScenario.location), findsOneWidget);
      expect(find.text(testScenario.distance), findsOneWidget);
      expect(find.text(testScenario.duration), findsOneWidget);
    });

    testWidgets('should display base app bar', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      expect(find.byType(BaseAppBar), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display scenario image', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      expect(find.image(AssetImage(testScenario.image)), findsOneWidget);
    });

    testWidgets('should display play button', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.text('Play'), findsOneWidget);
    });

    testWidgets('should display exactly three labeled icons', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      expect(find.byType(LabeledIcon), findsExactly(3));
    });

    testWidgets('should display location, duration, and distance icons', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.byIcon(Icons.access_time), findsOneWidget);
      expect(find.byIcon(Icons.directions_walk), findsOneWidget);
    });

    testWidgets('should handle play button tap and navigation', (tester) async {
      // TODO: move to integration tests
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: testScenario),
      ));

      final playButton = find.byType(FilledButton);
      expect(playButton, findsOneWidget);
      
      await tester.tap(playButton);
      await tester.pumpAndSettle();
    });

    testWidgets('should handle long description text', (tester) async {
      final longScenario = Scenario(
        title: 'Very Long Title That Might Wrap',
        description: 'This is a very long description ' * 50,
        location: 'Very Long Location Name',
        distance: '999km',
        duration: '24 hours',
        image: '',
        startNode: exampleScenario[0],
      );

      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(scenario: longScenario),
      ));

      expect(find.text(longScenario.description), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}