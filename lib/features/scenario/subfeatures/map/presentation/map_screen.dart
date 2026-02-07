import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_factory.dart';
import 'package:narracity/keys.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        final cubit = context.read<MapCubit>();
        return switch (state) {
          MapInitial() => _LodaingView(),
          MapPermissionDenied() => _PermissionDeniedView(
            askForPermission: cubit.askForPermission
          ),
          MapPermissionDeniedForever() => _PermissionDeniedForeverView(
            openAppSettings: cubit.openAppSettings, 
            refresh: cubit.askForPermission
          ),
          MapLocationServiceRequestRejected() => _LocationServiceRequestRejectedView(
            openLocationSettings: cubit.openLocationSettings, 
            refresh: cubit.askForPermission
          ),
          MapReady(:var position) => _MapView(position: position),
        };
      }
    );
  }
}

class _LodaingView extends StatelessWidget {
  const _LodaingView();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class _PermissionDeniedView extends StatelessWidget {
  final VoidCallback askForPermission;
  
  const _PermissionDeniedView({
    required this.askForPermission
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Please give the application location permission. We need it to display your position on the map.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: askForPermission,
            child: const Text('Give permission'),
          ),
        ],
      ),
    );
  }
}

class _PermissionDeniedForeverView extends StatelessWidget {
  final VoidCallback openAppSettings;
  final VoidCallback refresh;

  const _PermissionDeniedForeverView({
    required this.openAppSettings,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Location permission was denied forever. We won\'t ask for it anymore. Please manually change it in the application settings and refresh the map.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: openAppSettings,
              child: const Text('Open settings'),
            ),
            TextButton(
              onPressed: refresh,
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationServiceRequestRejectedView extends StatelessWidget {
  final VoidCallback openLocationSettings;
  final VoidCallback refresh;

  const _LocationServiceRequestRejectedView({
    required this.openLocationSettings,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enable location service and refresh the map',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: openLocationSettings,
              child: const Text('Open settings'),
            ),
            TextButton(
              onPressed: refresh,
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapView extends StatelessWidget {
  final LocationMarkerPosition position;

  const _MapView({
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScenarioCubit, ScenarioRunning>(
      builder: (context, state) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: MapFactory.build(
              key: keys.mapScreen.mapWidget,
              options: MapOptions(
                initialCenter: position.latLng,
                initialZoom: 16,
                maxZoom: 20,
                minZoom: 12,
                keepAlive: true,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'pl.edu.pw.mini.karandys.narracity',
                  tileProvider: NetworkTileProvider(
                    cachingProvider: BuiltInMapCachingProvider.getOrCreateInstance(
                      maxCacheSize: 1_000_000_000,
                    ),
                  ),
                ),
                PolygonLayer(polygons: state.polygons),
                LocationMarkerLayer(position: position),
                const SimpleAttributionWidget(
                  source: Text('OpenStreetMap contributors'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}