import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_blur.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/background_image.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_sheet.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/content.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class MockCatalogCubit extends Mock implements CatalogCubit {}
class MockScenario extends Mock implements Scenario {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class FakeRoute extends Fake implements Route {}

void main() {
  late MockCatalogCubit mockCubit;
  late MockScenario mockScenario;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockCubit = MockCatalogCubit();
    mockScenario = MockScenario();
    mockObserver = MockNavigatorObserver();
    
    registerFallbackValue(FakeRoute());

    when(() => mockScenario.id).thenReturn('Test Id');
    when(() => mockScenario.image).thenReturn('https://example.com/image.png');
    when(() => mockScenario.title).thenReturn('Test Scenario');
    when(() => mockScenario.description).thenReturn('Test Description');
    when(() => mockScenario.location).thenReturn('Test Location');
    when(() => mockScenario.duration).thenReturn('Dur');
    when(() => mockScenario.distance).thenReturn('Dist');
  });

  Widget createWidgetUnderTest(String id) {
    return MaterialApp(
      home: BlocProvider<CatalogCubit>.value(
        value: mockCubit,
        child: DetailsScreen(id: id)
      ),
      navigatorObservers: [mockObserver],
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

        verify(() => mockObserver.didPush(any(), any())).called(1);
      });
    });
  });
}