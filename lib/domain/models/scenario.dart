import 'package:narracity/domain/models/node.dart';

class Scenario {

  Scenario({
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.distance,
    required this.duration,
    required this.startNode
  });

  final String title;
  final String description;
  final String image;
  final String location;
  final String distance;
  final String duration;
  final ScenarioNode startNode;
}
