import 'package:flutter/material.dart';

class   ErrorScreen extends StatelessWidget {
  String errormsg;
  ErrorScreen({super.key, required this.errormsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error,color: Colors.grey,size: 100,),
          const SizedBox(height: 20),
          Text(errormsg, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}