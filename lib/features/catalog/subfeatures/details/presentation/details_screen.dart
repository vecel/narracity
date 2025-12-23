import 'package:flutter/material.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/background_image.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_sheet.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_blur.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/content.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          // TODO: Change exampleScenario to dynamic one
          MaterialPageRoute(builder: (context) => ScenarioScreen(scenario: exampleScenario.nodes))
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: CircleBorder(),
        child: const Icon(Icons.play_arrow, size: 32),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          return switch (height) {
            > 540 => _VerticalLayout(scenario, height),
            _ => _HorizontalLayout(scenario)
          };
        },
      )
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout(this.scenario, this.height);

  final Scenario scenario;
  final double height;

  @override
  Widget build(BuildContext context) {
    final imageHeight = height / 3 + 16;
    final bottomSheetHeight = height / 3 * 2;

    return Stack(
      children: [
        DetailsBackgroundImage(scenario.image, imageHeight),
        DetailsBottomSheet(DetailsScreenContent(scenario), bottomSheetHeight),
        DetailsBottomBlur()
      ],
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout(this.scenario);

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DetailsScreenContent(scenario),
        DetailsBottomBlur()
      ],
    );
  }
}