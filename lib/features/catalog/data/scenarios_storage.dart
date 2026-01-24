import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:path_provider/path_provider.dart';

class ScenariosStorage {
  static const _directory = 'scenarios';
  static final log = Logger('ScenariosStorage');

  Future<Directory> _getScenariosDirectory() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final scenariosDirectory = Directory('${appDirectory.path}/$_directory');

    if (!await scenariosDirectory.exists()) {
      scenariosDirectory.create();
    }

    return scenariosDirectory;
  }

  Future<File> _getScenarioFile(String id) async {
    final scenariosDirectory = await _getScenariosDirectory();
    return File('${scenariosDirectory.path}/scenario_$id.json');
  }

  Future<Scenario> _getScenarioFromFile(File file) async {
    final data = await file.readAsString();
    final json = jsonDecode(data);
    return Scenario.fromJson(json);
  }

  Future<void> save(Scenario scenario) async {
    final scenarioFile = await _getScenarioFile(scenario.id);
    if (await scenarioFile.exists()) {
      log.info('Storage file for scenario with id ${scenario.id} already exists and will be overwritten');
    }

    final data = scenario.toJson();
    await scenarioFile.writeAsString(jsonEncode(data));
    log.info('Scenario with id ${scenario.id} saved to file ${scenarioFile.path}');
  }

  Future<Scenario?> load(String id) async {
    final scenarioFile = await _getScenarioFile(id);
    if (!await scenarioFile.exists()) {
      log.info('There is no local file for scenario with id $id');
      return null;
    }

    return await _getScenarioFromFile(scenarioFile);
  }

  // TODO: Add test for the method
  Future<List<Scenario>> loadAll() async {
    final result = <Scenario>[];
    final scenariosDirectory = await _getScenariosDirectory();
    for (final file in scenariosDirectory.listSync()) {
      if (file is! File) {
        throw UnsupportedError('Cannot read scenario from a Link or Directory.');
      }
      final scenario = await _getScenarioFromFile(file);
      result.add(scenario);
    }

    return result;
  }
}