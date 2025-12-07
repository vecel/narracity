import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

sealed class ScenarioNode {}

final class TextNode extends ScenarioNode {
  TextNode({required this.text, required this.next});

  final String text;
  final ScenarioNode next;
}

final class ChoiceNode extends ScenarioNode {
  ChoiceNode({required this.text, required this.labelA, required this.labelB, required this.choiceA, required this.choiceB});

  final String text;
  final String labelA;
  final String labelB;
  final ScenarioNode choiceA;
  final ScenarioNode choiceB;
}

final class PolygonNode extends ScenarioNode {
  PolygonNode({required this.polygon, this.onEnter, this.onLeave, this.removeOnEnter = true, this.removeOnLeave = false});

  final Polygon polygon;
  final ScenarioNode? onEnter;
  final ScenarioNode? onLeave;
  final bool removeOnEnter;
  final bool removeOnLeave;
}

class EmptyNode extends ScenarioNode {}

final winNode = TextNode(
  text: 'You have won', 
  next: EmptyNode()
);

final addPolygonNode = PolygonNode(
  polygon: Polygon(
    points: [
      LatLng(52.190727, 20.857727),
      LatLng(52.197257, 20.850770),
      LatLng(52.199115, 20.858575),
      LatLng(52.196711, 20.859618),
    ],
    color: Colors.amber,
    borderColor: Colors.redAccent,
    borderStrokeWidth: 2
  ),
  onEnter: winNode
);

final choice = ChoiceNode(
  text: 'Choose wisely',
  labelA: 'Play',
  labelB: 'Exit', 
  choiceA: TextNode(text: 'Okay, let\'s play', next: addPolygonNode), 
  choiceB: TextNode(text: 'Failure', next: EmptyNode())
);

final exampleNode = TextNode(
  text: 'Hello, welcome to my game',
  next: choice
);