import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('ScenarioSelectionScreen', (tester) async {
//     final viewModel = ScenarioSelectionViewModel(scenariosRepository: FakeScenariosRepository());

//     await tester.pumpWidget(MaterialApp(
//       home: ScenarioSelectionScreen(viewModel: viewModel)
//     ));

//     final listViewFinder = find.byType(ListView);
//     final itemsFinder = find.descendant(
//       of: listViewFinder,
//       matching: find.byType(ScenarioListItem)
//     );

//     expect(listViewFinder, findsOneWidget);
//     expect(itemsFinder, findsExactly(2));
//   });
// }