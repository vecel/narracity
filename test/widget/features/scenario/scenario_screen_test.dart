import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_factory.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/features/scenario/subfeatures/story/presentation/story_screen.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

import '../../../utils/test_factory.dart';

void main() {
  late ScenariosRepository mockRepository;
  late Scenario mockScenario;
  late LocationService mockLocationService;

  setUpAll(() {
    registerFallbackValue(TestFactory.createMockScenario());
  });

  setUp(() {
    mockScenario = TestFactory.createMockScenario();
    mockRepository = TestFactory.createMockScenariosRepository(scenarios: [mockScenario]);
    mockLocationService = TestFactory.createMockLocationService();

    MapFactory.setMockBuilder((options, children) => const SizedBox());
  });

  tearDown(() {
    MapFactory.clearMockBuilder();
  });

  Widget createWidgetUnderTest() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ScenariosRepository>.value(value: mockRepository),
        RepositoryProvider<LocationService>.value(value: mockLocationService)
      ], 
      child: const MaterialApp(
        home: ScenarioScreen(id: 'Id'),
      )
    );
  }

  group('ScenarioScreen', () {
    testWidgets('renders StoryScreen and AppBar', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        expect(find.byType(BaseAppBar), findsOneWidget);
        expect(find.text('Title'), findsOneWidget);
        
        expect(find.byType(StoryScreen), findsOneWidget);
      });
    });
  });
}