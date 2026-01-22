import 'package:json_annotation/json_annotation.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/utils/json_serializer.dart';

part 'dsl_scenario.g.dart';

// TODO: Add AddPolygonTrigger
// TODO: Easier button removal after use/trigger
// TODO: Easier notifications sending
// TODO: Add default polygon style
// TODO: Add text styling (headings, center, bold etc.)
// TODO: Add button styling

// TODO: Change type field type from String to enum

@JsonSerializable()
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

  factory Scenario.fromJson(Map<String, dynamic> json) => _$ScenarioFromJson(json);
  // {
  //   return Scenario(
  //     id: json['id'] as String,
  //     title: json['title'] as String,
  //     description: json['description'] as String,
  //     distance: json['distance'] as String,
  //     location: json['location'] as String,
  //     duration: json['duration'] as String,
  //     image: json['image'] as String,
  //     nodes: (json['nodes'] as List<dynamic>)
  //       .map((nodeJson) => ScenarioNode.fromJson(nodeJson as Map<String, dynamic>))
  //       .toList()
  //   );
  // }

  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
  // {
  //   return {
  //     'title': title,
  //     'description': description,
  //     'distance': distance,
  //     'duration': duration,
  //     'loaction': location,
  //     'image': image,
  //     'nodes': nodes.map((node) => node.toJson()).toList()
  //   };
  // }
}

@JsonSerializable()
class ScenarioNode {
  const ScenarioNode({required this.id, required this.elements});

  final String id;

  @ScenarioElementSerializer()
  final List<ScenarioElement> elements;

  factory ScenarioNode.fromJson(Map<String, dynamic> json) => _$ScenarioNodeFromJson(json);
  // {
  //   return ScenarioNode(
  //     id: json['id'] as String,
  //     elements: (json['elements'] as List<dynamic>)
  //       .map((element) => ScenarioElement.fromJson(element as Map<String, dynamic>))
  //       .toList(),
  //   );
  // }

  Map<String, dynamic> toJson() => _$ScenarioNodeToJson(this);
  // {
  //   return {
  //     'id': id,
  //     'elements': elements.map((element) => element.toJson()).toList()
  //   };
  // }
}