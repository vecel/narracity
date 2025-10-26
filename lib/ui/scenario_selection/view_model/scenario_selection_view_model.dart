import 'package:narracity/data/repositiories/scenarios_repository.dart';
import 'package:narracity/domain/models/scenario.dart';

class ScenarioSelectionViewModel {

  ScenarioSelectionViewModel({
    required ScenariosRepository scenariosRepository
  }) : 
    _scenariosRepository = scenariosRepository;


  final ScenariosRepository _scenariosRepository;
  
  int get scenariosCount => _scenariosRepository.scenarios.length;
  Scenario getScenario(int index) => _scenariosRepository.scenarios[index];
}