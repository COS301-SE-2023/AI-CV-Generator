import 'package:flutter/material.dart';

class AppBarButtonStyle extends StatelessWidget {
  const AppBarButtonStyle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return LayoutBuilder(
      builder: (context,contraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                          overflow: TextOverflow.clip
                        ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}