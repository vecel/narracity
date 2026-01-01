import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';

class Scenario {
  const Scenario({
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.distance,
    required this.duration,
    required this.nodes
  });

  final String title;
  final String description;
  final String image;
  final String location;
  final String distance;
  final String duration;
  final List<ScenarioNode> nodes;

  factory Scenario.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Scenario(
      title: data['title'] ?? 'Untitled',
      description: 'Example',
      distance: '4km',
      location: data['location'] ?? 'Unknown',
      duration: '1h',
      image: 'assets/cat.webp',
      nodes: []
    );
  }
}

class ScenarioNode {
  const ScenarioNode({required this.id, required this.elements});

  final String id;
  final List<ScenarioElement> elements;
}


final exampleScenario = Scenario(
  title: 'Example Scenario',
  description: 'This is example scenario to present how the app works',
  distance: '1 km',
  duration: '30 min',
  location: 'Warsaw',
  image: 'assets/cat.webp',
  nodes: exampleScenarioNodes
);

final exampleScenarioNodes = [
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
