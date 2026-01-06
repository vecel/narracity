import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narracity/example.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class ScenariosRepository {
  // TODO: Uncomment for firestore database usage
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<List<Scenario>> getScenarios() async {

  //   if (_auth.currentUser == null) {
  //     await _auth.signInAnonymously();
  //   }

  //   final snapshot = await _firestore.collection('scenarios').get();
  //   return snapshot.docs.map((doc) => Scenario.fromFirestore(doc)).toList();
  // }

  // For Linux development purposes
  Future<List<Scenario>> getScenarios() async {
    return Future.value(List.of([warsawUniversityOfTechnologyScenario]));
  }
  
  
}