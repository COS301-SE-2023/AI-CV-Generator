import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  EmailVerification({super.key, this.code});
  String? code;
  @override
  State<StatefulWidget> createState() => EmailVerificationState();
}

class EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              
            }, 
            child: Text("Verify email Account")
          )
        ],
      ),
    );
  }
}