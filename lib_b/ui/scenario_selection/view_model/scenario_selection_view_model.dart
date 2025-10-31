import 'dart:collection';

import '../../../data/repositiories/scenarios_repository.dart';
import '../../../domain/models/scenario.dart';

class ScenarioSelectionViewModel {

  ScenarioSelectionViewModel({
    required ScenariosRepository scenariosRepository
  }) : 
    _scenariosRepository = scenariosRepository;


  final ScenariosRepository _scenariosRepository;
  
  int get scenariosCount => _scenariosRepository.scenarios.length;
  UnmodifiableListView<Scenario> get scenarios => UnmodifiableListView(_scenariosRepository.scenarios); 
}