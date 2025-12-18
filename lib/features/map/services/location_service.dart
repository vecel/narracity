import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  Future<Position?> getLastKnownPosition() {
    return Geolocator.getLastKnownPosition();
  }

  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition();
  }

  Stream<LocationMarkerPosition?> getPositionStream() {
    return LocationMarkerDataStreamFactory().fromGeolocatorPositionStream();
  }

  Future<void> openLocationSettings() async {
    Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    Geolocator.openAppSettings();
  }
}