import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/presentation/cubit/geofence_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

import '../../../utils/location_helper.dart';

class MockScenarioCubit extends Mock implements ScenarioCubit {}
class MockMapCubit extends Mock implements MapCubit {}

void main() {
  group('GeofenceCubit', () {
    late MockMapCubit mockMapCubit;
    late MockScenarioCubit mockScenarioCubit;
    late GeofenceCubit geofenceCubit;
    late StreamController<MapState> mapStreamController;
    late StreamController<ScenarioRunning> scenarioStreamController;

    final position = LocationMarkerPosition(
      latitude: 50.0, 
      longitude: 21.0, 
      accuracy: 0
    );

    final polygon = PolygonElement(
      points: [
        LatLng(52.0, 21.0),
        LatLng(54.0, 21.0),
        LatLng(54.0, 23.0),
        LatLng(52.0, 23.0)
      ],
      enterTrigger: EmptyTrigger()
    );

    setUpAll(() {
      registerFallbackValue(EmptyTrigger());
    });

    setUp(() {
      mockMapCubit = MockMapCubit();
      mockScenarioCubit = MockScenarioCubit();
      mapStreamController = StreamController();
      scenarioStreamController = StreamController();

      when(() => mockMapCubit.stream).thenAnswer((_) => mapStreamController.stream);
      when(() => mockScenarioCubit.stream).thenAnswer((_) => scenarioStreamController.stream);
      
      when(() => mockMapCubit.state).thenReturn(MapReady(position));
      when(() => mockScenarioCubit.state).thenReturn(ScenarioRunning(elements: [polygon]));

      geofenceCubit = GeofenceCubit(
        scenarioCubit: mockScenarioCubit, 
        mapCubit: mockMapCubit
      );
    });

    tearDown(() {
      geofenceCubit.close();
    });

    blocTest('emit state if user enter the polygon', 
      build: () => geofenceCubit,
      act: (cubit) {
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(53.0, 22.0)));
      },
      expect: () => [
        isA<GeofenceState>()
          .having((state) => state.insidePolygons.isNotEmpty, 'has inside polygons', true)
          .having((state) => state.insidePolygons, 'inside polygons', {polygon}),
      ],
    );

    blocTest('no trigger is called if user does not enter the polygon', 
      build: () => geofenceCubit,
      act: (cubit) {
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(51.0, 21.0)));
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(50.0, 21.0)));
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(51.0, 22.0)));
      },
      verify: (_) {
        verifyNever(() => mockScenarioCubit.handleTrigger(any()));
      },
      expect: () => [
        isA<GeofenceState>().having((state) => state.insidePolygons.isEmpty, 'no inside polygons', true),
        isA<GeofenceState>().having((state) => state.insidePolygons.isEmpty, 'no inside polygons', true),
        isA<GeofenceState>().having((state) => state.insidePolygons.isEmpty, 'no inside polygons', true),
      ],
    );

    blocTest('handle trigger if user enter the polygon', 
      build: () => geofenceCubit,
      act: (cubit) {
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(53.0, 22.0)));
      },
      verify: (_) {
        verify(() => mockScenarioCubit.handleTrigger(any())).called(1);
      },
      expect: () => [
        isA<GeofenceState>().having((state) => state.insidePolygons.isNotEmpty, 'has inside polygons', true)
      ],
    );

    blocTest('emit empty set of inside polygons if user left the polygon', 
      build: () => geofenceCubit,
      act: (cubit) {
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(53.0, 22.0)));
        mapStreamController.add(MapReady(LocationHelper.createLocationMarkerPosition(50.0, 20.0)));
      },
      verify: (_) {
        verify(() => mockScenarioCubit.handleTrigger(any())).called(1);
      },
      expect: () => [
        isA<GeofenceState>().having((state) => state.insidePolygons.isNotEmpty, 'has inside polygons', true),
        isA<GeofenceState>().having((state) => state.insidePolygons.isEmpty, 'no inside polygons', true)
      ],
    );
    
  });
}