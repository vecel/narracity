import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosApi {
  ScenariosApi({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth
  }) : 
    _firestore = firestore ?? FirebaseFirestore.instance,
    _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<List<Scenario>> getScenarios() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }

    final snapshot = await _firestore.collection('scenarios').get();
    final futures = snapshot.docs.map((doc) async {
      final data = doc.data();
      final nodesSnapshot = await doc.reference.collection('nodes').get();
      final nodes = nodesSnapshot.docs.map((nodeDoc) => ScenarioNode.fromJson(nodeDoc.data())).toList();
      return Scenario.fromJson(data, nodes);
    });
    
    return Future.wait(futures);
  }

  Future<Scenario?> getScenarioById(String id) async {
    final snapshot = await _firestore.collection('scenarios').doc(id).get();
    if (snapshot.exists) {
      final data = snapshot.data();
      // return Scenario.fromJson(data!);
      return null; // TODO: !!!!
    }
    return null;
  }

}