import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narracity/example.dart';
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

  // TODO: Uncomment for production
  Future<List<Scenario>> loadAll() async {
    final cached = _cache.loadAll();
    final remote = await _api.getScenarios();
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

  // For Linux development purposes
  // Future<List<Scenario>> loadAll() async {
  //   return Future.value(List.of([warsawUniversityOfTechnologyScenario]));
  // }
  
  Future<Scenario?> load(String id) async {
    if (_cache.contains(id)) {
      return Future.value(_cache.load(id));
    }

    // Uncomment for production
    final remote = await _api.getScenarioById(id);
    if (remote != null) {
      return remote;
    }

    final local = await _storage.load(id);
    if (local != null) {
      return local;
    }

    // This is for testing purposes only
    return Future.value(warsawUniversityOfTechnologyScenario);
  }

  Future<void> save(Scenario scenario) async {
    await _storage.save(scenario);
  }
  
}