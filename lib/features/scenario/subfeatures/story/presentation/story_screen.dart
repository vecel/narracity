import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_state.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScenarioCubit, ScenarioState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemCount: (state as ScenarioRunning).story.length,
            itemBuilder: (context, index)  => _StoryItem(element: state.story[index])
          ),
        );
      }
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({required this.element});

  final StoryElement element;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScenarioCubit>();

    return switch (element) {
      TextElement(:final text) => Text(text),

      ButtonElement(:final text, :final trigger) => TextButton(
          onPressed: () => cubit.handleTrigger(trigger),
          child: Text(text),
        ),
        
      MultiButtonElement(buttons: final actions) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions.map((action) {
          return TextButton(
            onPressed: () => cubit.handleTrigger(action.trigger),
            child: Text(action.text),
          );
        }).toList(),
      ),
    };
  }
}