import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

// This is utility class used nowhere in production, but I was using it to
// upload scenario written as dart file to database
class ScenariosUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _log = Logger('ScenariosUploader');

  Future<void> uploadScenario(Scenario scenario) async {
    _log.info('Starting upload for scenario: ${scenario.id}');

    final scenarioRef = _firestore.collection('scenarios').doc(scenario.id);
    final nodesCollection = scenarioRef.collection('nodes');

    WriteBatch batch = _firestore.batch();
    int operationCount = 0;

    final scenarioJson = scenario.toJson();

    batch.set(scenarioRef, scenarioJson);
    operationCount++;

    for (final node in scenario.nodes) {
      final nodeRef = nodesCollection.doc(node.id);
      final json = node.toJson();
      
      batch.set(nodeRef, json);
      operationCount++;

      if (operationCount >= 499) {
        await batch.commit();
        batch = _firestore.batch();
        operationCount = 0;
        _log.fine('Committed intermediate batch of nodes...');
      }
    }

    await batch.commit();
    _log.info('Successfully uploaded scenario ${scenario.id} with ${scenario.nodes.length} nodes.');
  }
}