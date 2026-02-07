import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

import '../../../utils/test_factory.dart';

void main() {
  group('CatalogCubit', () {
    late CatalogCubit cubit;
    late ScenariosRepository mockScenariosRepository;
    late List<Scenario> mockScenarios;

    setUpAll(() {
      registerFallbackValue(TestFactory.createMockScenario());
    });

    setUp(() {
      mockScenarios = [
        TestFactory.createMockScenario(id: 'id_1'),
        TestFactory.createMockScenario(id: 'id_2')
      ];

      mockScenariosRepository = TestFactory.createMockScenariosRepository(scenarios: mockScenarios);

      cubit = CatalogCubit(scenariosRepository: mockScenariosRepository);
    });

    void whenRepositoryThrowsFirebaseException() {
      when(() => mockScenariosRepository.loadAll()).thenThrow(FirebaseException(plugin: '', code: 'unavailable'));
    }

    void whenRepositoryThrowsUnknownException() {
      when(() => mockScenariosRepository.loadAll()).thenThrow(Exception(['error']));
    }    

    tearDown(() {
      cubit.close();
    });

    test('initial state is Loading', () {
      expect(cubit.state, isA<CatalogLoading>());
    });

    blocTest('loads all scenarios', 
      build: () => cubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<CatalogLoaded>().having((state) => state.scenarios, 'scenarios', mockScenarios)
      ]
    );

    blocTest('emits internet connection error correctly', 
      setUp: () => whenRepositoryThrowsFirebaseException(),
      build: () => cubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<CatalogError>().having((state) => state.message, 'error message', 'No internet connection. Please try again.')
      ]
    );

    blocTest('emits generic error on unknown exception', 
      setUp: () => whenRepositoryThrowsUnknownException(),
      build: () => cubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<CatalogError>().having((state) => state.message, 'error message', 'Something went wrong. Please try again.')
      ]
    );
  });
}