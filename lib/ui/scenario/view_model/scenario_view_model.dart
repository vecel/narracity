import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:narracity/domain/models/scenario.dart';
import 'package:narracity/domain/models/node.dart';

class ScenarioViewModel extends ChangeNotifier {

  static final Logger logger = Logger('ScenarioViewModel');

  ScenarioViewModel({required this.scenario}): _scenarioProgress = [scenario.startNode];

  final Scenario scenario;
  final List<ScenarioNode> _scenarioProgress;
  
  int selectedPageIndex = 0;
  bool storyPageNotification = false;
  bool mapPageNotification = false;
  
  UnmodifiableListView<ScenarioNode> get scenarioProgress => UnmodifiableListView(_scenarioProgress);

  void selectPage(int index) {
    selectedPageIndex = index;
    switch (index) {
      case 0: _onStoryPageSelected();
      case 1: _onMapPageSelected();
      default: throw Exception('Invalid index selected');
    }
    notifyListeners();
  }

  void proceed(ScenarioNode node) {
    _scenarioProgress.add(node);
    // do something
    notifyListeners();
  }

  void _onStoryPageSelected() => storyPageNotification = false;
  void _onMapPageSelected() => mapPageNotification = false;
}