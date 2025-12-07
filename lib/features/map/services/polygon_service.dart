import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/map/domain/my_polygon.dart';

class PolygonService {

  static final Logger _log = Logger('PolygonService');

  final List<MyPolygon> _polygons = [];
  final Set<MyPolygon> _enteredPolygons = {};

  List<Polygon> get polygons => List.of(_polygons.map((e) => e.polygon));

  void update(LocationMarkerPosition position) {
    LatLng point = position.latLng;
    for (MyPolygon polygon in _polygons) {
      bool inside = _isPointInPolygon(point, polygon.polygon);
      bool wasInside = _enteredPolygons.contains(polygon);
      
      if (inside && !wasInside) {
        _log.info('Polygon enter event');
        if (polygon.onEnter != null) polygon.onEnter!();
        _enteredPolygons.add(polygon);
        
      }

      if (!inside && wasInside) {
        _log.info('Polygon leave event');
        if (polygon.onLeave != null) polygon.onLeave!();
        _enteredPolygons.remove(polygon);
      }
    }
  }

  void add(MyPolygon polygon) {
    _polygons.add(polygon);
  }

  void remove(MyPolygon polygon) {
    _polygons.remove(polygon);
    _enteredPolygons.remove(polygon);
  }

  bool _isPointInPolygon(LatLng point, Polygon polygon) {
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