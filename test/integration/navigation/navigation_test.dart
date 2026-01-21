import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/home/welcome_screen.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_factory.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:narracity/routes.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../utils/test_factory.dart';

void main() {
  late ScenariosRepository mockRepository;
  late LocationService mockLocationService;
  late Scenario mockScenario;
  late DefaultCacheManager mockCacheManager;

  setUp(() {
    mockLocationService = TestFactory.createMockLocationService();
    mockScenario = TestFactory.createMockScenario(); 
    mockRepository = TestFactory.createMockScenariosRepository(scenarios: [mockScenario]);
    mockCacheManager = TestFactory.createMockCacheManager();

    MapFactory.setMockBuilder((options, children) => const SizedBox());
  });

  tearDown(() {
    MapFactory.clearMockBuilder();
  });

  Widget createTestApp() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ScenariosRepository>.value(value: mockRepository),
        RepositoryProvider<LocationService>.value(value: mockLocationService),
        RepositoryProvider<BaseCacheManager>.value(value: mockCacheManager),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  group('App Navigation Flow', () {
    testWidgets('navigates to CatalogScreen and back to WelcomeScreen', (tester) async {  
      await mockNetworkImages(() async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        expect(find.byType(WelcomeScreen), findsOneWidget);

        await tester.tap(find.text("Let's Explore"));
        await tester.pumpAndSettle();

        expect(find.byType(CatalogScreen), findsOneWidget);
        expect(find.text('Catalog'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        expect(find.byType(WelcomeScreen), findsOneWidget);
      });
    });

    testWidgets('navigates to ScenarioScreen and back to WelcomeScreen', (tester) async {
      await mockNetworkImagesFor(() async {

        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        await tester.tap(find.text("Let's Explore"));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Title'));
        await tester.pumpAndSettle();

        expect(find.byType(DetailsScreen), findsOneWidget);

        await tester.tap(find.byIcon(Icons.play_arrow));
        await tester.pump(Duration(seconds: 5));

        // if (find.byType(ErrorWidget).evaluate().isNotEmpty) {
        //   final error = tester.widget<ErrorWidget>(find.byType(ErrorWidget));
        //   print("🚨 APP CRASHED! Error: ${error.message}");
        // } else if (find.byType(DetailsScreen).evaluate().isNotEmpty) {
        //   print("⚠️ NAVIGATION FAILED: Still on DetailsScreen.");
        // }

        expect(find.byType(ScenarioScreen), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back)); 
        await tester.pumpAndSettle();
        expect(find.byType(DetailsScreen), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(CatalogScreen), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(WelcomeScreen), findsOneWidget);
      });
    });
  });
}