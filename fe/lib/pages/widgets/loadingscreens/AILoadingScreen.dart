import 'package:flutter/material.dart';

class AILoadingScreen extends StatelessWidget {
  const AILoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text('LOADING...', style: Theme.of(context).textTheme.bodyMedium),
          Text('This may take up to 30s', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}