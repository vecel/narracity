import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:narracity/ui/scenario/view_model/scenario_view_model.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key, required this.viewModel});

  final ScenarioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: viewModel.scenario.title),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.text_snippet), 
            label: 'Story'
          ),
          NavigationDestination(
            icon: Icon(Icons.map), 
            label: 'Map'
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory), 
            label: 'Inventory'
          )
        ]
      ),
      body: Center(
        child: Text('Scenario'),
      )
    );
  }
}