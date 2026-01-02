import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/home/welcome_screen.dart';
import 'package:narracity/firebase_options.dart';

void main() async {

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    developer.log('[${record.level.name}] [${record.time}]: ${record.message}', name: record.loggerName);
  });

  // TODO: Uncomment for production
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform
  // );

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