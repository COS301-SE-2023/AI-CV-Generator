import 'package:flutter/material.dart';

class GeneralButtonStyleLarge extends StatelessWidget {
  const GeneralButtonStyleLarge({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: h*5,
            width: w*15,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFDA187),
                    Color(0xFFEA6D79),
                  ]),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 0.9*w,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
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