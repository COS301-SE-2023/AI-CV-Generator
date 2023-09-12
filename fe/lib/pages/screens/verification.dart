import 'package:flutter/material.dart';

class Verification extends StatelessWidget
{
  TextEditingController codeC = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Enter the code"),
        Text("Please enter the 5 digit code sent to your email"),
        Row(
          children: [
            TextField(
              controller: codeC,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Verify")
            ),
          ],
        )
      ],
    );
  }

}