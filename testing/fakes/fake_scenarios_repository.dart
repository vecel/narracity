import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/scenario.dart';

final _choiceNode = ChoiceNode(
  text: 'Choose wisely',
  labelA: 'Choice A',
  labelB: 'Choice B', 
  choiceA: TextNode(text: 'Success', next: EmptyNode()), 
  choiceB: TextNode(text: 'Failure', next: EmptyNode())
);

final _startNode = TextNode(
  text: 'Hello, welcome to my game',
  next: _choiceNode
);

final _fakeScenarios = [
  Scenario(
      title: 'Example Scenario', 
      description: "This is description of example scenario designed for testing", 
      image: 'assets/cat.webp',
      location: 'Warsaw', 
      distance: '4 km', 
      duration: '1 h',
      startNode: _startNode
    ),
    Scenario(title: 'Mystery Road', 
      description: "This is fabular scenario that you play on the roads of Warsaw. It requires flair and lateral thinking. Can you cope?", 
      image: '',
      location: 'Warsaw', 
      distance: '20 km', 
      duration: '5 h',
      startNode: _startNode
    )
];

class FakeScenariosRepository implements ScenariosRepository {

  FakeScenariosRepository.empty();
  FakeScenariosRepository.withScenarios() {
    _scenarios.addAll(_fakeScenarios);
  }
  
  final List<Scenario> _scenarios = [];

  @override
  List<Scenario> get scenarios => _scenarios;
  
}