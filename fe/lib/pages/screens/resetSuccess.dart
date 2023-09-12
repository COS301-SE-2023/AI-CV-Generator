import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:flutter/material.dart';

class ResetSuccess extends StatefulWidget {
  
  const ResetSuccess({super.key, this.code});
  final String? code;
  @override
  State<StatefulWidget> createState() => ResetSuccessState();
}

class ResetSuccessState extends State<ResetSuccess> {

  toLogin() {
    Navigator.popAndPushNamed(context, "/");
  }
  showError(String message) {
    showMessage(message, context);
  }

  @override
  Widget build(Object context) {
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
                const Text(
                  "Please check your email to change your password",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: FloatingActionButton(
                        onPressed: () async {
                          Code response = await AuthApi.verify(code: widget.code!);
                          if (response == Code.success) {
                            toLogin();
                          } else if (response == Code.expired) {
                            showError("Unfortunatley this token is expired please register again");
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
                            color: Colors.white
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