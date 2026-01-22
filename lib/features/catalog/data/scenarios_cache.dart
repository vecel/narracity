import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosCache {
  final Map<String, Scenario> _cache = {};

  void save(Scenario scenario) {
    final id = scenario.id;
    if (_cache.containsKey(id)) return;

    _cache[id] = scenario;
  }

  List<Scenario> loadAll() {
    return _cache.values.toList();
  }

  Scenario? load(String id) {
    if (_cache.containsKey(id)) return _cache[id];
    return null;
  }

  bool contains(String id) {
    return _cache.containsKey(id);
  }
}