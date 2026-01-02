import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/presentation/cubit/navigation_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

class ScenarioCubit extends Cubit<ScenarioState> {
  ScenarioCubit({required this.scenario, required this.navigationCubit}): super(ScenarioState.initial()) {
    if (scenario.isNotEmpty) {
      load(scenario.first.id);
    }
  }

  final List<ScenarioNode> scenario;
  final NavigationCubit navigationCubit;

  void load(String id) {
    final node = scenario.firstWhere(
      (element) => element.id == id,
      orElse: () => throw Exception('ScenarioNode with id: $id was not found in the scenario.')
    );

    emit(ScenarioState(elements: node.elements));
  }

  void handleTrigger(ScenarioTrigger trigger) {
    switch (trigger) {
      case ProceedTrigger(:final id): {
        load(id);
      }
      case AppendElementsTrigger(:final elements): {
        final updated = List<ScenarioElement>.from(state.elements)..addAll(elements);
        emit(ScenarioState(elements: updated));
      }
      case WithStoryNotificationTrigger(:final trigger): {
        navigationCubit.addStoryNotification();
        handleTrigger(trigger);
      }
      case WithMapNotificationTrigger(:final trigger): {
        navigationCubit.addMapNotification();
        handleTrigger(trigger);
      }
      case EmptyTrigger(): {}
    }
  }

  void removeElement(ScenarioElement element) {
    final updated = List<ScenarioElement>.from(state.elements)..remove(element);
    emit(ScenarioState(elements: updated));
  }
}