import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

class CatalogListItem extends StatelessWidget {
  const CatalogListItem({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => context.go('/details/${scenario.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 96,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: scenario.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    ),
                  )
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24, 
                      child: Text(scenario.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    SizedBox(
                      height: 40,
                      child: Text(
                        scenario.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LabeledIcon(icon: Icons.location_on, label: scenario.location),
                          Expanded(child: Container()),
                          LabeledIcon(icon: Icons.access_time, label: scenario.duration),
                          SizedBox(width: 8),
                          LabeledIcon(icon: Icons.directions_walk, label: scenario.distance)
                        ],
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}