import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart' hide PermissionDeniedException;
import 'package:logging/logging.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';

class MapCubit extends Cubit<MapState> {

  static final _log = Logger('MapCubit');
  
  MapCubit({LocationService? locationService}): 
    _locationService = locationService ?? LocationService(),
    super(MapInitial());

  final LocationService _locationService;
  StreamSubscription<LocationMarkerPosition?>? _positionStreamSubscription;
  LocationMarkerPosition? _position;

  void askForPermission() async {
    LocationPermission permission = await _resolvePermission();

    switch (permission) {
      case LocationPermission.deniedForever: _handlePermissionDeniedForever();
      case LocationPermission.denied: _handlePermissionDenied();
      case LocationPermission.always || LocationPermission.whileInUse: _initializeMap();
      default: throw Exception('Cannot determine location permission');
    }
  }

  void openLocationSettings() async {
    await _locationService.openLocationSettings();
  }

  void openAppSettings() async {
    await _locationService.openAppSettings();
  }

  Future<LocationPermission> _resolvePermission() async {
    LocationPermission permission;

    _log.info('Checking location permission');
    permission = await _locationService.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _locationService.requestPermission();
    }
    return permission;
  }

  void _handlePermissionDeniedForever() {
    _log.info('Permission denied forever');
    emit(MapPermissionDeniedForever());
  }

  void _handlePermissionDenied() {
    _log.info('Permission denied');
    emit(MapPermissionDenied());
  }

  void _initializeMap() async {
    try {
      _position = await _getPosition();
      _subscribeToPositionStream();
      _emitMapReadyState();
    } on LocationServiceDisabledException {
      emit(MapLocationServiceRequestRejected());
    }
  }

  Future<LocationMarkerPosition> _getPosition() async {
    Position? position;
    _log.info('Checking last known position');
    position = await _locationService.getLastKnownPosition();
    if (position == null) {
      _log.info('Checking current position');
      position = await _locationService.getCurrentPosition();
    }
    return LocationMarkerPosition(
      latitude: position.latitude, 
      longitude: position.longitude, 
      accuracy: position.accuracy
    );
  }

  void _emitMapReadyState() {
    if (_position == null) {
      _log.info('MapReady state requested to emit, but position was not initialized yet. Skipping.');
      return;
    }
    emit(MapReady(_position!));
  }

  void _subscribeToPositionStream() {
    _positionStreamSubscription = _locationService.getPositionStream().listen(
      (position) {
        _log.info('Position update with $position');
        if (position != null) {
          _position = position;
          _emitMapReadyState();
        }
      },
      onError: (error) {
        switch (error) {
          case IncorrectSetupException _:
            _log.info('LocationMarker plugin has not been setup correctly. '
                  'Please follow the instructions in the documentation');
          case PermissionRequestingException _:
            emit(MapInitial());
          case PermissionDeniedException _:
            emit(MapPermissionDenied());
          case ServiceDisabledException _:
            _log.info('Location service disabled');
        }
      }
    );
  }

  void _unsubscribeToPositionStream() {
    _positionStreamSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _unsubscribeToPositionStream();
    return super.close();
  }
}