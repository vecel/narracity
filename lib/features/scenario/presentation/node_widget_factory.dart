import 'package:flutter/material.dart';
import 'package:narracity/features/scenario/models/node.dart';

// TODO: Should move this file to progress feature

class NodeWidgetFactory {
  static Widget create(ScenarioNode node) {
    return switch(node) {
      TextNode(:var text) => Text(text),
      ChoiceNode(:var text) => Text(text),
      EmptyNode() => Container(),
    };
  }

  static Widget createActionWidget(ScenarioNode node, void Function(ScenarioNode) proceed) {
    return switch (node) {
      TextNode(:var next) => TextButton(
        onPressed: () => proceed(next), 
        child: Text('Next')
      ),
      ChoiceNode(:var labelA, :var labelB, :var choiceA, :var choiceB) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () { 
              proceed(TextNode(text: 'You chose A', next: choiceA));
              proceed(choiceA);
            }, 
            child: Text(labelA)),
          SizedBox(width: 16),
          TextButton(onPressed: () => proceed(choiceB), child: Text(labelB))
        ],
      ),
      EmptyNode() => Container()
    };
  }
}