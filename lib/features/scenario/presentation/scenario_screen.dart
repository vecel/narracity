import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/map/presentation/map_screen.dart';
import 'package:narracity/features/scenario/presentation/navigation_bar.dart';
import 'package:narracity/features/story/presentation/story_screen.dart';
import 'package:narracity/features/scenario/presentation/view_model/scenario_view_model.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

class ScenarioScreen extends StatelessWidget {
  const ScenarioScreen({super.key, required this.viewModel});

  final ScenarioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) => Scaffold(
          appBar: BaseAppBar(title: 'TODO'),
          bottomNavigationBar: ScenarioNavigationBar(
            index: viewModel.selectedPageIndex,
            selectPage: viewModel.selectPage,
            storyNotification: viewModel.storyPageNotification,
            mapNotification: viewModel.mapPageNotification,
            journalNotification: false,
          ),
          body: [
            StoryScreen(viewModel: viewModel.storyViewModel),
            MapScreen(),
            Center(child: Text('Journal')),
          ][viewModel.selectedPageIndex],
        )
      ),
    );
  }
}