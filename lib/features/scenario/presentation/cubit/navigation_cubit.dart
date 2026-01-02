import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationState {
  const NavigationState(this.index, this.storyNotification, this.mapNotification);

  factory NavigationState.initial() => const NavigationState(0, false, false);

  final int index;
  final bool storyNotification;
  final bool mapNotification;

  NavigationState copyWith({
    int? index,
    bool? storyNotification,
    bool? mapNotification,
  }) {
    return NavigationState(
      index ?? this.index,
      storyNotification ?? this.storyNotification,
      mapNotification ?? this.mapNotification,
    );
  }
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(): super(NavigationState.initial());

  void selectPage(int index) {
    switch (index) {
      case 0: emit(state.copyWith(index: index, storyNotification: false));
      case 1: emit(state.copyWith(index: index, mapNotification: false));
      default: throw Exception('Invalid navigation index selected');
    }
  }

  void addStoryNotification() {
    emit(state.copyWith(storyNotification: true));
  }

  void addMapNotification() {
    emit(state.copyWith(mapNotification: true));
  }
}