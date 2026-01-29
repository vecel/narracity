import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

import '../../../utils/test_factory.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ScenariosStorage storage;
  late Directory testDirectory;

  setUpAll(() async {
    testDirectory = await Directory.systemTemp.createTemp('scenarios_test_');

    const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
    
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return testDirectory.path;
      }
      return null;
    });
  });

  tearDownAll(() {
    if (testDirectory.existsSync()) {
      testDirectory.deleteSync(recursive: true);
    }
  });

  setUp(() {
    if (testDirectory.existsSync()) {
      testDirectory.deleteSync(recursive: true);
    }
    testDirectory.createSync();
    storage = ScenariosStorage();
  });

  Future<void> seedMockScenario(Scenario scenario) async {
    final directoryPath = '${testDirectory.path}/scenarios';
    Directory(directoryPath).createSync();
    final scenarioDirectory = Directory('$directoryPath/${scenario.id}');
    await scenarioDirectory.create();

    final metadataFile = File('${scenarioDirectory.path}/${scenario.id}.json');
    await metadataFile.writeAsString(jsonEncode(scenario.toJson()));

    final nodesDirectory = Directory('${scenarioDirectory.path}/nodes');
    await nodesDirectory.create();

    final futures = scenario.nodes.map((node) async {
      final file = File('${nodesDirectory.path}/${node.id}.json');
      await file.writeAsString(jsonEncode(node.toJson()));
    });

    Future.wait(futures);
  }

  group('ScenariosStorage', () {
    test('save writes the scenario to the correct directory', () async {
      final scenario = TestFactory.createMockScenario();

      await storage.save(scenario);

      final directory = Directory('${testDirectory.path}/scenarios/${scenario.id}');
      
      expect(directory.existsSync(), isTrue);
    });

    test('save creates correct structure inside scenario directory', () async {
      final nodes = TestFactory.createDummyNodes(ids: ['first', 'second']);
      final scenario = TestFactory.createMockScenario(nodes: nodes);

      await storage.save(scenario);

      final directory = Directory('${testDirectory.path}/scenarios/${scenario.id}');
      final metadataFile = File('${directory.path}/${scenario.id}.json');
      expect(directory.existsSync(), isTrue);
      expect(metadataFile.existsSync(), isTrue);

      final metadataJson = jsonDecode(await metadataFile.readAsString()) as Map<String, dynamic>;
      expect(metadataJson, scenario.toJson());
      
      final nodesDirectory = Directory('${directory.path}/nodes');
      expect(nodesDirectory.existsSync(), isTrue);

      final firstNodeFile = File('${nodesDirectory.path}/first.json');
      final secondNodeFile = File('${nodesDirectory.path}/second.json');
      expect(firstNodeFile.existsSync(), isTrue);
      expect(secondNodeFile.existsSync(), isTrue);

      final firstJson = jsonDecode(await firstNodeFile.readAsString()) as Map<String, dynamic>;
      final secondJson = jsonDecode(await secondNodeFile.readAsString()) as Map<String, dynamic>;
      expect(firstJson, nodes[0].toJson());
      expect(secondJson, nodes[1].toJson());
    });

    test('save overwrites existing directory if scenario already exists', () async {
      final id = 'to_overwrite';
      final scenariosDirectory = Directory('${testDirectory.path}/scenarios')..createSync();
      final directory = Directory('${scenariosDirectory.path}/$id')..createSync();
      final metadataFile = File('${directory.path}/$id.json');
      metadataFile..createSync()..writeAsString('Old content');

      final scenario = TestFactory.createMockScenario(id: id);

      await storage.save(scenario);

      final json = jsonDecode(metadataFile.readAsStringSync());

      expect(metadataFile.readAsStringSync(), isNot('Old content'));
      expect(json, scenario.toJson());
    });

    test('load returns null if scenario does not exist', () async {
      final result = await storage.load('not_id');

      expect(result, isNull);
    });

    test('load returns correct scenario when scenario exists', () async {
      final nodes = TestFactory.createDummyNodes(ids: ['first', 'second']);
      final scenario = TestFactory.createMockScenario(
        id: 'id',
        nodes: nodes, 
        startNodeId: 'first'
      );
      await seedMockScenario(scenario);

      final result = await storage.load('id');

      expect(result, isNotNull);
      expect(result!.id, 'id');
      expect(result.nodes.length, 2);
    });

    test('loadAll returns all saved scenarios', () async {
      await seedMockScenario(TestFactory.createMockScenario(id: 'first'));
      await seedMockScenario(TestFactory.createMockScenario(id: 'second'));

      final result = await storage.loadAll();

      expect(result.length, equals(2));
      expect(result.any((s) => s.id == 'first'), isTrue);
      expect(result.any((s) => s.id == 'second'), isTrue);
    });

    test('loadAll returns empty list if no scenarios exist', () async {
      final result = await storage.loadAll();
      expect(result, isEmpty);
    });

    test('loadAll throws UnsupportedError if non-directory file exists in root', () async {
      
      final rootDirectory = Directory('${testDirectory.path}/scenarios');
      await rootDirectory.create();
      
      final rogueFile = File('${rootDirectory.path}/rogue.txt');
      await rogueFile.writeAsString('I should not be here');

      expect(
        () async => await storage.loadAll(),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });
}