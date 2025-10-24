import 'dart:ui';
import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:narracity/ui/core/ui/labeled_icon.dart';
import 'package:narracity/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:flutter/material.dart';

class ScenarioDescriptionScreen extends StatelessWidget {
  const ScenarioDescriptionScreen({super.key, required this.viewModel});

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    assert(viewModel.currentScenario != null);

    final blurredFab = Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black)
          )
        ),
        width: double.infinity,
        height: 64,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Center(
              child: FilledButton(onPressed: () => {}, child: Text('Start')),
            ),
          ),
        ),
      );

    final imageSection = SizedBox(
      height: 160,
      child: Image(
        image: AssetImage('assets/cat.webp'),
        fit: BoxFit.cover, 
      ),
    );
    final titleSection = Row(
      children: [
        Text(
          'Hello, Scenario',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        Expanded(child: Container()),
        FilledButton(onPressed: () => {}, child: Text('Play'))
      ],
    ); 
    final detailsSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LabeledIcon(icon: Icons.location_on, label: 'Warszawa'),
        LabeledIcon(icon: Icons.access_time, label: '30 min'),
        LabeledIcon(icon: Icons.directions_walk, label: '2 km')
      ],
    );
    final descriptionSection = Text(
      viewModel.currentScenario!.description * 2,
      textAlign: TextAlign.justify,
    );

    return Scaffold(
      appBar: BaseAppBar(title: viewModel.currentScenario!.title),
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