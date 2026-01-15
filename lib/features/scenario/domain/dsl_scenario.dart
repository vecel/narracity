import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';

// TODO: Add AddPolygonTrigger
// TODO: Easier button removal after use/trigger
// TODO: Easier notifications sending
// TODO: Add default polygon style
// TODO: Add text styling (headings, center, bold etc.)
// TODO: Add button styling

class Scenario {
  const Scenario({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.distance,
    required this.duration,
    required this.nodes
  });

  final String id;
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
      id: data['id'] ?? 'Unknown',
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