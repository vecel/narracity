import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/map/presentation/map_screen.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/presentation/cubit/geofence_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/navigation_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/navigation_bar.dart';
import 'package:narracity/features/scenario/presentation/story_screen.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key, required this.scenario});

  final List<ScenarioNode> scenario;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => ScenarioCubit(scenario)),
        BlocProvider(create: (context) => MapCubit()),
        BlocProvider(
          lazy: false,
          create: (context) => GeofenceCubit(
            scenarioCubit: context.read<ScenarioCubit>(), 
            mapCubit: context.read<MapCubit>()
          )
        )
      ],
      child: _ScenarioScreenLayout()
    );
  }
}

class _ScenarioScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) => Scaffold(
        appBar: BaseAppBar(title: 'TODO'),
        bottomNavigationBar: ScenarioNavigationBar(
          index: state,
          selectPage: context.read<NavigationCubit>().selectPage,
          storyNotification: false,
          mapNotification: false,
          journalNotification: false,
        ),
        body: [
          StoryScreen(),
          MapScreen(),
          Center(child: Text('Journal')),
        ][state],
      ),
    );
  }
}