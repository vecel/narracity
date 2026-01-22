import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenarioLoader extends StatelessWidget {
  const ScenarioLoader({super.key, required this.id, required this.builder});

  final String id;
  final Widget Function(Scenario scenario) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ScenariosRepository>().load(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        }
        if (snapshot.hasError) {
          // TODO: Add Error page
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}