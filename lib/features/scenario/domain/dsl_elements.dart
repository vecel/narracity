import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/utils/json_serializer.dart';

part 'dsl_elements.g.dart';

sealed class ScenarioElement {
  const ScenarioElement({required this.type});

  final String type;

  Map<String, dynamic> toJson() {
    final json = _toJsonContent();
    json['type'] = type;
    return json;
  }

  Map<String, dynamic> _toJsonContent();
  
  factory ScenarioElement.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    
    return switch(type) {
      'text' => TextElement.fromJson(json),
      'polygon' => PolygonElement.fromJson(json),
      'button' => ButtonElement.fromJson(json),
      'multi_button' => MultiButtonElement.fromJson(json),
      _ => throw FormatException('Unsupported element type: $type')
    };
  }
  
}

sealed class StoryElement extends ScenarioElement {
  const StoryElement({required super.type});
}

sealed class MapElement extends ScenarioElement {
  const MapElement({required super.type});
}


@JsonSerializable()
class TextElement extends StoryElement {
  const TextElement({required this.text}) : super(type: 'text');

  final String text;
  
  factory TextElement.fromJson(Map<String, dynamic> json) => _$TextElementFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$TextElementToJson(this);
  
}

@JsonSerializable()
class PolygonElement extends MapElement {
  PolygonElement({required this.points, this.removeOnEnter = true, this.enterTrigger, this.leaveTrigger}):
    polygon = Polygon(
      points: points,
      color: Colors.blue.withAlpha(50),
      borderColor: Colors.blue,
      borderStrokeWidth: 2
    ),
    super(type: 'polygon');

  @LatLngSerializer()
  final List<LatLng> points;
  final bool removeOnEnter;

  @ScenarioTriggerSerializer()
  final ScenarioTrigger? enterTrigger;

  @ScenarioTriggerSerializer()
  final ScenarioTrigger? leaveTrigger;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Polygon polygon;

  factory PolygonElement.fromJson(Map<String, dynamic> json) => _$PolygonElementFromJson(json);
  
  @override
  Map<String, dynamic> _toJsonContent() => _$PolygonElementToJson(this);
}

@JsonSerializable()
class ButtonElement extends StoryElement {
  const ButtonElement({required this.text, required this.trigger}): super(type: 'button');

  final String text;

  @ScenarioTriggerSerializer()
  final ScenarioTrigger trigger;

  factory ButtonElement.fromJson(Map<String, dynamic> json) => _$ButtonElementFromJson(json);
  
  @override
  Map<String, dynamic> _toJsonContent() => _$ButtonElementToJson(this);

}

@JsonSerializable(explicitToJson: true)
class MultiButtonElement extends StoryElement {
  const MultiButtonElement({required this.buttons}) : super(type: 'multi_button');

  final List<ButtonElement> buttons;

  factory MultiButtonElement.fromJson(Map<String, dynamic> json) => _$MultiButtonElementFromJson(json);
  
  @override
  Map<String, dynamic> _toJsonContent() => _$MultiButtonElementToJson(this);
}