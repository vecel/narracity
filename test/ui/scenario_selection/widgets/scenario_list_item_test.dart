import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/domain/models/node.dart';
import 'package:narracity/domain/models/scenario.dart';
import 'package:narracity/ui/core/ui/labeled_icon.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_list_item.dart';

void main() {
  testWidgets('ScenarioListItem', (tester) async {
    final scenario = Scenario(
      title: 'Example', 
      description: 'This is an example scenario', 
      image: '', 
      location: 'Warsaw', 
      distance: '20km', 
      duration: '5h', 
      startNode: EmptyNode()
    );

    await tester.pumpWidget(MaterialApp(
      home: ScenarioListItem(scenario: scenario)
    ));

    expect(find.text(scenario.title), findsOneWidget);
    expect(find.text(scenario.description), findsOneWidget);
    expect(find.byType(LabeledIcon), findsExactly(3));

  });
}