import 'package:flutter/material.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

class CatalogListItem extends StatelessWidget {
  const CatalogListItem({super.key, required this.scenario});

  final Scenario scenario;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetailsScreen(scenario: scenario))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 96,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                  child: Image(
                    image: NetworkImage(scenario.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24, 
                      child: Text(scenario.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    SizedBox(
                      height: 40,
                      child: Text(
                        scenario.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LabeledIcon(icon: Icons.location_on, label: scenario.location),
                          Expanded(child: Container()),
                          LabeledIcon(icon: Icons.access_time, label: scenario.duration),
                          SizedBox(width: 8),
                          LabeledIcon(icon: Icons.directions_walk, label: scenario.distance)
                        ],
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}