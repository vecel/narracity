import 'package:city_games/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:city_games/ui/scenario_selection/widgets/scenario_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  const ScenarioSelectionScreen({super.key, required this.viewModel});

  static final log = Logger('ScenarioSelectionScreen');

  final ScenarioSelectionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final scenariosList = ListView.builder(
        itemCount: viewModel.scenarios.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () { 
            viewModel.currentScenario = viewModel.scenarios[index];
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ScenarioDescriptionScreen(viewModel: viewModel))
            );
          },
          child: Container(
            color: index.isEven ? Colors.lightBlue : null,
            padding: EdgeInsets.all(16),
            child: Text('$index: ${viewModel.scenarios[index]}')),
        ),
      );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back)
        ),
        title: Text('Choose Scenario'),
      ),
      body: scenariosList
    );
  }
}