import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_screen.dart';
import 'package:narracity/features/scenario/presentation/cubit/geofence_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/navigation_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/navigation_bar.dart';
import 'package:narracity/features/scenario/subfeatures/story/presentation/story_screen.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';
import 'package:narracity/shared_widgets/scenario_loader.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {

    return ScenarioLoader(
      id: id,
      builder: (scenario) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavigationCubit()),
          BlocProvider(create: (context) => MapCubit()),
          BlocProvider(create: (context) => ScenarioCubit(
            scenario: scenario.nodes,
            navigationCubit: context.read<NavigationCubit>()
          )),
          BlocProvider(
            lazy: false,
            create: (context) => GeofenceCubit(
              scenarioCubit: context.read<ScenarioCubit>(), 
              mapCubit: context.read<MapCubit>()
            )
          )
        ],
        child: BlocListener<ScenarioCubit, ScenarioState>(
          listener: (context, state) {
            if (state is ScenarioFinished) {
              context.go('/details/$id');
            }
          },
          child: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) => Scaffold(
              appBar: BaseAppBar(title: scenario.title, backRoute: '/details/$id'),
              bottomNavigationBar: ScenarioNavigationBar(
                index: state.index,
                selectPage: (index) => context.read<NavigationCubit>().selectPage(index),
                storyNotification: state.storyNotification,
                mapNotification: state.mapNotification,
                journalNotification: false,
              ),
              body: [
                StoryScreen(),
                MapScreen(),
                Center(child: Text('Journal')),
              ][state.index],
            ),
          )
        )
      ),
    );
  }
}

// class _ScenarioScreenView extends StatelessWidget {
//   const _ScenarioScreenView(this.title);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NavigationCubit, NavigationState>(
//       builder: (context, state) => Scaffold(
//         appBar: BaseAppBar(title: title, backRoute: '/details/$id'),
//         bottomNavigationBar: ScenarioNavigationBar(
//           index: state.index,
//           selectPage: (index) => context.read<NavigationCubit>().selectPage(index),
//           storyNotification: state.storyNotification,
//           mapNotification: state.mapNotification,
//           journalNotification: false,
//         ),
//         body: [
//           StoryScreen(),
//           MapScreen(),
//           Center(child: Text('Journal')),
//         ][state.index],
//       ),
//     );
//   }
// }