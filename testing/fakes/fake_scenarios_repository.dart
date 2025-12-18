import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/domain/scenario.dart';

final _testScenario = Scenario(
  title: 'Mystery in Old Town',
  description: 'Solve a centuries-old mystery while exploring the historic streets of the old town. This adventure will take you through hidden passages and ancient secrets.',
  location: 'Warsaw, Poland',
  distance: '15km',
  duration: '3 hours',
  image: 'assets/cat.webp',
  startNode: _scenarioWithPolygon[0]
);

final _scenarioWithPolygon = [
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

class FakeScenariosRepository implements ScenariosRepository {

  FakeScenariosRepository.empty();
  FakeScenariosRepository.withScenarios() {
    _scenarios.add(_testScenario);
  }
  
  final List<Scenario> _scenarios = [];

  @override
  List<Scenario> get scenarios => _scenarios;
  
}