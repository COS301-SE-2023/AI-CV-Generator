import 'package:flutter/material.dart';

class CustomizableButton extends StatelessWidget {
  const CustomizableButton({
    super.key, 
    required this.text, 
    required this.width, 
    required this.height,
    required this.onTap
  });
  final String text;
  final double width;
  final double height;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: height,
                width: width,
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
        ),
      )
    );
  }
}