sealed class ScenarioNode {}

final class TextNode extends ScenarioNode {
  TextNode({required this.text, required this.next});

  final String text;
  final ScenarioNode next;
}

final class ChoiceNode extends ScenarioNode {
  ChoiceNode({required this.text, required this.labelA, required this.labelB, required this.choiceA, required this.choiceB});

  final String text;
  final String labelA;
  final String labelB;
  final ScenarioNode choiceA;
  final ScenarioNode choiceB;
}

class EmptyNode extends ScenarioNode {}

final choice = ChoiceNode(
  text: 'Choose wisely',
  labelA: 'Choice A',
  labelB: 'Choice B', 
  choiceA: TextNode(text: 'Success', next: EmptyNode()), 
  choiceB: TextNode(text: 'Failure', next: EmptyNode())
);

final exampleNode = TextNode(
  text: 'Hello, welcome to my game',
  next: choice
);