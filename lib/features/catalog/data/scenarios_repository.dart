import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosRepository {
  ScenariosRepository() {
    // TODO remove
    // _scenarios
    //   ..add(exampleScenario)
    //   ..add(exampleScenario);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Scenario>> getScenarios() async {

    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }

    final snapshot = await _firestore.collection('scenarios').get();
    return snapshot.docs.map((doc) => Scenario.fromFirestore(doc)).toList();
  }

  // final List<Scenario> _scenarios = List.empty(growable: true);

  // List<Scenario> get scenarios => _scenarios;
  
}