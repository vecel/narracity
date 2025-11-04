import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/presentation/catalog_list_item.dart';
import 'package:narracity/shared_widgets/labeled_icon.dart';

void main() {
  group('CatalogListItem Widget Tests', () {
    const testTitle = 'Mystery in Old Town';
    const testDescription = 'Solve a centuries-old mystery while exploring the historic streets of the old town';
    const testLocation = 'Warsaw';
    const testDistance = '15km';
    const testDuration = '3h';

    testWidgets('should display all required text elements', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: testTitle,
            description: testDescription,
            distance: testDistance,
            duration: testDuration,
            location: testLocation,
          ),
        ),
      ));

      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testDescription), findsOneWidget);
      expect(find.text(testDistance), findsOneWidget);
      expect(find.text(testDuration), findsOneWidget);
      expect(find.text(testLocation), findsOneWidget);
    });

    testWidgets('should display exactly three labeled icons', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: testTitle,
            description: testDescription,
            distance: testDistance,
            duration: testDuration,
            location: testLocation,
          ),
        ),
      ));

      expect(find.byType(LabeledIcon), findsExactly(3));
    });

    testWidgets('should handle empty strings gracefully', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: '',
            description: '',
            distance: '',
            duration: '',
            location: '',
          ),
        ),
      ));

      expect(find.byType(CatalogListItem), findsOneWidget);
      expect(find.byType(LabeledIcon), findsExactly(3));
    });

    testWidgets('should handle long text content', (tester) async {
      const longTitle = 'This is a very long scenario title that might overflow in certain screen sizes';
      const longDescription = 'This is an extremely long description that contains a lot of details about the scenario and might need to be truncated or wrapped properly to avoid layout issues in the user interface';
      const longLocation = 'Very Long Location Name That Might Overflow';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: longTitle,
            description: longDescription,
            distance: testDistance,
            duration: testDuration,
            location: longLocation,
          ),
        ),
      ));

      expect(find.text(longTitle), findsOneWidget);
      // TODO check for ... character and beggining of description
      // expect(find.text(longDescription.substring(0, 20)), findsOne);
      // expect(find.text('...'), findsOne);
      expect(find.text(longLocation), findsOneWidget);
      expect(find.byType(LabeledIcon), findsExactly(3));
    });

    testWidgets('should be tappable and respond to tap gestures', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GestureDetector(
            onTap: () => tapped = true,
            child: CatalogListItem(
              title: testTitle,
              description: testDescription,
              distance: testDistance,
              duration: testDuration,
              location: testLocation,
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(CatalogListItem));
      expect(tapped, isTrue);
    });

    // testWidgets('should handle different screen sizes', (tester) async {
    //   // Test with small screen size
    //   tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    //   tester.binding.window.devicePixelRatioTestValue = 1.0;

    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       body: CatalogListItem(
    //         title: testTitle,
    //         description: testDescription,
    //         distance: testDistance,
    //         duration: testDuration,
    //         location: testLocation,
    //       ),
    //     ),
    //   ));

    //   expect(find.byType(CatalogListItem), findsOneWidget);
    //   expect(find.text(testTitle), findsOneWidget);

    //   // Reset to default size
    //   addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    // });

    testWidgets('should display icons with proper labels', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: testTitle,
            description: testDescription,
            distance: testDistance,
            duration: testDuration,
            location: testLocation,
          ),
        ),
      ));

      final labeledIcons = find.byType(LabeledIcon);
      expect(labeledIcons, findsExactly(3));

      expect(find.text(testDistance), findsOneWidget);
      expect(find.text(testDuration), findsOneWidget);
      expect(find.text(testLocation), findsOneWidget);
    });
  });

  group('CatalogListItem Edge Cases', () {
    testWidgets('should handle special characters in text', (tester) async {
      const specialTitle = 'Café & Restaurant Mystery 🔍';
      const specialDescription = 'Explore émojis & special chars: @#\$%^&*()';
      const specialLocation = 'Kraków & Gdańsk';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: specialTitle,
            description: specialDescription,
            distance: '10km',
            duration: '2h',
            location: specialLocation,
          ),
        ),
      ));

      expect(find.text(specialTitle), findsOneWidget);
      expect(find.text(specialDescription), findsOneWidget);
      expect(find.text(specialLocation), findsOneWidget);
    });

    testWidgets('should handle numeric values as strings', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CatalogListItem(
            title: '123456789',
            description: '0.123456789',
            distance: '999km',
            duration: '24h',
            location: 'Location 123',
          ),
        ),
      ));

      expect(find.text('123456789'), findsOneWidget);
      expect(find.text('0.123456789'), findsOneWidget);
      expect(find.text('999km'), findsOneWidget);
      expect(find.text('24h'), findsOneWidget);
      expect(find.text('Location 123'), findsOneWidget);
    });
  });
}