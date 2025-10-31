import 'dart:developer' as developer;

import 'ui/welcome_screen/widgets/welcome_screen.dart';
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
      title: 'Narracity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(30, 170, 200, 1))
      ),
      home: WelcomeScreen()
    );
  }
}