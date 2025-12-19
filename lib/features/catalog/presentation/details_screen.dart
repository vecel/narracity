import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/scenario.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          // TODO: Change exampleScenario to dynamic one
          MaterialPageRoute(builder: (context) => ScenarioScreen(scenario: exampleScenario))
        ),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: const Icon(Icons.play_arrow, size: 32),
      ),
      body: Stack(
        children: [
          _buildBackgroudImage(),
          _buildBottomSheet(context),
          _buildBottomBlur()
        ],
      )
    );
  }

  Widget _buildBackgroudImage() {
    return Positioned.fill(
      child: Column(
        children: [
          SizedBox(
            height: 320,
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

  Widget _buildBottomSheet(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: SafeArea(
        child: Container(
          height: 420,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, -4)
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            child: Text(scenario.description * 2),
          ),
        )
      ),
    );
  }

  Widget _buildBottomBlur() {
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
                    Colors.white.withAlpha(0),
                    Colors.white.withAlpha(60),
                    Colors.white.withAlpha(250)
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