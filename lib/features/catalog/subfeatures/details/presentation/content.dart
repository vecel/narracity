import 'package:flutter/material.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

class DetailsScreenContent extends StatelessWidget {
  const DetailsScreenContent(this.scenario, {super.key});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: Icon(Icons.arrow_back)
              ),
              SizedBox(width: 8),
              Text(
                scenario.title,
                style: TextStyle(fontSize: 24),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.more_vert)
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Container()),
              LabeledIcon(icon: Icons.location_on, label: scenario.location),
              SizedBox(width: 64),
              LabeledIcon(icon: Icons.access_time, label: scenario.duration),
              SizedBox(width: 64),
              LabeledIcon(icon: Icons.directions_walk, label: scenario.distance),
              Expanded(child: Container())
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                Text(
                  scenario.description,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 56)
              ]
            ),
          ),
        ],
      )
    );
  }
}