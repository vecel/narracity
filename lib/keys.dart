import 'package:flutter/foundation.dart';

class WelocmeScreenKeys {
  final letsExploreButton = const Key('lets_explore_button');
}

class CatalogScreenKeys {
  Key scenarioItemKey(String id) => Key('scenario_item_$id');
}

class DetailsScreenKeys {
  Key playScenarioKey(String id) => Key('play_scenario_$id');
}

class ScenarioScreenKeys {
  final storyTab = const Key('story_tab');
  final mapTab = const Key('map_tab');
}

class Keys {
  final welcomeScreen = WelocmeScreenKeys();
  final catalogScreen = CatalogScreenKeys();
  final detailsScreen = DetailsScreenKeys();
  final scenarioScreen = ScenarioScreenKeys();
}

final keys = Keys();