import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class LocationHelper {
  static LocationMarkerPosition createLocationMarkerPosition(double latitude, double longitude) => 
      LocationMarkerPosition(latitude: latitude, longitude: longitude, accuracy: 0);
}