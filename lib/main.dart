import 'dart:developer' as developer;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:narracity/example.dart';
import 'package:narracity/features/catalog/data/scenarios_api.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/features/scenario/domain/dsl_triggers.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:narracity/firebase_options.dart';
import 'package:narracity/routes.dart';

class MockScenariosApi extends Mock implements ScenariosApi {}

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

  final mockApi = MockScenariosApi();
  when(() => mockApi.getScenarios()).thenAnswer((_) async => Future.value([warsawUniversityOfTechnologyScenario]));

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => ScenariosRepository(
        api: Platform.isLinux ? mockApi : null,
      )),
      RepositoryProvider(create: (context) => LocationService())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Narracity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(30, 170, 200, 1))
      ),
    );
  }
}
