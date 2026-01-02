import 'package:narracity/features/scenario/domain/dsl_elements.dart';

sealed class ScenarioTrigger {
  const ScenarioTrigger();
}

class ProceedTrigger extends ScenarioTrigger {
  const ProceedTrigger({required this.id});

  final String id;
} 

class AppendElementsTrigger extends ScenarioTrigger {
  const AppendElementsTrigger({required this.elements});

  final List<ScenarioElement> elements;
}

class WithStoryNotificationTrigger extends ScenarioTrigger {
  const WithStoryNotificationTrigger({required this.trigger});

  final ScenarioTrigger trigger;
}

class WithMapNotificationTrigger extends ScenarioTrigger {
  const WithMapNotificationTrigger({required this.trigger});

  final ScenarioTrigger trigger;
}

class EmptyTrigger extends ScenarioTrigger {}
