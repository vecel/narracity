import 'package:flutter/material.dart';

class LabeledIcon extends StatelessWidget {
  const LabeledIcon({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(label, style: TextStyle(fontSize: 12))
      ],
    );
  }
}