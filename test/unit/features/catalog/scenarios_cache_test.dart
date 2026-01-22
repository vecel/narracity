import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/data/scenarios_cache.dart';

import '../../../utils/test_factory.dart';

void main() {
  late ScenariosCache cache;

  setUp(() {
    cache = ScenariosCache();
  });

  group('ScenariosCache', () {
    test('starts empty', () {
      expect(cache.loadAll(), isEmpty);
    });

    test('stores a scenario successfully', () {
      final scenario = TestFactory.createMockScenario();
      
      cache.save(scenario);

      expect(cache.contains(scenario.id), isTrue);
    });

    test('does not overwrite scenario with existing ID', () {
      final original = TestFactory.createMockScenario(id: 'id', title: 'original');
      final replacement = TestFactory.createMockScenario(id: 'id', title: 'replacement');
      
      cache.save(original);
      cache.save(replacement);

      final loaded = cache.load('id');
      
      expect(loaded, isNotNull);
      expect(loaded!.title, 'original');
      expect(loaded, same(original)); 
      expect(loaded, isNot(same(replacement)));
    });

    test('returns null for non-existing ID', () {      
      final result = cache.load('not_id');

      expect(result, isNull);
    });

    test('returns all saved scenarios', () {
      final s1 = TestFactory.createMockScenario(id: '1');
      final s2 = TestFactory.createMockScenario(id: '2');
      final s3 = TestFactory.createMockScenario(id: '3');

      cache.save(s1);
      cache.save(s2);
      cache.save(s3);

      final result = cache.loadAll();

      expect(result.length, 3);
      expect(result, containsAll([s1, s2, s3]));
    });

    test('contains method returns true only if ID exists', () {
      final scenario = TestFactory.createMockScenario(id: 'id');

      cache.save(scenario);

      expect(cache.contains('id'), isTrue);
      expect(cache.contains('not_id'), isFalse);
    });
  });
}