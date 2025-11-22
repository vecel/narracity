import 'package:geolocator/geolocator.dart';

sealed class MapState {}
final class MapInitial extends MapState {}
final class MapLocationServiceDisabled extends MapState {}
final class MapLocationServiceRequestRejected extends MapState {}
final class MapPermissionDenied extends MapState {}
final class MapPermissionDeniedForever extends MapState {}
final class MapPermissionGranted extends MapState {
  MapPermissionGranted(this.position);

  final Position position;
}