import 'package:file/memory.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/data/scenarios_api.dart';
import 'package:narracity/features/catalog/data/scenarios_cache.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';

import 'location_helper.dart';

class MockScenario extends Mock implements Scenario {}
class MockLocationService extends Mock implements LocationService {}
class MockScenariosRepository extends Mock implements ScenariosRepository {}
class MockCacheManager extends Mock implements DefaultCacheManager {}
class MockScenariosApi extends Mock implements ScenariosApi {}
class MockScenariosStorage extends Mock implements ScenariosStorage {}
class MockScenariosCache extends Mock implements ScenariosCache {}

class TestFactory {

  static Scenario createMockScenario({
    String id = 'Id',
    String title = 'Title',
    String description = 'Description',
    String image = 'https://www.pw.plock.pl/var/wwwglowna/storage/images/filia/aktualnosci/politechnika-warszawska-zmienia-swoje-oblicze/35146-2-pol-PL/Politechnika-Warszawska-zmienia-swoje-oblicze.png',
    String location = 'Location',
    String distance = 'Distance',
    String duration = 'Duration',
    List<ScenarioNode> nodes = const [],
    String startNodeId = ''
  }) {
    final mock = MockScenario();

    when(() => mock.id).thenReturn(id);
    when(() => mock.title).thenReturn(title);
    when(() => mock.description).thenReturn(description);
    when(() => mock.location).thenReturn(location);
    when(() => mock.duration).thenReturn(duration);
    when(() => mock.distance).thenReturn(distance);
    when(() => mock.image).thenReturn(image);
    when(() => mock.nodes).thenReturn(nodes);
    when(() => mock.startNodeId).thenReturn(startNodeId);

    final json = {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'duration': duration,
      'distance': distance,
      'image': image,
      'nodes': nodes,
      'startNodeId': startNodeId
    };

    when(() => mock.toJson()).thenReturn(json);

    return mock;
  }

  static LocationService createMockLocationService() {
    final mock = MockLocationService();

    when(() => mock.checkPermission()).thenAnswer((_) async => LocationPermission.whileInUse);
    when(() => mock.getLastKnownPosition()).thenAnswer((_) async => LocationHelper.createPosition(52.0, 21.0));
    when(() => mock.getPositionStream()).thenAnswer((_) => Stream.empty());

    return mock;
  }

  static ScenariosRepository createMockScenariosRepository({
    required List<Scenario> scenarios
  }) {
    final mock = MockScenariosRepository();

    when(() => mock.loadAll()).thenAnswer((_) async => scenarios);
    when(() => mock.load(any())).thenAnswer((_) async => scenarios.first);
    when(() => mock.save(any())).thenAnswer((_) async {});

    return mock;
  }

  static DefaultCacheManager createMockCacheManager() {
    final mock = MockCacheManager();

    final fs = MemoryFileSystem();
    final file = fs.file('');

    when(() => mock.getFileStream(any())).thenAnswer((_) => Stream.value(
      FileInfo(
        file,
        FileSource.Online,
        DateTime.now(),
        'http://test.url'
      )
    ));

    return mock;
  }

  static ScenariosApi createMockScenariosApi({
    required List<Scenario> scenarios
  }) {
    final mock = MockScenariosApi();

    when(() => mock.loadAll()).thenAnswer((_) async => scenarios);
    when(() => mock.load(any())).thenAnswer((_) async => null);
    for (final scenario in scenarios) {
      final id = scenario.id;
      when(() => mock.load(id)).thenAnswer((_) async => scenario); 
    }

    return mock;
  }

  static ScenariosStorage createMockScenariosStorage({
    required List<Scenario> scenarios
  }) {
    final mock = MockScenariosStorage();

    when(() => mock.loadAll()).thenAnswer((_) async => scenarios);
    when(() => mock.load(any())).thenAnswer((_) async => null);
    for (final scenario in scenarios) {
      final id = scenario.id;
      when(() => mock.load(id)).thenAnswer((_) async => scenario);
    }

    when(() => mock.save(any())).thenAnswer((_) async {});

    return mock;
  }

  static ScenariosCache createMockScenariosCache({
    required List<Scenario> scenarios
  }) {
    final mock = MockScenariosCache();

    when(() => mock.loadAll()).thenReturn(scenarios);
    when(() => mock.load(any())).thenReturn(null);
    when(() => mock.contains(any())).thenReturn(false);
    for (final scenario in scenarios) {
      final id = scenario.id;
      when(() => mock.load(id)).thenReturn(scenario);
      when(() => mock.contains(id)).thenReturn(true);
    }

    return mock;
  }
}