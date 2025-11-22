import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';

class MapScreen extends StatelessWidget {
  static final _log = Logger('MapScreen');

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _log.info('Build method');
    // final error = Column(
    //     children: [
    //       Text('Should enable location and give permission'),
    //       FilledButton(
    //         onPressed: () {}, 
    //         child: Text('Action')
    //       )
    //     ],
    //   );

    // final screen = Center(
    //   child: Container(
    //     margin: EdgeInsets.all(16),
    //     child: FlutterMap(
    //       options: MapOptions(
    //         initialCenter: LatLng(52.20161, 20.86548),
    //         initialZoom: 16,
    //         maxZoom: 20,
    //         minZoom: 12
    //       ),
    //       children: [
    //         TileLayer(
    //           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //           userAgentPackageName: 'pl.edu.pw.mini.karandys.narracity',
    //         ),
    //         PolygonLayer(
    //           polygons: [
    //             Polygon(
    //               points: [
    //                 LatLng(52.20, 20.86),
    //                 LatLng(52.20, 20.85),
    //                 LatLng(52.21, 20.85),
    //                 LatLng(52.21, 20.86),
    //               ],
    //               color: Colors.red
    //             ),
    //           ]
    //         ),
    //         // MarkerLayer(
    //         //   markers: [
    //         //     Marker(point: viewModel.userLocation!, child: Container(width: 10, height: 10, color: Colors.red))
    //         //   ]
    //         // ),
    //         SimpleAttributionWidget(source: Text('OpenStreetMap contributors')),
    //       ]
    //     )
    //   ),
    // );

    final cubit = BlocProvider.of<MapCubit>(context);
  
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        _log.info('Entering bloc builder with state: $state');
        switch (state) {
          case MapInitial(): {
            cubit.askForPermission();
            return _buildLoadingScreen();
          }
          case MapPermissionDenied(): {
            return Text('Permission not granted');
          }
          case MapPermissionDeniedForever(): {
            // Add button to open app settings
            return Text('Permission denied forever');
          }
          case MapLocationServiceDisabled(): {
            return Text('Location disabled');
          }
          case MapLocationServiceRequestRejected(): {
            return TextButton(onPressed: cubit.x, child: Text('Open location settings'));
          }
          case MapPermissionGranted(:var position): {
            return Text('$position');
          }
        }
      }
    );
  }

  Widget _buildLoadingScreen() {
    return CircularProgressIndicator();
  }
}