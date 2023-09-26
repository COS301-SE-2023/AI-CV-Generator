import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.fromLTRB(1*w, 3*h, 10*w, 1*h),
                  child: Image(
                    fit: BoxFit.contain,
                    image: ResizeImage(
                      const AssetImage('assets/images/logo.png'),
                      width:w.toInt()*100,
                    ),
                  )
                ),
              ),
              SizedBox(width: w*5,),
              SingleChildScrollView(
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Verify your account",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 28, 
                                  color: Theme.of(context).colorScheme.primary
                                ),
                              ),
                              SizedBox(width: 1.6*w,),
                              Icon(
                                Icons.verified,
                                
                                color: Theme.of(context).colorScheme.primary
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Complete the verification process",
                            overflow: TextOverflow.fade,
                            maxLines: 10,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomizableButton(
                        text: 'Verify', 
                        width: 10*w, 
                        height: 30, 
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
                        fontSize: 0.9*w
                      ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




