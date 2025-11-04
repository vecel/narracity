import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/scenario/domain/node.dart';
import 'package:narracity/features/story/domain/progress_item.dart';
import 'package:narracity/features/story/presentation/view_model/story_view_model.dart';

class ScenarioViewModel extends ChangeNotifier {

  static final Logger log = Logger('ScenarioViewModel');

  ScenarioViewModel({required this.title, required this.node}): storyViewModel = StoryViewModel() {
    _enter(node);
  }
  
  final StoryViewModel storyViewModel;
  final String title;

  final List<ProgressItem> progress = [];
  ScenarioNode node;

  int selectedPageIndex = 0;
  bool storyPageNotification = false;
  bool mapPageNotification = false;

  void _enter(ScenarioNode node) {
    switch (node) {
      case TextNode(:var text, :var next): {
        progress.add(TextProgressItem(text: text));
        progress.add(ProceedProgressItem(
          onPressed: () {
            _leave(node);
            _enter(next);
          })
        );
      }
      case ChoiceNode(:var text, :var labelA, :var labelB, :var choiceA, :var choiceB): {
        progress.add(TextProgressItem(text: text));
        progress.add(ChoiceProgressItem(
          labelA: labelA, 
          labelB: labelB, 
          onChoiceA: () {
            _leave(node);
            _enter(choiceA);
            // storyViewModel.addProgressItem(LogProgressItem(text: 'This is log A')); Move to _leave()
          }, 
          onChoiceB: () {
            _leave(node);
            _enter(choiceB);
          })
        );
      }
      case EmptyNode(): {}
    }
    storyViewModel.progress = progress;
  }

  void _leave(ScenarioNode node) {
    switch (node) {
      case TextNode(): progress.removeLast();
      case ChoiceNode(): {
        progress.removeLast();
        progress.add(LogProgressItem(text: 'TODO'));
      }
      case EmptyNode(): {}
    }
  }

  void selectPage(int index) {
    selectedPageIndex = index;
    switch (index) {
      case 0: _onStoryPageSelected();
      case 1: _onMapPageSelected();
      default: throw Exception('Invalid index selected');
    }
    notifyListeners();
  }

  void _onStoryPageSelected() => storyPageNotification = false;
  void _onMapPageSelected() => mapPageNotification = false;

}