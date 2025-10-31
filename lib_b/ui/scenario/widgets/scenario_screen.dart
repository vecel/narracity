import '../../core/ui/base_app_bar.dart';
import 'package:flutter/material.dart';
import '../view_model/scenario_view_model.dart';
import 'node_widget_factory.dart';
import 'scenario_page_destination.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key, required this.viewModel});

  final ScenarioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Scaffold(
        appBar: BaseAppBar(title: viewModel.scenario.title),
        bottomNavigationBar: NavigationBar(
          selectedIndex: viewModel.selectedPageIndex,
          onDestinationSelected: (index) => viewModel.selectPage(index),
          destinations: [
            ScenarioPageDestination(icon: Icons.text_snippet, label: 'Story', notification: viewModel.storyPageNotification),
            ScenarioPageDestination(icon: Icons.map, label: 'Map', notification: viewModel.mapPageNotification),
            ScenarioPageDestination(icon: Icons.inventory, label: 'Journal', notification: false, enabled: false)
          ]
        ),
        body: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: viewModel.scenarioProgress.length + 1,
              itemBuilder: (context, index) {
                if (index == viewModel.scenarioProgress.length) {
                  return NodeWidgetFactory.createActionWidget(viewModel.scenarioProgress.last, viewModel.proceed);
                }
                final node = viewModel.scenarioProgress[index];
                return NodeWidgetFactory.create(node);
              }
            ),
          ),
          Center(child: Text('Map')),
          Center(child: Text('Journal')),
        ][viewModel.selectedPageIndex],
      )
    );
  }
}