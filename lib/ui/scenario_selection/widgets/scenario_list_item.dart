import 'package:narracity/domain/models/scenario.dart';
import 'package:narracity/ui/core/ui/labeled_icon.dart';
import 'package:flutter/material.dart';

class ScenarioListItem extends StatelessWidget {
  const ScenarioListItem({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 96,
              child: Image(
                image: AssetImage('assets/cat.webp'), // TODO
                fit: BoxFit.cover,
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
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LabeledIcon(icon: Icons.location_on, label: scenario.location),
                        LabeledIcon(icon: Icons.access_time, label: scenario.duration),
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
    );
  }
}