import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

sealed class CatalogState {}

final class CatalogLoading extends CatalogState {}
final class CatalogLoaded extends CatalogState {
  CatalogLoaded(this.scenarios);
  final List<Scenario> scenarios;
}
final class CatalogError extends CatalogState {
  CatalogError(this.message, {this.isConnectionError = false});
  final String message;
  final bool isConnectionError;
}