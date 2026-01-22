// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsl_triggers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProceedTrigger _$ProceedTriggerFromJson(Map<String, dynamic> json) =>
    ProceedTrigger(id: json['id'] as String)
      ..triggered = json['triggered'] as bool;

Map<String, dynamic> _$ProceedTriggerToJson(ProceedTrigger instance) =>
    <String, dynamic>{'triggered': instance.triggered, 'id': instance.id};

AppendElementsTrigger _$AppendElementsTriggerFromJson(
  Map<String, dynamic> json,
) => AppendElementsTrigger(
  elements: (json['elements'] as List<dynamic>)
      .map(
        (e) => const ScenarioElementSerializer().fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
)..triggered = json['triggered'] as bool;

Map<String, dynamic> _$AppendElementsTriggerToJson(
  AppendElementsTrigger instance,
) => <String, dynamic>{
  'triggered': instance.triggered,
  'elements': instance.elements
      .map(const ScenarioElementSerializer().toJson)
      .toList(),
};

WithStoryNotificationTrigger _$WithStoryNotificationTriggerFromJson(
  Map<String, dynamic> json,
) => WithStoryNotificationTrigger(
  trigger: const ScenarioTriggerSerializer().fromJson(
    json['trigger'] as Map<String, dynamic>,
  ),
)..triggered = json['triggered'] as bool;

Map<String, dynamic> _$WithStoryNotificationTriggerToJson(
  WithStoryNotificationTrigger instance,
) => <String, dynamic>{
  'triggered': instance.triggered,
  'trigger': const ScenarioTriggerSerializer().toJson(instance.trigger),
};

WithMapNotificationTrigger _$WithMapNotificationTriggerFromJson(
  Map<String, dynamic> json,
) => WithMapNotificationTrigger(
  trigger: const ScenarioTriggerSerializer().fromJson(
    json['trigger'] as Map<String, dynamic>,
  ),
)..triggered = json['triggered'] as bool;

Map<String, dynamic> _$WithMapNotificationTriggerToJson(
  WithMapNotificationTrigger instance,
) => <String, dynamic>{
  'triggered': instance.triggered,
  'trigger': const ScenarioTriggerSerializer().toJson(instance.trigger),
};

EndTrigger _$EndTriggerFromJson(Map<String, dynamic> json) =>
    EndTrigger()..triggered = json['triggered'] as bool;

Map<String, dynamic> _$EndTriggerToJson(EndTrigger instance) =>
    <String, dynamic>{'triggered': instance.triggered};

EmptyTrigger _$EmptyTriggerFromJson(Map<String, dynamic> json) =>
    EmptyTrigger()..triggered = json['triggered'] as bool;

Map<String, dynamic> _$EmptyTriggerToJson(EmptyTrigger instance) =>
    <String, dynamic>{'triggered': instance.triggered};
