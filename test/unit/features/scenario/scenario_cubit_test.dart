import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

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

    late ScenarioCubit cubit;

    setUp(() {
      cubit = ScenarioCubit(scenario);
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
    
  });
}