import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:flutter/material.dart';

class EmailConfirmationArguments{
  String username;
  String password;
  EmailConfirmationArguments({
    required this.username,
    required this.password
  });
}

class EmailConfirmation extends StatelessWidget {
  const EmailConfirmation({Key? key, this.username, this.password}) : super(key: key);
  final String? username;
  final String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back,color: Colors.black,)
        ),
      ),
        body: MyStatefulWidget(username: username,password: password,),
    );
  }
}
 
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key,this.username,this.password }) : super(key: key);
  final String? username;
  final String? password;
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  
  bool error = false;
  Color? p2textColor;

  void backToLogin() {
    Navigator.popUntil(context, ModalRoute.withName("/"));
  }

  TextEditingController errorMessage = TextEditingController(text: "Error");
  Stream<String> sampleListener(TextEditingController controller) async* { // <- here
    while (true) {
      await Future.delayed(const Duration(milliseconds: 10));
      yield controller.value.text;
    }
  }

  @override
  void initState() {
    
    super.initState();
  }

  showError(String message) {
    showMessage(message, context);
  }
  showSuccess(String message) {
    showHappyMessage(message, context);
  }

 
  @override
  Widget build(BuildContext context) {
    String? username = widget.username;
    String? password = widget.password;
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
              SizedBox(width: w*2,),
              SingleChildScrollView(
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Container(
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
                                "Check your inbox",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 28, 
                                  color: Theme.of(context).colorScheme.primary
                                ),
                              ),
                              SizedBox(width: 1.6*w,),
                              Icon(
                                Icons.email,
                                
                                color: Theme.of(context).colorScheme.primary
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Click on the link in the email to complete the verification process",
                            overflow: TextOverflow.fade,
                            maxLines: 10,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                        Column(
                          children: [
                            SizedBox(
                              height: 24,
                              child: TextButton(
                                onPressed: () async {
                                  Code code = await AuthApi.resendEmail(username: username!, password: password!);
                                  if (code == Code.success) {
                                    showSuccess("Email sent!!");
                                  } else {
                                    showError("Unknown error occurred!");
                                    setState(() {
                                      
                                    });
                                  }
                                }, 
                                child: Text(
                                  "Resend Email?",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomizableButton(
                              text: 'Login', 
                              width: 10*w, 
                              height: 30, 
                              onTap: () {
                                backToLogin();
                              }, 
                              fontSize: 0.9*w
                            )
                          ],
                        )
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