import 'package:flutter/material.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

class CatalogListItem extends StatelessWidget {
  const CatalogListItem({
    super.key, 
    required this.title, 
    required this.description, 
    required this.location, 
    required this.duration, 
    required this.distance
  });

  final String title;
  final String description;
  final String location;
  final String duration;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              spreadRadius: 2,
              blurRadius: 1
            )
          ],
          color: Theme.of(context).colorScheme.surface
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 96,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                child: Image(
                  image: AssetImage('assets/cat.webp'), // TODO
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 24, 
                    child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  SizedBox(
                    height: 40,
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LabeledIcon(icon: Icons.location_on, label: location),
                        Expanded(child: Container()),
                        LabeledIcon(icon: Icons.access_time, label: duration),
                        SizedBox(width: 8),
                        LabeledIcon(icon: Icons.directions_walk, label: distance)
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}