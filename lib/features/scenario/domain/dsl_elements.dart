import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  PolygonElement({required List<LatLng> points, this.removeOnEnter = true, this.enterTrigger, this.leaveTrigger}):
    polygon = Polygon(
      points: points,
      color: Colors.blue.withAlpha(50),
      borderColor: Colors.blue,
      borderStrokeWidth: 2
    );

  final Polygon polygon;
  final bool removeOnEnter;
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