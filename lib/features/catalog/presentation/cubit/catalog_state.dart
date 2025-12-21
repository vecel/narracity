import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

sealed class CatalogState {}

final class CatalogLoading extends CatalogState {}
final class CatalogLoaded extends CatalogState {
  CatalogLoaded(this.scenarios);
  final List<Scenario> scenarios;
}