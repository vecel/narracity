import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_blur.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/background_image.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_sheet.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/content.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

import '../../../utils/router_helper.dart';

class MockScenario extends Mock implements Scenario {}
class MockScenariosRepository extends Mock implements ScenariosRepository {}
class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockScenario mockScenario;
  late MockScenariosRepository mockRepository;
  late MockGoRouter mockRouter;

  setUp(() {
    mockScenario = MockScenario();
    mockRepository = MockScenariosRepository();
    mockRouter = MockGoRouter();

    when(() => mockRepository.getScenarioById(any())).thenAnswer((_) async => mockScenario);

    when(() => mockScenario.id).thenReturn('Test Id');
    when(() => mockScenario.image).thenReturn('https://example.com/image.png');
    when(() => mockScenario.title).thenReturn('Test Scenario');
    when(() => mockScenario.description).thenReturn('Test Description');
    when(() => mockScenario.location).thenReturn('Test Location');
    when(() => mockScenario.duration).thenReturn('Dur');
    when(() => mockScenario.distance).thenReturn('Dist');

    when(() => mockRouter.go(any())).thenReturn(null);
  });

  Widget createWidgetUnderTest(String id) {
    return RepositoryProvider<ScenariosRepository>.value(
      value: mockRepository,
      child: MaterialApp(
        home: MockGoRouterProvider(
          router: mockRouter,
          child: DetailsScreen(id: id)
        ),
      ),
    );
  }

  group('DetailsScreen', () {
    testWidgets('renders Vertical Layout when screen is tall (> 540)', (tester) async {
      await mockNetworkImagesFor(() async {
        tester.view.physicalSize = const Size(600, 800);
        tester.view.devicePixelRatio = 1;
        
        await tester.pumpWidget(createWidgetUnderTest('Test Id'));
        await tester.pumpAndSettle();

        expect(find.byType(DetailsBackgroundImage), findsOneWidget);
        expect(find.byType(DetailsBottomSheet), findsOneWidget);
        expect(find.byType(DetailsScreenContent), findsOneWidget);
        expect(find.byType(DetailsBottomBlur), findsOneWidget);
      });
    });

    testWidgets('renders Horizontal Layout when screen is short (<= 540)', (tester) async {
      await mockNetworkImagesFor(() async {
        tester.view.physicalSize = const Size(800, 400);
        tester.view.devicePixelRatio = 1;
        
        await tester.pumpWidget(createWidgetUnderTest('Test Id'));
        await tester.pumpAndSettle();

        expect(find.byType(DetailsBackgroundImage), findsNothing);
        expect(find.byType(DetailsBottomSheet), findsNothing);
        
        expect(find.byType(DetailsScreenContent), findsOneWidget);
        expect(find.byType(DetailsBottomBlur), findsOneWidget);
      });
    });

    testWidgets('navigates to ScenarioScreen when FAB is pressed', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest('Test Id'));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.play_arrow));
        
        await tester.pump(); 

        verify(() => mockRouter.go('/scenario/Test Id')).called(1);
      });
    });
  });
}