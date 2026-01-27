import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/presentation/catalog_list_item.dart';

import '../../../utils/test_factory.dart';

class MockScenariosRepository extends Mock implements ScenariosRepository {}

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
      when(() => mockRepository.loadAll()).thenAnswer(
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
      final mockScenario = TestFactory.createMockScenario();
      
      when(() => mockRepository.loadAll()).thenAnswer((_) async => [mockScenario]);

      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        expect(find.byType(CatalogListItem), findsOneWidget);
        expect(find.text('No scenarios found'), findsNothing);
      });

    });

    testWidgets('renders Error view when repository throws an exception', (tester) async {
      when(() => mockRepository.loadAll()).thenThrow(Exception('Network Error'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('renders Empty view when repository returns empty list', (tester) async {
      when(() => mockRepository.loadAll()).thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No scenarios found'), findsOneWidget);
      expect(find.text('Scenarios repository is empty.'), findsOneWidget);
      expect(find.byIcon(Icons.sentiment_dissatisfied), findsOneWidget);
      
      expect(find.text('Try Again'), findsOneWidget);
    });
  });
}