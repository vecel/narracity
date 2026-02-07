
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/keys.dart';
import 'package:patrol/patrol.dart';

import 'patrol_extension.dart';

void main() {
  patrolTest(
    'navigates to scenario screen - map tab, turns on location service and grants permission',
    ($) async {
      await $.pumpNarracityApp();

      await $(keys.welcomeScreen.letsExploreButton).tap();
      await $(keys.catalogScreen.scenarioItemKey('hello_wut')).tap();
      await $(keys.detailsScreen.playScenarioKey('hello_wut')).tap();
      await $(keys.scenarioScreen.mapTab).tap();

      await $.platform.android.grantPermissionOnlyThisTime();

      await $.pumpAndSettle();
      expect(find.byKey(keys.mapScreen.mapWidget), findsOneWidget);
      
    },
  );
}