import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static LocationMarkerPosition createLocationMarkerPosition(double latitude, double longitude) => 
      LocationMarkerPosition(latitude: latitude, longitude: longitude, accuracy: 0);

  static Position createPosition(double latitude, double longitude) => 
    Position(longitude: longitude, latitude: latitude, timestamp: DateTime.now(), accuracy: 1.0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
}