import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_factory.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

import '../../utils/test_factory.dart';

void main() {
  late ScenariosRepository mockRepository;
  late Scenario mockScenario;
  late LocationService mockLocationService;

  setUp(() {
    mockScenario = TestFactory.createMockScenario();
    mockRepository = TestFactory.createMockScenariosRepository(scenarios: [mockScenario]);
    mockLocationService = TestFactory.createMockLocationService();

    MapFactory.setMockBuilder((options, children) => const SizedBox(key: Key('map_placeholder')));
  });

  tearDown(() {
    MapFactory.clearMockBuilder();
  });

  Widget createTestApp() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ScenariosRepository>.value(value: mockRepository),
        RepositoryProvider<LocationService>.value(value: mockLocationService)
      ], 
      child: MaterialApp(
        home: ScenarioScreen(id: 'Id'),
      )
    );
  }

  group('ScenarioScreen Tabs Flow', () {
    testWidgets('navigates between Story and Map tabs', (tester) async {
      await mockNetworkImagesFor(() async {
        
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        final mapIconFinder = find.byIcon(Icons.map);
        expect(mapIconFinder, findsOneWidget);

        final mapFinder = find.byKey(Key('map_placeholder'));
        expect(mapFinder, findsNothing);
        
        await tester.tap(mapIconFinder);
        await tester.pump();

        expect(mapFinder, findsOneWidget);

        final storyIconFinder = find.byIcon(Icons.text_snippet);
        expect(storyIconFinder, findsOneWidget);
      });
    });
  });
}