import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/scenario/subfeatures/map/services/location_service.dart';
import 'package:narracity/firebase_options.dart';
import 'package:narracity/keys.dart';
import 'package:narracity/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest(
    'navigates to scenario screen - map tab, turns on location service and grants permission',
    ($) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
      );

      await $.pumpWidgetAndSettle(MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ScenariosRepository()),
          RepositoryProvider(create: (context) => LocationService())
        ],
        child: const MyApp(),
      ));

      await $(keys.welcomeScreen.letsExploreButton).tap();
      await $(keys.catalogScreen.scenarioItemKey('hello_wut')).tap();
      await $(keys.detailsScreen.playScenarioKey('hello_wut')).tap();
      await $(keys.scenarioScreen.mapTab).tap();

      await $.platform.android.grantPermissionOnlyThisTime();
      
    },
  );
}