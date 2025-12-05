import 'dart:collection';

import 'package:narracity/features/story/domain/progress_item.dart';

sealed class StoryState {}
final class StoryInitial extends StoryState {}
final class StoryReady extends StoryState {
  StoryReady(List<ProgressItem> progress): progress = UnmodifiableListView(progress);
  final UnmodifiableListView<ProgressItem> progress;
}