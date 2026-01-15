import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/background_image.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_sheet.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/bottom_blur.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/content.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/scenario_loader.dart';

// TODO: Wyswietlaj dopiero po zaladowaniu zdjecia

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {

    return ScenarioLoader(
      id: id,
      builder: (scenario) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _FloatingActionButton(id),
        body: _DetailsView(scenario)
      ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView(this.scenario);

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return switch (height) {
          > 540 => _VerticalLayout(scenario, height),
          _ => _HorizontalLayout(scenario)
        };
      },
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton(this.id);

  final String id;
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.go('/scenario/$id'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: CircleBorder(),
      child: const Icon(Icons.play_arrow, size: 32),
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