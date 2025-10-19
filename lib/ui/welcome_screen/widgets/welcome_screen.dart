import 'package:city_games/ui/scenario_selection/view_model/scenario_selection_view_model.dart';
import 'package:city_games/ui/scenario_selection/widgets/scenario_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static final log = Logger('WelcomeScreen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.home),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () => log.info('Welcome'),
                child: Text('Create an account')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.tonal(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => ScenarioSelectionScreen(viewModel: ScenarioSelectionViewModel())
                    ) 
                  );
                }, 
                child: Text('Continue as guest')
              ),
            )
          ],
        ),
      ),
    );
  }
}