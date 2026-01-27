import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_blur.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/background_image.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_sheet.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/content.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

import '../../../utils/test_factory.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late Scenario mockScenario;
  late ScenariosRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(TestFactory.createMockScenario());
  });

  setUp(() {
    mockScenario = TestFactory.createMockScenario();
    mockRepository = TestFactory.createMockScenariosRepository(scenarios: [mockScenario]);
  });

  Widget createWidgetUnderTest() {
    return RepositoryProvider<ScenariosRepository>.value(
      value: mockRepository,
      child: MaterialApp(
        home: DetailsScreen(id: 'Id')
      ),
    );
  }

  group('DetailsScreen', () {
    testWidgets('renders Vertical Layout when screen is tall (> 540)', (tester) async {
      await mockNetworkImages(() async {
        tester.view.physicalSize = const Size(600, 800);
        tester.view.devicePixelRatio = 1;
        
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

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
        
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(DetailsBackgroundImage), findsNothing);
        expect(find.byType(DetailsBottomSheet), findsNothing);
        
        expect(find.byType(DetailsScreenContent), findsOneWidget);
        expect(find.byType(DetailsBottomBlur), findsOneWidget);
      });
    });
  });
}