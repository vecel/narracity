// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsl_elements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextElement _$TextElementFromJson(Map<String, dynamic> json) =>
    TextElement(text: json['text'] as String);

Map<String, dynamic> _$TextElementToJson(TextElement instance) =>
    <String, dynamic>{'text': instance.text};

PolygonElement _$PolygonElementFromJson(
  Map<String, dynamic> json,
) => PolygonElement(
  points: (json['points'] as List<dynamic>)
      .map((e) => const LatLngSerializer().fromJson(e as Map<String, dynamic>))
      .toList(),
  removeOnEnter: json['removeOnEnter'] as bool? ?? true,
  enterTrigger: _$JsonConverterFromJson<Map<String, dynamic>, ScenarioTrigger>(
    json['enterTrigger'],
    const ScenarioTriggerSerializer().fromJson,
  ),
  leaveTrigger: _$JsonConverterFromJson<Map<String, dynamic>, ScenarioTrigger>(
    json['leaveTrigger'],
    const ScenarioTriggerSerializer().fromJson,
  ),
);

Map<String, dynamic> _$PolygonElementToJson(
  PolygonElement instance,
) => <String, dynamic>{
  'points': instance.points.map(const LatLngSerializer().toJson).toList(),
  'removeOnEnter': instance.removeOnEnter,
  'enterTrigger': _$JsonConverterToJson<Map<String, dynamic>, ScenarioTrigger>(
    instance.enterTrigger,
    const ScenarioTriggerSerializer().toJson,
  ),
  'leaveTrigger': _$JsonConverterToJson<Map<String, dynamic>, ScenarioTrigger>(
    instance.leaveTrigger,
    const ScenarioTriggerSerializer().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

ButtonElement _$ButtonElementFromJson(Map<String, dynamic> json) =>
    ButtonElement(
      text: json['text'] as String,
      trigger: const ScenarioTriggerSerializer().fromJson(
        json['trigger'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ButtonElementToJson(ButtonElement instance) =>
    <String, dynamic>{
      'text': instance.text,
      'trigger': const ScenarioTriggerSerializer().toJson(instance.trigger),
    };

MultiButtonElement _$MultiButtonElementFromJson(Map<String, dynamic> json) =>
    MultiButtonElement(
      buttons: (json['buttons'] as List<dynamic>)
          .map((e) => ButtonElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultiButtonElementToJson(MultiButtonElement instance) =>
    <String, dynamic>{'buttons': instance.buttons};
