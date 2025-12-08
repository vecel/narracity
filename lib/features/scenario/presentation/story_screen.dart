import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/scenario/domain/node.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final cubit = BlocProvider.of<ScenarioCubit>(context);

    return BlocBuilder<ScenarioCubit, ScenarioState>(
      bloc: cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemCount: state.story.length,
            itemBuilder: (context, index) {
              final item = state.story[index];
              return _buildStoryItem(item, cubit);
            }
          ),
        );
      }
    );
  }

  Widget _buildStoryItem(StoryAction item, ScenarioCubit cubit) {
    return switch (item) {
      DisplayTextAction(:var text) => Text(text),
      AddButtonAction(:var text, :var trigger) => TextButton(
        onPressed: () => cubit.handleTrigger(trigger), 
        child: Text(text)
      ),
      AddMultiButtonsAction(:var actions) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions.map((action) => TextButton(onPressed: () => cubit.handleTrigger(action.trigger), child: Text(action.text))).toList()
      ),
    };
  }
}