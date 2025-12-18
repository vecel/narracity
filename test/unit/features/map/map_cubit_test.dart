import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/map/services/location_service.dart';

class MockLocationService extends Mock implements LocationService {}

void main() {
  group('MapCubit', () {
    late MapCubit cubit;
    late MockLocationService mockLocationService;
    late StreamController<LocationMarkerPosition> positionStreamController;

    Position createPosition(double latitude, double longitude) => Position(
      longitude: longitude, latitude: latitude, timestamp: DateTime.now(),
      accuracy: 0, altitude: 0, heading: 0, speed: 0, 
      speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0,
    );

    LocationMarkerPosition createLocationMarkerPosition(double latitude, double longitude) => 
      LocationMarkerPosition(latitude: latitude, longitude: longitude, accuracy: 0);
    
    setUp(() {
      positionStreamController = StreamController<LocationMarkerPosition>();
      mockLocationService = MockLocationService();

      when(() => mockLocationService.getPositionStream()).thenAnswer((_) => positionStreamController.stream);
      when(() => mockLocationService.getLastKnownPosition()).thenAnswer((_) async => null);
      when(() => mockLocationService.getCurrentPosition()).thenAnswer((_) async => createPosition(52.0, 21.0));

      cubit = MapCubit(locationService: mockLocationService);
    });

    tearDown(() {
      cubit.close();
    });

    void whenPermissionIsGranted() {
      when(() => mockLocationService.checkPermission()).thenAnswer((_) async => LocationPermission.always);
    }

    void whenPermissionIsDenied() {
      when(() => mockLocationService.checkPermission()).thenAnswer((_) async => LocationPermission.denied);
      when(() => mockLocationService.requestPermission()).thenAnswer((_) async => LocationPermission.denied);
    }

    void whenPermissionIsDeniedForever() {
      when(() => mockLocationService.checkPermission()).thenAnswer((_) async => LocationPermission.denied);
      when(() => mockLocationService.requestPermission()).thenAnswer((_) async => LocationPermission.deniedForever);
    }

    void whenPermissionIsGrantedAfterRequest() {
      when(() => mockLocationService.checkPermission()).thenAnswer((_) async => LocationPermission.denied);
      when(() => mockLocationService.requestPermission()).thenAnswer((_) async => LocationPermission.always);
    }

    blocTest('initialize map if permission is already granted', 
      setUp: () => whenPermissionIsGranted(),
      build: () => cubit,
      act: (cubit) => cubit.askForPermission(),
      expect: () => [
        isA<MapReady>().having((state) => state.position.latLng, 'position', LatLng(52.0, 21.0))
      ],
    );

    blocTest('emit MapPermissionDenied state if permission is not granted after request ', 
      setUp: () => whenPermissionIsDenied(),
      build: () => cubit,
      act: (cubit) => cubit.askForPermission(),
      expect: () => [
        isA<MapPermissionDenied>()
      ],
    );

    blocTest('emit MapPermissionDeniedForever state if permission is denied forever after request ', 
      setUp: () => whenPermissionIsDeniedForever(),
      build: () => cubit,
      act: (cubit) => cubit.askForPermission(),
      expect: () => [
        isA<MapPermissionDeniedForever>()
      ],
    );

    blocTest('initialize map if permission is granted after request ', 
      setUp: () => whenPermissionIsGrantedAfterRequest(),
      build: () => cubit,
      act: (cubit) => cubit.askForPermission(),
      verify: (_) {
        verify(() => mockLocationService.checkPermission()).called(1);
        verify(() => mockLocationService.requestPermission()).called(1);
      },
      expect: () => [
        isA<MapReady>().having((state) => state.position.latLng, 'position', LatLng(52.0, 21.0))
      ],
    );

    blocTest('position is updated with stream updates', 
      setUp: () => whenPermissionIsGranted(),
      build: () => cubit,
      act: (cubit) async {
        cubit.askForPermission();
        positionStreamController.add(createLocationMarkerPosition(51.0, 21.0));
        await Future.delayed(Duration(microseconds: 10));
        positionStreamController.add(createLocationMarkerPosition(50.0, 21.0));
      },
      verify: (_) {
        verify(() => mockLocationService.checkPermission()).called(1);
        verify(() => mockLocationService.getLastKnownPosition()).called(1);
        verify(() => mockLocationService.getCurrentPosition()).called(1);
      },
      expect: () => [
        isA<MapReady>().having((state) => state.position.latLng, 'position', LatLng(52.0, 21.0)),
        isA<MapReady>().having((state) => state.position.latLng, 'position', LatLng(51.0, 21.0)),
        isA<MapReady>().having((state) => state.position.latLng, 'position', LatLng(50.0, 21.0))
      ],
    );
  });
}