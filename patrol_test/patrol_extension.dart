import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:narracity/firebase_options.dart';
import 'package:narracity/main.dart';
import 'package:patrol/patrol.dart';

extension ApplicationPump on PatrolIntegrationTester {
  Future<void> pumpNarracityApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    await pumpWidgetAndSettle(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ScenariosRepository()),
        RepositoryProvider(create: (context) => LocationService())
      ],
      child: const MyApp(),
    ));
  }
}