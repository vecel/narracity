import 'package:narracity/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:narracity/ui/scenario_selection/widgets/scenario_selection_screen.dart';
import 'package:flutter/material.dart';

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
                        builder: (context) => ScenarioSelectionScreen(viewModel: ScenarioSelectionViewModel())
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