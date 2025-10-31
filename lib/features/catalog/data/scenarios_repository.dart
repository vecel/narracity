import 'package:narracity/features/scenario/models/scenario.dart';
import 'package:narracity/features/scenario/models/node.dart';

class ScenariosRepository {
  ScenariosRepository() {
    // TODO remove
    _scenarios.add(Scenario(
      title: 'Example', 
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also", 
      image: 'assets/cat.webp',
      location: 'Warsaw', 
      distance: '4 km', 
      duration: '1 h',
      startNode: exampleNode
    ));

    _scenarios.add(Scenario(
      title: 'Mystery Road', 
      description: "This is fabular scenario that you play on the roads of Warsaw. It requires flair and lateral thinking. Can you cope?", 
      image: 'assets/cat.webp',
      location: 'Warsaw', 
      distance: '20 km', 
      duration: '5 h',
      startNode: exampleNode
    ));
  }

  final List<Scenario> _scenarios = List.empty(growable: true);

  List<Scenario> get scenarios => _scenarios;
  
}