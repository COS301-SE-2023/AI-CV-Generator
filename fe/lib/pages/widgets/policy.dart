import 'package:flutter/material.dart';

class Policy extends StatelessWidget {
  const Policy({
    super.key,
    required this.filename,
    this.radius = 6
  });
  final String filename;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius)
        )
      ),
      backgroundColor: const Color(0xFFEA6D79),
      padding: const EdgeInsets.all(0),
    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      child: Column(
        children: [
          Expanded(
            child: Text("")
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: flatButtonStyle,
            child: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius)
                )
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}