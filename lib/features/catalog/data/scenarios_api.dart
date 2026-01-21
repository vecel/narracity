import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Scenario>> getScenarios() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }

    final snapshot = await _firestore.collection('scenarios').get();
    
    return snapshot.docs.map((doc) => Scenario.fromJson(doc.data())).toList();
  }

  Future<Scenario?> getScenarioById(String id) async {
    final snapshot = await _firestore.collection('scenarios').doc(id).get();
    if (snapshot.exists) {
      final data = snapshot.data();
      return Scenario.fromJson(data!);
    }
    return null;
  }

}