import 'package:flutter/material.dart';

enum LabeledIconOrientation { horizontal, vertical }

class LabeledIcon extends StatelessWidget {
  const LabeledIcon({
    super.key, 
    required this.icon, 
    required this.label, 
    this.orientation = LabeledIconOrientation.vertical
  });

  final IconData icon;
  final String label;
  final LabeledIconOrientation orientation;

  @override
  Widget build(BuildContext context) {
    final children = [
      Icon(icon),
      Text(label, style: TextStyle(fontSize: 12))
    ];
    
    return orientation == LabeledIconOrientation.vertical 
      ? Column(children: children)
      : Row(children: children);
  }
}