import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart' hide PermissionDeniedException;
import 'package:logging/logging.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {

  static final _log = Logger('MapCubit');
  
  MapCubit(): 
    _positionStream = const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream(),
    super(MapInitial());

  final Stream<LocationMarkerPosition?> _positionStream;
  late StreamSubscription<LocationMarkerPosition?> _positionStreamSubscription;
  late LocationMarkerPosition _position;

  bool _mapInitalized = false;

  @override
  Future<void> close() {
    _unsubscribeToPositionStream();
    return super.close();
  }

  void askForPermission() async {
    bool permissionGranted = await _resolvePermission();

    if (!permissionGranted) return;
    
    try {
      _position = await _getPosition();
      _subscribeToPositionStream();
      _mapInitalized = true;
      _emitMapReadyState();
    } on LocationServiceDisabledException {
      emit(MapLocationServiceRequestRejected());
    }
  }

  void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  void openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<bool> _resolvePermission() async {
    LocationPermission permission;

    _log.info('Checking location permission');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        _log.info('Permission denied forever');
        emit(MapPermissionDeniedForever());
        return false;
      }
      if (permission == LocationPermission.denied) {
        _log.info('Permission denied');
        emit(MapPermissionDenied());
        return false;
      }
    }
    _log.info('Permission granted');
    return true;
  }

  Future<LocationMarkerPosition> _getPosition() async {
    Position? position;
    _log.info('Checking last known position');
    position = await Geolocator.getLastKnownPosition();
    if (position == null) {
      _log.info('Checking current position');
      position = await Geolocator.getCurrentPosition();
    }
    return LocationMarkerPosition(
      latitude: position.latitude, 
      longitude: position.longitude, 
      accuracy: position.accuracy
    );
  }

  void _emitMapReadyState() {
    if (!_mapInitalized) {
      _log.info('MapReady state requested to emit, but map was not initialized yet. Skipping.');
      return;
    }
    emit(MapReady(_position));
  }

  void _subscribeToPositionStream() {
    _positionStreamSubscription = _positionStream.listen(
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
    _positionStreamSubscription.cancel();
  }
}