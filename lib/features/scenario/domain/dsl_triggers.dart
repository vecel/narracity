import 'package:json_annotation/json_annotation.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/utils/json_serializer.dart';

part 'dsl_triggers.g.dart';

sealed class ScenarioTrigger {
  ScenarioTrigger({required this.type});

  final String type;
  bool triggered = false;

  Map<String, dynamic> toJson() {
    final json = _toJsonContent();
    json['type'] = type;
    return json;
  }

  Map<String, dynamic> _toJsonContent();

  factory ScenarioTrigger.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    return switch (type) {
      'proceed' => ProceedTrigger.fromJson(json),
      'append_elements' => AppendElementsTrigger.fromJson(json),
      'with_story_notification' => WithStoryNotificationTrigger.fromJson(json),
      'with_map_notification' => WithMapNotificationTrigger.fromJson(json),
      'end' => EndTrigger.fromJson(json),
      'empty' => EmptyTrigger.fromJson(json),
      _ => throw FormatException('Unsupported trigger type $type')
    };
  }
}

@JsonSerializable()
class ProceedTrigger extends ScenarioTrigger {
  ProceedTrigger({required this.id}) : super(type: 'proceed');

  final String id;

  factory ProceedTrigger.fromJson(Map<String, dynamic> json) => _$ProceedTriggerFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$ProceedTriggerToJson(this);
} 

@JsonSerializable()
class AppendElementsTrigger extends ScenarioTrigger {
  AppendElementsTrigger({required this.elements}) : super(type: 'append_elements');

  @ScenarioElementSerializer()
  final List<ScenarioElement> elements;

  factory AppendElementsTrigger.fromJson(Map<String, dynamic> json) => _$AppendElementsTriggerFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$AppendElementsTriggerToJson(this);
}

@JsonSerializable()
class WithStoryNotificationTrigger extends ScenarioTrigger {
  WithStoryNotificationTrigger({required this.trigger}) : super(type: 'with_story_notification');

  @ScenarioTriggerSerializer()
  final ScenarioTrigger trigger;

  factory WithStoryNotificationTrigger.fromJson(Map<String, dynamic> json) => _$WithStoryNotificationTriggerFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$WithStoryNotificationTriggerToJson(this);
}

@JsonSerializable()
class WithMapNotificationTrigger extends ScenarioTrigger {
  WithMapNotificationTrigger({required this.trigger}) : super(type: 'with_map_notification');

  @ScenarioTriggerSerializer()
  final ScenarioTrigger trigger;

  factory WithMapNotificationTrigger.fromJson(Map<String, dynamic> json) => _$WithMapNotificationTriggerFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$WithMapNotificationTriggerToJson(this);
}

@JsonSerializable()
class EndTrigger extends ScenarioTrigger {
  EndTrigger() : super(type: 'end');
  
  factory EndTrigger.fromJson(Map<String, dynamic> json) => _$EndTriggerFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$EndTriggerToJson(this);
}

@JsonSerializable()
class EmptyTrigger extends ScenarioTrigger {
  EmptyTrigger() : super(type: 'empty');

  factory EmptyTrigger.fromJson(Map<String, dynamic> json) => _$EmptyTriggerFromJson(json);

  @override
  Map<String, dynamic> _toJsonContent() => _$EmptyTriggerToJson(this);
}
