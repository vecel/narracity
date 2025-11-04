import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/map/presentation/view_model/map_view_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.viewModel});

  final MapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(52.20161, 20.86548),
            initialZoom: 16,
            maxZoom: 20,
            minZoom: 12
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'pl.edu.pw.mini.narracity',
            ),
            PolygonLayer(
              polygons: [
                Polygon(
                  points: [
                    LatLng(52.20, 20.86),
                    LatLng(52.20, 20.85),
                    LatLng(52.21, 20.85),
                    LatLng(52.21, 20.86),
                  ],
                  color: Colors.red
                ),
              ]
            ),
            SimpleAttributionWidget(source: Text('OpenStreetMap contributors')),
          ]
        )
      ),
    );
  }
}