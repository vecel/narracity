import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';

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

  group('ScenariosStorage', () {
    test('save writes the scenario to the correct file path', () async {
      final scenario = TestFactory.createMockScenario();

      await storage.save(scenario);

      final file = File('${testDirectory.path}/scenarios/scenario_${scenario.id}.json');
      
      expect(file.existsSync(), isTrue);

      final content = await file.readAsString();
      
      expect(jsonDecode(content), scenario.toJson());
    });

    test('save overwrites existing file if scenario already exists', () async {
      final dir = Directory('${testDirectory.path}/scenarios')..createSync();
      File('${dir.path}/scenario_overwrite.json').writeAsStringSync('{"id": "overwrite", "data": "OLD"}');

      final scenario = TestFactory.createMockScenario(id: 'overwrite');

      await storage.save(scenario);

      final file = File('${dir.path}/scenario_overwrite.json');
      final content = await file.readAsString();
      expect(content, contains(scenario.title));
    });

    test('load returns null if file does not exist', () async {
      final result = await storage.load('not_id');

      expect(result, isNull);
    });

    test('load deserializes data correctly', () async {
      final dir = Directory('${testDirectory.path}/scenarios')..createSync();
      final scenario = TestFactory.createMockScenario(id: 'loaded');
      
      File('${dir.path}/scenario_loaded.json').writeAsStringSync(jsonEncode(scenario.toJson()));

      final result = await storage.load('loaded');

      expect(result, isNotNull);
      expect(result!.id, 'loaded');
      expect(result.title, scenario.title);
    });

    test('load() throws FormatException if file content is corrupt', () async {
      final dir = Directory('${testDirectory.path}/scenarios')..createSync();
      File('${dir.path}/scenario_corrupt.json').writeAsStringSync('{ broken_json: ');

      expect(
        () async => await storage.load('corrupt'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}