import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/node.dart';
import 'package:narracity/features/scenario/domain/scenario.dart';

class FakeScenariosRepository implements ScenariosRepository{
  final List<Scenario> _scenarios = [
    Scenario(
      title: 'Scenario 1', 
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also", 
      image: 'assets/cat.webp',
      location: 'Warsaw', 
      distance: '4 km', 
      duration: '1 h',
      startNode: exampleNode
    ),
    Scenario(
      title: 'Scenario 2',
      description: 'This is scenario with empty starting node.',
      image: 'assets/cat.webp',
      location: 'Berlin',
      distance: '10 km',
      duration: '3 h',
      startNode: EmptyNode()
    )
  ];
  
  @override
  List<Scenario> get scenarios => _scenarios;


}