import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/scenario/subfeatures/map/presentation/map_screen.dart';
import 'package:narracity/features/scenario/presentation/cubit/geofence_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/navigation_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/navigation_bar.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
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
          BlocProvider(create: (context) => MapCubit(
            locationService: context.read<LocationService>()
          )),
          BlocProvider(create: (context) => ScenarioCubit(
            scenario: scenario,
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
        child: MultiBlocListener(
          listeners: [
            BlocListener<ScenarioCubit, ScenarioState>(
              listener: (context, state) {
                if (state is ScenarioFinished) {
                  context.go('/details/$id');
                }
              }
            ),
            BlocListener<NavigationCubit, NavigationState>(
              listenWhen: (previous, current) {
                return previous.index != current.index && current.index == 1;
              },
              listener: (context, state) {
                final mapCubit = context.read<MapCubit>();
                if (mapCubit.state is MapInitial) {
                  mapCubit.askForPermission();
                }
              },
            )
          ], 
          child: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) => Scaffold(
              appBar: _ScenarioAppBar(scenario.title, scenario.id),
              bottomNavigationBar: _ScenarioNavBar(state: state),
              body: _ScenarioBody(tabIndex: state.index)
            )
          )
        )
      ),
    );
  }
}

class _ScenarioAppBar extends BaseAppBar {
  const _ScenarioAppBar(String title, String id) 
    : super(title: title, backRoute: '/details/$id');
}

class _ScenarioNavBar extends StatelessWidget {
  const _ScenarioNavBar({required this.state});

  final NavigationState state;

  @override
  Widget build(BuildContext context) {
    return ScenarioNavigationBar(
      index: state.index,
      selectPage: (index) => context.read<NavigationCubit>().selectPage(index),
      storyNotification: state.storyNotification,
      mapNotification: state.mapNotification,
      journalNotification: false,
    );
  }
}

class _ScenarioBody extends StatelessWidget {
  const _ScenarioBody({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScenarioCubit, ScenarioState>(
      builder: (context, state) => switch(state) {
        ScenarioRunning() => _SuccessView(tabIndex: tabIndex),
        ScenarioError(:final message) => _ErrorView(message: message),
        ScenarioFinished() => _ErrorView(message: 'Something went wrong, go back to details screen')
      },
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: tabIndex,
      children: const [
        StoryScreen(),
        MapScreen(),
        Center(child: Text('Journal')),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}