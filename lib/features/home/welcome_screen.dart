import 'package:flutter/material.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/catalog_screen.dart';
import 'package:narracity/features/catalog/view_model/catalog_view_model.dart';

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
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => CatalogScreen(
                          viewModel: CatalogViewModel(scenariosRepository: ScenariosRepository()))
                      ) 
                    );
                  }, 
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