import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  
  const EmailVerification({super.key, this.code});
  final String? code;
  @override
  State<StatefulWidget> createState() => EmailVerificationState();
}

class EmailVerificationState extends State<EmailVerification> {

  toLogin() {
    Navigator.popAndPushNamed(context, "/");
  }

  showError(String message) {
    showMessage(message, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 30, 100, 10),
                child: const Image(
                  image: ResizeImage(
                    AssetImage('assets/images/logo.png'),
                    width:350,
                    height:350
                    ),
                  )
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please verify your account to continue",
                  style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 48,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          Code response = await AuthApi.verify(code: widget.code!);
                          if (response == Code.success) {
                            toLogin();
                          } else if (response == Code.expired) {
                            showError("Unfortunatley this token is expired please resend verification email again");
                            setState(() {
                              
                            });
                          } else {
                            showError("Verification failed something went wrong!");
                            setState(() {
                              
                            });
                          }
                        }, 
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ),
                    ),
                  ],
                )
                
              ],
            ),
          ],
      ));
  }
}