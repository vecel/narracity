import 'package:flutter/foundation.dart';

class WelocmeScreenKeys {
  final letsExploreButton = const Key('lets_explore_button');
}

class CatalogScreenKeys {
  Key scenarioItemKey(String id) => Key('scenario_item_$id');
}

class DetailsScreenKeys {
  final saveButton = const Key('save_button');
  final snackBar = const Key('snack_bar');

  Key playScenarioKey(String id) => Key('play_scenario_$id');
}

class ScenarioScreenKeys {
  final storyTab = const Key('story_tab');
  final mapTab = const Key('map_tab');
}

class MapScreenKeys {
  final mapWidget = const Key('map_widget');
}

class Keys {
  final welcomeScreen = WelocmeScreenKeys();
  final catalogScreen = CatalogScreenKeys();
  final detailsScreen = DetailsScreenKeys();
  final scenarioScreen = ScenarioScreenKeys();
  final mapScreen = MapScreenKeys();
}

final keys = Keys();