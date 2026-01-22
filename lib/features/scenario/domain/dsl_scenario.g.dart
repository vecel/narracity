// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsl_scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scenario _$ScenarioFromJson(Map<String, dynamic> json) => Scenario(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  location: json['location'] as String,
  distance: json['distance'] as String,
  duration: json['duration'] as String,
  nodes: (json['nodes'] as List<dynamic>)
      .map((e) => ScenarioNode.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'image': instance.image,
  'location': instance.location,
  'distance': instance.distance,
  'duration': instance.duration,
  'nodes': instance.nodes,
};

ScenarioNode _$ScenarioNodeFromJson(Map<String, dynamic> json) => ScenarioNode(
  id: json['id'] as String,
  elements: (json['elements'] as List<dynamic>)
      .map(
        (e) => const ScenarioElementSerializer().fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$ScenarioNodeToJson(ScenarioNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'elements': instance.elements
          .map(const ScenarioElementSerializer().toJson)
          .toList(),
    };
