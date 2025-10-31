import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/presentation/catalog_list_item.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

void main() {
  testWidgets('ScenarioListItem', (tester) async {
    final title = 'Example';
    final description = 'This is an example scenario'; 
    final location = 'Warsaw';
    final distance = '20km';
    final duration = '5h';

    await tester.pumpWidget(MaterialApp(
      home: CatalogListItem(
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