import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:narracity/features/catalog/data/scenarios_api.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

import '../../../utils/test_factory.dart';

void main() {
  late ScenariosApi api;
  late FakeFirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockAuth;
  late Scenario mockScenario;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockScenario = TestFactory.createMockScenario();

    api = ScenariosApi(firestore: fakeFirestore, auth: mockAuth);
  });

  group('ScenariosApi', () {
    test('returns scenario when it exists', () async {
      await fakeFirestore
        .collection('scenarios')
        .doc(mockScenario.id)
        .set(mockScenario.toJson());

      final result = await api.loadAll();

      expect(result.length, 1);
      expect(result.first.title, mockScenario.title);
      expect(result.first.id, isNotEmpty);
    });

    test('returns scenario with given id', () async {
      final id = 'other';
      final otherScenario = TestFactory.createMockScenario(id: id);

      await fakeFirestore.collection('scenarios')
        .doc(mockScenario.id)
        .set(mockScenario.toJson());
      await fakeFirestore.collection('scenarios')
        .doc(otherScenario.id)
        .set(otherScenario.toJson());

      final result = await api.load(id);

      expect(result, isNotNull);
      expect(result!.id, id);
    });

    test('returns empty list when database is empty', () async {
      final result = await api.loadAll();

      expect(result, isNotNull);
      expect(result.length, 0);
    });

    test('returns null when there is no scenario with given id', () async {
      await fakeFirestore.collection('scenarios')
        .doc(mockScenario.id)
        .set(mockScenario.toJson());

      final result = await api.load('not_id');

      expect(result, isNull);
    });

  });
}