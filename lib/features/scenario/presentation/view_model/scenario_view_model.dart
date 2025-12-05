import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/scenario/domain/node.dart';

class ScenarioViewModel extends ChangeNotifier {

  static final Logger log = Logger('ScenarioViewModel');

  ScenarioViewModel({required this.title, required this.start});
  
  final String title;
  final ScenarioNode start;

  int selectedPageIndex = 0;
  bool storyPageNotification = false;
  bool mapPageNotification = false;

  void selectPage(int index) {
    selectedPageIndex = index;
    switch (index) {
      case 0: _onStoryPageSelected();
      case 1: _onMapPageSelected();
      default: throw Exception('Invalid index selected');
    }
    notifyListeners();
  }

  void _onStoryPageSelected() => storyPageNotification = false;
  void _onMapPageSelected() => mapPageNotification = false;

}