import 'dart:collection';

import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/models/scenario.dart';

class CatalogViewModel {

  CatalogViewModel({required ScenariosRepository scenariosRepository}): _scenariosRepository = scenariosRepository;

  final ScenariosRepository _scenariosRepository;

  UnmodifiableListView<Scenario> get scenarios => UnmodifiableListView(_scenariosRepository.scenarios);
}