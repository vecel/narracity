import 'package:flutter/material.dart';

class ScenarioPageDestination extends StatelessWidget {
  const ScenarioPageDestination({super.key, required this.icon, required this.label, required this.notification, this.enabled = true});

  final IconData icon;
  final String label;
  final bool notification;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: notification ? Badge(child: Icon(icon)) : Icon(icon),
      enabled: enabled,
      label: label
    );
  }
}