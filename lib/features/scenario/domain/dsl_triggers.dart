import 'package:narracity/features/scenario/domain/dsl_elements.dart';

sealed class ScenarioTrigger {
  ScenarioTrigger();

  bool triggered = false;
}

class ProceedTrigger extends ScenarioTrigger {
  ProceedTrigger({required this.id});

  final String id;
} 

class AppendElementsTrigger extends ScenarioTrigger {
  AppendElementsTrigger({required this.elements});

  final List<ScenarioElement> elements;
}

class WithStoryNotificationTrigger extends ScenarioTrigger {
  WithStoryNotificationTrigger({required this.trigger});

  final ScenarioTrigger trigger;
}

class WithMapNotificationTrigger extends ScenarioTrigger {
  WithMapNotificationTrigger({required this.trigger});

  final ScenarioTrigger trigger;
}

class EndTrigger extends ScenarioTrigger {}

class EmptyTrigger extends ScenarioTrigger {}
