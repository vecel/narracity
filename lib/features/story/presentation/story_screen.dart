import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/story/domain/progress_item.dart';
import 'package:narracity/features/story/presentation/cubit/story_cubit.dart';
import 'package:narracity/features/story/presentation/cubit/story_state.dart';
import 'package:narracity/features/story/presentation/progress_widget_factory.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<StoryCubit>(context);

    return BlocBuilder<StoryCubit, StoryState>(
      bloc: cubit,
      builder: (context, state) {
        switch (state) {
          case StoryInitial():
            return _buildLoadingScreen();
          case StoryReady(:var progress):
            return _buildStoryScreen(progress);
        }
        
      }
    );
  }

  Widget _buildLoadingScreen() {
    return CircularProgressIndicator();
  }

  Widget _buildStoryScreen(List<ProgressItem> progress) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: progress.length,
        itemBuilder: (context, index) {
          final item = progress[index];
          return ProgressWidgetFactory.create(item);
        }
      ),
    );
  }
}