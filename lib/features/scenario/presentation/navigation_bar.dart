import 'package:flutter/material.dart';
import 'package:narracity/features/scenario/presentation/scenario_navigation_destination.dart';
import 'package:narracity/keys.dart';

class ScenarioNavigationBar extends StatelessWidget {
  const ScenarioNavigationBar({super.key, required this.index, required this.selectPage, required this.storyNotification, required this.mapNotification, required this.journalNotification});

  final int index;
  final void Function(int) selectPage;
  final bool storyNotification;
  final bool mapNotification;
  final bool journalNotification;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: selectPage,
      destinations: [
        ScenarioNavigationDestination(key: keys.scenarioScreen.storyTab, icon: Icons.text_snippet, label: 'Story', notification: storyNotification),
        ScenarioNavigationDestination(key: keys.scenarioScreen.mapTab, icon: Icons.map, label: 'Map', notification: mapNotification),
        ScenarioNavigationDestination(icon: Icons.inventory, label: 'Journal', notification: journalNotification, enabled: false)
      ]
    );
  }
}
