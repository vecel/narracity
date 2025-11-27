import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {

  static final _log = Logger('MapCubit');
  
  MapCubit(): super(MapInitial()) {
    // _subscribeToPositionStream();
  }

  final Stream<LocationMarkerPosition?> _positionStream = const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream();
  late StreamSubscription<LocationMarkerPosition?> _positionStreamSubscription;

  late LocationMarkerPosition? _position;
  final List<Polygon> _polygons = [];
  

  @override
  Future<void> close() {
    _unsubscribeToPositionStream();
    return super.close();
  }

  void askForPermission() async {
    LocationPermission permission;

    _log.info('Checking location permission');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        _log.info('Permission denied forever');
        emit(MapPermissionDeniedForever());
        return;
      }
      if (permission == LocationPermission.denied) {
        _log.info('Permission denied');
        emit(MapPermissionDenied());
        return;
      }
    }

    _log.info('Permission granted');
    try {
      _position = await _getPosition();
      _subscribeToPositionStream();
      emit(MapReady(_position, _polygons));
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

  void addPolygon(Polygon polygon) {
    _polygons.add(polygon);
  }

  Future<Position> _getPosition() async {
    Position? position;
    _log.info('Checking last known position');
    position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      return position;
    }
    _log.info('Checking current position');
    return await Geolocator.getCurrentPosition();
  }

  void _subscribeToPositionStream() {
    _positionStreamSubscription = _positionStream.listen(
      (position) {
        if (position != null) {
          _position = position;
          emit(MapReady(_position!, _polygons));
        }
      }
    );
  }

  void _unsubscribeToPositionStream() {
    _positionStreamSubscription.cancel();
  }
}