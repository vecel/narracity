import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:narracity/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_description_screen.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_list_item.dart';
import 'package:flutter/material.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  const ScenarioSelectionScreen({super.key, required this.viewModel});

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: BaseAppBar(title: 'Choose Scenario'),
      body: ListView.builder(
        itemCount: viewModel.scenariosCount,
        itemBuilder: (context, index) {
          final scenario = viewModel.getScenario(index);
          return GestureDetector(
            onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ScenarioDescriptionScreen(scenario: scenario))
            ),
            child: ScenarioListItem(scenario: scenario)
          );
        }
      )
    );
  }
}