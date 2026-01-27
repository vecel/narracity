import 'package:narracity/features/catalog/data/scenarios_api.dart';
import 'package:narracity/features/catalog/data/scenarios_cache.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosRepository {
  ScenariosRepository({
    ScenariosApi? api,
    ScenariosStorage? storage,
    ScenariosCache? cache
  }) : 
    _api = api ?? ScenariosApi(), 
    _storage = storage ?? ScenariosStorage(),
    _cache = cache ?? ScenariosCache();

  final ScenariosApi _api;
  final ScenariosStorage _storage;
  final ScenariosCache _cache;

  Future<List<Scenario>> loadAll() async {
    final cached = _cache.loadAll();
    final remote = await _api.loadAll();
    final local = await _storage.loadAll();

    final Map<String, Scenario> scenarios = {};

    Scenario insertToScenarios(Scenario s) => scenarios[s.id] = s;

    local.forEach(insertToScenarios);
    remote.forEach(insertToScenarios);
    cached.forEach(insertToScenarios);

    for (final scenario in scenarios.values) {
      _cache.save(scenario);
    }

    return scenarios.values.toList();
  }

  Future<Scenario?> load(String id) async {
    if (_cache.contains(id)) {
      return Future.value(_cache.load(id));
    }

    final remote = await _api.load(id);
    if (remote != null) {
      return remote;
    }

    final local = await _storage.load(id);
    if (local != null) {
      return local;
    }

    return null;
  }

  Future<void> save(Scenario scenario) async {
    await _storage.save(scenario);
  }
  
}