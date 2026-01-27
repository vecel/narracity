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

@JsonSerializable(createFactory: false, explicitToJson: true)
class Scenario {
  const Scenario({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.distance,
    required this.duration,
    required this.nodes,
    required this.startNodeId
  });

  final String id;
  final String title;
  final String description;
  final String image;
  final String location;
  final String distance;
  final String duration;
  final String startNodeId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<ScenarioNode> nodes;

  factory Scenario.fromJson(Map<String, dynamic> json, List<ScenarioNode> nodes) {
    return Scenario(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      location: json['location'] as String,
      distance: json['distance'] as String,
      duration: json['duration'] as String,
      startNodeId: json['startNodeId'] as String,
      nodes: nodes
    );
  }
  
  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScenarioNode {
  const ScenarioNode({required this.id, required this.elements});

  final String id;

  @ScenarioElementSerializer()
  final List<ScenarioElement> elements;

  factory ScenarioNode.fromJson(Map<String, dynamic> json) => _$ScenarioNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ScenarioNodeToJson(this);
}