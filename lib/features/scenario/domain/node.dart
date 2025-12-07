import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ScenarioNode {
  const ScenarioNode({required this.id, required this.actions});

  final String id;
  final List<ScenarioAction> actions;
}



sealed class ScenarioAction {
  const ScenarioAction();
}

class DisplayTextAction extends ScenarioAction {
  const DisplayTextAction({required this.text});

  final String text;
}

class AddPolygonAction extends ScenarioAction {
  const AddPolygonAction({required this.polygon, this.enterTrigger, this.leaveTrigger});

  final Polygon polygon;
  final ScenarioActionTrigger? enterTrigger;
  final ScenarioActionTrigger? leaveTrigger;
}

class AddButtonAction extends ScenarioAction {
  const AddButtonAction({required this.text, required this.trigger});

  final String text;
  final ScenarioActionTrigger trigger;
}

class AddMultiButtonsAction extends ScenarioAction {
  const AddMultiButtonsAction({required this.actions});

  final List<AddButtonAction> actions;
}



sealed class ScenarioActionTrigger {
  const ScenarioActionTrigger();
}

class ProceedTrigger extends ScenarioActionTrigger {
  const ProceedTrigger({required this.node});

  final String node;
} 

class AppendActionsTrigger extends ScenarioActionTrigger {
  const AppendActionsTrigger({required this.actions});

  final List<ScenarioAction> actions;
}

class EmptyTrigger extends ScenarioActionTrigger {}


final scenario = [
  ScenarioNode(
    id: 'introduction', 
    actions: [
      DisplayTextAction(text: 'Welcome, this is my brand new game. Would you like to play?'),
      DisplayTextAction(text: 'Of course you would, haha. To start click the button below.'),
      AddButtonAction(
        text: 'Click me', 
        trigger: AppendActionsTrigger(
          actions: [
            DisplayTextAction(text: 'Great, you are doing well.'),
            AddButtonAction(
              text: 'Proceed', 
              trigger: ProceedTrigger(node: 'chapter 1')
            )
          ]
        )
      )
    ]
  ),

  ScenarioNode(
    id: 'chapter 1', 
    actions: [
      DisplayTextAction(text: 'I will add a polygon to the map. Let me do this now.'),
      AddPolygonAction(
        polygon: Polygon(
          points: [
            LatLng(52.190727, 20.857727),
            LatLng(52.197257, 20.850770),
            LatLng(52.199115, 20.858575),
            LatLng(52.196711, 20.859618),
          ],
          color: Colors.amber,
          borderColor: Colors.redAccent,
          borderStrokeWidth: 2
        )
      )
    ]
  )
];


// final class TextNode extends ScenarioNode {
//   TextNode({required this.text, required this.next});

//   final String text;
//   final ScenarioNode next;
// }

// final class ChoiceNode extends ScenarioNode {
//   ChoiceNode({required this.text, required this.labelA, required this.labelB, required this.choiceA, required this.choiceB});

//   final String text;
//   final String labelA;
//   final String labelB;
//   final ScenarioNode choiceA;
//   final ScenarioNode choiceB;
// }

// final class PolygonNode extends ScenarioNode {
//   PolygonNode({required this.polygon, this.onEnter, this.onLeave, this.removeOnEnter = true, this.removeOnLeave = false});

//   final Polygon polygon;
//   final ScenarioNode? onEnter;
//   final ScenarioNode? onLeave;
//   final bool removeOnEnter;
//   final bool removeOnLeave;
// }

// class EmptyNode extends ScenarioNode {}

// final winNode = TextNode(
//   text: 'You have won', 
//   next: EmptyNode()
// );

// final addPolygonNode = PolygonNode(
//   polygon: Polygon(
//     points: [
//       LatLng(52.190727, 20.857727),
//       LatLng(52.197257, 20.850770),
//       LatLng(52.199115, 20.858575),
//       LatLng(52.196711, 20.859618),
//     ],
//     color: Colors.amber,
//     borderColor: Colors.redAccent,
//     borderStrokeWidth: 2
//   ),
//   onEnter: winNode
// );

// final choice = ChoiceNode(
//   text: 'Choose wisely',
//   labelA: 'Play',
//   labelB: 'Exit', 
//   choiceA: TextNode(text: 'Okay, let\'s play', next: addPolygonNode), 
//   choiceB: TextNode(text: 'Failure', next: EmptyNode())
// );

// final exampleNode = TextNode(
//   text: 'Hello, welcome to my game',
//   next: choice
// );