import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key,this.code }) : super(key: key);
  final String? code;
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
        body: ChangePasswordWidget(code: code,)
    );
  }
}

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key, this.code});
  final String? code;
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordWidget> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetypeController = TextEditingController();
  
  Color? p2textColor;

  showError(String message) {
    showMessage(message, context);
  }
  showSuccess(String message) {
    showHappyMessage(message, context);
  }
  toLogin() {
    Navigator.popAndPushNamed(context, "/");
  }
  toResetSuccess() {
    Navigator.popAndPushNamed(context, "/resetSuccess");
  }
  bool wait = true;
  bool failed = true;
  String message = "Unfortunatley this link is no longer valid";

  @override
  void initState() {
    AuthApi.validateReset(token: widget.code!).then((value) {
      if (value == Code.success) {
        failed = false;
      } else if (value == Code.requestFailed) {
        message = "Something went wrong!!";
        failed = true;
      }
      wait = false;
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wait) return const LoadingScreen();
    if (failed) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
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
                      message,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ]
            )
          ]
        )
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Image(image: ResizeImage(AssetImage('assets/images/logo.png'),width:350,height:350),)
                ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('password'),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:Color(0xFF000000),
                      width: 1.0
                    )
                  ),
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  if (passwordRetypeController.text != passwordController.text) {
                    setState(() {
                      p2textColor = const Color.fromRGBO(250, 0, 0, 0.466);
                    });
                    
                  } else {
                    setState(() {
                      p2textColor = null;
                    });
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('passwordretype'),
                obscureText: true,
                controller: passwordRetypeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: p2textColor??const Color(0xFF000000),
                      width: 1.0
                    )
                  ),
                  labelText: 'Retype Password',
                  labelStyle: TextStyle(
                    color: p2textColor
                  )
                ),
                onChanged: (value) {
                  if (passwordRetypeController.text != passwordController.text) {
                    setState(() {
                      p2textColor = const Color.fromRGBO(250, 0, 0, 0.466);
                    });
                  } else {
                    setState(() {
                      p2textColor = null;
                    });
                  }
                },
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(600, 0, 600, 0),
                child: ElevatedButton(
                  key: const Key('ChangePassword'),
                  child: const Text('Send Verification Code'),
                  onPressed: () async {
                    if (passwordController.text != passwordRetypeController.text) {
                      showError("Password does not match");
                      return;
                    }
                    setState(() {
                      wait = true;
                    });
                    Code resp = await AuthApi.changePassword(newPassword: passwordController.text, token: widget.code!);
                    if (resp == Code.success) {
                      showSuccess("Password has been successfully changed");
                      toLogin();
                      
                    } else if (resp == Code.failed) {
                      showError("Something went wrong!!");
                      setState(() {
                        wait = false;
                      });
                    } else if (resp == Code.requestFailed) {
                      showError("Something went wrong!!");
                      setState(() {
                        wait = false;
                      });
                    }
                  },
                )
            ),
        ]
      )
    );
  }
}