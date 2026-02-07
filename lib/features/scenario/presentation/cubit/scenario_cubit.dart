import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/presentation/cubit/navigation_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

class ScenarioCubit extends Cubit<ScenarioState> {
  ScenarioCubit({required this.scenario, required this.navigationCubit}): super(ScenarioRunning(elements: [])) {
    try {
      load(scenario.startNodeId);
    } catch (e) {
      emit(ScenarioError(message: e.toString()));
    }
  }

  final Scenario scenario;
  final NavigationCubit navigationCubit;

  void load(String id) {
    final node = scenario.nodes.firstWhere(
      (element) => element.id == id,
      orElse: () => throw Exception('ScenarioNode with id: $id was not found in the scenario.')
    );

    emit(ScenarioRunning(elements: node.elements));
  }

  void handleTrigger(ScenarioTrigger trigger) {
    _ensureStateIsScenarioRunning();
    if (trigger.triggered) return;

    switch (trigger) {
      case ProceedTrigger(:final id): {
        load(id);
      }
      case AppendElementsTrigger(:final elements): {
        final updated = List<ScenarioElement>.from((state as ScenarioRunning).elements)..addAll(elements);
        emit(ScenarioRunning(elements: updated));
      }
      case WithStoryNotificationTrigger(:final trigger): {
        navigationCubit.addStoryNotification();
        handleTrigger(trigger);
      }
      case WithMapNotificationTrigger(:final trigger): {
        navigationCubit.addMapNotification();
        handleTrigger(trigger);
      }
      case EndTrigger(): {
        
      }
      case EmptyTrigger(): {}
    }

    trigger.triggered = true;
  }

  void removeElement(ScenarioElement element) {
    _ensureStateIsScenarioRunning();
    final updated = List<ScenarioElement>.from((state as ScenarioRunning).elements)..remove(element);
    emit(ScenarioRunning(elements: updated));
  }

  void _ensureStateIsScenarioRunning() {
    if (state is! ScenarioRunning) {
      emit(ScenarioError(message: 'Cannot handle trigger for scenario with state not equal to ScenarioRunning'));
    }
  }
}