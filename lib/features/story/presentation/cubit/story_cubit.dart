import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/map/domain/my_polygon.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/scenario/domain/node.dart';
import 'package:narracity/features/story/domain/progress_item.dart';
import 'package:narracity/features/story/presentation/cubit/story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  
  StoryCubit(ScenarioNode startingNode, MapCubit mapCubit): 
    _mapCubit = mapCubit,
    super(StoryInitial()) {
    _enter(startingNode);
  }

  final MapCubit _mapCubit;
  final List<ProgressItem> _progress = [];

  void _enter(ScenarioNode node) {
    switch (node) {
      case TextNode(): _enterTextNode(node);
      case ChoiceNode(): _enterChoiceNode(node);
      case PolygonNode(): _enterPolygonNode(node);
      case EmptyNode(): {}
    }
    
    emit(StoryReady(_progress));
  }

  void _enterTextNode(TextNode node) {
    _progress.add(TextProgressItem(text: node.text));
    _progress.add(ActionProgressItem(
      onPressed: () {
        _leaveTextNode();
        _enter(node.next);
      })
    );
  }
  
  void _enterChoiceNode(ChoiceNode node) {
    _progress.add(TextProgressItem(text: node.text));
    _progress.add(ChoiceProgressItem(
      labelA: node.labelA, 
      labelB: node.labelB, 
      onChoiceA: () {
        _leaveChoiceNode('You chose option A');
        _enter(node.choiceA);
      }, 
      onChoiceB: () {
        _leaveChoiceNode('You chose option B');
        _enter(node.choiceB);
      })
    );
  }

  void _enterPolygonNode(PolygonNode node) {
    _progress.add(LogProgressItem(text: 'Map was updated'));
    MyPolygon myPolygon = MyPolygon(
      polygon: node.polygon,
      onEnter: () {
        if (node.onEnter != null) {
          _enter(node.onEnter!);
        }
      },
      onLeave: () {
        if (node.onLeave != null) {
          _enter(node.onLeave!);
        }
      }
    );
    _mapCubit.addPolygon(myPolygon);
  }

  void _leaveTextNode() => _progress.removeLast();
  void _leaveChoiceNode(String logMessage) {
    _progress.removeLast();
    _progress.add(LogProgressItem(text: logMessage));
  }

}