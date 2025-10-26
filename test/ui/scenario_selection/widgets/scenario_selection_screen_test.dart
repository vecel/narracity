import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_list_item.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_selection_screen.dart';

import '../../../../testing/fakes/fake_scenarios_repository.dart';

void main() {
  testWidgets('ScenarioSelectionScreen', (tester) async {
    final viewModel = ScenarioSelectionViewModel(scenariosRepository: FakeScenariosRepository());

    await tester.pumpWidget(MaterialApp(
      home: ScenarioSelectionScreen(viewModel: viewModel)
    ));

    final listViewFinder = find.byType(ListView);
    final itemsFinder = find.descendant(
      of: listViewFinder,
      matching: find.byType(ScenarioListItem)
    );

    expect(listViewFinder, findsOneWidget);
    expect(itemsFinder, findsExactly(2));
  });
}