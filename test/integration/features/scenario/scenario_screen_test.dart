import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_factory.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/features/scenario/subfeatures/story/presentation/story_screen.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_screen.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

import '../../../utils/location_helper.dart';
import '../../../utils/router_helper.dart';

class MockScenariosRepository extends Mock implements ScenariosRepository {}
class MockScenario extends Mock implements Scenario {}
class MockGoRouter extends Mock implements GoRouter {}
class MockLocationService extends Mock implements LocationService {}

void main() {
  late MockScenariosRepository mockRepository;
  late MockGoRouter mockRouter;
  late MockScenario mockScenario;
  late MockLocationService mockLocationService;

  setUp(() {
    mockRepository = MockScenariosRepository();
    mockRouter = MockGoRouter();
    mockScenario = MockScenario();
    mockLocationService = MockLocationService();

    when(() => mockRouter.go(any())).thenReturn(null);

    when(() => mockScenario.id).thenReturn('Test Id');
    when(() => mockScenario.title).thenReturn('Test Title');
    when(() => mockScenario.description).thenReturn('Example description');
    when(() => mockScenario.location).thenReturn('Warsaw');
    when(() => mockScenario.duration).thenReturn('2 h');
    when(() => mockScenario.distance).thenReturn('6 km');
    when(() => mockScenario.image).thenReturn('');
    when(() => mockScenario.nodes).thenReturn([]);

    when(() => mockRepository.getScenarioById(any()))
      .thenAnswer((_) async => mockScenario);

    when(() => mockLocationService.checkPermission())
      .thenAnswer((_) async => LocationPermission.whileInUse);
    when(() => mockLocationService.getLastKnownPosition())
      .thenAnswer((_) async => LocationHelper.createPosition(52.0, 21.0));
    when(() => mockLocationService.getPositionStream())
      .thenAnswer((_) => Stream.empty());

    MapFactory.setMockBuilder((options, children) => Center(
      child: Text('Map Placeholder')
    ));
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
      child: MockGoRouterProvider(
        router: mockRouter,
        child: const MaterialApp(
          home: ScenarioScreen(id: 'Test Id'),
        ),
      ),
    );
  }

  group('ScenarioScreen', () {
    testWidgets('renders Loader initially, then StoryScreen and AppBar upon success', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();

        expect(find.byType(BaseAppBar), findsOneWidget);
        expect(find.text('Test Title'), findsOneWidget);
        
        expect(find.byType(StoryScreen), findsOneWidget);
      });
    });

    testWidgets('navigates between Story and Map tabs', (tester) async {
      await mockNetworkImagesFor(() async {
        
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final mapIconFinder = find.byIcon(Icons.map);
        expect(mapIconFinder, findsOneWidget);

        final mapFinder = find.text('Map Placeholder');
        expect(mapFinder, findsNothing);
        
        await tester.tap(mapIconFinder);
        await tester.pump();

        expect(mapFinder, findsOneWidget);

        final storyIconFinder = find.byIcon(Icons.text_snippet);
        expect(storyIconFinder, findsOneWidget);
      });
    });

    testWidgets('AppBar back button calls router to return to details', (tester) async {
      await mockNetworkImagesFor(() async {
        
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.arrow_back)); 

        verify(() => mockRouter.go('/details/Test Id')).called(1); 
      });
    });
  });
}