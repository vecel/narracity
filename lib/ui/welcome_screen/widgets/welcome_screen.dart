import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Placeholder(),
          ElevatedButton(
            onPressed: () => print('Welcome'), 
            child: Text('Create an account')
          ),
          const Placeholder()
        ],
      ),
    );
  }
}