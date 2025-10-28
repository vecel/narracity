import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/ui/core/ui/labeled_icon.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_list_item.dart';

void main() {
  testWidgets('ScenarioListItem', (tester) async {
    final title = 'Example';
    final description = 'This is an example scenario'; 
    final location = 'Warsaw';
    final distance = '20km';
    final duration = '5h';

    await tester.pumpWidget(MaterialApp(
      home: ScenarioListItem(
        title: title,
        description: description,
        distance: distance,
        duration: duration,
        location: location,
      )
    ));

    expect(find.text(title), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(LabeledIcon), findsExactly(3));
    expect(find.text(distance), findsOneWidget);
    expect(find.text(duration), findsOneWidget);
    expect(find.text(location), findsOneWidget);
  });
}