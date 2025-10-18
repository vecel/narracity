import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static final log = Logger('WelcomeScreen');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Placeholder(),
          ElevatedButton(
            onPressed: () => log.info('Welcome'),
            child: Text('Create an account')
          ),
          const Placeholder()
        ],
      ),
    );
  }
}