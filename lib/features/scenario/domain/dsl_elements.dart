import 'package:flutter_map/flutter_map.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';

sealed class ScenarioElement {
  const ScenarioElement();
}

sealed class StoryElement extends ScenarioElement {
  const StoryElement();
}

sealed class MapElement extends ScenarioElement {
  const MapElement();
}



class TextElement extends StoryElement {
  const TextElement({required this.text});

  final String text;
}

class PolygonElement extends MapElement {
  const PolygonElement({required this.polygon, this.enterTrigger, this.leaveTrigger});

  final Polygon polygon;
  final ScenarioTrigger? enterTrigger;
  final ScenarioTrigger? leaveTrigger;
}

class ButtonElement extends StoryElement {
  const ButtonElement({required this.text, required this.trigger});

  final String text;
  final ScenarioTrigger trigger;
}

class MultiButtonElement extends StoryElement {
  const MultiButtonElement({required this.buttons});

  final List<ButtonElement> buttons;
}