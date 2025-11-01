import 'package:flutter/material.dart';
import 'package:narracity/features/scenario/models/scenario.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/features/scenario/presentation/view_model/scenario_view_model.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.scenario});

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
            MaterialPageRoute(builder: (context) => ScenarioScreen(viewModel: ScenarioViewModel(title: scenario.title)))
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