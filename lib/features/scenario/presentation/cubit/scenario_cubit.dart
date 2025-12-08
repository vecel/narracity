import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/scenario/domain/node.dart';
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

    emit(ScenarioState(actions: node.actions));
  }

  void handleTrigger(ScenarioActionTrigger trigger) {
    switch (trigger) {
      case ProceedTrigger(:var id): {
        load(id);
      }
      case AppendActionsTrigger(:var actions): {
        final updated = List<ScenarioAction>.from(state.actions)..addAll(actions);
        emit(ScenarioState(actions: updated));
      }
      case EmptyTrigger(): {}
    }
  }
}