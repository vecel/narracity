import 'package:city_games/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:flutter/material.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  const ScenarioSelectionScreen({super.key, required this.viewModel});

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back)
        ),
        title: Text('Choose Scenario'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: viewModel.scenarios.length,
          itemBuilder: (context, index) => Text('$index: ${viewModel.scenarios[index]}'),
        )
      ),
    );
  }
}