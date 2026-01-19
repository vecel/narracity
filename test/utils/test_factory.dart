import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';

import 'location_helper.dart';

class MockScenario extends Mock implements Scenario {}
class MockLocationService extends Mock implements LocationService {}
class MockScenariosRepository extends Mock implements ScenariosRepository {}

class TestFactory {

  static Scenario createMockScenario({
    String id = 'Id',
    String title = 'Title',
    String description = 'Description',
    String image = 'Image',
    String location = 'Location',
    String distance = 'Distance',
    String duration = 'Duration',
    List<ScenarioNode> nodes = const []
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

    when(() => mock.getScenarios()).thenAnswer((_) async => scenarios);
    when(() => mock.getScenarioById(any())).thenAnswer((_) async => scenarios.first);

    return mock;
  }
}