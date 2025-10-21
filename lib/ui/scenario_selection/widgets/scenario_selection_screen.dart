import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:narracity/ui/scenario/widgets/scenario_screen.dart';
import 'package:narracity/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_list_item.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  const ScenarioSelectionScreen({super.key, required this.viewModel});

  static final log = Logger('ScenarioSelectionScreen');

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final scenariosList = ListView.builder(
        // itemCount: viewModel.scenarios.length,
        itemCount: 1,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () { 
            viewModel.currentScenario = viewModel.scenarios[index];
            Navigator.push(
              context, 
              // MaterialPageRoute(builder: (context) => ScenarioDescriptionScreen(viewModel: viewModel))
              MaterialPageRoute(builder: (context) => ScenarioScreen())
            );
          },
          child: ScenarioListItem()
        ),
      );

    return Scaffold(
      appBar: BaseAppBar(title: 'Choose Scenario'),
      body: scenariosList
    );
  }
}