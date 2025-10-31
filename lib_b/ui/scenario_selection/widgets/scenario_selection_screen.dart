import '../../core/ui/base_app_bar.dart';
import '../view_model/scenario_selection_view_model.dart';
import 'scenario_description_screen.dart';
import 'scenario_list_item.dart';
import 'package:flutter/material.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  const ScenarioSelectionScreen({super.key, required this.viewModel});

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: BaseAppBar(title: 'Choose Scenario'),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: ListView.builder(
        itemCount: viewModel.scenariosCount,
        itemBuilder: (context, index) {
          final scenario = viewModel.scenarios[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ScenarioDescriptionScreen(scenario: scenario))
            ),
            child: ScenarioListItem(
              title: scenario.title,
              description: scenario.description,
              distance: scenario.distance,
              duration: scenario.duration,
              location: scenario.location,
            )
          );
        }
      )
    );
  }
}