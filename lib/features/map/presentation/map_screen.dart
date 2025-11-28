import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';

class MapScreen extends StatelessWidget {
  static final _log = Logger('MapScreen');

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final cubit = BlocProvider.of<MapCubit>(context);
  
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        switch (state) {
          case MapInitial(): {
            cubit.askForPermission();
            return _buildLoadingScreen();
          }
          case MapPermissionDenied(): {
            return _buildPermissionDeniedScreen(cubit.askForPermission);
          }
          case MapPermissionDeniedForever(): {
            return _buildPermissionDeniedForeverScreen(cubit.openAppSettings, cubit.askForPermission);
          }
          case MapLocationServiceRequestRejected(): {
            return _buildLocationServiceRequestRejectedScreen(cubit.openLocationSettings, cubit.askForPermission);
          }
          case MapReady(:var position, :var polygons): {
            return _buildMapScreen(position, polygons);
          }
        }
      }
    );
  }

  Widget _buildLoadingScreen() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildPermissionDeniedScreen(void Function() askForPermission) {
    return Center(
      child: Column(
        children: [
          Text('Please give the application location permission. We need it to display your position on the map.'),
          FilledButton(onPressed: askForPermission, child: Text('Give permission'))
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedForeverScreen(void Function() openAppSettings, void Function() refresh) {
    return Center(
      child: Column(
        children: [
          Text('Location permission was denied forever. We won\'t ask for it anymore. Please manually change it in the application settings and refresh the map.'),
          FilledButton(onPressed: openAppSettings, child: Text('Open settings')),
          TextButton(onPressed: refresh, child: Text('Refresh'))
        ],
      ),
    );
  }

  Widget _buildLocationServiceRequestRejectedScreen(void Function() openLocationSettings, void Function() refresh) {
    return Center(
      child: Column(
        children: [
          Text('Please enable location service and refresh the map'),
          FilledButton(onPressed: openLocationSettings, child: Text('Open settings')),
          TextButton(onPressed: refresh, child: Text('Refresh'))
        ],
      ),
    );
  }

  Widget _buildMapScreen(LocationMarkerPosition position, List<Polygon> polygons) {
    return _buildMapWidget(
      layers: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'pl.edu.pw.mini.karandys.narracity',
        ),
        PolygonLayer(polygons: polygons),
        LocationMarkerLayer(position: position),
        // CurrentLocationLayer(
        //   indicators: LocationMarkerIndicators(
        //     serviceDisabled: LocationMarkerLayer(
        //       position: LocationMarkerPosition(latitude: lastKnownPosition.latitude, longitude: lastKnownPosition.longitude, accuracy: lastKnownPosition.accuracy),
        //       style: LocationMarkerStyle(
        //         marker: DefaultLocationMarker(color: Colors.grey),
        //         showHeadingSector: false,
        //         showAccuracyCircle: false
        //       ),
        //     ),
        //   ),
        // ),
        SimpleAttributionWidget(source: Text('OpenStreetMap contributors')),
      ]
    );
  }

  Widget _buildMapWidget({required List<Widget> layers}) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: FlutterMap(
          // TODO: Change map options.
          options: MapOptions(
            initialCenter: LatLng(52.20161, 20.86548),
            initialZoom: 16,
            maxZoom: 20,
            minZoom: 12
          ),
          children: layers
        )
      ),
    );
  }
}