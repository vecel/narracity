import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

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
            > 540 => _buildVerticalLayout(context, height),
            _ => _buildHorizontalLayout(context, height)
          };
        },
      )
    );
  }

  Widget _buildVerticalLayout(BuildContext context, double height) {
    final imageHeight = height / 3 + 16;
    final bottomSheetHeight = height / 3 * 2;
    return Stack(
      children: [
        _buildBackgroudImage(imageHeight),
        _buildBottomSheet(context, bottomSheetHeight),
        _buildBottomBlur(context)
      ],
    );
  }

  Widget _buildHorizontalLayout(BuildContext context, double height) {
    return Stack(
      children: [
        _detailsScreenContent(context),
        _buildBottomBlur(context)
      ],
    );
  }

  Widget _buildBackgroudImage(double height) {
    return Positioned.fill(
      child: Column(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: Image(
              image: AssetImage(scenario.image), 
              fit: BoxFit.cover
            )
          ),
          Expanded(child: Container())
        ],
      )
    );
  }

  Widget _buildBottomSheet(BuildContext context, double height) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: SafeArea(
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, -4)
              )
            ]
          ),
          child: _detailsScreenContent(context)
        )
      ),
    );
  }

  Widget _detailsScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: Icon(Icons.arrow_back)
              ),
              SizedBox(width: 8),
              Text(
                scenario.title,
                style: TextStyle(fontSize: 24),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.more_vert)
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Container()),
              LabeledIcon(icon: Icons.location_on, label: scenario.location),
              SizedBox(width: 64),
              LabeledIcon(icon: Icons.access_time, label: scenario.duration),
              SizedBox(width: 64),
              LabeledIcon(icon: Icons.directions_walk, label: scenario.distance),
              Expanded(child: Container())
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                Text(
                  scenario.description,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 56)
              ]
            ),
          ),
        ],
      )
    );
  }

  Widget _buildBottomBlur(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.6),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    surface.withAlpha(0),
                    surface.withAlpha(60),
                    surface.withAlpha(250)
                  ],
                  stops: [0.0, 0.5, 1.0]
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _DetailsScreenVerticalLayout extends StatelessWidget {

//   const _DetailsScreenVerticalLayout(this.height);

//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [

//       ],
//     );
//   }

  
// }