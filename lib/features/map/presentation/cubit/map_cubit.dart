import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {

  static final _log = Logger('MapCubit');
  
  MapCubit(): 
    _positionStream = Geolocator.getPositionStream(), 
    _locationServiceStream = Geolocator.getServiceStatusStream(),
    super(MapInitial());

  final Stream<Position> _positionStream;
  final Stream<ServiceStatus> _locationServiceStream;

  void askForPermission() async {
    LocationPermission permission;

    _log.info('Checking location permission');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _log.info('Permission denied, requesting it');
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      _log.info('Permission denied');
      emit(MapPermissionDenied());
      return;
    }
    
    if (permission == LocationPermission.deniedForever) {
      _log.info('Permission denied forever');
      emit(MapPermissionDeniedForever());
      return;
    } 

    _log.info('Permission granted, resolving position');
    try {
      await _getPosition();
      _listenToPositionChanges();
      _listenToLocationServiceStatus();
    } on LocationServiceDisabledException {
      _log.info('Location service request rejected');
      emit(MapLocationServiceRequestRejected());
    }
  }

  void _listenToLocationServiceStatus() {
    _log.info('Listening for location service status');
    _locationServiceStream.listen(
      (status) {
        if (status == ServiceStatus.disabled) {
          _log.info('Location service disabled');
        }
        if (status == ServiceStatus.enabled) {
          _log.info('Location service enabled');
        }
      }
    );
  }

  void _listenToPositionChanges() {
    _log.info('Listening for position changes');
    _positionStream.listen(
      (position) {
        _log.info('Position update with position: $position');
        emit(MapPermissionGranted(position));
      },
      onError: (error) {
        _log.info('Location service disabled when listening to updates');
        throw error;
      },
      onDone: () => _log.info('Position stream closed'),
    );
  }

  Future<void> _getPosition() async {
    Position? position;
    _log.info('Checking last known position');
    position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      emit(MapPermissionGranted(position));
    }
    // Method below will request location service if needed
    _log.info('Resolving current position');
    position = await Geolocator.getCurrentPosition();
    _log.info('Current position resolved');
    emit(MapPermissionGranted(position));
  }

  void x() async {
    final v = await Geolocator.openLocationSettings();
    _log.info(v);
  }
}