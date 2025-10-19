import 'package:city_games/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:flutter/material.dart';

class ScenarioDescriptionScreen extends StatelessWidget {
  const ScenarioDescriptionScreen({super.key, required this.viewModel});

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back)
        ),
        title: Text(viewModel.currentScenario!),
      ),
      body: Center(
        child: Text('This is description of ${viewModel.currentScenario}'),
      )
    );
  }
}