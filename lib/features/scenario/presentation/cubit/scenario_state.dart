import 'package:narracity/features/scenario/domain/node.dart';

final class ScenarioState {
  const ScenarioState({required this.actions});

  factory ScenarioState.initial() => const ScenarioState(actions: []);

  final List<ScenarioAction> actions;

  List<MapAction> get mapElements => actions.whereType<MapAction>().toList();
  List<StoryAction> get story => actions.whereType<StoryAction>().toList();
} 