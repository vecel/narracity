import 'package:flutter/material.dart';
import 'package:narracity/features/story/domain/progress_item.dart';

class ProgressWidgetFactory {
  static Widget create(ProgressItem node) {
    return switch(node) {
      TextProgressItem(:var text) => Text(text),
      LogProgressItem(:var text) => Text(text, style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey)), // TODO use theme
      ProceedProgressItem(:var onPressed) => TextButton(onPressed: onPressed, child: Text('Next')),
      ChoiceProgressItem(:var labelA, :var labelB, :var onChoiceA, :var onChoiceB) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onChoiceA, child: Text(labelA)),
          SizedBox(width: 16),
          TextButton(onPressed: onChoiceB, child: Text(labelB))
        ],
      ),
    };
  }
}