import 'package:flutter/material.dart';

class SizableButtonStyle extends StatelessWidget {
  const SizableButtonStyle({super.key, required this.text, required this.width, required this.height});
  final String text;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: width,
            width: height,
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
                  style: const TextStyle(
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