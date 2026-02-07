import 'package:flutter_map/flutter_map.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';

sealed class ScenarioState {}

class ScenarioRunning extends ScenarioState {
  ScenarioRunning({required this.elements});

  factory ScenarioRunning.initial() => ScenarioRunning(elements: []);

  final List<ScenarioElement> elements;

  List<PolygonElement> get polygonElements => elements.whereType<PolygonElement>().toList();
  List<Polygon> get polygons => polygonElements.map((el) => el.polygon).toList();
  List<StoryElement> get story => elements.whereType<StoryElement>().toList();
} 

class ScenarioError extends ScenarioState {
  ScenarioError({required this.message});
  final String message;
}
class ScenarioFinished extends ScenarioState {}