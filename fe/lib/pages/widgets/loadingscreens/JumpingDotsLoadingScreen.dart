import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class JumpingDotsLoadingScreen extends StatelessWidget {
  const JumpingDotsLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          JumpingDots(numberOfDots: 4,color: Colors.grey.shade500,radius: 10)
        ],
      ),
    );
  }
}