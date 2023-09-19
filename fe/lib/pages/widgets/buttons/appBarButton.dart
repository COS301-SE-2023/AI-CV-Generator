import 'package:flutter/material.dart';

class AppBarButtonStyle extends StatelessWidget {
  const AppBarButtonStyle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    // double w = screenSize.width/100;
    // double h = screenSize.height/100; 
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 28,
            width: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white
                  ]),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary
                    ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}