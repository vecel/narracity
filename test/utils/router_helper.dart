import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({super.key, required this.router, required this.child});

  final GoRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InheritedGoRouter( 
      goRouter: router,
      child: child
    );
  }
}