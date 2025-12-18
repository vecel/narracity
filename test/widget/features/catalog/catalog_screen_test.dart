import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:narracity/features/catalog/presentation/catalog_list_item.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/presentation/details_screen.dart';
import 'package:narracity/features/catalog/presentation/view_model/catalog_view_model.dart';

void main() {
  group('CatalogScreen Widget Tests', () {
    late CatalogViewModel fakeViewModel;

    setUp(() {
      fakeViewModel = CatalogViewModel(
        scenariosRepository: FakeScenariosRepository.withScenarios()
      );
    });

    testWidgets('should display catalog screen with basic structure', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CatalogScreen(viewModel: fakeViewModel),
        ),
      );

      expect(find.byType(CatalogScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display app bar with correct title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CatalogScreen(viewModel: fakeViewModel),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Choose Scenario'), findsOneWidget);
    });

    testWidgets('should display scenarios list when scenarios are available', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CatalogScreen(viewModel: fakeViewModel),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should display empty state when no scenarios available', (tester) async {

      fakeViewModel = CatalogViewModel(scenariosRepository: FakeScenariosRepository.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: CatalogScreen(viewModel: fakeViewModel),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CatalogListItem), findsNothing);
    });

    testWidgets('should display scenario list items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CatalogScreen(viewModel: fakeViewModel),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CatalogListItem), findsAtLeastNWidgets(2));
    });

    testWidgets('should handle scenario selection on tap', (tester) async {
      // TODO: move to integration tests
      await tester.pumpWidget(
        MaterialApp(
          home: CatalogScreen(viewModel: fakeViewModel),
        ),
      );

      await tester.pumpAndSettle();

      final firstScenario = find.byType(CatalogListItem).first;
      await tester.tap(firstScenario);
      await tester.pumpAndSettle();

      expect(find.byType(DetailsScreen), findsOneWidget);
    });
  });
}