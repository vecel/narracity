import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/keys.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patrol/patrol.dart';

import 'patrol_extension.dart';

void main() {
  patrolTest(
    'downloads the scenario to local storage',
    ($) async {
      await $.pumpNarracityApp();

      await $(keys.welcomeScreen.letsExploreButton).tap();
      await $(keys.catalogScreen.scenarioItemKey('hello_wut')).tap();
      await $(keys.detailsScreen.saveButton).tap();
      await $(keys.detailsScreen.snackBar).waitUntilVisible();

      final appDirectory = await getApplicationDocumentsDirectory();
      final scenarioDirectory = Directory('${appDirectory.path}/scenarios/hello_wut');

      expect(scenarioDirectory.existsSync(), isTrue);
    }
  );
}