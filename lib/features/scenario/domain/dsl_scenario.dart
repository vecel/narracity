import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';

class ScenarioNode {
  const ScenarioNode({required this.id, required this.elements});

  final String id;
  final List<ScenarioElement> elements;
}



final exampleScenario = [
  ScenarioNode(
    id: 'introduction', 
    elements: [
      TextElement(text: 'Welcome, this is my brand new game. Would you like to play?'),
      TextElement(text: 'Of course you would, haha. To start click the button below.'),
      ButtonElement(
        text: 'Click me', 
        trigger: AppendElementsTrigger(
          elements: [
            TextElement(text: 'Great, you are doing well.'),
            ButtonElement(
              text: 'Proceed', 
              trigger: ProceedTrigger(id: 'chapter 1')
            )
          ]
        )
      )
    ]
  ),

  ScenarioNode(
    id: 'chapter 1', 
    elements: [
      TextElement(text: 'I will add a polygon to the map. Let me do this now.'),
      PolygonElement(
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
        )
      )
    ]
  )
];
