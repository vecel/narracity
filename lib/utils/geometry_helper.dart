import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GeometryHelper {

  static bool isPointInPolygon(LatLng point, Polygon polygon) {
    final polygonPoints = polygon.points;
    int intersections = 0;
    
    for (int i = 0; i < polygonPoints.length; i++) {
      int j = (i + 1) % polygonPoints.length;
      
      if (((polygonPoints[i].latitude > point.latitude) != 
           (polygonPoints[j].latitude > point.latitude)) &&
          (point.longitude < (polygonPoints[j].longitude - polygonPoints[i].longitude) * 
           (point.latitude - polygonPoints[i].latitude) / 
           (polygonPoints[j].latitude - polygonPoints[i].latitude) + polygonPoints[i].longitude)) {
        intersections++;
      }
    }
    
    return intersections % 2 == 1;
  }
}