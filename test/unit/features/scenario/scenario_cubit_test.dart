import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/presentation/cubit/navigation_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

class MockNavigationCubit extends Mock implements NavigationCubit {}

void main() {
  group('ScenarioCubit', () {
    final welcomeText = TextElement(text: 'Hello, World!');
    final thankText = TextElement(text: 'Thank you');
    final byeText = TextElement(text: 'Bye bye, World!');
    final startNode = ScenarioNode(
      id: 'start', 
      elements: [welcomeText]
    );

    final endNode = ScenarioNode(
      id: 'end', 
      elements: [thankText, byeText]
    );

    final scenario = [startNode, endNode];

    late MockNavigationCubit mockNavigationCubit;
    late ScenarioCubit cubit;

    setUp(() {
      mockNavigationCubit = MockNavigationCubit();

      when(() => mockNavigationCubit.state).thenReturn(NavigationState.initial());

      cubit = ScenarioCubit(
        scenario: scenario,
        navigationCubit: mockNavigationCubit
      );
    });

    test('first node is loaded', () {
      expect(cubit.state.elements.length, 1);
      expect(cubit.state.elements, [welcomeText]);
    });

    blocTest('proceed trigger is handled correctly', 
      build: () => cubit,
      act: (cubit) => cubit.handleTrigger(ProceedTrigger(id: 'end')),
      expect: () => [
        isA<ScenarioState>()
          .having((state) => state.elements.length, 'length', 2)
          .having((state) => state.elements, 'elements', [thankText, byeText])
      ]
    );

    blocTest('append elements trigger is handled correctly', 
      build: () => cubit,
      act: (cubit) => cubit.handleTrigger(AppendElementsTrigger(elements: [thankText])),
      expect: () => [
        isA<ScenarioState>()
          .having((state) => state.elements.length, 'length', 2)
          .having((state) => state.elements, 'elements', [welcomeText, thankText])
      ]
    );

    blocTest('removing elements is handled correctly', 
      build: () => cubit,
      act: (cubit) => cubit.removeElement(welcomeText),
      expect: () => [
        isA<ScenarioState>()
          .having((state) => state.elements.length, 'length', 0)
      ]
    );

    blocTest('with story notification trigger is handled correctly', 
      build: () => cubit,
      act: (cubit) => cubit.handleTrigger(WithStoryNotificationTrigger(trigger: ProceedTrigger(id: 'end'))),
      verify: (_) {
        verify(() => mockNavigationCubit.addStoryNotification()).called(1);
      }
    );
    
    blocTest('with map notification trigger is handled correctly', 
      build: () => cubit,
      act: (cubit) => cubit.handleTrigger(WithMapNotificationTrigger(trigger: ProceedTrigger(id: 'end'))),
      verify: (_) {
        verify(() => mockNavigationCubit.addMapNotification()).called(1);
      }
    );

  });
}