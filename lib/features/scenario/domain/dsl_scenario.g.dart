// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsl_scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'image': instance.image,
  'location': instance.location,
  'distance': instance.distance,
  'duration': instance.duration,
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
