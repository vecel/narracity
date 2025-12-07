import 'package:flutter_map/flutter_map.dart';

class MyPolygon {
  MyPolygon({required this.polygon, this.onEnter, this.onLeave});

  final Polygon polygon;
  final void Function()? onEnter;
  final void Function()? onLeave;
}