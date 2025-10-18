import 'dart:developer' as developer;

import 'package:city_games/ui/welcome_screen/widgets/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    developer.log('[${record.level.name}] [${record.time}]: ${record.message}', name: record.loggerName);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Games',
      home: Scaffold(
        body: WelcomeScreen(),
      )
    );
  }
}