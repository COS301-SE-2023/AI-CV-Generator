import 'package:flutter/material.dart';

class ExtractionLoadingScreen extends StatelessWidget {
  const ExtractionLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text('LOADING...', style: Theme.of(context).textTheme.bodyMedium),
          Text('Extraction may take a while', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}