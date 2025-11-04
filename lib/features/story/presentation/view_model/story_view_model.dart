import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:narracity/features/story/domain/progress_item.dart';

class StoryViewModel extends ChangeNotifier {
  
  List<ProgressItem> _progress = [];

  UnmodifiableListView<ProgressItem> get progress => UnmodifiableListView(_progress);
  set progress(List<ProgressItem> progress) {
    _progress = progress;
    notifyListeners();
  }
}