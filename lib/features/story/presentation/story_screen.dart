import 'package:flutter/material.dart';
import 'package:narracity/features/story/presentation/progress_widget_factory.dart';
import 'package:narracity/features/story/presentation/view_model/story_view_model.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key, required this.viewModel});

  final StoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemCount: viewModel.progress.length,
          itemBuilder: (context, index) {
            final item = viewModel.progress[index];
            return ProgressWidgetFactory.create(item);
          }
        ),
      ),
    );
  }
}