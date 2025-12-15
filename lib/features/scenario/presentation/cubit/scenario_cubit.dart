import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

class ScenarioCubit extends Cubit<ScenarioState> {
  ScenarioCubit(this.scenario): super(ScenarioState.initial()) {
    if (scenario.isNotEmpty) {
      load(scenario.first.id);
    }
  }

  final List<ScenarioNode> scenario;

  void load(String id) {
    final node = scenario.firstWhere(
      (element) => element.id == id,
      orElse: () => throw Exception('ScenarioNode with id: $id was not found in the scenario.')
    );

    emit(ScenarioState(elements: node.elements));
  }

  void handleTrigger(ScenarioTrigger trigger) {
    switch (trigger) {
      case ProceedTrigger(:var id): {
        load(id);
      }
      case AppendElementsTrigger(:var elements): {
        final updated = List<ScenarioElement>.from(state.elements)..addAll(elements);
        emit(ScenarioState(elements: updated));
      }
      case EmptyTrigger(): {}
    }
  }
}