import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosRepository {
  ScenariosRepository() {
    // TODO remove
    _scenarios
      ..add(exampleScenario)
      ..add(exampleScenario);
  }

  final List<Scenario> _scenarios = List.empty(growable: true);

  List<Scenario> get scenarios => _scenarios;
  
}