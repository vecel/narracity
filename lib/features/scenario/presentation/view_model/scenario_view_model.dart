import 'package:flutter/material.dart';

class ScenarioViewModel extends ChangeNotifier {

  ScenarioViewModel({required this.title});
  
  final String title;

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