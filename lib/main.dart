import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/home/welcome_screen.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
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

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => ScenariosRepository()),
      RepositoryProvider(create: (context) => LocationService())
    ],
    child: const MyApp(),
  ));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
    GoRoute(path: '/catalog', builder: (context, state) => CatalogScreen()),
    GoRoute(path: '/details/:id', builder: (context, state) => DetailsScreen(id: state.pathParameters['id']!)),
    GoRoute(path: '/scenario/:id', builder: (context, state) => ScenarioScreen(id: state.pathParameters['id']!)),
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Narracity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(30, 170, 200, 1))
      ),
    );
  }
}