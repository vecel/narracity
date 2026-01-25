import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:narracity/keys.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 96),
            Icon(
              Icons.map, 
              size: 96,
              color: Theme.of(context).colorScheme.onPrimary
            ),
            Text(
              'Narracity',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24
              ),
            ),
            Expanded(
              child: Center(
                child: FilledButton.tonal(
                  key: keys.welcomeScreen.letsExploreButton,
                  onPressed: () => context.go('/catalog'),
                  child: Text("Let's Explore")
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}