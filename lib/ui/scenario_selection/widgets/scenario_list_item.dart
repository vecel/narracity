import 'package:narracity/ui/core/ui/labeled_icon.dart';
import 'package:flutter/material.dart';

class ScenarioListItem extends StatelessWidget {
  const ScenarioListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 96),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(96, 96)),
            child: Image(
              image: AssetImage('assets/cat.webp'),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text('Lorem ipsum dolor set amet dis ans duz equat los dew on')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LabeledIcon(icon: Icons.location_on, label: 'Warszawa'),
                    LabeledIcon(icon: Icons.access_time, label: '30 min'),
                    LabeledIcon(icon: Icons.directions_walk, label: '2 km')
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }
}