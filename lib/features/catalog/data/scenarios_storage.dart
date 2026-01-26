import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ScenariosStorage {
  static const _directory = 'scenarios';
  static const _nodesDirectory = 'nodes';
  static final _log = Logger('ScenariosStorage');

  Future<Directory> _getAppDirectory() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final scenariosDirectory = Directory('${appDirectory.path}/$_directory');

    if (!await scenariosDirectory.exists()) {
      scenariosDirectory.create();
    }

    return scenariosDirectory;
  }

  Future<void> save(Scenario scenario) async {
    final scenarioDirectory = await _getScenarioDirectory(scenario.id);
    if (!await scenarioDirectory.exists()) {
      _log.info('Creating directory for scenario with id ${scenario.id}');
      scenarioDirectory.createSync();
    }

    final nodesDirectory = Directory('${scenarioDirectory.path}/$_nodesDirectory');
    if (!await nodesDirectory.exists()) {
      nodesDirectory.createSync();
    }

    final data = scenario.toJson();
    final json = jsonEncode(data);
    final file = File('${scenarioDirectory.path}/${scenario.id}.json');
    await file.writeAsString(json);
    
    final futures = scenario.nodes.map((node) async {
      final data = node.toJson();
      final json = jsonEncode(data);
      final file = File('${nodesDirectory.path}/${node.id}.json');
      await file.writeAsString(json);
    });

    Future.wait(futures);
  }

  Future<Scenario?> load(String id) async {
    final directory = await _getScenarioDirectory(id);
    final scenario = await _loadScenarioFromDirectory(directory);
    return scenario;
  }

  // TODO: Add test for the method
  Future<List<Scenario>> loadAll() async {
    final result = <Scenario>[];
    final scenariosDirectory = await _getAppDirectory();
    for (final directory in scenariosDirectory.listSync()) {
      if (directory is! Directory) {
        throw UnsupportedError('Cannot read scenario from a Link or File.');
      }

      final scenario = await _loadScenarioFromDirectory(directory);
      result.add(scenario);
    }

    return result;
  }

  Future<Directory> _getScenarioDirectory(String id) async {
    final appDirectory = await _getAppDirectory();
    final scenarioDirectory = Directory('${appDirectory.path}/$id');
    return scenarioDirectory;
  }

  Future<Scenario> _loadScenarioFromDirectory(Directory scenarioDirectory) async {
    final metadata = await _loadScenarioMetadata(scenarioDirectory);
    final nodes = await _loadScenarioNodes(scenarioDirectory);
    return Scenario.fromJson(metadata, nodes);
  }

  Future<Map<String, dynamic>> _loadScenarioMetadata(Directory scenarioDirectory) async {
    final id = path.basename(scenarioDirectory.path);
    final file = File(path.join(scenarioDirectory.path, '$id.json'));
    if (!await file.exists()) {
      throw FormatException('Scenario directory ${scenarioDirectory.path} should contain $id.json file.');
    }
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return json;
  }

  Future<List<ScenarioNode>> _loadScenarioNodes(Directory scenarioDirectory) async {
    final nodesDirectory = Directory(path.join(scenarioDirectory.path, _nodesDirectory));
    if (!await nodesDirectory.exists()) {
      _log.info('Found none nodes inside ${scenarioDirectory.path}');
      return [];
    }

    final entities = await nodesDirectory.list().toList();
    final files = entities
        .whereType<File>()
        .where((f) => path.extension(f.path) == '.json');

    final futures = files.map((file) => _loadNode(file));
    return Future.wait(futures);
  }

  Future<ScenarioNode> _loadNode(File file) async {
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ScenarioNode.fromJson(json);
  }
}