import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

sealed class MapState {}
final class MapInitial extends MapState {}
/// Emitted when user explicitly reject enabling location service. Can happen only if they are asked to do so by dialog.
final class MapLocationServiceRequestRejected extends MapState {}
final class MapPermissionDenied extends MapState {}
final class MapPermissionDeniedForever extends MapState {}
final class MapReady extends MapState {
  MapReady(this.position, this.polygons);
  final LocationMarkerPosition position;
  final List<Polygon> polygons;
}