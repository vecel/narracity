import 'package:flutter/material.dart';
import 'package:narracity/features/story/presentation/view_model/story_view_model.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key, required this.viewModel});

  final StoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Progress Screen'));
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ListView.separated(
    //     separatorBuilder: (context, index) => SizedBox(height: 8),
    //     itemCount: viewModel.scenarioProgress.length + 1,
    //     itemBuilder: (context, index) {
    //       if (index == viewModel.scenarioProgress.length) {
    //         return NodeWidgetFactory.createActionWidget(viewModel.scenarioProgress.last, viewModel.proceed);
    //       }
    //       final node = viewModel.scenarioProgress[index];
    //       return NodeWidgetFactory.create(node);
    //     }
    //   ),
    // );
  }
}