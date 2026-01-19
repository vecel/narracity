import 'package:go_router/go_router.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/details_screen.dart';
import 'package:narracity/features/home/welcome_screen.dart';
import 'package:narracity/features/scenario/presentation/scenario_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
    GoRoute(path: '/catalog', builder: (context, state) => CatalogScreen()),
    GoRoute(path: '/details/:id', builder: (context, state) => DetailsScreen(id: state.pathParameters['id']!)),
    GoRoute(path: '/scenario/:id', builder: (context, state) => ScenarioScreen(id: state.pathParameters['id']!)),
  ]
);