import 'package:narracity/features/scenario/domain/dsl_elements.dart';

sealed class ScenarioTrigger {
  ScenarioTrigger();

  bool triggered = false;

  Map<String, dynamic> toJson();
}

class ProceedTrigger extends ScenarioTrigger {
  ProceedTrigger({required this.id});

  final String id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'proceed',
      'id': id,
    };
  }
} 

class AppendElementsTrigger extends ScenarioTrigger {
  AppendElementsTrigger({required this.elements});

  final List<ScenarioElement> elements;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'append_elements',
      'elements': elements.map((element) => element.toJson()).toList(),
    };
  }
}

class WithStoryNotificationTrigger extends ScenarioTrigger {
  WithStoryNotificationTrigger({required this.trigger});

  final ScenarioTrigger trigger;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'with_story_notification',
      'trigger': trigger.toJson(),
    };
  }
}

class WithMapNotificationTrigger extends ScenarioTrigger {
  WithMapNotificationTrigger({required this.trigger});

  final ScenarioTrigger trigger;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'with_map_notification',
      'trigger': trigger.toJson(),
    };
  }
}

class EndTrigger extends ScenarioTrigger {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'end',
    };
  }
}

class EmptyTrigger extends ScenarioTrigger {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'empty',
    };
  }
}
