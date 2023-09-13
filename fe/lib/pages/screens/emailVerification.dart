import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/generalTextButton.dart';
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

  showSuccess(String message) {
    showHappyMessage(message, context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return Scaffold(
          body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(1*w, 3*h, 10*w, 1*h),
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
                  height: 4.8*h,
                ),
                Row(
                  children: [
                    Container(
                      height: 5*h,
                      width: 10*w,
                      child: InkWell(
                        onTap: () async {
                          Code response = await AuthApi.verify(code: widget.code!);
                          if (response == Code.success) {
                            showSuccess("Account has been verified");
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
                        child: const GeneralButtonStyle(text: "Verify")
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