import 'package:narracity/domain/models/scenario.dart';
import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:narracity/ui/core/ui/labeled_icon.dart';
import 'package:narracity/ui/scenario/view_model/scenario_view_model.dart';
import 'package:narracity/ui/scenario/widgets/scenario_screen.dart';
import 'package:flutter/material.dart';

class ScenarioDescriptionScreen extends StatelessWidget {
  const ScenarioDescriptionScreen({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    final imageSection = SizedBox(
      height: 160,
      child: Image(
        image: AssetImage(scenario.image),
        fit: BoxFit.cover, 
      ),
    );
    final titleSection = Row(
      children: [
        Text(
          scenario.title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        Expanded(child: Container()),
        FilledButton(
          onPressed: () => Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ScenarioScreen(viewModel: ScenarioViewModel(scenario: scenario)))
          ),
          child: Text('Play')
        )
      ],
    ); 
    final detailsSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LabeledIcon(icon: Icons.location_on, label: scenario.location),
        LabeledIcon(icon: Icons.access_time, label: scenario.duration),
        LabeledIcon(icon: Icons.directions_walk, label: scenario.distance)
      ],
    );
    final descriptionSection = Text(
      scenario.description,
      textAlign: TextAlign.justify,
    );

    return Scaffold(
      appBar: BaseAppBar(),
      body: ListView(
        children: [
          imageSection,
          titleSection,
          Divider(),
          detailsSection,
          descriptionSection
        ]
      )
    );
  }
}