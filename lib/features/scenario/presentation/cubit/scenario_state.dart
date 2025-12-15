import 'package:flutter_map/flutter_map.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';

final class ScenarioState {
  const ScenarioState({required this.elements});

  factory ScenarioState.initial() => const ScenarioState(elements: []);

  final List<ScenarioElement> elements;

  List<PolygonElement> get polygonElements => elements.whereType<PolygonElement>().toList();
  List<Polygon> get polygons => polygonElements.map((el) => el.polygon).toList();
  List<StoryElement> get story => elements.whereType<StoryElement>().toList();
} 