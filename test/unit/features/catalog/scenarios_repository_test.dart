import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/data/scenarios_api.dart';
import 'package:narracity/features/catalog/data/scenarios_cache.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';

import '../../utils/test_factory.dart';

void main() {
  late ScenariosRepository repository;
  late ScenariosApi mockApi;
  late ScenariosStorage mockStorage;
  late ScenariosCache mockCache;

  final remoteScenarios = [
    TestFactory.createMockScenario(id: 'id_1', title: 'rem_1'),
    TestFactory.createMockScenario(id: 'id_2', title: 'rem_2'),
  ];

  final localScenarios = [
    TestFactory.createMockScenario(id: 'id_1', title: 'loc_1'),
    TestFactory.createMockScenario(id: 'id_2', title: 'loc_2'),
    TestFactory.createMockScenario(id: 'id_3', title: 'loc_3'),
  ];

  final cachedScenarios = [
    TestFactory.createMockScenario(id: 'id_1', title: 'cac_1')
  ];

  setUpAll(() {
    registerFallbackValue(TestFactory.createMockScenario());
  });

  setUp(() {
    mockApi = TestFactory.createMockScenariosApi(scenarios: remoteScenarios);
    mockStorage = TestFactory.createMockScenariosStorage(scenarios: localScenarios);
    mockCache = TestFactory.createMockScenariosCache(scenarios: cachedScenarios);

    repository = ScenariosRepository(
      api: mockApi, 
      storage: mockStorage,
      cache: mockCache
    );
  });

  group('ScenariosRepository Integration Tests', () {
    test('loadAll merges sources with priority Cache > Remote > Local', () async {
      final result = await repository.loadAll();

      expect(result.length, 3);
      
      final scenario1 = result.firstWhere((s) => s.id == 'id_1');
      expect(scenario1.title, 'cac_1');

      final scenario2 = result.firstWhere((s) => s.id == 'id_2');
      expect(scenario2.title, 'rem_2');

      final scenario3 = result.firstWhere((s) => s.id == 'id_3');
      expect(scenario3.title, 'loc_3');

      verify(() => mockApi.loadAll()).called(1);
      verify(() => mockCache.loadAll()).called(1);
    });

    test('load returns cached scenario if available, avoiding external calls', () async {
      final result = await repository.load('id_1');

      expect(result, isNotNull);
      expect(result!.title, 'cac_1');
      
      verifyNever(() => mockApi.load(any()));
      verifyNever(() => mockStorage.load(any()));
    });

    test('load fetches from API if not in cache, then falls back to storage', () async {
      final result = await repository.load('id_3');

      expect(result, isNotNull);
      expect(result!.title, 'loc_3');

      verify(() => mockCache.contains('id_3')).called(1);
      verify(() => mockApi.load('id_3')).called(1);
      verify(() => mockStorage.load('id_3')).called(1);
    });

    test('save delegates to storage', () async {
      final scenario = TestFactory.createMockScenario();
      await repository.save(scenario);

      verify(() => mockStorage.save(scenario)).called(1);
    });
  });
}