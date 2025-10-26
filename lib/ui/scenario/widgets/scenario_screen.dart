import 'package:narracity/domain/models/node.dart';
import 'package:narracity/ui/core/ui/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:narracity/ui/scenario/view_model/scenario_view_model.dart';
import 'package:narracity/ui/scenario/widgets/scenario_page.dart';

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
            ScenarioPage(icon: Icons.text_snippet, label: 'Story', notification: viewModel.storyPageNotification),
            ScenarioPage(icon: Icons.map, label: 'Map', notification: viewModel.mapPageNotification),
            ScenarioPage(icon: Icons.inventory, label: 'You', notification: false, enabled: false)
          ]
        ),
        body: [
            ListView.builder(
              itemCount: viewModel.scenarioProgress.length + 1,
              itemBuilder: (context, index) {
                if (index == viewModel.scenarioProgress.length) {
                  return switch (viewModel.scenarioProgress.last) {
                    TextNode(:var next) => TextButton(
                      onPressed: () => viewModel.proceed(next), 
                      child: Text('Next')
                    ),
                    ChoiceNode(:var labelA, :var labelB, :var choiceA, :var choiceB) => Row(
                      children: [
                        TextButton(onPressed: () => viewModel.proceed(choiceA), child: Text(labelA)),
                        TextButton(onPressed: () => viewModel.proceed(choiceB), child: Text(labelB))
                      ],
                    ),
                    EmptyNode() => Container()
                  };
                }
                final node = viewModel.scenarioProgress[index];
                return switch(node) {
                  TextNode(:var text) => Text(text),
                  ChoiceNode(:var text) => Text(text),
                  EmptyNode() => Container()
                };
              }
            ),
            Center(child: Text('Map')),
            Center(child: Text('Inventory')),
          ][viewModel.selectedPageIndex],
        )
    );
  }
}