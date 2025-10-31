import 'package:narracity/features/catalog/view_model/catalog_view_model.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

import 'details_screen.dart';
import 'catalog_list_item.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.viewModel});

  final CatalogViewModel viewModel;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: BaseAppBar(title: 'Choose Scenario'),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: ListView.builder(
        itemCount: viewModel.scenarios.length,
        itemBuilder: (context, index) {
          final scenario = viewModel.scenarios[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => DetailsScreen(scenario: scenario))
            ),
            child: CatalogListItem(
              title: scenario.title,
              description: scenario.description,
              distance: scenario.distance,
              duration: scenario.duration,
              location: scenario.location,
            )
          );
        }
      )
    );
  }
}