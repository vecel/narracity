import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

// TODO: change private methods to _SthView classes

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final cubit = BlocProvider.of<MapCubit>(context);
  
    return BlocBuilder<MapCubit, MapState>(
      bloc: cubit,
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
          case MapReady(:var position): {
            return _buildMapScreen(position);
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

  Widget _buildMapScreen(LocationMarkerPosition position) {
    return BlocBuilder<ScenarioCubit, ScenarioRunning>(
      builder: (context, state) => Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: position.latLng,
              initialZoom: 16,
              maxZoom: 20,
              minZoom: 12
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'pl.edu.pw.mini.karandys.narracity',
              ),
              PolygonLayer(polygons: state.polygons),
              LocationMarkerLayer(position: position),
              SimpleAttributionWidget(source: Text('OpenStreetMap contributors')),
            ]
          )
        ),
      ),
    );
  }
}