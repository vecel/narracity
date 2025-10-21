import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:flutter/material.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Your Scenario'),
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