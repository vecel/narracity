import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';

class LatLngSerializer implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngSerializer();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {
      'lat': object.latitude,
      'lng': object.longitude,
    };
  }
}

class ScenarioTriggerSerializer implements JsonConverter<ScenarioTrigger, Map<String, dynamic>> {
  const ScenarioTriggerSerializer();

  @override
  ScenarioTrigger fromJson(Map<String, dynamic> json) {
    return ScenarioTrigger.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ScenarioTrigger object) {
    return object.toJson();
  }
}

class ScenarioElementSerializer implements JsonConverter<ScenarioElement, Map<String, dynamic>> {
  const ScenarioElementSerializer();

  @override
  ScenarioElement fromJson(Map<String, dynamic> json) {
    return ScenarioElement.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ScenarioElement object) {
    return object.toJson();
  }
}