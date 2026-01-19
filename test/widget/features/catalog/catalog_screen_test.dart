import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/presentation/catalog_list_item.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockScenariosRepository extends Mock implements ScenariosRepository {}

class MockScenario extends Mock implements Scenario {}

void main() {
  late MockScenariosRepository mockRepository;

  setUp(() {
    mockRepository = MockScenariosRepository();
  });

  Widget createWidgetUnderTest() {
    return RepositoryProvider<ScenariosRepository>.value(
      value: mockRepository,
      child: MaterialApp(
        home: CatalogScreen(),
      ),
    );
  }

  group('CatalogScreen', () {
    testWidgets('renders Loading view initially', (tester) async {
      when(() => mockRepository.getScenarios()).thenAnswer(
        (_) async {
          await Future.delayed(const Duration(seconds: 1));
          return [];
        },
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); 

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('renders Success view with list items when data loads', (tester) async {
      final mockScenario = MockScenario();

      when(() => mockScenario.title).thenReturn('Test Title');
      when(() => mockScenario.description).thenReturn('Example description');
      when(() => mockScenario.location).thenReturn('Warsaw');
      when(() => mockScenario.duration).thenReturn('2 h');
      when(() => mockScenario.distance).thenReturn('6 km');
      when(() => mockScenario.image).thenReturn('');
      
      when(() => mockRepository.getScenarios()).thenAnswer((_) async => [mockScenario]);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(CatalogListItem), findsOneWidget);
        expect(find.text('No scenarios found'), findsNothing);
      });

    });

    testWidgets('renders Error view when repository throws', (tester) async {
      when(() => mockRepository.getScenarios()).thenThrow(Exception('Network Error'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('renders Empty view when repository returns empty list', (tester) async {
      when(() => mockRepository.getScenarios()).thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No scenarios found'), findsOneWidget);
      expect(find.text('Scenarios repository is empty.'), findsOneWidget);
      expect(find.byIcon(Icons.sentiment_dissatisfied), findsOneWidget);
      
      expect(find.text('Try Again'), findsOneWidget);
    });
  });
}